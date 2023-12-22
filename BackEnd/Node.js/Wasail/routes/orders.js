var router = require('express').Router();

const orderController = require('../controllers/orderController')


/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });

//user_table
router.post('/addorder', orderController.addOrder)
router.get('/allorders', orderController.getAllOrders)
router.get('/:order_id', orderController.getOneOrder)
router.put('/:order_id', orderController.updateOrder)
router.delete('/:order_id', orderController.deleteOrder)



module.exports = router;
