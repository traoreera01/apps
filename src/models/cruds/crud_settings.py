
import os
from datetime import datetime
from models.model_users import Settings
from models.database import get_db
from settings.Settings import PATHS, DATABASE




class Settings_cruds():

    def __init__(self):

        self.db = next(get_db())

    def add(self,key:dict, value:dict, created_at=None, updated_at=None):
        setting = Settings(key=key, value=value, created_at=created_at, updated_at=updated_at)
        try:
            self.db.add(setting)
            self.db.commit()
            self.db.refresh(setting)
            return setting
        
        except Exception as e:
            raise e

    def removes(self,key):
        try:
            setting = self.db.query(Settings).filter(Settings.key == key).first()
            if setting:
                self.db.delete(setting)
                self.db.commit()
                return True
            else:
                return False
        except Exception as e:
            raise e

    def updates(self,key, value:dict,  updated_at=datetime.utcnow()):
        try:
            setting = self.db.query(Settings).filter(Settings.key == key).first()
            if setting:
                setting.value = value
                setting.updated_at = updated_at
                self.db.commit()
                self.db.refresh(setting)
                return setting
            else:
                return None
        except Exception as e:
            raise e

    def get(self,key):
        try:
            setting = self.db.query(Settings).filter(Settings.key == key).first()
            return setting.value
        except Exception as e:
            raise e

    def get_all(self):
        try:
            settings = self.db.query(Settings).all()
            return [i.responseModel() for i in settings]
        except Exception as e:
            raise e


class Init_settings():
    def __init__(self):
        print('is called')
        try:
            self.init_themes()
            self.init_taskmanager()
            self.init_notification()
        
        except Exception as e:
            print(e)
        super().__init__()
        
    def init_themes(self):
        
        try:
            Settings_cruds.add(self:=Settings_cruds,
                key="theme",
                value={
                    "url": os.path.join(PATHS.UI, "themes",'app.themes.final.json'),
                    "name": "main",
                    "theme_mode": 'light',
                }
            )
        except Exception as e:
            pass
    
    def init_taskmanager(self):
        try: Settings_cruds.add(self:=Settings_cruds,
                key="taskmanager",
                value={
                    "num_processes": '4',
                }
            )
        except Exception as e:
            print(e)

    def init_notification(self):
        
        Settings_cruds.add(self:=Settings_cruds,
            'notification', {
            "audio_active": True,
            "msgDisplay": True,
        })