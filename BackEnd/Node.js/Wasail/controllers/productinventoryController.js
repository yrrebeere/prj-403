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

const searchProductByVID = async (req, res) => {
    try {
        const vendor_id = req.params.vendor_vendor_id;

        if (!vendor_id) {
            return res.status(400).json({ error: 'Vendor ID is required.' });
        }

        const inventories = await Inventory.findAll({
            where: {

                vendor_vendor_id: vendor_id,
            },
        });

        res.status(200).send(inventories);
    } catch (error) {
        console.error('Error searching products by vendor:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const selectProduct = async (req, res) => {
    try {
        const product_inventory_id = req.params.product_inventory_id;

        if (!product_inventory_id) {
            return res.status(400).json({ error: 'Product Inventory ID is required.' });
        }

        const productInventory = await Inventory.findOne({
            where: {
                product_inventory_id: product_inventory_id,
            },
        });

        if (!productInventory) {
            return res.status(404).json({ error: 'Product Inventory not found for the given ID.' });
        }

        const product = await db.product.findOne({
            where: {
                product_id: productInventory.product_product_id,
            },
        });

        if (!product) {
            return res.status(404).json({ error: 'Product not found for the given Product Inventory ID.' });
        }

        res.status(200).json({
            productInventory,
            product,
        });
    } catch (error) {
        console.error('Error selecting product:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};


module.exports = {
    addProductInventory,
    getAllProductInventories,
    getOneProductInventory,
    updateProductInventory,
    deleteProductInventory,
    searchProductByVID,
    selectProduct
}