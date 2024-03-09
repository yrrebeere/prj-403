const db = require('../models')
const { Op } = require("sequelize");
const Category = db.product_category

const addProductCategory = async (req, res) => {

    let data = {
        category_name: req.body.category_name,
        image: req.body.image
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

const searchProductCategory = async (req, res) => {
    try {
        let category_name = req.params.category_name;

        if (!category_name) {
            return res.status(400).json({ error: 'Search term is required.' });
        }

        const category = await Category.findAll({
            where: {

                category_name: {
                    [Op.like]: `%${category_name}%`,
                },

            },
        });

        res.status(200).send(category)
    } catch (error) {
        console.error('Error searching products:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

module.exports = {
    addProductCategory,
    getAllProductCategories,
    getOneProductCategory,
    updateProductCategory,
    deleteProductCategory,
    searchProductCategory
}