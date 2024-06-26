'use strict';

module.exports = (sequelize, Datatypes)=>{
    return sequelize.define('image',{
        filename: {
            type: Datatypes.STRING,
            allowNull: false
        },
        filepath: {
            type: Datatypes.STRING,
            allowNull: false
        },
        uploadedAt: {
            type: Datatypes.DATE,
            allowNull: false,
            defaultValue: Datatypes.NOW
        },
    },
        {
            underscored:true
        }
    )
}
