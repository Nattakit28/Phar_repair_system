const multer = require('multer');
const path = require('path');
const fs = require('fs');

class ImageService {
    constructor() {
        // ✅ ไม่เก็บ baseUrl แล้ว — เก็บแค่ relative path ลง DB
        this.ensureDirectories();
    }

    ensureDirectories() {
        const dirs = [
            'uploads',
            'uploads/repair-images',
            'uploads/completion-images'
        ];
        dirs.forEach(dir => {
            if (!fs.existsSync(dir)) {
                fs.mkdirSync(dir, { recursive: true });
            }
        });
    }

    createStorage() {
        return multer.diskStorage({
            destination: (req, file, cb) => {
                const uploadDir = file.fieldname === 'completion_images'
                    ? 'uploads/completion-images'
                    : 'uploads/repair-images';
                cb(null, uploadDir);
            },
            filename: (req, file, cb) => {
                const uniqueSuffix = Date.now() + '-' + Math.round(Math.random() * 1E9);
                const prefix = file.fieldname === 'completion_images' ? 'completion-' : 'repair-';
                cb(null, prefix + uniqueSuffix + path.extname(file.originalname));
            }
        });
    }

    fileFilter(req, file, cb) {
        const allowedTypes = /jpeg|jpg|png|gif|webp/;
        const extname = allowedTypes.test(path.extname(file.originalname).toLowerCase());
        const mimetype = allowedTypes.test(file.mimetype);
        if (mimetype && extname) {
            return cb(null, true);
        } else {
            cb(new Error('อนุญาตเฉพาะไฟล์รูปภาพเท่านั้น (JPEG, PNG, GIF, WebP)'));
        }
    }

    normalizePath(filePath) {
        if (!filePath) return filePath;

        // ✅ ถ้าเป็น URL เต็ม (http://...) ให้แปลงกลับเป็น relative path
        if (filePath.startsWith('http://') || filePath.startsWith('https://')) {
            try {
                const url = new URL(filePath);
                // ตัดเอาแค่ pathname เช่น /uploads/repair-images/xxx.jpg
                return url.pathname.replace(/^\//, ''); // ตัด / นำหน้าออก → uploads/repair-images/xxx.jpg
            } catch (e) {
                return filePath;
            }
        }

        return filePath.replace(/\\/g, '/');
    }

    deleteFile(filePath) {
        try {
            const normalizedPath = this.normalizePath(filePath);
            if (normalizedPath && fs.existsSync(normalizedPath)) {
                fs.unlinkSync(normalizedPath);
                return true;
            }
        } catch (error) {
            console.warn('ไม่สามารถลบไฟล์:', filePath, error.message);
        }
        return false;
    }

    async saveImagesToDatabase(connection, repairId, images, type = 'repair') {
        if (!images || images.length === 0) return [];

        const tableName = type === 'completion' ? 'completion_images' : 'repair_images';

        const imageInsertPromises = images.map(image => {
            // ✅ เก็บแค่ relative path เช่น uploads/repair-images/repair-xxx.jpg
            const normalizedPath = this.normalizePath(image.path);

            return connection.execute(`
                INSERT INTO ${tableName} 
                (repair_request_id, file_path, file_name, file_size)
                VALUES (?, ?, ?, ?)
            `, [repairId, normalizedPath, image.originalname, image.size]);
        });

        await Promise.all(imageInsertPromises);

        return images.map(img => ({
            file_path: this.normalizePath(img.path),
            file_name: img.originalname,
            file_size: img.size
        }));
    }

    async getImagesFromDatabase(connection, repairId, type = 'repair') {
        const tableName = type === 'completion' ? 'completion_images' : 'repair_images';

        const [rows] = await connection.execute(`
            SELECT * FROM ${tableName} WHERE repair_request_id = ?
        `, [repairId]);

        return rows.map(row => ({
            ...row,
            file_path: this.normalizePath(row.file_path)
        }));
    }
}

module.exports = new ImageService();
