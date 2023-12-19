const db = require('../models')

const Vendor = db.vendors

const addVendor = async (req, res) => {

    let data = {
        vendor_name: req.body.vendor_name,
        delivery_locations: req.body.delivery_locations
    }

    const vendor = await Vendor.create(data)
    res.status(200).send(vendor)
}

const getAllVendors = async (req, res) => {

    const vendors = await Vendor.findAll({})
    res.status(200).send(vendors)

}

module.exports = {
    addVendor,
    getAllVendors
}