var router = require('express').Router();

const predictionController = require('../controllers/predictionController')


router.get('/sendweeklyprediction/:model/:store_number/:product_number',predictionController.sendWeeklyPrediction);
router.get('/sendmonthlyprediction/:model/:store_number/:product_number',predictionController.sendMonthlyPrediction);


module.exports = router;
