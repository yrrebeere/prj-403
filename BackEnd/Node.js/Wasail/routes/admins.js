var router = require('express').Router();

const adminController = require('../controllers/adminController')

/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });

router.post('/addadmin',adminController.addAdmin)
router.get('/alladmins',adminController.getAllAdmins)
router.get('/:admin_id', adminController.getOneAdmin)
router.put('/:admin_id', adminController.updateAdmin)
router.delete('/:admin_id', adminController.deleteAdmin)
module.exports = router;
