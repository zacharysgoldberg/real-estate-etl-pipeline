from flask import Blueprint, jsonify, abort, request
from ..models import User, Content, db
from ..data_sets import content_types

bp = Blueprint('content', __name__, url_prefix='/content')


@bp.route('', methods=['GET'])
def index():
    content = Content.query.all()
    result = [c.serialize() for c in content]
    return jsonify(result)


@bp.route('/<int:id>', methods=['GET'])
def show(id: int):
    content = Content.query.get_or_404(id)
    return jsonify(content.serialize())

# Create/Post content


@bp.route('', methods=['POST'])
def create():
    if 'user_id' not in request.json or 'content_type' not in request.json:
        return abort(400)

    User.query.get_or_404(request.json['user_id'])

    content = Content(
        user_id=request.json['user_id'],
        content_type=request.json['content_type'],
        description=request.json['description'],
        filtered=request.json['filtered']
    )

    db.session.add(content)
    db.session.commit()

    return jsonify(content.serialize())


@bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    content = Content.query.get_or_404(id)
    try:
        db.session.delete(content)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

# Updating content post


@bp.route('/<int:id>', methods=['PATCH', 'PUT'])
def update(id: int):
    lst = ['content_type', 'description']
    content = Content.query.get_or_404(id)
    if all(item not in request.json for item in lst):
        return abort(400)

    if 'content_type' in request.json:
        if request.json['content_type'] not in content_types:
            return abort(400)
        content.content_type = request.json['content_type']

    if 'description' in request.json:
        if type(request.json['description']) is not str:
            return abort(400)
        content.description = request.json['description']

    try:
        db.session.commit()
        return jsonify(content.serialize())
    except:
        return jsonify(False)

# Users that liked a content post


@bp.route('/<int:id>/users_liking', methods=['GET'])
def users_liking(id: int):
    content = Content.query.get_or_404(id)
    result = [u.serialize() for u in content.users_liking]
    return jsonify(result)
