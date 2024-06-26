const db = require('../models')
const { Sequelize } = require('sequelize');
const axios = require('axios');

const sendWeeklyPrediction = async (req, res) => {
    try {
        const { model, store_number, product_number} = req.params;

        if (!store_number || !product_number) {
            return res.status(400).json({ error: 'Store ID and product ID are required.' });
        }

        const url = `https://hammerhead-app-6m6td.ondigitalocean.app/get-weekly-prediction/${model}/${store_number}/${product_number}`;


        const response = await axios.get(url);

        res.status(200).json(response.data);
    } catch (error) {
        console.error('Error sending weekly prediction request:', error);

        if (error.response) {
            res.status(error.response.status).json({ error: error.response.data });
        } else if (error.request) {
            res.status(500).json({ error: 'No response received from prediction service.' });
        } else {
            res.status(500).json({ error: 'Error in sending request to prediction service.' });
        }
    }
};

const sendMonthlyPrediction = async (req, res) => {
    try {
        const { model, store_number, product_number} = req.params;

        if (!store_number || !product_number) {
            return res.status(400).json({ error: 'Store ID and product ID are required.' });
        }

        const url = `https://hammerhead-app-6m6td.ondigitalocean.app/get-monthly-prediction/${model}/${store_number}/${product_number}`;

        const response = await axios.get(url);

        res.status(200).json(response.data);
    } catch (error) {
        console.error('Error sending weekly prediction request:', error);

        if (error.response) {
            res.status(error.response.status).json({ error: error.response.data });
        } else if (error.request) {
            res.status(500).json({ error: 'No response received from prediction service.' });
        } else {
            res.status(500).json({ error: 'Error in sending request to prediction service.' });
        }
    }
};

module.exports = {
    sendWeeklyPrediction,
    sendMonthlyPrediction
}
