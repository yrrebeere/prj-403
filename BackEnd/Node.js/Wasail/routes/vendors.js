var express = require('express');
var router = express.Router();
const vendorController = require('../controllers/vendorController')

router.get('/', function(req, res, next) {
    res.send('respond with a resource');
});

router.post('/addvendor',vendorController.addVendor)
router.get('/allvendors',vendorController.getAllVendors)

module.exports = router;