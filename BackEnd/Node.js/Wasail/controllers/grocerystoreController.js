const db = require('../models')
const { Sequelize } = require('sequelize');
const Store = db.grocery_store

const addStore = async (req, res) => {

    let data = {
        store_name: req.body.store_name,
        image: req.body.store_image,
        store_address: req.body.store_address,
        user_table_user_id: req.body.user_table_user_id
    }

    const store = await Store.create(data)
    res.status(201).send(store)
}

const getAllStores = async (req, res) => {

    const stores = await Store.findAll({})
    res.status(200).send(stores)

}

const getOneStore = async (req, res) => {

    let store_id = req.params.store_id
    let store = await Store.findOne({ where: { store_id: store_id }})
    res.status(200).send(store)

}

const updateStore = async (req, res) => {

    let store_id = req.params.store_id
    const store = await Store.update(req.body, { where: { store_id: store_id }})
    res.status(200).send(store)

}

const deleteStore = async (req, res) => {

    let store_id = req.params.store_id
    await Store.destroy({ where: { store_id: store_id }} )
    res.status(200).send('Store is deleted !')

}

const searchStoreByVID = async (req, res) => {
    try {
        const vendor_id = req.params.vendor_vendor_id;

        if (!vendor_id) {
            return res.status(400).json({ error: 'Vendor ID is required.' });
        }

        const associatedStores = await db.list.findAll({
            where: { vendor_vendor_id: vendor_id },
        });


        const groceryStoreIds = associatedStores.map((store) => store.grocery_store_store_id);


        const groceryStores = await db.grocery_store.findAll({
            where: { store_id: groceryStoreIds },
        });

        res.status(200).json(groceryStores);
    } catch (error) {
        console.error('Error searching grocery stores by vendor ID:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const viewVendorList = async (req, res) => {
    try {
        const store_id = req.params.grocery_store_store_id;

        if (!store_id) {
            return res.status(400).json({ error: 'Store ID is required.' });
        }

        const associatedVendors = await db.list.findAll({
            where: { grocery_store_store_id: store_id },
        });

        const vendorIds = associatedVendors.map((vendor) => vendor.vendor_vendor_id);

        const vendors = await db.vendor.findAll({
            where: { vendor_id: vendorIds },
        });

        res.status(200).json(vendors);
    } catch (error) {
        console.error('Error viewing vendor list:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const groceryStoreCount = async (req, res) => {
    try {
        const totalGroceryStores = await Store.count();

        res.status(200).json({ totalGroceryStores });
    } catch (error) {
        console.error('Error calculating total grocery stores:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};



module.exports = {
    addStore,
    getAllStores,
    getOneStore,
    updateStore,
    deleteStore,
    searchStoreByVID,
    viewVendorList,
    groceryStoreCount
}