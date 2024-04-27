var router = require('express').Router();

const productController = require('../controllers/productController')

/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });

router.post('/addproduct',productController.addProduct)
router.get('/allproducts',productController.getAllProducts)
router.get('/:product_id', productController.getOneProduct)
router.put('/:prouct_id', productController.updateProduct)
router.delete('/:product_id', productController.deleteProduct)
router.get('/searchproduct/:product_name', productController.searchProduct)
router.get('/searchproductininventory/:vendor_vendor_id/:product_name', productController.searchProductInInventory)
router.get('/searchproductinstore/:product_name', productController.searchProductInStore)

module.exports = router;
