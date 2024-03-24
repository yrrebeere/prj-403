var router = require('express').Router();

const listController = require('../controllers/listcontroller')


/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });

//user_table
router.post('/addvendorlist/:grocery_store_store_id/:vendor_vendor_id', listController.addVendorList)
router.delete('/:vendor_vendor_id', listController.deleteVendorList)

module.exports = router;
