"""empty message

Revision ID: 9acc543a4a02
Revises: 
Create Date: 2022-05-08 19:41:32.381296

"""
from alembic import op
import sqlalchemy as sa
from sqlalchemy.dialects import postgresql

# revision identifiers, used by Alembic.
revision = '9acc543a4a02'
down_revision = None
branch_labels = None
depends_on = None


def upgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.drop_table('users_tips')
    op.drop_table('content')
    op.drop_table('users_content')
    op.drop_table('incidents')
    op.drop_table('locations')
    op.drop_table('tips')
    op.drop_table('users')
    # ### end Alembic commands ###


def downgrade():
    # ### commands auto generated by Alembic - please adjust! ###
    op.create_table('users',
    sa.Column('id', sa.INTEGER(), server_default=sa.text("nextval('users_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('fullname', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('username', sa.VARCHAR(length=128), autoincrement=False, nullable=False),
    sa.Column('password', sa.VARCHAR(length=128), autoincrement=False, nullable=False),
    sa.Column('date_of_birth', sa.DATE(), autoincrement=False, nullable=False),
    sa.Column('phone', sa.TEXT(), autoincrement=False, nullable=True),
    sa.PrimaryKeyConstraint('id', name='users_pkey'),
    sa.UniqueConstraint('username', name='users_username_key'),
    postgresql_ignore_search_path=False
    )
    op.create_table('tips',
    sa.Column('id', sa.INTEGER(), server_default=sa.text("nextval('tips_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('anonymous', sa.BOOLEAN(), autoincrement=False, nullable=False),
    sa.Column('username', sa.VARCHAR(length=128), autoincrement=False, nullable=True),
    sa.Column('city', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('state', sa.VARCHAR(length=2), autoincrement=False, nullable=False),
    sa.Column('coordinates', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('incident_type', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('description', sa.TEXT(), autoincrement=False, nullable=True),
    sa.Column('date_time', postgresql.TIMESTAMP(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['id'], ['incidents.id'], name='fk_tips_incidents'),
    sa.ForeignKeyConstraint(['id'], ['locations.id'], name='fk_tips_locations'),
    sa.ForeignKeyConstraint(['id'], ['users.id'], name='fk_tips_users'),
    sa.PrimaryKeyConstraint('id', name='tips_pkey'),
    postgresql_ignore_search_path=False
    )
    op.create_table('locations',
    sa.Column('id', sa.INTEGER(), server_default=sa.text("nextval('locations_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('city', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('state', sa.VARCHAR(length=2), autoincrement=False, nullable=False),
    sa.PrimaryKeyConstraint('id', name='locations_pkey'),
    postgresql_ignore_search_path=False
    )
    op.create_table('incidents',
    sa.Column('id', sa.INTEGER(), server_default=sa.text("nextval('incidents_id_seq'::regclass)"), autoincrement=True, nullable=False),
    sa.Column('city', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('state', sa.VARCHAR(length=2), autoincrement=False, nullable=False),
    sa.Column('incident_type', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('coordinates', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('description', sa.TEXT(), autoincrement=False, nullable=True),
    sa.Column('ongoing', sa.BOOLEAN(), autoincrement=False, nullable=True),
    sa.Column('date_time', postgresql.TIMESTAMP(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['id'], ['locations.id'], name='fk_incidents_locations', ondelete='SET NULL'),
    sa.PrimaryKeyConstraint('id', name='incidents_pkey'),
    postgresql_ignore_search_path=False
    )
    op.create_table('users_content',
    sa.Column('user_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('content_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('created_at', postgresql.TIMESTAMP(), autoincrement=False, nullable=True),
    sa.ForeignKeyConstraint(['content_id'], ['content.id'], name='fk_users_content_content', ondelete='SET NULL'),
    sa.ForeignKeyConstraint(['user_id'], ['users.id'], name='fk_users_content_users', ondelete='SET NULL'),
    sa.PrimaryKeyConstraint('user_id', 'content_id', name='users_content_pkey')
    )
    op.create_table('content',
    sa.Column('id', sa.INTEGER(), autoincrement=True, nullable=False),
    sa.Column('description', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('created_at', postgresql.TIMESTAMP(), autoincrement=False, nullable=False),
    sa.Column('content_type', sa.TEXT(), autoincrement=False, nullable=False),
    sa.Column('filtered', sa.BOOLEAN(), autoincrement=False, nullable=False),
    sa.Column('user_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.ForeignKeyConstraint(['user_id'], ['users.id'], name='fk_content_users'),
    sa.PrimaryKeyConstraint('id', name='content_pkey')
    )
    op.create_table('users_tips',
    sa.Column('user_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('tip_id', sa.INTEGER(), autoincrement=False, nullable=False),
    sa.Column('created_at', postgresql.TIMESTAMP(), autoincrement=False, nullable=True),
    sa.ForeignKeyConstraint(['tip_id'], ['tips.id'], name='fk_users_tips_tips', ondelete='SET NULL'),
    sa.ForeignKeyConstraint(['user_id'], ['users.id'], name='fk_users_tips_users', ondelete='SET NULL'),
    sa.PrimaryKeyConstraint('user_id', 'tip_id', name='users_tips_pkey')
    )
    # ### end Alembic commands ###