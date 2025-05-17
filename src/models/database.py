# local modules
from settings import Settings
#
from sqlalchemy.orm import sessionmaker, Session
from sqlalchemy import create_engine
from sqlalchemy.ext.declarative import declarative_base
#
import os

Base = declarative_base()



def get_db():

    try:
        if os.path.exists(Settings.DATABASE.DB_USER):
            engine = create_engine(
                url='sqlite:///' + Settings.DATABASE.DB_USER,
                echo= Settings.DATABASE.ECHO
                )
            SessionLocal = sessionmaker(
                autocommit=False, 
                autoflush=False, 
                bind=engine
                )
            Base.metadata.create_all(engine)
            db = SessionLocal()
            yield db
        else:
            engine = create_engine(
                url='sqlite:///' + Settings.DATABASE.DB_USER,
                echo= Settings.DATABASE.ECHO
                )
            SessionLocal = sessionmaker(
                autocommit=False, 
                autoflush=False, 
                bind=engine
                )
            Base.metadata.create_all(engine)
            db = SessionLocal()
            from .import initialize
            initialize.initialise(db)
            yield db

        
        yield db 
        
        
    except Exception as e:
        raise e