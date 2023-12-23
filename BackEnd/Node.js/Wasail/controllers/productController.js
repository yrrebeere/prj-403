const db = require('../models')

const Product = db.product

const addProduct = async (req, res) => {

    let data = {
        product_name: req.body.product_name
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

module.exports = {
    addProduct,
    getAllProducts,
    getOneProduct,
    updateProduct,
    deleteProduct
}