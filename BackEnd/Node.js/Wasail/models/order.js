'use strict';

module.exports = (sequelize, Datatypes)=>{
    return sequelize.define('order',{
        order_id:{
            type: Datatypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        order_date:{
            type: Datatypes.DATE,
            notNull: true,
        },
        delivery_date:{
            type: Datatypes.DATE,
            notNull: true,
        },
        total_bill:{
            type: Datatypes.INTEGER,
            isAlphanumeric: true,
            notNull: true,
            len: [8,12],
        },
        order_status:{
            type: Datatypes.ENUM('In Process', 'On Its Way', 'Delivered')
        },
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
    },
        {
            underscored:true
        }
    )
}
