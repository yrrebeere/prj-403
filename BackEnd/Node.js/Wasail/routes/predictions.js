var router = require('express').Router();

const predictionController = require('../controllers/predictionController')


router.get('/sendweeklyprediction/:store_id/:product_id',predictionController.sendWeeklyPrediction);
router.get('/sendmonthlyprediction/:store_id/:product_id',predictionController.sendMonthlyPrediction);


module.exports = router;
