var router = require('express').Router();

const imageController = require('../controllers/imageController')


/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });

router.post('/uploadproduct', imageController.uploadProductImage);
router.post('/uploadcategory', imageController.uploadCategoryImage);
router.post('/uploadstore', imageController.uploadStoreImage);
router.post('/uploadvendor', imageController.uploadVendorImage);
router.get('/products/:filename', imageController.getProductImage);
router.get('/categories/:filename', imageController.getCategoryImage);
router.get('/stores/:filename', imageController.getStoreImage);
router.get('/vendors/:filename', imageController.getVendorImage);

module.exports = router;
