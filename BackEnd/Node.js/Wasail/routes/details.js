var router = require('express').Router();

const orderdetailController = require('../controllers/orderdetailController')


router.post('/addorderdetail', orderdetailController.addOrderDetail)
router.get('/allorderdetails', orderdetailController.getAllOrderDetails)
router.get('/:detail_id', orderdetailController.getOneOrderDetail)
router.put('/:detail_id', orderdetailController.updateOrderDetail)
router.delete('/:detail_id', orderdetailController.deleteOrderDetail)


module.exports = router;
