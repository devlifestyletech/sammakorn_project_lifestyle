from models import visitor, blacklist, whitelist, whitelist_log
from schemas import VisitorIN, Blacklist, Whitelist, WhitelistLog, UpdateVisitor
from datetime import date, datetime


# ------------------------------------- Application ---------------------------


async def Register_Visitor(db, register: VisitorIN):
    defual_timestamp = datetime(1, 1, 1)

    query = visitor.insert().values(firstname=register.firstname, lastname=register.lastname, home_number=register.home_number,
                                    license_plate=register.license_plate, date=register.date, start_time=register.start_time, end_time=register.end_time, timestamp=defual_timestamp)
    last_record_id = await db.execute(query)
    return {"id": last_record_id, "msg": "ok"}


async def Register_Backlist(db, register: Blacklist):
    query = blacklist.insert().values(firstname=register.firstname, lastname=register.lastname,
                                      home_number=register.home_number, license_plate=register.license_plate)
    last_record_id = await db.execute(query)
    return {"id": last_record_id, "msg": "ok"}


async def Register_Whitelist(db, register: Whitelist):
    query = whitelist.insert().values(firstname=register.firstname, lastname=register.lastname,
                                      home_number=register.home_number, license_plate=register.license_plate)
    last_record_id = await db.execute(query)
    return {"id": last_record_id, "msg": "ok"}


# ------------------------------------- End Application ---------------------------


# -------------------------------- Website ------------------------
async def Visitor_CheckIN(db, visitor_id: int, payload: UpdateVisitor):
    query = visitor.update().where(visitor.c.visitor_id == visitor_id).values(
        timestamp=payload.timestamp)
    await db.execute(query)
    return {"id": visitor_id, **payload.dict()}


async def Register_Whitelist_log(db, register=WhitelistLog):
    query = whitelist_log.insert().values(firstname=register.firstname, lastname=register.lastname,
                                          home_number=register.home_number, license_plate=register.license_plate, timestamp=register.timestamp)
    last_record_id = await db.execute(query)
    return {"id": last_record_id, "msg": "ok"}


async def visitor_All_item(db):
    query = visitor \
        .select()   \
        .order_by(visitor.c.start_time.asc())
    return await db.fetch_all(query)


async def Visitor_Item(db, home_number: str):
    today = date.today()

    query = visitor \
        .select()   \
        .where(visitor.c.date == today)    \
        .where(visitor.c.home_number == home_number)    \
        .order_by(visitor.c.start_time.asc())
    return await db.fetch_all(query)


async def Blacklist_Item(db, home_number: str):
    query = blacklist \
        .select()   \
        .where(blacklist.c.home_number == home_number)
    return await db.fetch_all(query)


async def Whitelist_Item(db, home_number: str):
    query = whitelist \
        .select()   \
        .where(whitelist.c.home_number == home_number)
    return await db.fetch_all(query)


async def Whitelist_log_Item(db, home_number: str):
    query = whitelist_log \
        .select()   \
        .where(whitelist_log.c.home_number == home_number)
    return await db.fetch_all(query)


# -------------------------------- End Website ------------------------


async def get_all_items(db):
    today = date.today()

    all_items = []

    query_visitor = visitor.select()    \
        .where(visitor.c.date == today)
    query_whitelist = whitelist.select()
    query_blacklist = blacklist.select()

    visitor_items = await db.fetch_all(query_visitor)
    whitelist_items = await db.fetch_all(query_whitelist)
    blacklist_items = await db.fetch_all(query_blacklist)

    all_items.append(visitor_items)
    all_items.append(whitelist_items)
    all_items.append(blacklist_items)

    return all_items
