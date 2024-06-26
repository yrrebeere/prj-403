'use strict';

module.exports = (sequelize, Datatypes)=>{
    return sequelize.define('product_category_link',{
        product_product_id: {
            type: Datatypes.INTEGER,
            primaryKey: true,
            references: {
                model: 'products',
                key: 'product_id'
            },
            allowNull: false
        },
        product_category_product_category_id: {
            type: Datatypes.INTEGER,
            primaryKey: true,
            references: {
                model: 'product_catgories',
                key: 'product_category_id'
            },
            allowNull: false
        },
    },
        {
            underscored:true
        }
    )
}
