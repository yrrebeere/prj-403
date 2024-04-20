const db = require('../models')
const { Op } = require("sequelize");
const Admin = db.admin

const addAdmin = async (req, res) => {

    let data = {
        admin_role: req.body.admin_role,
        email: req.body.email,
        user_table_user_id: req.body.user_table_user_id
    }

    const admin = await Admin.create(data)
    res.status(201).send(admin)
}

const getAllAdmins = async (req, res) => {

    const admins = await Admin.findAll({})
    res.status(200).send(admins)

}

const getOneAdmin = async (req, res) => {

    let admin_id = req.params.admin_id
    let admin = await Admin.findOne({ where: { admin_id: admin_id }})
    res.status(200).send(admin)

}

const updateAdmin = async (req, res) => {

    let admin_id = req.params.admin_id
    const admin = await Admin.update(req.body, { where: { admin_id: admin_id }})
    res.status(200).send(admin)

}

const deleteAdmin = async (req, res) => {

    let admin_id = req.params.admin_id
    await Admin.destroy({ where: { admin_id: admin_id }} )
    res.status(200).send('Admin is deleted !')

}

module.exports = {
    addAdmin,
    getAllAdmins,
    getOneAdmin,
    updateAdmin,
    deleteAdmin
}