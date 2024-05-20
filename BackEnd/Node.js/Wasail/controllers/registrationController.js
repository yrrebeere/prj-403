const db = require('../models')
const { Op } = require("sequelize");
const User = db.user_table
const Vendor = db.vendor
const Store = db.grocery_store

const addRegistration = async (req, res) => {
    try {
        const userInfo = {
            phone_number: req.body.phone_number,
            name: req.body.name,
            password: req.body.password,
            username: req.body.username,
            language: req.body.language,
            user_type: req.body.user_type,
        };

        const user = await User.create(userInfo);

        if (user) {
            const vendorInfo = {
                vendor_name: req.body.vendor_name,
                delivery_locations: req.body.delivery_locations,
                user_table_user_id: req.body.user_table_user_id
            };


            const vendor = await Vendor.create(vendorInfo);


            res.status(200).json({ user, vendor });
        } else {
            res.status(400).json({ error: 'Failed to create user.' });
        }
    } catch (error) {
        console.error('Error creating user and vendor:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const addStoreRegistration = async (req, res) => {
    try {
        const userInfo = {
            phone_number: req.body.phone_number,
            name: req.body.name,
            password: req.body.password,
            username: req.body.username,
            language: req.body.language,
            user_type: req.body.user_type,
        };

        const user = await User.create(userInfo);

        if (user) {
            const storeInfo = {
                store_name: req.body.store_name,
                image: req.body.image,
                store_address: req.body.store_address,
                user_table_user_id: req.body.user_table_user_id
            };


            const store = await Store.create(storeInfo);


            res.status(200).json({ user, store });
        } else {
            res.status(400).json({ error: 'Failed to create user.' });
        }
    } catch (error) {
        console.error('Error creating user and vendor:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

module.exports = {
    addRegistration,
    addStoreRegistration
};
