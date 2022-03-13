from flask import Blueprint, jsonify, abort, request
from ..models import User, db, Content, users_content
import hashlib
import secrets
import sqlalchemy
import re


bp = Blueprint('users', __name__, url_prefix='/users')


def hashpass(password: str):
    """Hash and salt the given password"""
    salt = secrets.token_hex(16)
    return hashlib.sha512((password + salt).encode('utf-8')).hexdigest()


@bp.route('', methods=['GET'])
def index():
    tips = User.query.all()
    result = []
    for t in tips:
        result.append(t.serialize())
    return jsonify(result)


@bp.route('/<int:id>', methods=["GET"])
def show(id: int):
    user = User.query.get_or_404(id)
    return jsonify(user.serialize())

# Create new user


@bp.route('', methods=['POST'])
def create():
    length = [len(request.json['username']), len(request.json['password'])]
    lst = ['username', 'password']
    if length[0] < 3 or length[1] < 8 or any(item not in request.json for item in lst):
        return abort(400)

    user = User(
        full_name=request.json['full_name'],
        username=request.json['username'],
        password=request.json['password'],
        date_of_birth=request.json['date_of_birth'],
        email=request.json['email'],
        phone=request.json['phone']
    )

    db.session.add(user)
    db.session.commit()

    return jsonify(user.serialize())

# Delete user


@ bp.route('/<int:id>', methods=['DELETE'])
def delete(id: int):
    user = User.query.get_or_404(id)
    try:
        db.session.delete(user)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)


# Update user


@ bp.route('/<int:id>', methods=['PATCH', 'PUT'])
def update(id: int):
    user = User.query.get_or_404(id)
    lst = ['username', 'password', 'email', 'phone']
    if all(item not in request.json for item in lst):
        return abort(400)

    if 'username' in request.json:
        if len(request.json['username']) < 3:
            return abort(400)
        user.username = request.json['username']

    if 'password' in request.json:
        if len(request.json['password']) < 8:
            return abort(400)
        user.password = hashpass(request.json['password'])

    if 'email' in request.json:
        if not re.match(r"[^@]+@[^@]+\.[^@]+", request.json['email']):
            return abort(400)
        user.email = request.json['email']

    if 'phone' in request.json:
        if len(request.json['phone']) != 10 or request.json['phone'].isdecimal() == False:
            return abort(400)
        user.phone = request.json['phone']

    try:
        db.session.commit()
        return jsonify(user.serialize())

    except:
        return jsonify(False)

# Tips that a user submitted


@ bp.route('/<int:id>/tips_submitted', methods=['GET'])
def tips_submitted(id: int):
    user = User.query.get_or_404(id)
    result = [tip.serialize() for tip in user.tips_submitted]
    return jsonify(result)

# Content that a user liked


@ bp.route('/<int:id>/liked_content', methods=['GET'])
def liked_content(id: int):
    user = User.query.get_or_404(id)
    result = [content.serialize() for content in user.liked_content]
    return jsonify(result)

# Like content


@ bp.route('/<int:id>/like', methods=['POST'])
def like(id: int):
    if 'content_id' not in request.json:
        return abort(400)

    User.query.get_or_404(id)
    Content.query.get_or_404(request.json['content_id'])

    try:
        like = sqlalchemy.insert(users_content).values(
            user_id=id, content_id=request.json['content_id'])
        db.session.execute(like)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)

# Unlike content


@bp.route('/<int:user_id>/unlike/<int:content_id>', methods=['DELETE'])
def unlike(user_id: int, content_id: int):
    # check user and content exist
    User.query.get_or_404(user_id)
    Content.query.get_or_404(content_id)

    try:
        unlike = sqlalchemy.delete(users_content).where(
            users_content.c.user_id == user_id,
            users_content.c.content_id == content_id
        )
        db.session.execute(unlike)
        db.session.commit()
        return jsonify(True)
    except:
        return jsonify(False)
