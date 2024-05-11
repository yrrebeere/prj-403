var router = require('express').Router();

const grocerystoreController = require('../controllers/grocerystoreController')

/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });

//vendor
router.post('/addstore',grocerystoreController.addStore)
router.get('/allstores',grocerystoreController.getAllStores)
router.get('/grocerystorecount', grocerystoreController.groceryStoreCount)
router.get('/:store_id', grocerystoreController.getOneStore)
router.put('/:store_id', grocerystoreController.updateStore)
router.delete('/:store_id', grocerystoreController.deleteStore)
router.get('/searchstore/:vendor_vendor_id', grocerystoreController.searchStoreByVID)
router.get('/viewvendorlist/:grocery_store_store_id', grocerystoreController.viewVendorList)



module.exports = router;
