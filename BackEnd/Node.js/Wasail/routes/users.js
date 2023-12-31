var router = require('express').Router();

const usertableController = require('../controllers/usertableController')


/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });

//user_table
router.post('/adduser', usertableController.addUser)
router.get('/allusers', usertableController.getAllUsers)
router.get('/:user_id', usertableController.getOneUser)
router.put('/:user_id', usertableController.updateUser)
router.delete('/:user_id', usertableController.deleteUser)
router.get('/numberexists/:phone_number', usertableController.numberExists)
router.get('/usernameexists/:username', usertableController.usernameExists)
router.get('/userauthentication/:phone_number', usertableController.userAuthentication)


module.exports = router;
