'use strict';

module.exports = (sequelize, Datatypes)=>{
    return sequelize.define('product_category',{
        product_category_id:{
            type: Datatypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        category_name:{
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