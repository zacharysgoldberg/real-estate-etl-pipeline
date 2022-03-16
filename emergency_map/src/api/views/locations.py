from flask import Blueprint, jsonify, abort, request
from ..models.models import Location, db

bp = Blueprint('locations', __name__, url_prefix='/locations')


@bp.route('', methods=['GET'])  # decorator takes path and list of HTTP verbs
def index():
    locations = Location.query.all()
    result = [l.serialize() for l in locations]
    return jsonify(result)


@bp.route('/<int:id>', methods=["GET"])
def show(id: int):
    location = Location.query.get_or_404(id)
    return jsonify(location.serialize())
