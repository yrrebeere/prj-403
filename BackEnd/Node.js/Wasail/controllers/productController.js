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

module.exports = {
    addProduct,
    getAllProducts,
    getOneProduct,
    updateProduct,
    deleteProduct,
    searchProduct
}