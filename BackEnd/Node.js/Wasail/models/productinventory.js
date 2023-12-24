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
        vendor_vendor_id: {
            type: Datatypes.INTEGER,
            references: {
                model: 'vendors',
                key: 'vendor_id'
            },
            allowNull: false
        },

        product_product_id: {
            type: Datatypes.INTEGER,
            references: {
                model: 'products',
                key: 'product_id'
            },
            allowNull: false
        },

    },{
        underscored:true
    })
}