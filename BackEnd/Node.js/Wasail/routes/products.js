var router = require('express').Router();

const productController = require('../controllers/productController')

router.post('/addproduct',productController.addProduct)
router.get('/allproducts',productController.getAllProducts)
router.get('/productcount',productController.productCount)
router.get('/:product_id', productController.getOneProduct)
router.put('/:product_id', productController.updateProduct)
router.delete('/:product_id', productController.deleteProduct)
router.get('/searchproduct/:product_name', productController.searchProduct)
router.get('/searchproductininventory/:vendor_vendor_id/:product_name', productController.searchProductInInventory)
router.get('/searchproductinstore/:product_name', productController.searchProductInStore)

module.exports = router;
