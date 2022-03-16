from flask_sqlalchemy import SQLAlchemy
import datetime


db = SQLAlchemy()

# Locations table


class Location(db.Model):
    __tablename__ = 'locations'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    city = db.Column(db.Text, nullable=False)
    state = db.Column(db.String(2), nullable=False)

    tips = db.relationship('Tip', backref='locations')
    incidents = db.relationship('Incident', backref='locations')

    def __init__(self, city: str, state: str):
        self.city = city
        self.state = state

    def serialize(self):
        return {
            'id': self.id,
            'city': self.city,
            'state': self.state
        }

# Incidents/Emergencies table


class Incident(db.Model):
    __tablename__ = 'incidents'
    id = db.Column(
        db.Integer, primary_key=True, autoincrement=True)
    city = db.Column(db.Text, nullable=False)
    state = db.Column(db.String(2), nullable=False)
    incident_type = db.Column(db.String(100), nullable=False)
    coordinates = db.Column(db.Text, nullable=False)
    description = db.Column(db.Text, nullable=True)
    ongoing = db.Column(db.Boolean, nullable=True)
    date_time = db.Column(db.DateTime, nullable=False)

    location_id = db.Column(db.Integer, db.ForeignKey(
        'locations.id'), nullable=False)
    tips = db.relationship('Tip', backref='incidents')

    def __init__(self, city: str, state: str, incident_type: str, coordinates: str, description: str, ongoing: bool, date_time: str, location_id: int):
        self.city = city
        self.state = state
        self.incident_type = incident_type
        self.coordinates = coordinates
        self.description = description
        self.ongoing = ongoing
        self.date_time = date_time
        self.location_id = location_id

    def serialize(self):
        return {
            'id': self.id,
            'city': self.city,
            'state': self.state,
            'incident_type': self.incident_type,
            'coordinates': self.coordinates,
            'description': self.description,
            'ongoing': self.ongoing,
            'date_time': self.date_time,
            'location_id': self.location_id
        }


# Users and tips many-to-many table
users_tips = db.Table(
    'users_tips',
    db.Column('user_id',
              db.Integer,
              db.ForeignKey('users.id'),
              primary_key=True),

    db.Column('tip_id',
              db.Integer,
              db.ForeignKey('tips.id'),
              primary_key=True),


    db.Column('created_at',
              db.DateTime,
              default=datetime.datetime.utcnow,
              nullable=False)
)

# Users table


class User(db.Model):
    __tablename__ = 'users'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    full_name = db.Column(db.Text, nullable=False)
    username = db.Column(db.String(128), nullable=False, unique=True)
    password = db.Column(db.String(128), nullable=False)
    date_of_birth = db.Column(db.DateTime, nullable=False)
    email = db.Column(db.String(200), nullable=False)
    phone = db.Column(db.Text, nullable=True)

    content = db.relationship(
        'Content', backref='users', cascade='all, delete')
    tips_submitted = db.relationship("Tip", secondary=users_tips,
                                     backref="users")

    def __init__(self, full_name: str, username: str,
                 password: str, date_of_birth: str,
                 email: str, phone: str):
        self.full_name = full_name
        self.username = username
        self.password = password
        self.date_of_birth = date_of_birth
        self.email = email
        self.phone = phone

    def serialize(self):
        return {
            'id': self.id,
            'full_name': self.full_name,
            'username': self.username,
            'date_of_birth': self.date_of_birth,
            'email': self.email,
            'phone': self.phone
        }


# Users and content many-to-many table
users_content = db.Table(
    'users_content',
    db.Column('user_id',
              db.Integer,
              db.ForeignKey('users.id'),
              primary_key=True),

    db.Column('content_id',
              db.Integer,
              db.ForeignKey('content.id'),
              primary_key=True),

    db.Column('created_at',
              db.DateTime,
              default=datetime.datetime.utcnow,
              nullable=False)
)

# Content table


class Content(db.Model):
    __tablename__ = 'content'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    description = db.Column(db.Text, nullable=False)
    created_at = db.Column(
        db.DateTime, default=datetime.datetime.utcnow, nullable=False)
    content_type = db.Column(db.Text, nullable=False)
    filtered = db.Column(db.Boolean, nullable=False)
    user_id = db.Column(db.Integer, db.ForeignKey('users.id'))
    users_liking = db.relationship(
        'User', secondary=users_content,
        lazy='subquery',
        backref=db.backref('liked_content', lazy=True)
    )

    def __init__(self, description: str, content_type: str,
                 filtered: bool, user_id: int):
        self.description = description
        self.content_type = content_type
        self.filtered = filtered
        self.user_id = user_id

    def serialize(self):
        return {
            'id': self.id,
            'description': self.description,
            'created_at': self.created_at.isoformat(),
            'content_type': self.content_type,
            'filtered': self.filtered,
            'user_id': self.user_id
        }

# Incident/Emergency Tips table


class Tip(db.Model):
    __tablename__ = 'tips'
    id = db.Column(db.Integer, primary_key=True, autoincrement=True)
    anonymous = db.Column(db.Boolean, nullable=False)
    username = db.Column(db.String(128), nullable=True)
    city = db.Column(db.Text, nullable=False)
    state = db.Column(db.String(2), nullable=False)
    coordinates = db.Column(db.Text, nullable=False)
    incident_type = db.Column(db.String(100), nullable=False)
    description = db.Column(db.Text, nullable=True)
    date_time = db.Column(db.DateTime,
                          default=datetime.datetime.utcnow,
                          nullable=False)

    user_id = db.Column(db.Integer, db.ForeignKey(
        'users.id'), nullable=True)
    location_id = db.Column(db.Integer, db.ForeignKey(
        'locations.id'), nullable=False)
    incident_id = db.Column(db.Integer, db.ForeignKey(
        'incidents.id'), nullable=False)
    submitted_tips = db.relationship(
        'User', secondary=users_tips,
        backref='tips'
    )

    def __init__(self, anonymous: bool, username: str, user_id: int,
                 city: str, state: str, coordinates: str,
                 incident_type: str, description: str, location_id: int,
                 incident_id: int):
        self.anonymous = anonymous
        self.username = username
        self.user_id = user_id
        self.city = city
        self.state = state
        self.coordinates = coordinates
        self.incident_type = incident_type
        self. description = description
        self.location_id = location_id
        self.incident_id = incident_id

    def serialize(self):
        return {
            'id': self.id,
            'anonymous': self.anonymous,
            'username': self.username,
            'user_id': self.user_id,
            'location_id': self.location_id,
            'incident_id': self.incident_id,
            'city': self.city,
            'state': self.state,
            'coordinates': self.coordinates,
            'incident_type': self.incident_type,
            'description': self.description,
            'date_time': self.date_time.isoformat()
        }
