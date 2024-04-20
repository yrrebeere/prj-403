'use strict';

module.exports = (sequelize, Datatypes)=>{
    return sequelize.define('admin',{
        admin_id:{
            type: Datatypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        admin_role:{
            type: Datatypes.STRING,
            isAlpha: true,
            notNull: true,
        },
        email:{
            type: Datatypes.STRING,
            isAlpha: true,
            notNull: true,
            isEmail: true,
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