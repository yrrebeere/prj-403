from flask import Flask, request, jsonify, render_template
from darts.models import XGBModel
import numpy as np


app = Flask(__name__)


@app.route('/get-weekly-prediction/<model>/<store>/<product>')
def get_weekly_prediction(model, store, product):
    forecasting_model = XGBModel.load("models/xgb/XGB_S"+store+"P"+product+".pkl")
    prediction = forecasting_model.predict(n=7)
    prediction = prediction.pd_series().tolist()
    prediction = np.maximum(prediction, 0)
    prediction = sum(prediction)
    prediction = int(prediction)
    return jsonify(prediction), 200


@app.route('/get-monthly-prediction/<model>/<store>/<product>')
def get_monthly_prediction(model, store, product):
    forecasting_model = XGBModel.load("models/xgb/XGB_S" + store + "P" + product + ".pkl")
    prediction = forecasting_model.predict(n=30)
    prediction = prediction.pd_series().tolist()
    prediction = np.maximum(prediction, 0)
    prediction = sum(prediction)
    prediction = int(prediction)
    return jsonify(prediction), 200


@app.route('/')
def home():
    return render_template('index.html')


@app.route('/predict', methods=["POST"])
def predict():

    xgb_model = XGBModel.load("models/xgb/XGB_S8P30.pkl")

    xgb_predictions = xgb_model.predict(n=30)
    xgb_predictions = xgb_predictions.pd_series().tolist()
    xgb_predictions = np.maximum(xgb_predictions, 0)
    xgb_predictions = sum(xgb_predictions)
    xgb_predictions = int(xgb_predictions)

    return render_template(
        'index.html', 
        predictions = xgb_predictions,
    )


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)

