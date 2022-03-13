from flask import Blueprint, jsonify, abort, request
from ..models import User, Tip, db, Location, Incident
import random
from faker import Faker
from datetime import datetime
import sqlalchemy


bp = Blueprint('tips', __name__, url_prefix='/tips')

fake = Faker()


# Get


@bp.route('', methods=['GET'])
def index():
    tips = Tip.query.all()
    result = []
    for t in tips:
        result.append(t.serialize())
    return jsonify(result)


@bp.route('/<int:id>', methods=["GET"])
def show(id: int):
    tip = Tip.query.get_or_404(id)
    return jsonify(tip.serialize())


# Create Tip


@bp.route('', methods=['POST'])
def create():
    lst = ['anonymous', 'city', 'state', 'incident_type']
    if all(item not in request.json for item in lst):
        return abort(400)

    tip = Tip(
        anonymous=request.json["anonymous"],
        username=request.json['username']
        if request.json['anonymous'] == False else None,
        user_id=db.session.query(User.id).filter(
            request.json['username'] == User.username)
        if request.json['anonymous'] == False else None,
        city=request.json["city"],
        state=request.json["state"],
        coordinates=fake.coordinate(),
        incident_type=request.json["incident_type"],
        description=request.json["description"],
        location_id=db.session.query(
            Location.id).filter(request.json['city'] == Location.city),
        incident_id=db.session.query(Incident.id).order_by(
            Incident.id.desc()).first()[0] + 1
    )

    incident = sqlalchemy.insert(Incident).values(
        city=tip.city, state=tip.state, incident_type=tip.incident_type,
        description=tip.description, ongoing=None,
        date_time=datetime.now(),
        location_id=tip.location_id)

    db.session.execute(incident)
    db.session.add(tip)
    db.session.commit()
    return jsonify(tip.serialize())


# Delete
@ bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    tip = Tip.query.get_or_404(id)

    try:
        db.session.delete(tip)  # prepare DELETE tip
        db.session.commit()  # execute DELETE tip
        return jsonify(True)
    except:
        return jsonify(False)

# User that submitted tip


@bp.route('/<int:id>/submitted_tips', methods=['GET'])
def submitted_tips(id: int):
    tip = Tip.query.get_or_404(id)
    result = [user.serialize() for user in tip.submitted_tips]
    return jsonify(result)
