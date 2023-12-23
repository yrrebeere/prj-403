const db = require('../models')

const Category = db.product_category

const addProductCategory = async (req, res) => {

    let data = {
        category_name: req.body.category_name
    }

    const category = await Category.create(data)
    res.status(200).send(category)
}

const getAllProductCategories = async (req, res) => {

    const categories = await Category.findAll({})
    res.status(200).send(categories)

}

const getOneProductCategory = async (req, res) => {

    let product_category_id = req.params.product_category_id
    let category = await Category.findOne({ where: { product_category_id: product_category_id }})
    res.status(200).send(category)

}

const updateProductCategory = async (req, res) => {

    let product_category_id = req.params.product_category_id
    const category = await Category.update(req.body, { where: { product_category_id: product_category_id }})
    res.status(200).send(category)

}

const deleteProductCategory = async (req, res) => {

    let product_category_id = req.params.product_category_id
    await Category.destroy({ where: { product_category_id: product_category_id }} )
    res.status(200).send('Product Category is deleted !')

}

module.exports = {
    addProductCategory,
    getAllProductCategories,
    getOneProductCategory,
    updateProductCategory,
    deleteProductCategory
}