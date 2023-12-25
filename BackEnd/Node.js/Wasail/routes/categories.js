var router = require('express').Router();

const productcategoryController = require('../controllers/productcategoryController')

/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });


//vendor
router.post('/addproductcategory',productcategoryController.addProductCategory)
router.get('/allproductcategories',productcategoryController.getAllProductCategories)
router.get('/:product_category_id', productcategoryController.getOneProductCategory)
router.put('/:product_category_id', productcategoryController.updateProductCategory)
router.delete('/:product_category_id', productcategoryController.deleteProductCategory)
router.get('/searchproductcategory/:category_name', productcategoryController.searchProductCategory)

module.exports = router;
