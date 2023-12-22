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
    },{
        underscored:true
    })
}