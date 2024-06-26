const db = require('../models')
const { Op } = require("sequelize");
const List = db.list

const addVendorList = async (req, res) => {
    try {
        const store_id = req.params.grocery_store_store_id;
        const vendor_vendor_id = req.params.vendor_vendor_id;

        if (!store_id || !vendor_vendor_id) {
            return res.status(400).json({ error: 'Both store_id and vendor_vendor_id are required.' });
        }

        const newList = await List.create({
            grocery_store_store_id: store_id,
            vendor_vendor_id: vendor_vendor_id
        });

        res.status(201).json(newList);
    } catch (error) {
        console.error('Error adding vendor list:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const deleteVendorList = async (req, res) => {

    const vendor_vendor_id = req.params.vendor_vendor_id;
    await List.destroy({ where: { vendor_vendor_id: vendor_vendor_id }} )
    res.status(200).send('It is deleted !')

}

module.exports = {
    addVendorList,
    deleteVendorList
};
