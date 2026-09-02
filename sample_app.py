import os
import pymysql
from flask import Flask, jsonify

sample_app = Flask(__name__)

def get_db_connection():
    return pymysql.connect(
        host=os.getenv("DB_HOST", "db"),
        user=os.getenv("DB_USER", "root"),
        password=os.getenv("DB_PASSWORD", "password"),
        database=os.getenv("DB_NAME", "app_db"),
        cursorclass=pymysql.cursors.DictCursor
    )

@sample_app.route("/")
def index():
    try:
        connection = get_db_connection()
        with connection.cursor() as cursor:
            cursor.execute("SELECT VERSION() as version;")
            result = cursor.fetchone()
        connection.close()
        return jsonify({"status": "success", "db_version": result["version"]}), 200
    except Exception as e:
        return jsonify({"status": "error", "message": str(e)}), 500

if __name__ == "__main__":
    sample_app.run(host="0.0.0.0", port=5000)