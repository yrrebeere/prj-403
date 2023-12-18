const express = require('express');
const router = express.Router();
const asyncHandler = require('../Helpers/asyncHandler');
const validate = require('validate.js');

router.post('/',asyncHandler((req,res) =>{
    const constraints = {
        phone_number: {
            presence : true
        },
        name: {
            presence : true
        },
        password: {
            presence : true
        },
        user_name: {
            presence : true
        },
        language: {
            presence : true
        },
        user_type: {
            presence : true
        },
    }
    const phone_number = req.body.phone_number;
    const name = req.body.name;
    const password = req.body.password;
    const user_name = req.body.user_name;
    const language = req.body.language;
    const user_type = req.body.user_type;

    const validation = validate({phone_number,name,password,user_name,language,user_type},constraints);

    if(validation) return res.status(400).json({error: validation});

    }
))

module.exports = router;