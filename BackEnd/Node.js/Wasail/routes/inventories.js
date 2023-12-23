var router = require('express').Router();

const productinventoryController = require('../controllers/productinventoryController')

/* GET users listing. */
// router.get('/', function(req, res, next) {
//   res.send('respond with a resource');
// });


//vendor
router.post('/addproductinventory',productinventoryController.addProductInventory)
router.get('/allproductinventories',productinventoryController.getAllProductInventories)
router.get('/:product_inventory_id', productinventoryController.getOneProductInventory)
router.put('/:product_inventory_id', productinventoryController.updateProductInventory)
router.delete('/:product_inventory_id', productinventoryController.deleteProductInventory)

module.exports = router;
