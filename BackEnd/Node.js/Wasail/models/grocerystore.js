'use strict';

module.exports = (sequelize, Datatypes)=>{
    return sequelize.define('grocery_store',{
        store_id:{
            type: Datatypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        store_name:{
            type: Datatypes.STRING,
            notNull: true,
        },

        store_address:{
            type: Datatypes.STRING,
            notNull: true,
        },
    },{
        underscored:true
    })
}