import os
from api import create_app
from flask import render_template


app = create_app()


# [home]


@app.route('/')
def index():
    return render_template('base.html')

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
