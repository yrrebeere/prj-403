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

const uploadProductImage = (req, res) => {

    const productName = req.body.product_name || req.query.product_name;

    if (!productName) {
        return res.status(400).json({ error: 'Product name is required.' });
    }

    upload.single('file')(req, res, (err) => {
        if (err) {
            return res.status(400).json({ error: 'Error uploading image.' });
        }

        if (!req.file) {
            return res.status(400).json({ error: 'No image uploaded.' });
        }


        const filename = `${productName}${path.extname(req.file.originalname)}`;
        const productImagePath = path.join(__dirname, '../uploads/products', filename);


        fs.rename(req.file.path, productImagePath, (err) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to move image to products folder.' });
            }

            res.status(200).json({ filename });
        });
    });
};


const uploadCategoryImage = (req, res) => {

    const categoryName = req.body.category_name || req.query.category_name;

    if (!categoryName) {
        return res.status(400).json({ error: 'Category name is required.' });
    }

    upload.single('file')(req, res, (err) => {
        if (err) {
            return res.status(400).json({ error: 'Error uploading image.' });
        }

        if (!req.file) {
            return res.status(400).json({ error: 'No image uploaded.' });
        }


        const filename = `${categoryName}${path.extname(req.file.originalname)}`;
        const categoryImagePath = path.join(__dirname, '../uploads/categories', filename);


        fs.rename(req.file.path, categoryImagePath, (err) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to move image to categories folder.' });
            }

            res.status(200).json({ filename });
        });
    });
};



const uploadStoreImage = (req, res) => {

    const storeName = req.body.store_name || req.query.store_name;

    if (!storeName) {
        return res.status(400).json({ error: 'Store name is required.' });
    }

    upload.single('file')(req, res, (err) => {
        if (err) {
            return res.status(400).json({ error: 'Error uploading image.' });
        }

        if (!req.file) {
            return res.status(400).json({ error: 'No image uploaded.' });
        }


        const filename = `${storeName}${path.extname(req.file.originalname)}`;
        const storeImagePath = path.join(__dirname, '../uploads/stores', filename);


        fs.rename(req.file.path, storeImagePath, (err) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to move image to stores folder.' });
            }

            res.status(200).json({ filename });
        });
    });
};


const uploadVendorImage = (req, res) => {

    const vendorName = req.body.vendor_name || req.query.vendor_name;

    if (!vendorName) {
        return res.status(400).json({ error: 'Vendor name is required.' });
    }

    upload.single('file')(req, res, (err) => {
        if (err) {
            return res.status(400).json({ error: 'Error uploading image.' });
        }

        if (!req.file) {
            return res.status(400).json({ error: 'No image uploaded.' });
        }


        const filename = `${vendorName}${path.extname(req.file.originalname)}`;
        const vendorImagePath = path.join(__dirname, '../uploads/vendors', filename);

       
        fs.rename(req.file.path, vendorImagePath, (err) => {
            if (err) {
                return res.status(500).json({ error: 'Failed to move image to vendors folder.' });
            }

            res.status(200).json({ filename });
        });
    });
};



module.exports = {
    getProductImage,
    getCategoryImage,
    getStoreImage,
    getVendorImage,
    uploadProductImage,
    uploadCategoryImage,
    uploadStoreImage,
    uploadVendorImage
};
