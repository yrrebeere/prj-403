from flask import Flask, render_template, request
import pandas as pd
import numpy as np
import pickle
from joblib import load

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict', methods=["POST"])
def predict():

    data = {
        'store_nbr': 1,
        'family_encoded': "",
        'onpromotion': 0,
        'typeholiday_encoded': "Holiday",
        'dcoilwtico': 46.8,
        'city_encoded': "Quito",
        'state_encoded': "Pichincha",
        'typestores_encoded': "D",
        'cluster': 13,
        'day_of_week': 3,
        'day': 16,
        'month': 8,
        'year': 2017
    }

    df = pd.DataFrame([data])

    if request.method == 'POST':
        df['family_encoded'] = request.form.get('family_encoded')
    
    with open('models/family_encoder.pkl', 'rb') as file:
        family_encoder = pickle.load(file)

    with open('models/typeholiday_encoder.pkl', 'rb') as file:
        typeholiday_encoder = pickle.load(file)

    with open('models/city_encoder.pkl', 'rb') as file:
        city_encoder = pickle.load(file)

    with open('models/state_encoder.pkl', 'rb') as file:
        state_encoder = pickle.load(file)

    with open('models/typestores_encoder.pkl', 'rb') as file:
        typestores_encoder = pickle.load(file)

    df['family_encoded'] = family_encoder.transform([df['family_encoded'].iloc[0]])[0]
    df['typeholiday_encoded'] = typeholiday_encoder.transform([df['typeholiday_encoded'].iloc[0]])[0]
    df['city_encoded'] = city_encoder.transform([df['city_encoded'].iloc[0]])[0]
    df['state_encoded'] = state_encoder.transform([df['state_encoded'].iloc[0]])[0]
    df['typestores_encoded'] = typestores_encoder.transform([df['typestores_encoded'].iloc[0]])[0]

    features = [
        'store_nbr',
        'onpromotion',
        'dcoilwtico',
        'cluster',
        'day_of_week',
        'day',
        'month',
        'year',
        'family_encoded',
        'typeholiday_encoded',
        'city_encoded', 
        'state_encoded',
        'typestores_encoded',
    ]

    X = df[features]

    model = load('models/M10.joblib')

    prediction = model.predict(X)

    prediction = int(np.ceil(np.maximum(prediction, 0)))
    # prediction = np.maximum(prediction, 0)


    return render_template(
        'index.html', 
        prediction = prediction
    )

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)

# flask run --port=8000
