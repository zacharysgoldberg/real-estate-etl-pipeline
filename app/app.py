from flask import Flask, render_template, redirect, url_for
import os


app = Flask(__name__, template_folder='templates')


@app.route('/', methods=['GET'])
def index():
    return redirect(url_for('analysis'))


@app.route('/data-table', methods=['GET'])
def data_table():
    return


@app.route('/analysis', methods=['GET'])
def analysis():
    return render_template('final-results-viz.html')


if __name__ == "__main__":
    host = os.getenv('HOST', '0.0.0.0')
    port = os.getenv('PORT', 5000)
    app.run(threaded=True, host=host, port=port)
