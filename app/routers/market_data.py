from flask import Blueprint, jsonify, request, render_template
from ..models import Result, db
import logging

bp = Blueprint('market_data', __name__, url_prefix='/market-data')


# [Get data based on user search criteria/keywords or provide options in filter]


@bp.route('', methods=['GET', 'POST'])
def get_market_data():
    if request.method == 'POST':
        city = request.form['city']
        state = request.form['state']
        date = request.form['date']
        if city or state or date:
            results = db.session.query(Result)\
                .filter(Result.city.like(f"%{city}%"),
                        Result.state.like(f"%{state}%"),
                        Result.date.like(f"%{date}%"))\
                .all()
            msg = "Here are your results"
        else:
            results = []
            msg = 'Must enter at least a city, state, or date...'
            # logging.warning("=====================================================")

        return render_template('market-data.html', results=results, msg=msg)
