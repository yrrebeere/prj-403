const db = require('../models')
const { Op } = require('sequelize');


const Product = db.product

const addProduct = async (req, res) => {

    let data = {
        product_name: req.body.product_name,
        image: req.body.image,
    }

    const product = await Product.create(data)
    res.status(200).send(product)
}

const getAllProducts = async (req, res) => {

    const products = await Product.findAll({})
    res.status(200).send(products)

}

const getOneProduct = async (req, res) => {

    let product_id = req.params.product_id
    let product = await Product.findOne({ where: { product_id: product_id }})
    res.status(200).send(product)

}

const updateProduct = async (req, res) => {

    let product_id = req.params.product_id
    const product = await Product.update(req.body, { where: { product_id: product_id }})
    res.status(200).send(product)

}

const deleteProduct = async (req, res) => {

    let product_id = req.params.product_id
    await Product.destroy({ where: { product_id: product_id }} )
    res.status(200).send('Product is deleted !')

}


const searchProduct = async (req, res) => {
    try {
        let product_name = req.params.product_name;
        if (!product_name) {
            return res.status(400).json({ error: 'Search term is required.' });
        }
        const product = await Product.findAll({
            where: {
                product_name: {
                    [Op.like]: `%${product_name}%`,
                },
            },
        });
        res.status(200).send(product)
    } catch (error) {
        console.error('Error searching products:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const searchProductInInventory = async (req, res) => {
    try {
        const vendor_id = req.params.vendor_vendor_id;
        let product_name = req.params.product_name;

        if (!vendor_id) {
            return res.status(400).json({ error: 'Vendor ID is required.' });
        }

        const associatedInventories = await db.product_inventory.findAll({
            where: { vendor_vendor_id: vendor_id },
        });

        const productInventoryIds = associatedInventories.map((inventory) => inventory.product_product_id);

        const products = await db.product.findAll({
            where: {
                product_id: productInventoryIds,
                product_name: {
                    [Op.like]: `%${product_name}%`,
                },
            },
        });

        res.status(200).json(products);
    } catch (error) {
        console.error('Error searching products in inventory by vendor ID:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const searchProductInStore = async (req, res) => {
    try {
        const product_name = req.params.product_name;

        if (!product_name) {
            return res.status(400).json({ error: 'Product name is required.' });
        }

        const products = await Product.findAll({
            where: {
                product_name: {
                    [Op.like]: `%${product_name}%`,
                },
            },
        });

        if (!products || products.length === 0) {
            return res.status(404).json({ error: 'No products found for the given name.' });
        }

        const productIds = products.map((product) => product.product_id);

        const productInventories = await db.product_inventory.findAll({
            where: {
                product_product_id: {
                    [Op.in]: productIds,
                },
            },
        });

        if (!productInventories || productInventories.length === 0) {
            return res.status(404).json({ error: 'No product inventory found for the given products.' });
        }

        const vendorIds = productInventories.map((inventory) => inventory.vendor_vendor_id);

        const vendors = await db.vendor.findAll({
            where: {
                vendor_id: {
                    [Op.in]: vendorIds,
                },
            },
        });

        if (!vendors || vendors.length === 0) {
            return res.status(404).json({ error: 'No vendors found for the given products.' });
        }

        res.status(200).json({
            products,
            productInventories,
            vendors,
        });
    } catch (error) {
        console.error('Error searching product details:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const productCount = async (req, res) => {
    try {
        const totalProducts = await Product.count();

        res.status(200).json({ totalProducts });
    } catch (error) {
        console.error('Error calculating total vendors:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};




module.exports = {
    addProduct,
    getAllProducts,
    getOneProduct,
    updateProduct,
    deleteProduct,
    searchProduct,
    searchProductInInventory,
    searchProductInStore,
    productCount
}