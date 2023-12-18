const db = require('../models')

const User = db.user_table

const addUser = async (req, res) => {

    let info = {
        phone_number: req.body.phone_number,
        name: req.body.name,
        password: req.body.password,
        username: req.body.username,
        language: req.body.language,
        user_type: req.body.user_type
    }

    const user = await User.create(info)
    res.status(200).send(user)
    console.log(user)
}

const getAllUsers = async (req, res) => {

    let users = await User.findAll({
        attributes: [
            'phone_number',
            'name',
            'username',
            'language',
            'user_type'
        ]
    })
    res.status(200).send(users)

}

const getOneUser = async (req, res) => {

    let user_id = req.params.user_id
    let user = await User.findOne({ where: { user_id: user_id }})
    res.status(200).send(user)

}

const updateUser = async (req, res) => {

    let user_id = req.params.user_id
    const user = await User.update(req.body, { where: { user_id: user_id }})
    res.status(200).send(user)

}

const deleteUser = async (req, res) => {

    let user_id = req.params.user_id
    await User.destroy({ where: { user_id: user_id }} )
    res.status(200).send('User is deleted !')

}

module.exports = {
    addUser,
    getAllUsers,
    getOneUser,
    updateUser,
    deleteUser
}