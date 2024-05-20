var router = require('express').Router();

const productinventoryController = require('../controllers/productinventoryController')


router.post('/addproductinventory',productinventoryController.addProductInventory)
router.get('/allproductinventories',productinventoryController.getAllProductInventories)
router.get('/:product_inventory_id', productinventoryController.getOneProductInventory)
router.put('/:product_inventory_id', productinventoryController.updateProductInventory)
router.delete('/:product_inventory_id', productinventoryController.deleteProductInventory)
router.get('/search/:vendor_vendor_id', productinventoryController.searchProductByVID)
router.get('/selectproduct/:product_inventory_id', productinventoryController.selectProduct)

module.exports = router;
