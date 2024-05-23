var router = require('express').Router();

const grocerystoreController = require('../controllers/grocerystoreController')


router.post('/addstore',grocerystoreController.addStore)
router.get('/allstores',grocerystoreController.getAllStores)
router.get('/grocerystorecount', grocerystoreController.groceryStoreCount)
router.get('/:store_id', grocerystoreController.getOneStore)
router.put('/:store_id', grocerystoreController.updateStore)
router.delete('/:store_id', grocerystoreController.deleteStore)
router.get('/searchstore/:vendor_vendor_id', grocerystoreController.searchStoreByVID)
router.get('/viewvendorlist/:grocery_store_store_id', grocerystoreController.viewVendorList)
router.get('/getstore/:user_table_user_id', grocerystoreController.getStoreIdByUserId)



module.exports = router;
