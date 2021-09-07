from sqlalchemy import Column, Table, Integer, String, Boolean, \
    Date, DateTime, ForeignKey
from sqlalchemy import MetaData, create_engine
from data.database import DATABASE_URL


metadata = MetaData()

resident_account = Table(
    "resident_account",
    metadata,
    Column("resident_id", Integer, primary_key=True, autoincrement=True),
    Column("firstname", String),
    Column("lastname", String),
    Column("username", String),
    Column("password", String),
    Column("email", String),
    Column("device_token", String(255)),
    Column("is_login", Boolean),
    Column("login_datetime", DateTime),
    Column("create_datetime", DateTime),
)

admin_account = Table(
    "admin_account",
    metadata,
    Column("admin_id", Integer, primary_key=True, autoincrement=True),
    Column("firstname", String),
    Column("lastname", String),
    Column("username", String),
    Column("password", String),
    Column("email", String),
    Column("login_datetime", DateTime),
    Column("create_datetime", DateTime),
)

guard_account = Table(
    "guard_account",
    metadata,
    Column("guard_id", Integer, primary_key=True, autoincrement=True),
    Column("firstname", String),
    Column("lastname", String),
    Column("username", String),
    Column("password", String),
    Column("email", String),
    Column("login_datetime", DateTime),
    Column("create_datetime", DateTime),
)

blacklist_token = Table(
    "blacklist_token",
    metadata,
    Column("TOKEN", String, primary_key=True)
)

visitor = Table(
    "visitor",
    metadata,
    Column("visitor_id", Integer, primary_key=True, autoincrement=True),
    Column("home_id", Integer, ForeignKey("home.home_id")),
    Column("class", String),
    Column("class_id", Integer),
    Column("firstname", String),
    Column("lastname", String),
    Column("license_plate", String),
    Column("id_card", String),
    Column("invite_date", Date),
    Column("qr_gen_id", String),
    Column("create_datetime", DateTime),
)

blacklist = Table(
    "blacklist",
    metadata,
    Column("blacklist_id", Integer, primary_key=True, autoincrement=True),
    Column("home_id", Integer, ForeignKey("home.home_id")),
    Column("class", String),
    Column("class_id", Integer),
    Column("firstname", String),
    Column("lastname", String),
    Column("resident_add_reason", String),
    Column("admin_datetime", DateTime),
    Column("admin_approve", Boolean),
    Column("admin_reason", String),
    Column("resident_remove_reason", String),
    Column("resident_remove_datetime", DateTime),
    Column("admin_decline_remove_reason", String),
    Column("admin_decline_remove_datetime", DateTime),
    Column("license_plate", String),
    Column("create_datetime", DateTime),
)

whitelist = Table(
    "whitelist",
    metadata,
    Column("whitelist_id", Integer, primary_key=True, autoincrement=True),
    Column("home_id", Integer, ForeignKey("home.home_id")),
    Column("class", String),
    Column("class_id", Integer),
    Column("firstname", String),
    Column("lastname", String),
    Column("resident_add_reason", String),
    Column("admin_datetime", DateTime),
    Column("admin_approve", Boolean),
    Column("admin_reason", String),
    Column("resident_remove_reason", String),
    Column("resident_remove_datetime", DateTime),
    Column("admin_decline_remove_reason", String),
    Column("admin_decline_remove_datetime", DateTime),
    Column("license_plate", String),
    Column("qr_gen_id", String),
    Column("create_datetime", DateTime),
)


history_log = Table(
    "history_log",
    metadata,
    Column("log_id", Integer, primary_key=True, index=True),
    Column("class", String),
    Column("class_id", Integer),
    Column("datetime_in", DateTime),
    Column("resident_stamp", DateTime),
    Column("resident_send_admin", DateTime),
    Column("resident_reason", String),
    Column("admin_datetime", DateTime),
    Column("admin_approve", Boolean),
    Column("admin_reason", String),
    Column("datetime_out", DateTime),
    Column("create_datetime", DateTime),
)


home = Table(
    "home",
    metadata,
    Column("home_id", Integer, primary_key=True, index=True),
    Column("home_name", String),
    Column("home_number", String),
    Column("stamp_count", Integer),
    Column("create_datetime", DateTime),
    Column("update_datetime", DateTime),
)

resident_home = Table(
    "resident_home",
    metadata,
    Column("resident_id", Integer, ForeignKey("resident_account.resident_id")),
    Column("home_id", Integer, ForeignKey("home.home_id")),
    Column("create_datetime", DateTime),
)

resident_car = Table(
    "resident_car",
    metadata,
    Column("resident_id", Integer, ForeignKey("resident_account.resident_id")),
    Column("license_plate", String),
    Column("create_datetime", DateTime),
)


engine = create_engine(
    DATABASE_URL, pool_size=3, max_overflow=0
)

metadata.create_all(engine)
