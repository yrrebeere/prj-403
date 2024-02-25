var router = require('express').Router();

const registrationController = require('../controllers/registrationController')


/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });

//user_table
router.post('/addregistration', registrationController.addRegistration)
router.post('/addstoreregistration', registrationController.addStoreRegistration)



module.exports = router;
