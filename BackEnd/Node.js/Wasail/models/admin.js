'use strict';

module.exports = (sequelize, Datatypes)=>{
    return sequelize.define('admin',{
        admin_id:{
            type: Datatypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        role:{
            type: Datatypes.STRING,
            isAlpha: true,
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