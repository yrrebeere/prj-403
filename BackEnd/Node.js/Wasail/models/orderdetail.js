'use strict';

module.exports = (sequelize, Datatypes)=>{
    return sequelize.define('order_detail',{
        detail_id:{
            type: Datatypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        quantity:{
            type: Datatypes.INTEGER,
            notNull: true,
        },
        unit_price:{
            type: Datatypes.INTEGER,
            notNull: true,
        },
        total_price:{
            type: Datatypes.INTEGER,
            notNull: true,

        },
        order_order_id: {
            type: Datatypes.INTEGER,
            references: {
                model: 'orders',
                key: 'order_id'
            },
            allowNull: false
        },

        product_inventory_product_inventory_id: {
            type: Datatypes.INTEGER,
            references: {
                model: 'product_inventories',
                key: 'product_inventory_id'
            },
            allowNull: false
        },
    },
        {
            underscored:true
        }
    )
}
