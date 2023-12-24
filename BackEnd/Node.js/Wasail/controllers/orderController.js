const db = require('../models')

const Order = db.order

const addOrder = async (req, res) => {

    let data = {
        order_date: req.body.order_date,
        delivery_date: req.body.delivery_date,
        total_bill: req.body.total_bill,
        order_status: req.body.order_status,
        grocery_store_store_id: req.body.grocery_store_store_id,
        vendor_vendor_id: req.body.vendor_vendor_id
    }

    const order = await Order.create(data)
    res.status(200).send(order)
}

const getAllOrders = async (req, res) => {

    const orders = await Order.findAll({})
    res.status(200).send(orders)

}

const getOneOrder = async (req, res) => {

    let order_id = req.params.order_id
    let order = await Order.findOne({ where: { order_id: order_id }})
    res.status(200).send(order)

}

const updateOrder = async (req, res) => {

    let order_id = req.params.order_id
    const order = await Order.update(req.body, { where: { order_id: order_id }})
    res.status(200).send(order)

}

const deleteOrder = async (req, res) => {

    let order_id = req.params.order_id
    await Order.destroy({ where: { order_id: order_id }} )
    res.status(200).send('Order is deleted !')

}

module.exports = {
    addOrder,
    getAllOrders,
    getOneOrder,
    updateOrder,
    deleteOrder
}