'use strict';

module.exports = (sequelize, Datatypes)=>{
    return sequelize.define('list',{
        grocery_store_store_id: {
            type: Datatypes.INTEGER,
            primaryKey: true,
            references: {
                model: 'grocery_stores',
                key: 'store_id'
            },
            allowNull: false
        },
        vendor_vendor_id: {
            type: Datatypes.INTEGER,
            primaryKey: true,
            references: {
                model: 'vendors',
                key: 'vendor_id'
            },
            allowNull: false
        },
    },{
        underscored:true
    })
}