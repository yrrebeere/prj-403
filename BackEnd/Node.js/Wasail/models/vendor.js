'use strict';

module.exports = (sequelize, Datatypes)=>{
    return sequelize.define('vendor',{
        vendor_id:{
            type: Datatypes.INTEGER,
            primaryKey: true,
            autoIncrement: true
        },
        vendor_name:{
            type: Datatypes.STRING,
            isAlpha: true,
            notNull: true,
        },

        delivery_locations:{
            type: Datatypes.ENUM('Dha', 'Gulberg', 'State Life ')
        },
    },{
        underscored:true
    })
}