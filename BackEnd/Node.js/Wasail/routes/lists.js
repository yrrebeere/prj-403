var router = require('express').Router();

const listController = require('../controllers/listcontroller')



router.post('/addvendorlist/:grocery_store_store_id/:vendor_vendor_id', listController.addVendorList)
router.delete('/:vendor_vendor_id', listController.deleteVendorList)

module.exports = router;
