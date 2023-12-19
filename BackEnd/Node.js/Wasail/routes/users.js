var router = require('express').Router();

const usertableController = require('../controllers/usertableController')
const vendorController = require('../controllers/vendorController')

/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });

//user_table
router.post('/adduser', usertableController.addUser)
router.get('/allusers', usertableController.getAllUsers)
router.get('/:user_id', usertableController.getOneUser)
router.put('/:user_id', usertableController.updateUser)
router.delete('/:user_id', usertableController.deleteUser)

//vendor
router.post('/addvendor',vendorController.addVendor)
router.get('/allvendors',vendorController.getAllVendors)
router.get('/:vendor_id', vendorController.getOneVendor)
router.put('/:vendor_id', vendorController.updateVendor)
router.delete('/:vendor_id', vendorController.deleteVendor)

module.exports = router;
