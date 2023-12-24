const db = require('../models')
const { Op } = require("sequelize");
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
    res.status(201).send(user)
}

const getAllUsers = async (req, res) => {

    let users = await User.findAll({
        attributes: [
            'user_id',
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

const numberExists = async (req, res) => {
    try {
        let phone_number = req.params.phone_number;

        let user = await User.findOne({
            where: {
                phone_number: {
                    [Op.eq]: phone_number,
                },
            },
        });

        if(user == null) {
            res.status(200).send(false)
        }
        else
            res.status(200).send(true)
    }
    catch (error) {
        console.error('Error checking phone number existence:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const usernameExists = async (req, res) => {
    try {
        let username = req.params.username;

        let user = await User.findOne({
            where: {
                username: {
                    [Op.eq]: phone_number,
                },
            },
        });

        if(user == null) {
            res.status(200).send(false)
        }
        else
            res.status(200).send(true)
    }
    catch (error) {
        console.error('Error checking phone number existence:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};




module.exports = {
    addUser,
    getAllUsers,
    getOneUser,
    updateUser,
    deleteUser,
    numberExists,
    usernameExists
}