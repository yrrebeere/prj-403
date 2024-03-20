const db = require('../models')
const { Op } = require("sequelize");
const Order = db.order
const Detail = db.order_detail

const addOrder = async (req, res) => {

    let data = {
        order_date: req.body.order_date,
        delivery_date: req.body.delivery_date,
        total_bill: req.body.total_bill,
        order_status: req.body.order_status,
        grocery_store_store_id: req.body.grocery_store_store_id,
        vendor_vendor_id: req.body.vendor_vendor_id
    }

    const order = await Order.create(data)
    res.status(200).send(order)
}

const getAllOrders = async (req, res) => {

    const orders = await Order.findAll({})
    res.status(200).send(orders)

}

const getOneOrder = async (req, res) => {

    let order_id = req.params.order_id
    let order = await Order.findOne({ where: { order_id: order_id }})
    res.status(200).send(order)

}

const updateOrder = async (req, res) => {

    let order_id = req.params.order_id
    const order = await Order.update(req.body, { where: { order_id: order_id }})
    res.status(200).send(order)

}

const deleteOrder = async (req, res) => {

    let order_id = req.params.order_id
    await Order.destroy({ where: { order_id: order_id }} )
    res.status(200).send('Order is deleted !')

}
const searchOrderByVID = async (req, res) => {
    try {
        const vendor_id = req.params.vendor_vendor_id;

        if (!vendor_id) {
            return res.status(400).json({ error: 'Vendor ID is required.' });
        }

        const orders = await Order.findAll({
            where: {
                vendor_vendor_id: vendor_id,
                order_status: {
                    [Op.in]: ['In Process', 'On Its Way'],
                },
            },
        });

        res.status(200).send(orders);
    } catch (error) {
        console.error('Error searching products by vendor:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const orderHistory = async (req, res) => {
    try {
        const vendor_id = req.params.vendor_vendor_id;

        if (!vendor_id) {
            return res.status(400).json({ error: 'Vendor ID is required.' });
        }

        const orders = await Order.findAll({
            where: {
                vendor_vendor_id: vendor_id,
                order_status: {
                    [Op.in]: ['Delivered'],
                },
            },
        });

        res.status(200).send(orders);
    } catch (error) {
        console.error('Error searching products by vendor:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const searchOrderByGID = async (req, res) => {
    try {
        const vendor_id = req.params.vendor_vendor_id;
        const store_id = req.params.grocery_store_store_id;

        if (!vendor_id && !store_id) {
            return res.status(400).json({ error: 'Vendor ID or Grocery Store ID is required.' });
        }

        const whereClause = {};

        if (vendor_id) {
            whereClause.vendor_vendor_id = vendor_id;
        }

        if (store_id) {
            whereClause.grocery_store_store_id = store_id;
        }

        const orders = await Order.findAll({
            where: {
                ...whereClause,
                order_status: {
                    [Op.in]: ['In Process', 'On Its Way'],
                },
            },
        });

        res.status(200).send(orders);
    } catch (error) {
        console.error('Error searching orders by vendor and store:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const orderHistoryByGID = async (req, res) => {
    try {
        const vendor_id = req.params.vendor_vendor_id;
        const store_id = req.params.grocery_store_store_id;

        if (!vendor_id && !store_id) {
            return res.status(400).json({ error: 'Vendor ID or Grocery Store ID is required.' });
        }

        const whereClause = {};

        if (vendor_id) {
            whereClause.vendor_vendor_id = vendor_id;
        }

        if (store_id) {
            whereClause.grocery_store_store_id = store_id;
        }

        const orders = await Order.findAll({
            where: {
                ...whereClause,
                order_status: {
                    [Op.in]: ['Delivered'],
                },
            },
        });

        res.status(200).send(orders);
    } catch (error) {
        console.error('Error searching orders by vendor and store:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const storeOrderHistory = async (req, res) => {
    try {
        const store_id = req.params.grocery_store_store_id;

        if (!store_id) {
            return res.status(400).json({ error: 'Store ID is required.' });
        }

        const orders = await Order.findAll({
            where: {
                grocery_store_store_id: store_id,
                order_status: {
                    [Op.in]: ['Delivered'],
                },
            },
        });

        res.status(200).send(orders);
    } catch (error) {
        console.error('Error searching products by store:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

const storeCurrentOrders = async (req, res) => {
    try {
        const store_id = req.params.grocery_store_store_id;

        if (!store_id) {
            return res.status(400).json({ error: 'Store ID is required.' });
        }

        const orders = await Order.findAll({
            where: {
                grocery_store_store_id: store_id,
                order_status: {
                    [Op.in]: ['In Process', 'On Its Way'],
                },
            },
        });

        res.status(200).send(orders);
    } catch (error) {
        console.error('Error searching products by store:', error);
        res.status(500).json({ error: 'Internal Server Error' });
    }
};

module.exports = {
    addOrder,
    getAllOrders,
    getOneOrder,
    updateOrder,
    deleteOrder,
    searchOrderByVID,
    orderHistory,
    searchOrderByGID,
    orderHistoryByGID,
    storeOrderHistory,
    storeCurrentOrders
}