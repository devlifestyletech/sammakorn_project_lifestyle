from fastapi.encoders import jsonable_encoder
from .models import blacklist_token


class Logout:
    async def is_token_blacklisted(self, db, token):
        query = blacklist_token.select().where(blacklist_token.c.TOKEN == token)
        value = jsonable_encoder(await db.fetch_one(query))

        if value is None:
            return False
        else:
            return True

    async def add_blacklist_token(self, db, token):
        query = blacklist_token.insert().values(TOKEN=token)
        await db.execute(query)

        return {'result': True}

    async def logout(self, db, token):
        if await self.is_token_blacklisted(db, token):
            return {'result': True}
        else:
            return await self.add_blacklist_token(db, token)
