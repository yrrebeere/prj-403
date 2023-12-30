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
        'dcoilwtico': 46.8,
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
    
    print("Family" + df['family'])
    
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

    # scaler = load('models/scaler.joblib')

    # scaled_test_features = scaler.transform(X[features])

    # sequence_length = 10

    # test_sequences = []

    # for i in range(len(scaled_test_features) - sequence_length):
    #     seq = scaled_test_features[i:i+sequence_length]
    #     test_sequences.append(seq)
    
    # test_sequences = np.array(test_sequences)

    # print(test_sequences.shape)

    m10 = load('models/M10.joblib')
    prediction = m10.predict(X)
    
    # m12 = load('models/M12.joblib')
    # m12 = load_model('models/m12.h5')
    # prediction = m12.predict(test_sequences)

    prediction = int(np.ceil(np.maximum(prediction, 0)))

    return render_template(
        'index.html', 
        prediction = prediction
    )

if __name__ == '__main__':
    # app.run(host='0.0.0.0', debug=True)
    app.run(host='0.0.0.0', port=8000, debug=True)
