import os
from sqlalchemy.orm import Session
from settings.Settings import DATABASE, PATHS
from .database import get_db
from .model_users import Settings



def initialise(db:Session):
    def add(key:dict, value:dict, created_at=None, updated_at=None):
        setting = Settings(key=key, value=value, created_at=created_at, updated_at=updated_at)
        db.add(setting)
        db.commit()
        db.refresh(setting)
    add(key="theme",value={"url": os.path.join(PATHS.UI, "themes",'app.themes.final.json'),"name": "main","theme_mode": 'light',})
    add(key="taskmanager",value={    "num_processes": '4',})
    add('notification', {"audio_active": True,"msgDisplay": True,})
    add('books_search_params', {'departement':'all','level':'all','categorie':'all','years':'laster'})
    add('plugins', {
        "directories":'./plugins',
    })