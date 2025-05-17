import os
import sys
from models import initialize
from routes.login import LoadLogin, Login
from routes.profile import Profile
from routes.home import App
from routes.agenda import EventModel as Agenda
from settings.Settings import DATABASE
from settings.themes import InsertThemes, Themes

from threads import TaskManager


if __name__ == "__main__":
    if not os.path.exists(DATABASE.DB_USER):print("ferfe")
    #themes
    
    # initialize app engine
    loadLogin = LoadLogin()
    # initialize login crud
    login_context = Login(app=loadLogin.app)
    home_context = App(app=loadLogin.app,context=loadLogin.context)
    profile_context = Profile(app=loadLogin.app,context=loadLogin.context)
    
    themes_insertion = InsertThemes(loadLogin.context,loadLogin.app)
    themes_crud = Themes(app=loadLogin.app, context=loadLogin.context)
    agenda = Agenda()
    
    
    login_context.signal.connect(Login)
    home_context.signal.connect(App)
    themes_crud.signal.connect(Themes)
    profile_context.signal.connect(Profile)
    agenda.eventsChanged.connect(Agenda)
    
    
    # set context
    loadLogin.context.setContextProperty("login", login_context)
    loadLogin.context.setContextProperty("homeContext", home_context)
    loadLogin.context.setContextProperty("themesConf", themes_crud)
    profile_context.context.setContextProperty("profileContext", profile_context)
    #themes_insertion.context.setContextProperty("themesInsertion", themes_insertion)
    profile_context.context.setContextProperty("eventModel", agenda)
    
    
    
    # load ui
    loadLogin.load_ui(".\\UI\\pages\\NewCount.qml")