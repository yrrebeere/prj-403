var router = require('express').Router();

const productcategoryController = require('../controllers/productcategoryController')


router.post('/addproductcategory',productcategoryController.addProductCategory)
router.get('/allproductcategories',productcategoryController.getAllProductCategories)
router.get('/productcategorycount',productcategoryController.productCategoryCount)
router.get('/:product_category_id', productcategoryController.getOneProductCategory)
router.put('/:product_category_id', productcategoryController.updateProductCategory)
router.delete('/:product_category_id', productcategoryController.deleteProductCategory)
router.get('/searchproductcategory/:category_name', productcategoryController.searchProductCategory)
router.get('/searchcategoryinstore/:category_name', productcategoryController.searchCategoryInStore)

module.exports = router;
