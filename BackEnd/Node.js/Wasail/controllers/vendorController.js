const db = require('../models')
const { Op } = require("sequelize");
const Vendor = db.vendor

const addVendor = async (req, res) => {

    let data = {
        vendor_name: req.body.vendor_name,
        delivery_locations: req.body.delivery_locations,
        image: req.body.image,
        user_table_user_id: req.body.user_table_user_id
    }

    const vendor = await Vendor.create(data)
    res.status(201).send(vendor)
}

const getAllVendors = async (req, res) => {

    const vendors = await Vendor.findAll({})
    res.status(200).send(vendors)

}

const getOneVendor = async (req, res) => {

    let vendor_id = req.params.vendor_id
    let vendor = await Vendor.findOne({ where: { vendor_id: vendor_id }})
    res.status(200).send(vendor)

}

const updateVendor = async (req, res) => {

    let vendor_id = req.params.vendor_id
    const vendor = await Vendor.update(req.body, { where: { vendor_id: vendor_id }})
    res.status(200).send(vendor)

}

const deleteVendor = async (req, res) => {

    let vendor_id = req.params.vendor_id
    await Vendor.destroy({ where: { vendor_id: vendor_id }} )
    res.status(200).send('Vendor is deleted !')

}

const getVendorIdByUserId = async (req, res) => {
    try {

        const user_id = req.params.user_table_user_id;

        if (!user_id) {
            return res.status(400).json({ error: 'User ID is required.' });
        }

        const vendor = await Vendor.findOne({
            where: {
                user_table_user_id: {
                    [Op.eq]: user_id,
                },
            },
        });

        res.status(200).send(vendor);

    } catch (error) {
        console.error('Error getting vendor id by user id:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const vendorProfile = async (req, res) => {
    try {
        const vendor_id = req.params.vendor_id;

        if (!vendor_id) {
            return res.status(400).json({ error: 'Vendor ID is required.' });
        }

        const vendor = await Vendor.findOne({
            where: {
                vendor_id: vendor_id,
            },
        });

        if (!vendor) {
            return res.status(404).json({ error: 'Vendor not found for the given vendor ID.' });
        }

        const productInventories = await db.product_inventory.findAll({
            where: {
                vendor_vendor_id: vendor_id,
            },
        });

        const productIds = productInventories.map((inventory) => inventory.product_product_id);

        const products = await db.product.findAll({
            where: {
                product_id: productIds,
            },
        });

        res.status(200).json({ vendor, productInventories,products });
    } catch (error) {
        console.error('Error searching products by vendor:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const searchVendorInStore = async (req, res) => {
    try {
        const vendor_name = req.params.vendor_name;

        if (!vendor_name) {
            return res.status(400).json({ error: 'Vendor name is required.' });
        }

        // Step 1: Search Vendors by Name
        const vendors = await Vendor.findAll({
            where: {
                vendor_name: {
                    [Op.like]: `%${vendor_name}%`,
                },
            },
        });

        if (!vendors || vendors.length === 0) {
            return res.status(404).json({ error: 'No vendors found for the given name.' });
        }

        // Step 2: Extract Vendor IDs
        const vendorIds = vendors.map((vendor) => vendor.vendor_id);

        // Step 3: Search Product Inventories by Vendor IDs
        const productInventories = await db.product_inventory.findAll({
            where: {
                vendor_vendor_id: {
                    [Op.in]: vendorIds,
                },
            },
        });

        if (!productInventories || productInventories.length === 0) {
            return res.status(404).json({ error: 'No product inventory found for the given vendors.' });
        }

        // Step 4: Extract Product IDs
        const productIds = productInventories.map((inventory) => inventory.product_product_id);

        // Step 5: Search Products by Product IDs
        const products = await db.product.findAll({
            where: {
                product_id: {
                    [Op.in]: productIds,
                },
            },
        });

        if (!products || products.length === 0) {
            return res.status(404).json({ error: 'No products found for the given vendors.' });
        }

        res.status(200).json({
            vendors,
            productInventories,
            products,
        });
    } catch (error) {
        console.error('Error searching vendor details:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const vendorCount = async (req, res) => {
    try {
        const totalVendors = await Vendor.count();

        res.status(200).json({ totalVendors });
    } catch (error) {
        console.error('Error calculating total vendors:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};



module.exports = {
    addVendor,
    getAllVendors,
    getOneVendor,
    updateVendor,
    deleteVendor,
    getVendorIdByUserId,
    vendorProfile,
    searchVendorInStore,
    vendorCount
}