var router = require('express').Router();

const vendorController = require('../controllers/vendorController')

/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });


//vendor
router.post('/addvendor',vendorController.addVendor)
router.get('/allvendors',vendorController.getAllVendors)
router.get('/vendorcount',vendorController.vendorCount)
router.get('/:vendor_id', vendorController.getOneVendor)
router.put('/:vendor_id', vendorController.updateVendor)
router.delete('/:vendor_id', vendorController.deleteVendor)
router.get('/getvendor/:user_table_user_id', vendorController.getVendorIdByUserId)
router.get('/vendorprofile/:vendor_id', vendorController.vendorProfile)
router.get('/searchvendorinstore/:vendor_name', vendorController.searchVendorInStore)
module.exports = router;
