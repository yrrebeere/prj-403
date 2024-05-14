from flask import Flask, request, jsonify, render_template
from darts.models import XGBModel
import numpy as np

app = Flask(__name__)

@app.route('/get-weekly-prediction/<store>/<product>')
def get_weekly_prediction(store, product):
    prediction = (store + product)
    return jsonify(prediction), 200

@app.route('/get-monthly-prediction/<store>/<product>')
def get_monthly_prediction(store, product):
    prediction = (store + product + store)
    return jsonify(prediction), 200

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict', methods=["POST"])
def predict():

    xgb_model = XGBModel.load("models/xgb/XGBoost_S8F30M.pkl")

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
