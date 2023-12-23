'use strict';

module.exports = (sequelize, Datatypes)=>{
    return sequelize.define('product_inventory',{
        product_inventory_id:{
            type: Datatypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        price:{
            type: Datatypes.INTEGER,
            isNumeric: true,
            isInt: true,
            notNull: true,
        },
        available_amount:{
            type: Datatypes.INTEGER,
            isNumeric: true,
            isInt: true,
            notNull: true,
        },

        listed_amount:{
            type: Datatypes.INTEGER,
            isNumeric: true,
            isInt: true,
            notNull: true,
        },

    },{
        underscored:true
    })
}