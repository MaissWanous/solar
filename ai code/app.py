import os
from flask import Flask, request, jsonify
import joblib

app = Flask(__name__)

BASE_DIR = os.path.dirname(os.path.abspath(__file__))

rf_model = joblib.load(os.path.join(BASE_DIR, "rf_model.pkl"))
vectorizer = joblib.load(os.path.join(BASE_DIR, "vectorizer.pkl"))


@app.route("/predict", methods=["POST"])
def predict():
    data = request.get_json()
    reviews = data.get("reviews", [])

    if not reviews or not isinstance(reviews, list):
        return jsonify({"error": "No reviews provided"}), 400

    # تحويل النصوص إلى مصفوفة خصائص
    X = vectorizer.transform(reviews)

    # التنبؤ
    preds = rf_model.predict(X)
    print(preds)
    return jsonify({"predictions": preds.tolist()})

if __name__ == "__main__":
    app.run(host="0.0.0.0", port=5000)
