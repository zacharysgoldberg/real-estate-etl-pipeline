import os
from flask import Flask, render_template, redirect, url_for, jsonify, request
from .models import FinalResults
from . import session
from .utils.common_functions import accelerated_query
from azure.storage.blob import BlobServiceClient
import logging

app = Flask(__name__, template_folder='src/templates')


@app.route('/')
def index():
    return render_template('base.html')

# TODO: Get data based on user search criteria/keywords or provide filtered selection options


@app.route('/market-data', methods=['GET', 'POST'])
def get_market_data():
    if request.method == 'POST':
        city = request.form['city']
        state = request.form['state']
        # date = request.form['date']

        query = "SELECT * FROM BlobStorage WHERE region='Oxnard, CA' AND date='2020-12-31'"

        # results = session.query(FinalResults)\
        #     .filter(FinalResults.city.like(f'%{city}%'),
        #             FinalResults.state.like(f'%{state}%'))\
        #     .all()

        results = accelerated_query(blob_client=BlobServiceClient, query=query)
        logging.warning(results)

        return render_template('market-data.html', results=results)

# [end of year report]


@ app.route('/end-of-year-analysis', methods=['GET'])
def end_of_year_report():
    return render_template("end-of-year-results-viz.html")


# [historical analysis]


@ app.route('/historical-analysis', methods=['GET'])
def historical_analysis():
    return render_template('final-results-viz.html')


if __name__ == "__main__":
    host = os.getenv('HOST', '0.0.0.0')
    port = os.getenv('PORT', 5000)
    app.run(debug=True, threaded=True, host=host, port=port)
