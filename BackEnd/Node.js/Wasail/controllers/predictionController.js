const db = require('../models')
const { Sequelize } = require('sequelize');
const axios = require('axios');

const sendWeeklyPrediction = async (req, res) => {
    try {
        const { store_id, product_id } = req.params;

        if (!store_id || !product_id) {
            return res.status(400).json({ error: 'Store ID and product ID are required.' });
        }

        const url = `https://hammerhead-app-6m6td.ondigitalocean.app/get-weekly-prediction/${store_id}/${product_id}`;

        const response = await axios.get(url);

        res.status(200).json(response.data);
    } catch (error) {
        console.error('Error sending weekly prediction request:', error);

        if (error.response) {
            // The request was made and the server responded with a status code
            // that falls out of the range of 2xx
            res.status(error.response.status).json({ error: error.response.data });
        } else if (error.request) {
            // The request was made but no response was received
            res.status(500).json({ error: 'No response received from prediction service.' });
        } else {
            // Something happened in setting up the request that triggered an Error
            res.status(500).json({ error: 'Error in sending request to prediction service.' });
        }
    }
};

module.exports = {
    sendWeeklyPrediction

}
