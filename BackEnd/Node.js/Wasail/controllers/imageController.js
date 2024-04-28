const multer = require('multer');
const path = require('path');
const fs = require('fs');
const db = require('../models')
const Image = db.image

const upload = multer({ dest: 'uploads/products' });


const getImage = (req, res) => {
    const filename = req.params.filename;
    const imagePath = path.join(__dirname, '../uploads/products', filename);

    fs.readFile(imagePath, (err, data) => {
        if (err) {
            return res.status(404).json({ error: 'Image not found.' });
        }

        // Serve the image file back to the client
        res.setHeader('Content-Type', 'image/png'); // Adjust content type based on your image type
        res.send(data);
    });
};

module.exports = {
    getImage
};
