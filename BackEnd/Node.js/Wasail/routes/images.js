var router = require('express').Router();

const imageController = require('../controllers/imageController')


/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });

router.get('/products/:filename', imageController.getProductImage);
router.get('/categories/:filename', imageController.getCategoryImage);

module.exports = router;
