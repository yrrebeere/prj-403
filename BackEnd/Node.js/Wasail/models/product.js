'use strict';

module.exports = (sequelize, Datatypes)=>{
    return sequelize.define('product',{
        product_id:{
            type: Datatypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        product_number:{
            type: Datatypes.INTEGER,
            notNull: true,
        },
        product_name:{
            type: Datatypes.STRING,
            isAlpha: true,
            notNull: true,
        },
        image:{
            type: Datatypes.STRING,
        },
    },{
        underscored:true
    })
}