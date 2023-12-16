'use strict';

module.exports = (sequelize, Datatypes)=>{
    return sequelize.define('user_table',{
        user_id:{
            type: Datatypes.INTEGER,
            primaryKey: true
        },
        phone_number:{
            type: Datatypes.BIGINT,
            isNumeric: true,
            isInt: true,
            notNull: true,
        },
        name:{
            type: Datatypes.STRING,
            isAlpha: true,
            notNull: true,
        },
        password:{
            type: Datatypes.STRING,
            isAlphanumeric: true,
            notNull: true,
            len: [8,12],
        },
        username:{
            type: Datatypes.STRING,
            isAlphanumeric: true,
            notNull: true,
        },
        language:{
            type: Datatypes.ENUM('English', 'Urdu', 'Roman Urdu')
        },
        user_type:{
            type: Datatypes.ENUM('Admin', 'Grocery Store', 'Vendor')
        },
    },{
        underscored:true
    })
}