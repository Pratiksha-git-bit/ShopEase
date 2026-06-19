from flask import Flask, jsonify
import mysql.connector

app = Flask(__name__)

db = mysql.connector.connect(
host="localhost",
user="root",
password="Redemption@28",
database="Shopease"
)

@app.route('/payment-analysis', methods=['GET'])
def payment_analysis():
    cursor = db.cursor(dictionary=True)
    query = """
    SELECT *
    FROM payment 
    WHERE transaction_status = 'Failed'
    OR transaction_status = 'pending'
"""   
@app.route('/payment-summary', methods=['GET'])
def payment_summary():
    cursor = db.cursor(dictionary=True)
    query = """
    SELECT
    transaction_status,
    COUNT(*) AS total_transactions
    FROM payment
    GROUP BY transaction_status
"""
@app.route('/failed-payment-summary', methods=['GET'])
def failed_payment_summary():
    cursor = db.cursor(dictionary=True)
    query = """
    select payment_method,
    count(*) as failed_transactions
    FROM payment
    WHERE transaction_status = 'failed'
    GROUP BY payment_method
"""
    cursor.execute(query)
    result = cursor.fetchall()
    cursor.close()
    return jsonify(result)

if __name__ == '__main__':
     app.run(debug=True)