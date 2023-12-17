from flask import Flask, render_template, request
import pickle

app = Flask(__name__)

@app.route('/')
def home():
    return render_template('index.html')

@app.route('/predict', methods=["POST"])
def predict():
    store_nbr = 1
    family = ""
    if request.method == 'POST':
        family = request.form.get("family")
    onpromotion = 0
    typeholiday = "NDay"
    dcoilwtico = 46.8
    city = "Quito"
    state = "Pichincha"
    typestores = "D"
    cluster = 13
    day_of_week = 3
    day = 16
    month = 8
    year = 2017

    with open('models/family_encoder.pkl', 'rb') as file:
        family_encoder = pickle.load(file)

    family = family_encoder.transform([family])[0]

    return render_template('index.html', family = family)

if __name__ == '__main__':
    app.run(host='0.0.0.0', debug=True)