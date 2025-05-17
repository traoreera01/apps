import os
from property import Wintools
from .Settings import THEMES, PATHS, QMLResources
from models.cruds import crud_settings
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlContext
from PySide6.QtCore import QObject, Signal, Slot
import json

crud = crud_settings.Settings_cruds()
thems = THEMES(run=False)


class Themes(QObject):
    
    signal=Signal(str)
    
    def __init__(self, app:QApplication,context:QQmlContext=None,parent = None, objectName = None):
        super().__init__(parent, objectName=objectName)
        self.wintools = Wintools(app)
        self.app =app
        self.context = context
        
        
    @Slot(str,str)
    def styleSheetFile(self, file:str,name:str='main'):
        try:
            if file in PATHS.THEMELIST:
                crud.updates('theme', value={
                    'url': os.path.join(PATHS.THEMEDIR, file),
                    'name': name,
                    'theme_mode': 'light'
                })
                self.wintools.reload()
        except Exception as e :
            print(e)

    @Slot(bool)
    def swith_theme(self,value:bool):
        
        print(value)
        try:
            data = crud.get('theme')
            crud.updates(
                'theme',
                {
                    'url': data['url'],
                    'name':data['name'],
                    'theme_mode': 'light' if value else 'dark'
                }
            )
            thems.theme_mode = 'light' if value else 'dark'
            thems.themes_path = data['url']
            thems.load()
            InsertThemes(context=self.context, app=self.app)
        except Exception as e:
            print(e)
    
    @Slot(bool)
    def reloadThemes(self, checked:bool):
        try:
            InsertThemes(context=self.context, app=self.app)
            #InsertThemes.qmlResourceInsert(self:=InsertThemes)

        except Exception as e:
            raise e


class InsertThemes:

    def __init__(self, context:QQmlContext, app:QApplication):
        self.context = context    
        self.themes = Themes(app=app)
        
        self.themes.signal.connect(Themes)
        self.context.setContextProperty('themes', self.themes)
        
        self.initialize()
        self.qmlResourceInsert()


    def initialize(self):
        themes_db = crud.get('theme')
        initial_theme = THEMES(themes_path=themes_db['url'],theme_mode=themes_db['theme_mode'], run = True)
        self.context.setContextProperty('swithvalue',True if themes_db['theme_mode'] == 'light' else False)
        self.context.setContextProperty("loginColor", initial_theme.Login)
        self.context.setContextProperty("appColor", initial_theme.Application)
        self.context.setContextProperty('homes', initial_theme.home)
        self.context.setContextProperty('params', initial_theme.settings)
        self.context.setContextProperty('themesList', initial_theme.themesList)
        self.context.setContextProperty('bibliotheque', initial_theme.biblio)
        self.context.setContextProperty('controlsThemes', initial_theme.controls)
    
    def qmlResourceInsert(self,) -> dict | None :
        try:
            with open(PATHS.QMLURLS,) as file:
                data = json.load(file)
                file.close()
            self.context.setContextProperty('icons', data[QMLResources.ICON])
            self.context.setContextProperty('images', data[QMLResources.IMAGES])
            return
        except Exception as e:
            raise e

