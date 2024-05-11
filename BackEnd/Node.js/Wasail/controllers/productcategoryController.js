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

const searchCategoryInStore = async (req, res) => {
    try {
        const category_name = req.params.category_name;

        if (!category_name) {
            return res.status(400).json({ error: 'Category name is required.' });
        }

        const categories = await Category.findAll({
            where: {
                category_name: {
                    [Op.like]: `%${category_name}%`,
                },
            },
        });

        if (!categories || categories.length === 0) {
            return res.status(404).json({ error: 'No categories found for the given name.' });
        }

        const categoryIds = categories.map((category) => category.product_category_id);

        const productCategoryLinks = await db.product_category_link.findAll({
            where: {
                product_category_product_category_id: {
                    [Op.in]: categoryIds,
                },
            },
        });

        if (!productCategoryLinks || productCategoryLinks.length === 0) {
            return res.status(404).json({ error: 'No product-category links found for the given categories.' });
        }

        const productIds = productCategoryLinks.map((link) => link.product_product_id);

        const products = await db.product.findAll({
            where: {
                product_id: {
                    [Op.in]: productIds,
                },
            },
        });

        if (!products || products.length === 0) {
            return res.status(404).json({ error: 'No products found for the given categories.' });
        }

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
            categories,
            products,
            productInventories,
            vendors,
        });
    } catch (error) {
        console.error('Error searching category details:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const productCategoryCount = async (req, res) => {
    try {
        const totalProductCategories = await Category.count();

        res.status(200).json({ totalProductCategories });
    } catch (error) {
        console.error('Error calculating total vendors:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};




module.exports = {
    addProductCategory,
    getAllProductCategories,
    getOneProductCategory,
    updateProductCategory,
    deleteProductCategory,
    searchProductCategory,
    searchCategoryInStore,
    productCategoryCount
}