import os
import json

class RSAConfig:
    PUBLIC_KEY = os.getenv("PUBLIC_KEY")

class DATABASE:
    DB_USER: str = os.path.join(os.path.curdir, "data", "users.db")
    ECHO:bool = False

class THREADS:
    NUM_PROCESSES:int = int(os.getenv("THREAD_COUNT"))

class PATHS:
    ROOTDIR = os.path.curdir
    UI = os.path.join(ROOTDIR, "UI")
    THEMEDIR = os.path.join(UI,'themes')
    
    #THEMELIST: list = [i for i in os.listdir(THEMEDIR) if i.endswith('.json')]
    QMLURLS:str = os.path.join(UI, 'qml.urls.json')

class QMLResources:
    QMLROOTDIR: str = "qmlRootDir"
    CONTROLS: str = "controls"
    PAGES: str = "pages"
    ICON: str = "icon"
    COLORANIM: str = "ColorAnim"
    SOUND: str = "sound"
    IMAGES: str = "images"

class NOTIFICATION():
    IMAGE:str = os.path.join(PATHS.UI,'src','Images','nord-Minimal-Nord.png') if os.path.exists(os.path.join(PATHS.UI,'src','Images','nord-Minimal-Nord.png')) else ''
    SOUND:str = os.path.join(PATHS.UI, 'src', 'Sound', 'notification.wav') if os.path.exists(os.path.join(PATHS.UI, 'src', 'Sound', 'notification.wav')) else ''

class THEMES:
    
    def __init__(
        self, 
        themes_path:str ='.\\UI\\themes\\test.themes.json',
        theme_mode:str='dark', run:bool=True
        ) -> None:

        self.ROOTDIR = os.path.join(PATHS.UI, "themes")
        self.Login:dict = {}
        self.home:dict = {}
        self.Application:dict = {}
        self.settings:dict = {}
        self.themesList:dict = {}
        self.biblio:dict = {}
        self.controls:dict = {}
        self.resetColor:dict = {}
        self.controls:dict = {}
        
        self.theme_mode:str = theme_mode
        self.description:dict = {}
        self.themes_path = themes_path
        try:
            with open(self.themes_path, "r") as f:
                self.themesList = json.load(f)
        except Exception as e:
            
            raise e
        
        if run :self.load()

    def theme_descriptions(self)->dict:
        return self.themesList['description']
    
    
    def load(self,):
        try:
            if self.theme_mode in ["dark","light"]:
                self.Login = self.themesList[self.theme_mode]["login"]
                self.home = self.themesList[self.theme_mode]["Home"]
                self.Application = self.themesList[self.theme_mode]["Application"]
                self.settings = self.themesList[self.theme_mode]["Settings"]
                self.biblio = self.themesList[self.theme_mode]["bibilotheque"]
                self.controls = self.themesList[self.theme_mode]["controls"]
                self.resetColor = self.themesList[self.theme_mode]["resetColor"]
                self.controls = self.themesList[self.theme_mode]["controls"]
            else:
                raise ValueError('theme must be "dark" or "light"')
        except Exception as e:
            raise e


class SETTINGS(DATABASE,RSAConfig,THREADS,PATHS,THEMES):
    pass
