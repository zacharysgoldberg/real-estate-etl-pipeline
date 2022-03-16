from flask import Blueprint, jsonify, abort, request
from ..models.models import Incident, db

bp = Blueprint('incidents', __name__, url_prefix='/incidents')


@bp.route('', methods=['GET'])
def index():
    incidents = Incident.query.all()
    result = [i.serialize() for i in incidents]
    return jsonify(result)


@bp.route('/<int:id>', methods=["GET"])
def show(id: int):
    incident = Incident.query.get_or_404(id)
    return jsonify(incident.serialize())
