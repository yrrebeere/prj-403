var router = require('express').Router();

const imageController = require('../controllers/imageController')


/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });

router.get('/images/:filename', imageController.getImage);

module.exports = router;
