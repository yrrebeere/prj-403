var router = require('express').Router();

const orderdetailController = require('../controllers/orderdetailController')


/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });

//user_table
router.post('/addorderdetail', orderdetailController.addOrderDetail)
router.get('/allorderdetails', orderdetailController.getAllOrderDetails)
router.get('/:detail_id', orderdetailController.getOneOrderDetail)
router.put('/:detail_id', orderdetailController.updateOrderDetail)
router.delete('/:detail_id', orderdetailController.deleteOrderDetail)



module.exports = router;
