from flask import Blueprint, jsonify, request, render_template
from .models import FinalResults
from . import session
from .utils.common_functions import accelerated_query
from azure.storage.blob import BlobServiceClient
import logging

bp = Blueprint('market_data', __name__, url_prefix='/market-data')


# TODO: Get data based on user search criteria/keywords or provide options in filter


@bp.route('', methods=['GET', 'POST'])
def get_market_data():
    if request.method == 'POST':
        city = request.form['city']
        state = request.form['state']
        # date = request.form['date']

        query = f"SELECT * FROM BlobStorage WHERE region='{city}, {state}' AND date='2021-12-31'"

        # results = session.query(FinalResults)\
        #     .filter(FinalResults.city.like(f'%{city}%'),
        #             FinalResults.state.like(f'%{state}%'))\
        #     .all()

        results = accelerated_query(blob_client=BlobServiceClient, query=query)
        logging.warning(results)

        return render_template('market-data.html', results=results)
