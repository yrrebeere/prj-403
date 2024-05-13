const multer = require('multer');
const path = require('path');
const fs = require('fs');
const db = require('../models')
const Image = db.image

const storage = multer.diskStorage({

    destination: (req, file, cb) => {
        cb(null, 'uploads')
    },
    filename: (req, file, cb) => {
        console.log(file)
        cb(null, file.originalname)
    }

})

const upload = multer({storage: storage})

const getProductImage = (req, res) => {
    const filename = req.params.filename;
    const imagePath = path.join(__dirname, '../uploads/products', filename);

    fs.readFile(imagePath, (err, data) => {
        if (err) {
            return res.status(404).json({ error: 'Image not found.' });
        }

        res.setHeader('Content-Type', 'image/png');
        res.send(data);
    });
};

const getCategoryImage = (req, res) => {
    const filename = req.params.filename;
    const imagePath = path.join(__dirname, '../uploads/categories', filename);

    fs.readFile(imagePath, (err, data) => {
        if (err) {
            return res.status(404).json({ error: 'Image not found.' });
        }

        res.setHeader('Content-Type', 'image/png');
        res.send(data);
    });
};
const getStoreImage = (req, res) => {
    const filename = req.params.filename;
    const imagePath = path.join(__dirname, '../uploads/stores', filename);

    fs.readFile(imagePath, (err, data) => {
        if (err) {
            return res.status(404).json({ error: 'Image not found.' });
        }

        res.setHeader('Content-Type', 'image/png');
        res.send(data);
    });
};

const getVendorImage = (req, res) => {
    const filename = req.params.filename;
    const imagePath = path.join(__dirname, '../uploads/vendors', filename);

    fs.readFile(imagePath, (err, data) => {
        if (err) {
            return res.status(404).json({ error: 'Image not found.' });
        }

        res.setHeader('Content-Type', 'image/png');
        res.send(data);
    });
};

// const uploadImage = (req, res) => {
//     upload.single('file')(req, res, (err) => {
//
//         console.log(req.file)
//
//         if (err) {
//             return res.status(400).json({ error: 'Error uploading image.' });
//         }
//
//         if (!req.file) {
//             return res.status(400).json({ error: 'No image uploaded.' });
//         }
//
//         res.status(200).json({ filename: req.file.filename });
//     });
// };

const uploadProductImage = (req, res) => {
    upload.single('file')(req, res, (err) => {
        if (err) {
            return res.status(400).json({ error: 'Error uploading image.' });
        }

        if (!req.file) {
            return res.status(400).json({ error: 'No image uploaded.' });
        }

        const productImagePath = path.join(__dirname, '../uploads/products', req.file.filename);

        // Move the uploaded image to the "products" folder
        fs.rename(req.file.path, productImagePath, (err) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to move image to products folder.' });
            }

            res.status(200).json({ filename: req.file.filename });
        });
    });
};

const uploadCategoryImage = (req, res) => {
    upload.single('file')(req, res, (err) => {
        if (err) {
            return res.status(400).json({ error: 'Error uploading image.' });
        }

        if (!req.file) {
            return res.status(400).json({ error: 'No image uploaded.' });
        }

        const categoryImagePath = path.join(__dirname, '../uploads/categories', req.file.filename);

        // Move the uploaded image to the "categories" folder
        fs.rename(req.file.path, categoryImagePath, (err) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to move image to categories folder.' });
            }

            res.status(200).json({ filename: req.file.filename });
        });
    });
};

const uploadStoreImage = (req, res) => {
    upload.single('file')(req, res, (err) => {
        if (err) {
            return res.status(400).json({ error: 'Error uploading image.' });
        }

        if (!req.file) {
            return res.status(400).json({ error: 'No image uploaded.' });
        }

        const storeImagePath = path.join(__dirname, '../uploads/stores', req.file.filename);

        // Move the uploaded image to the "stores" folder
        fs.rename(req.file.path, storeImagePath, (err) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to move image to stores folder.' });
            }

            res.status(200).json({ filename: req.file.filename });
        });
    });
};


module.exports = {
    getProductImage,
    getCategoryImage,
    getStoreImage,
    getVendorImage,
    // uploadImage,
    uploadProductImage,
    uploadCategoryImage,
    uploadStoreImage
};
