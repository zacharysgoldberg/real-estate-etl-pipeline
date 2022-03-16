"""
Populating emergency_map database with fake data using the SQLAlchemy ORM.
"""

from emergency_map.src import create_app
from emergency_map.src.api.models.models import User, Tip, Content, Location, Incident, users_tips, users_content, db
from faker import Faker
import random
import string
import hashlib
import secrets
from emergency_map.src.data_sets import content_types, cities_states, incident_types
import sqlalchemy


USER_COUNT = 100
CONTENT_COUNT = 75
LIKE_CONTENT_COUNT = 300
TIP_COUNT = 50
INCIDENT_COUNT = 1000
LOCATION_COUNT = len(cities_states)
boolean = [True, False]


assert LIKE_CONTENT_COUNT <= (USER_COUNT * CONTENT_COUNT)


def random_passhash():
    """Get hashed and salted password of length N | 8 <= N <= 15"""
    raw = ''.join(
        random.choices(
            string.ascii_letters + string.digits + '!@#$%&',  # valid pw characters
            k=random.randint(8, 15)  # length of pw
        )
    )

    salt = secrets.token_hex(16)

    return hashlib.sha512((raw + salt).encode('utf-8')).hexdigest()


def truncate_tables():
    """Delete all rows from database tables"""
    db.session.execute(users_tips.delete())
    Content.query.delete()
    Incident.query.delete()
    Tip.query.delete()
    User.query.delete()
    db.session.commit()


def main():
    """Main driver function"""
    app = create_app()
    app.app_context().push()
    truncate_tables()
    fake = Faker()

    # Locations
    last_location = None
    for key, value in cities_states.items():
        last_location = Location(
            city=key,
            state=value
        )
        db.session.add(last_location)

    # insert locations
    db.session.commit()

    # Users
    last_user = None  # save last user
    for _ in range(USER_COUNT):
        id = random.randint(
            last_location.id - LOCATION_COUNT + 1, last_location.id)
        name = fake.name()
        last_user = User(
            full_name=name,
            username=name.split()[0].lower() + str(random.randint(1, 150)),
            date_of_birth=fake.date_of_birth(),
            password=random_passhash(),
            email=fake.email(),
            phone=fake.phone_number()
        )
        db.session.add(last_user)

    # insert users
    db.session.commit()

    # Incidents
    last_incident = None
    for _ in range(INCIDENT_COUNT):
        # Choosing random city from list
        id = random.randint(
            last_location.id - LOCATION_COUNT + 1, last_location.id)
        last_incident = Incident(
            coordinates=fake.coordinate(),
            city=db.session.query(Location.city).filter(Location.id == id),
            # Getting corresponding state for city
            state=db.session.query(Location.state).filter(Location.id == id),
            # Getting random incident from list
            incident_type=random.choice(incident_types),
            description=fake.sentence(),
            ongoing=random.choice(boolean),
            date_time=fake.date_time_between(start_date='-1y', end_date='now'),
            location_id=id
        )
        db.session.add(last_incident)

    # insert incidents
    db.session.commit()

    # Incident_Tips
    last_tip = None  # save last tip

    for _ in range(TIP_COUNT):
        # Randomly choosing user from list of cleared backgrounds
        id = random.randint(
            last_user.id - USER_COUNT + 1, last_user.id)
        anonymous = random.choice(boolean)
        city = random.choice(list(cities_states.keys()))
        last_tip = Tip(
            # Randomly assigning if user decides to remain anonymous
            anonymous=False if anonymous == False else True,
            user_id=id if anonymous == False else None,
            username=db.session.query(User.username).filter(
                User.id == id) if anonymous == False else None,
            coordinates=fake.coordinate(),
            city=city,
            state=cities_states.get(city),
            location_id=db.session.query(
                Location.id).filter(city == Location.city),
            incident_id=db.session.query(Incident.id).order_by(
                Incident.id.desc()).first()[0] + 1,
            incident_type=random.choice(incident_types),
            description=fake.sentence() if random.choice(boolean) == True else None
        )

        # Inserting new tip into incidents table
        tip = sqlalchemy.insert(Incident).values(
            coordinates=last_tip.coordinates,
            city=last_tip.city, state=last_tip.state, incident_type=last_tip.incident_type,
            description=last_tip.description, ongoing=None,
            date_time=fake.date_time_this_year(),
            location_id=last_tip.location_id)

        db.session.execute(tip)
        db.session.add(last_tip)

    # insert tips
    db.session.commit()

    # Content
    last_content = None
    for _ in range(CONTENT_COUNT):
        id = random.randint(
            last_user.id - USER_COUNT + 1, last_user.id)
        last_content = Content(
            content_type=random.choice(content_types),
            filtered=random.choice(boolean),
            user_id=id,
            description=fake.sentence()
        )
        db.session.add(last_content)

    # insert content
    db.session.commit()

    # Users_Content
    user_content_pairs = set()
    while len(user_content_pairs) < LIKE_CONTENT_COUNT:

        content = (
            random.randint(last_user.id - USER_COUNT + 1, last_user.id),
            random.randint(last_content.id - CONTENT_COUNT +
                           1, last_content.id)
        )

        if content in user_content_pairs:
            continue

        user_content_pairs.add(content)

    new_content = [{'user_id': pair[0], 'content_id': pair[1]}
                   for pair in list(user_content_pairs)]
    insert_content_query = users_content.insert().values(new_content)

    db.session.execute(insert_content_query)
    db.session.commit()

    # Users_Tips
    users_tips_pairs = set()

    lst = db.session.query(Tip.user_id, Tip.id).join(
        User).filter(Tip.user_id == User.id).all()

    for t in lst:

        tip = (t[0], t[1])

        if tip in users_tips_pairs:
            continue

        users_tips_pairs.add(tip)

    new_tip = [{'user_id': pair[0], 'tip_id': pair[1]}
               for pair in list(users_tips_pairs)]
    insert_tip_query = users_tips.insert().values(new_tip)

    db.session.execute(insert_tip_query)
    db.session.commit()


# run script
main()
