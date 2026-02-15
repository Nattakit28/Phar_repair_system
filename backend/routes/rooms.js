// routes/rooms.js - FIXED: ใช้ pool แทน createConnection
const express = require('express');
const router = express.Router();
const mysql = require('mysql2/promise');

// ✅ ใช้ pool จาก db config แทน createConnection
let pool;
const getPool = () => {
    if (!pool) {
        pool = mysql.createPool({
            host: process.env.DB_HOST || 'localhost',
            user: process.env.DB_USER || 'root',
            password: process.env.DB_PASSWORD || '',
            database: process.env.DB_NAME || 'repair_system',
            charset: 'utf8mb4',
            waitForConnections: true,
            connectionLimit: 10,
            queueLimit: 0
        });
        console.log('[ROOMS] Connection pool created');
    }
    return pool;
};

let auth = null;
let authenticateToken = null;
let requireRole = null;

try {
    const authMiddleware = require('../middleware/auth');
    
    if (authMiddleware.authenticateToken && typeof authMiddleware.authenticateToken === 'function') {
        authenticateToken = authMiddleware.authenticateToken;
        auth = authenticateToken;
        requireRole = authMiddleware.requireRole;
        console.log('[AUTH] Auth middleware loaded successfully (new structure)');
    } else if (typeof authMiddleware === 'function') {
        auth = authMiddleware;
        authenticateToken = authMiddleware;
        console.log('[AUTH] Auth middleware loaded successfully (legacy structure)');
    } else {
        throw new Error('Auth middleware structure not recognized');
    }
} catch (error) {
    console.error('[AUTH] Error loading auth middleware:', error.message);
    auth = (req, res, next) => {
        req.user = { id: 1, role: 'admin', username: 'admin', email: 'admin@example.com' };
        next();
    };
    authenticateToken = auth;
    requireRole = (roles) => (req, res, next) => next();
}

// ✅ GET / - ดึงห้องทั้งหมด
router.get('/', authenticateToken, async (req, res) => {
    try {
        const db = getPool();
        const [rooms] = await db.execute(`
            SELECT id, name, building, floor, description, is_active, created_at, updated_at
            FROM rooms 
            ORDER BY building, floor, name
        `);

        console.log('[ROOMS] Fetched rooms:', rooms.length);
        res.json({ success: true, data: rooms });
    } catch (error) {
        console.error('[ROOMS] Error fetching rooms:', error);
        res.status(500).json({ success: false, message: 'Error fetching rooms' });
    }
});

// ✅ GET /by-building-floor
router.get('/by-building-floor', authenticateToken, async (req, res) => {
    try {
        const { building, floor } = req.query;

        if (!building || floor === undefined) {
            return res.status(400).json({ success: false, message: 'Building and floor required' });
        }

        const buildingNum = parseInt(building);
        const floorNum = parseInt(floor);

        if (isNaN(buildingNum) || isNaN(floorNum)) {
            return res.status(400).json({ success: false, message: 'Building and floor must be numbers' });
        }

        const db = getPool();
        const [rooms] = await db.execute(`
            SELECT id, name, building, floor, description
            FROM rooms 
            WHERE building = ? AND floor = ? AND is_active = 1
            ORDER BY name
        `, [buildingNum, floorNum]);

        console.log('[ROOMS] Fetched rooms for building', buildingNum, 'floor', floorNum, ':', rooms.length);
        res.json({ success: true, data: rooms, building: buildingNum, floor: floorNum, count: rooms.length });
    } catch (error) {
        console.error('[ROOMS] Error fetching rooms by building and floor:', error);
        res.status(500).json({ success: false, message: 'Error fetching rooms' });
    }
});

// ✅ GET /buildings
router.get('/buildings', authenticateToken, async (req, res) => {
    try {
        const db = getPool();
        const [buildings] = await db.execute(`
            SELECT DISTINCT building
            FROM rooms 
            WHERE is_active = 1
            ORDER BY building
        `);

        console.log('[ROOMS] Fetched buildings:', buildings.length);
        res.json({ success: true, data: buildings });
    } catch (error) {
        console.error('[ROOMS] Error fetching buildings:', error);
        res.status(500).json({ success: false, message: 'Error fetching buildings' });
    }
});

// ✅ GET /floors
router.get('/floors', authenticateToken, async (req, res) => {
    try {
        const { building } = req.query;

        if (!building) {
            return res.status(400).json({ success: false, message: 'Building number required' });
        }

        const buildingNum = parseInt(building);
        if (isNaN(buildingNum)) {
            return res.status(400).json({ success: false, message: 'Building must be a number' });
        }

        const db = getPool();
        const [floors] = await db.execute(`
            SELECT DISTINCT floor
            FROM rooms 
            WHERE building = ? AND is_active = 1
            ORDER BY floor
        `, [buildingNum]);

        console.log('[ROOMS] Fetched floors for building', buildingNum, ':', floors.length);
        res.json({ success: true, data: floors, building: buildingNum });
    } catch (error) {
        console.error('[ROOMS] Error fetching floors:', error);
        res.status(500).json({ success: false, message: 'Error fetching floors' });
    }
});

// ✅ GET /floors/:building
router.get('/floors/:building', authenticateToken, async (req, res) => {
    try {
        const building = parseInt(req.params.building);

        if (isNaN(building)) {
            return res.status(400).json({ success: false, message: 'Building must be a number' });
        }

        const db = getPool();
        const [floors] = await db.execute(`
            SELECT DISTINCT floor
            FROM rooms 
            WHERE building = ? AND is_active = 1
            ORDER BY floor
        `, [building]);

        res.json({ success: true, data: floors.map(row => row.floor), building });
    } catch (error) {
        console.error('[ROOMS] Error fetching floors:', error);
        res.status(500).json({ success: false, message: 'Error fetching floors' });
    }
});

// ✅ POST / - สร้างห้องใหม่
router.post('/', authenticateToken, async (req, res) => {
    try {
        if (req.user.role !== 'admin') {
            return res.status(403).json({ success: false, message: 'Access denied' });
        }

        const { name, building, floor, description } = req.body;

        if (!name || !building || floor === undefined) {
            return res.status(400).json({ success: false, message: 'Name, building, and floor required' });
        }

        const db = getPool();

        const [existing] = await db.execute(`
            SELECT id FROM rooms 
            WHERE name = ? AND building = ? AND floor = ? AND is_active = 1
        `, [name, building, floor]);

        if (existing.length > 0) {
            return res.status(409).json({ success: false, message: 'Room already exists in this building and floor' });
        }

        const [result] = await db.execute(`
            INSERT INTO rooms (name, building, floor, description, is_active)
            VALUES (?, ?, ?, ?, 1)
        `, [name, building, floor, description || null]);

        console.log('[ROOMS] Created room:', result.insertId);
        res.status(201).json({
            success: true,
            message: 'Room created successfully',
            data: { id: result.insertId, name, building, floor, description }
        });
    } catch (error) {
        console.error('[ROOMS] Error creating room:', error);
        res.status(500).json({ success: false, message: 'Error creating room' });
    }
});

// ✅ PUT /:id - แก้ไขห้อง
router.put('/:id', authenticateToken, async (req, res) => {
    try {
        if (req.user.role !== 'admin') {
            return res.status(403).json({ success: false, message: 'Access denied' });
        }

        const roomId = parseInt(req.params.id);
        const { name, building, floor, description, is_active } = req.body;

        if (isNaN(roomId)) {
            return res.status(400).json({ success: false, message: 'Invalid room ID' });
        }

        const db = getPool();

        const [room] = await db.execute(`SELECT id FROM rooms WHERE id = ?`, [roomId]);

        if (room.length === 0) {
            return res.status(404).json({ success: false, message: 'Room not found' });
        }

        await db.execute(`
            UPDATE rooms 
            SET name = ?, building = ?, floor = ?, description = ?, is_active = ?, updated_at = NOW()
            WHERE id = ?
        `, [name, building, floor, description || null, is_active !== undefined ? is_active : 1, roomId]);

        console.log('[ROOMS] Updated room:', roomId);
        res.json({ success: true, message: 'Room updated successfully' });
    } catch (error) {
        console.error('[ROOMS] Error updating room:', error);
        res.status(500).json({ success: false, message: 'Error updating room' });
    }
});

// ✅ DELETE /:id - ลบห้อง (soft delete)
router.delete('/:id', authenticateToken, async (req, res) => {
    try {
        if (req.user.role !== 'admin') {
            return res.status(403).json({ success: false, message: 'Access denied' });
        }

        const roomId = parseInt(req.params.id);

        if (isNaN(roomId)) {
            return res.status(400).json({ success: false, message: 'Invalid room ID' });
        }

        const db = getPool();

        const [room] = await db.execute(`
            SELECT id FROM rooms WHERE id = ? AND is_active = 1
        `, [roomId]);

        if (room.length === 0) {
            return res.status(404).json({ success: false, message: 'Room not found' });
        }

        await db.execute(`
            UPDATE rooms SET is_active = 0, updated_at = NOW() WHERE id = ?
        `, [roomId]);

        console.log('[ROOMS] Deleted room:', roomId);
        res.json({ success: true, message: 'Room deleted successfully' });
    } catch (error) {
        console.error('[ROOMS] Error deleting room:', error);
        res.status(500).json({ success: false, message: 'Error deleting room' });
    }
});

// Debug route
router.get('/debug/info', (req, res) => {
    res.json({
        message: 'Rooms route debug info',
        connectionType: 'pool (fixed)',
        routes: ['GET /', 'GET /by-building-floor', 'GET /buildings', 'GET /floors', 'GET /floors/:building', 'POST /', 'PUT /:id', 'DELETE /:id']
    });
});

module.exports = router;