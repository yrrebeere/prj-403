from flask import Flask, request, jsonify, render_template
from darts.models import RandomForest, XGBModel, Prophet, LightGBMModel
import pandas as pd
import numpy as np
from darts import TimeSeries
from darts import concatenate
from sklearn.metrics import mean_squared_error
import matplotlib.pyplot as plt
import os


app = Flask(__name__)


@app.route('/get-weekly-prediction/<model>/<store>/<product>')
def get_weekly_prediction(model, store, product):
    if model == 'prophet':
        forecasting_model = Prophet.load("models/prophet/P_S"+store+"P"+product+".pkl")
    elif model == 'lgbm':
        forecasting_model = LightGBMModel.load("models/lgbm/LGBM_S" + store + "P" + product + ".pkl")
    else:
        forecasting_model = XGBModel.load("models/xgb/XGB_S" + store + "P" + product + ".pkl")
    prediction = forecasting_model.predict(n=7)
    prediction = prediction.pd_series().tolist()
    prediction = np.maximum(prediction, 0)
    prediction = sum(prediction)
    prediction = int(prediction)
    return jsonify(prediction), 200


@app.route('/get-monthly-prediction/<model>/<store>/<product>')
def get_monthly_prediction(model, store, product):
    if model == 'prophet':
        forecasting_model = Prophet.load("models/prophet/P_S" + store + "P" + product + ".pkl")
    elif model == 'lgbm':
        forecasting_model = LightGBMModel.load("models/lgbm/LGBM_S" + store + "P" + product + ".pkl")
    else:
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


@app.route('/predict', methods=['GET', 'POST'])
def predict():
    selected_store = request.form.get('store', '1')
    selected_product = request.form.get('product', 'A')
    selected_features = request.form.getlist('features')
    selected_type = request.form.get('type', 'Univariate')
    selected_duration = request.form.get('duration', 'Week')
    selected_lag = request.form.get('lag', '2')
    selected_model = request.form.get('model', 'Prophet')

    df = pd.read_csv("data/flask.csv", parse_dates=["date"])

    df = df[(df['store_nbr'] == int(selected_store)) & (df['family'] == int(selected_product))]

    if selected_model == 'Prophet':
        df.set_index('date', inplace=True)
        ts = TimeSeries.from_dataframe(df, value_cols=["sales"], freq='d')

        if selected_duration == 'Week':
            training_size = len(ts) - 7
        else:
            training_size = len(ts) - 30

        train = ts[:training_size]
        val = ts[training_size:]

        val = val.pd_series().tolist()

        model = Prophet()
        model.fit(train)

    else:
        ts = TimeSeries.from_dataframe(df, value_cols=["sales"])

        if selected_duration == 'Week':
            training_size = len(ts) - 7
        else:
            training_size = len(ts) - 30

        train = ts[:training_size]
        val = ts[training_size:]

        val = val.pd_series().tolist()

        if selected_type == 'Multivariate':

            future_covariates = []

            if 'Holiday' in selected_features:
                typeholiday_ts = TimeSeries.from_dataframe(df, value_cols=["typeholiday"])
                future_covariates.append(typeholiday_ts)

            if 'Promotion' in selected_features:
                onpromotion_ts = TimeSeries.from_dataframe(df, value_cols=["onpromotion"])
                future_covariates.append(onpromotion_ts)

            if 'Day' in selected_features:
                day_ts = TimeSeries.from_dataframe(df, value_cols=["day"])
                future_covariates.append(day_ts)

            if 'Oil Prices' in selected_features:
                dcoilwtico_ts = TimeSeries.from_dataframe(df, value_cols=["dcoilwtico"])
                future_covariates.append(dcoilwtico_ts)

            if 'Day of Week' in selected_features:
                day_of_week_ts = TimeSeries.from_dataframe(df, value_cols=["day_of_week"])
                future_covariates.append(day_of_week_ts)

            if 'Month' in selected_features:
                month_ts = TimeSeries.from_dataframe(df, value_cols=["month"])
                future_covariates.append(month_ts)

            if 'Year' in selected_features:
                year_ts = TimeSeries.from_dataframe(df, value_cols=["year"])
                future_covariates.append(year_ts)

            if future_covariates:
                future_cov = concatenate(future_covariates, axis=1)
            else:
                future_cov = None

            len_future_covariates = len(val)
            future_covariates_lags = list(range(len_future_covariates))

            if selected_model == 'Random Forest':
                model = RandomForest(lags=int(selected_lag), lags_future_covariates=future_covariates_lags, output_chunk_length=30)
            elif selected_model == 'LightGBM':
                model = LightGBMModel(lags=int(selected_lag), lags_future_covariates=future_covariates_lags, output_chunk_length=30)
            else:
                model = XGBModel(lags=int(selected_lag), lags_future_covariates=future_covariates_lags, output_chunk_length=30)

            model.fit(train, future_covariates=future_cov)

        else: # Univariate
            if selected_model == 'Random Forest':
                model = RandomForest(lags=int(selected_lag))
            elif selected_model == 'LightGBM':
                model = LightGBMModel(lags=int(selected_lag))
            else:
                model = XGBModel(lags=int(selected_lag))

            model.fit(train)

    if selected_model == 'Prophet':
        nan_indices = np.isnan(val)
        nan_count = np.sum(nan_indices)
        if nan_count > 0:
            print(f"There are {nan_count} NaN values in the data.")
        val = np.nan_to_num(val, nan=0.0)

    predictions = model.predict(n=len(val))
    predictions = predictions.pd_series().tolist()
    predictions = np.maximum(predictions, 0)
    rmse = np.sqrt(mean_squared_error(val, predictions))
    rmsle = np.sqrt(mean_squared_error(np.log1p(val), np.log1p(predictions)))

    plt.figure(figsize=(12, 6))
    plt.plot(val, label='Actual')
    plt.plot(predictions, label='Predictions')
    plt.title(selected_model)
    plt.legend()
    plot_path = os.path.join('static', 'plot.png')
    plt.savefig(plot_path)
    plt.show()

    return render_template(
        'index.html',
        rmse=rmse,
        rmsle=rmsle,
        plot_path=plot_path,
        selected_store = selected_store,
        selected_product = selected_product,
        selected_model = selected_model,
        selected_lag = selected_lag,
        selected_type = selected_type,
        selected_features = selected_features,
        selected_duration = selected_duration
    )


if __name__ == '__main__':
    app.run(host='0.0.0.0', port=8000, debug=True)

