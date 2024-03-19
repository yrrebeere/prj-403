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
router.get('/search/:vendor_vendor_id', orderController.searchOrderByVID)
router.get('/orderhistory/:vendor_vendor_id', orderController.orderHistory)
router.get('/searchgroceryorder/:vendor_vendor_id/:grocery_store_store_id', orderController.searchOrderByGID)
router.get('/groceryorderhistory/:vendor_vendor_id/:grocery_store_store_id', orderController.orderHistoryByGID)
router.get('/storeorderhistory/:grocery_store_store_id', orderController.storeOrderHistory)


module.exports = router;
