const db = require('../models')

const Detail = db.order_detail

const addOrderDetail = async (req, res) => {

    let data = {
        quantity: req.body.quantity,
        unit_price: req.body.unit_price,
        total_price: req.body.total_price
    }

    const detail = await Detail.create(data)
    res.status(200).send(detail)
}

const getAllOrderDetails = async (req, res) => {

    const details = await Detail.findAll({})
    res.status(200).send(details)

}

const getOneOrderDetail = async (req, res) => {

    let detail_id = req.params.detail_id
    let detail = await Detail.findOne({ where: { detail_id: detail_id }})
    res.status(200).send(detail)

}

const updateOrderDetail = async (req, res) => {

    let detail_id = req.params.detail_id
    const detail = await Detail.update(req.body, { where: { detail_id: detail_id }})
    res.status(200).send(detail)

}

const deleteOrderDetail = async (req, res) => {

    let detail_id = req.params.detail_id
    await Detail.destroy({ where: { detail_id: detail_id }} )
    res.status(200).send('Order Detail is deleted !')

}

module.exports = {
    addOrderDetail,
    getAllOrderDetails,
    getOneOrderDetail,
    updateOrderDetail,
    deleteOrderDetail
}