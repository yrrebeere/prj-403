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

        // Step 2: Extract order IDs from the retrieved orders
        const orderIds = orders.map((order) => order.order_id);


        // Step 3: Find order details for the extracted order IDs
        const orderDetails = await Detail.findAll({
            where: {
                order_order_id: {
                    [Op.in]: orderIds,
                },
            },
        });

        // Step 4: Extract product inventory IDs from the retrieved order details
        const productInventoryIds = orderDetails.map((detail) => detail.product_inventory_product_inventory_id);

        // Step 5: Find product inventory information for the extracted IDs
        const productInventories = await db.product_inventory.findAll({
            where: {
                product_inventory_id: {
                    [Op.in]: productInventoryIds,
                },
            },
        });

        // Step 6: Extract product IDs from the retrieved product inventories
        const productIds = productInventories.map((inventory) => inventory.product_product_id);

        // Step 7: Find product information for the extracted product IDs
        const products = await db.product.findAll({
            where: {
                product_id: {
                    [Op.in]: productIds,
                },
            },
        });

        res.status(200).json({ orders, orderDetails, productInventories, products });

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

const orderPlacement = async (req, res) => {
    try {
        const data = {
            order_date: req.body.order_date,
            delivery_date: req.body.delivery_date,
            total_bill: req.body.total_bill,
            order_status: req.body.order_status,
            grocery_store_store_id: req.body.grocery_store_store_id,
            vendor_vendor_id: req.body.vendor_vendor_id
        };

        const order = await Order.create(data);

        if (order) {
            const detailInfo = {
                quantity: req.body.quantity,
                unit_price: req.body.unit_price,
                total_price: req.body.total_price,
                order_order_id: req.body.order_order_id,
                product_inventory_product_inventory_id: req.body.product_inventory_product_inventory_id
            };


            const detail = await Detail.create(detailInfo);


            res.status(200).json({ order, detail });
        } else {
            res.status(400).json({ error: 'Failed to create order.' });
        }
    } catch (error) {
        console.error('Error creating order and order details:', error);
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
    storeCurrentOrders,
    orderPlacement
}