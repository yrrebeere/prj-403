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
    },{
        underscored:true
    })
}