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
        image:{
            type: Datatypes.STRING,
        },
        store_address:{
            type: Datatypes.STRING,
            notNull: true,
        },
        user_table_user_id: {
            type: Datatypes.INTEGER,
            references: {
                model: 'user_tables',
                key: 'user_id'
            },
            allowNull: false
        },
    },{
        underscored:true
    })
}