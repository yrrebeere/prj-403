const db = require('../models')

const Store = db.grocery_store

const addStore = async (req, res) => {

    let data = {
        store_name: req.body.store_name,
        store_address: req.body.store_address,
        user_table_user_id: req.body.user_table_user_id
    }

    const store = await Store.create(data)
    res.status(200).send(store)
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

module.exports = {
    addStore,
    getAllStores,
    getOneStore,
    updateStore,
    deleteStore
}