const db = require('../models')

const Vendor = db.vendor

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

module.exports = {
    addVendor,
    getAllVendors,
    getOneVendor,
    updateVendor,
    deleteVendor
}