const db = require('../models')

const Inventory = db.product_inventory

const addProductInventory = async (req, res) => {

    let data = {
        price: req.body.price,
        available_amount: req.body.available_amount,
        listed_amount: req.body.listed_amount,
        vendor_vendor_id: req.body.vendor_vendor_id,
        product_product_id: req.body.product_product_id
    }

    const inventory = await Inventory.create(data)
    res.status(200).send(inventory)
}

const getAllProductInventories = async (req, res) => {

    const inventories = await Inventory.findAll({})
    res.status(200).send(inventories)

}

const getOneProductInventory = async (req, res) => {

    let product_inventory_id = req.params.product_inventory_id
    let inventory = await Inventory.findOne({ where: { product_inventory_id: product_inventory_id }})
    res.status(200).send(inventory)

}

const updateProductInventory = async (req, res) => {

    let product_inventory_id = req.params.product_inventory_id
    const inventory = await Inventory.update(req.body, { where: { product_inventory_id: product_inventory_id }})
    res.status(200).send(inventory)

}

const deleteProductInventory = async (req, res) => {

    let product_inventory_id = req.params.product_inventory_id
    await Inventory.destroy({ where: { product_inventory_id: product_inventory_id }} )
    res.status(200).send('Product Inventory is deleted !')

}

module.exports = {
    addProductInventory,
    getAllProductInventories,
    getOneProductInventory,
    updateProductInventory,
    deleteProductInventory
}