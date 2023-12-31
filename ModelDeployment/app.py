from flask import Flask, render_template, request
import pandas as pd
import numpy as np
from joblib import load


app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict', methods=["POST"])
def predict():

    data = {
        'store_nbr': 1,
        'family': "",
        'onpromotion': 0,
        'typeholiday': "Holiday",
        'dcoilwtico': 0.0,
        'city': "Quito", 
        'state': "Pichincha",
        'typestores': "D",
        'cluster': 13,
        'day_of_week': 0,
        'day': 0,
        'month': 0,
        'year': 0,
        'date': 0
    }

    df = pd.DataFrame([data])

    # df['date'] = request.form.get('datepicker')
    # df['date'] = pd.to_datetime(df['date'])
    # df['day_of_week'] = df['date'].dt.day_of_week
    # df['day_of_week'] = df['day_of_week']+1
    # df['day'] = df['date'].dt.day
    # df['month'] = df['date'].dt.month
    # df['year'] = df['date'].dt.year

    if request.method == 'POST':
        df['date'] = request.form.get('datepicker')
        df['date'] = pd.to_datetime(df['date'])
        df['day_of_week'] = df['date'].dt.day_of_week
        df['day_of_week'] = df['day_of_week']+1
        df['day'] = df['date'].dt.day
        df['month'] = df['date'].dt.month
        df['year'] = df['date'].dt.year

    if request.method == 'POST':
        df['family'] = request.form.get('family')

    filtered_df = pd.read_csv("data/filtered_train.csv")

    filtered_df = filtered_df[(filtered_df['day'] == int(df['day'])) & (filtered_df['month'] == int(df['month'])) & (filtered_df['year'] == int(df['year']))]

    filtered_df = filtered_df[(filtered_df['family'] == str(df['family'].iloc[0]))]

    print(filtered_df)

    df['typeholiday'] = filtered_df['typeholiday'].iloc[0]
    df['dcoilwtico'] = filtered_df['dcoilwtico'].iloc[0]
    df['onpromotion'] = filtered_df['onpromotion'].iloc[0]
    actual = round(filtered_df['sales'].iloc[0])
    
    with open('models/family_encoder.pkl', 'rb') as file:
        family_encoder = load(file)

    with open('models/typeholiday_encoder.pkl', 'rb') as file:
        typeholiday_encoder = load(file)

    with open('models/city_encoder.pkl', 'rb') as file:
        city_encoder = load(file)

    with open('models/state_encoder.pkl', 'rb') as file:
        state_encoder = load(file)

    with open('models/typestores_encoder.pkl', 'rb') as file:
        typestores_encoder = load(file)

    df['family'] = family_encoder.transform([df['family'].iloc[0]])[0]
    df['typeholiday'] = typeholiday_encoder.transform([df['typeholiday'].iloc[0]])[0]
    df['city'] = city_encoder.transform([df['city'].iloc[0]])[0]
    df['state'] = state_encoder.transform([df['state'].iloc[0]])[0]
    df['typestores'] = typestores_encoder.transform([df['typestores'].iloc[0]])[0]

    features = [
        'store_nbr',
        'family',
        'onpromotion',
        'typeholiday',
        'dcoilwtico',
        'city', 
        'state',
        'typestores',
        'cluster',
        'day_of_week',
        'day',
        'month',
        'year',
    ]

    X = df[features]

    selectedModel = "m22"

    if(selectedModel == "m10"):
        model = load('models/M10.joblib')
    
    else:
        model = load('models/M22.joblib')

    prediction = model.predict(X)

    prediction = int(np.ceil(np.maximum(prediction, 0)))

    return render_template(
        'index.html', 
        prediction = prediction,
        actual = actual
    )

if __name__ == '__main__':
    # app.run(host='0.0.0.0', debug=True)
    app.run(host='0.0.0.0', port=8000, debug=True)
