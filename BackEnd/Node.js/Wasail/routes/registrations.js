var router = require('express').Router();

const registrationController = require('../controllers/registrationController')


router.post('/addregistration', registrationController.addRegistration)
router.post('/addstoreregistration', registrationController.addStoreRegistration)



module.exports = router;
