"""adding an index

Revision ID: beaa18834b10
Revises: 5b9cd0b8bef3
Create Date: 2022-03-10 16:21:42.585183

"""
from alembic import op
import sqlalchemy as sa
from src.models import tip_model, user_model, content_model

# revision identifiers, used by Alembic.
revision = 'beaa18834b10'
down_revision = '5b9cd0b8bef3'
branch_labels = None
depends_on = None

# Index for incident_types in Tips table, username for users, and content_type for content


def upgrade():
    sa.Index('incident_type_index', tip_model.Tip.incident_type)
    sa.Index('username_index', user_model.User.username)
    sa.Index('content_type_index', content_model.Content.content_type)


def downgrade():
    sa.session.rollback()
