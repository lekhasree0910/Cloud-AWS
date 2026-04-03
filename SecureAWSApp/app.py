from flask import Flask, request, jsonify
import mysql.connector
import os
app = Flask(__name__)
# RDS Database connection (use environment variables for security)
db_config = {
    'host': os.environ.get('RDS_HOST', 'webapp-db.ch2a4wu081kp.eu-north-1.rds.amazonaws.com'),
    'user': os.environ.get('DB_USER', 'admin'),
    'password': os.environ.get('DB_PASSWORD', 'Sreekar#1011'),
    'database': 'webapp_db'
}
def get_db_connection():
    return mysql.connector.connect(**db_config)
@app.route('/')
def home():
    return "Backend is running on AWS EC2!"
@app.route('/submit', methods=['POST'])
def submit():
    data = request.get_json()
    name = data.get('name')
    email = data.get('email')
    if not name or not email:
        return jsonify({"message": "Name and email are required."}), 400
    
    try:
        db = get_db_connection()
        cursor = db.cursor()
        cursor.execute("INSERT INTO users (name, email) VALUES (%s, %s)", (name, email))
        db.commit()
        cursor.close()
        db.close()
        return jsonify({"message": "Data submitted successfully!"})
    except Exception as e:
        return jsonify({"message": f"Error: {str(e)}"}), 500

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000, debug=False)
