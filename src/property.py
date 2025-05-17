"""
This module contains a set of utility functions for working with PySide6
applications.

The InsertProperty class is used to load a QML file and execute the
application.

The Wintools class contains methods for closing all windows, reloading the
application and quitting the application.

"""

import sys,os
from PySide6.QtCore import QUrl
from PySide6.QtQml import QQmlContext
from PySide6.QtWidgets import QApplication
from PySide6.QtQml import QQmlApplicationEngine


class InsertProperty:
    """
    This class is used to load a QML file and execute the application.
    """

    def __init__(self):
        """
        Initialize the application and QML engine.
        """
        self.app = QApplication()
        self.engine = QQmlApplicationEngine()
        self.context = self.engine.rootContext()

    def load_ui(self, page_path:str):
        """
        Load the QML file and execute the application.

        Args:
            page_path (str): The path to the QML file.
        """
        self.engine.load(QUrl.fromLocalFile(page_path))
        if not self.engine.rootObjects():
            sys.exit(-1)
        exit_code = self.app.exec()
        
        del self.engine
        sys.exit(exit_code)



class Wintools:
    """
    This class contains methods for closing all windows, reloading the
    application and quitting the application.
    """

    def __init__(self, app:QApplication, engine:QQmlApplicationEngine=None, context:QQmlContext=None):
        """
        Initialize the application and QML engine.

        Args:
            app (QApplication): The application object.
            engine (QQmlApplicationEngine, optional): The QML engine. Defaults to None.
            context (QQmlContext, optional): The QML context. Defaults to None.
        """
        self.app = app
    
    def closeAllWindows(self):
        """
        Close all windows.
        """
        self.app.closeAllWindows()

    def closeAllWindow(self):
        """
        Close all windows.
        """
        for window in QApplication.allWindows():
            window.close()

    def reload(self):
        """
        Reload the application.
        """
        try:
            self.closeAllWindows()
            QApplication.instance().quit()
            os.execv(sys.executable, [sys.executable] + sys.argv)
        except Exception as e:
            print(e)
    
    def Reload(self):
        """
        Reload the application.
        """
        try:
            self.closeAllWindows()
            QApplication.instance().quit()
            os.execv(sys.executable, [sys.executable] + sys.argv)
        except Exception as e:
            print(e)
            return
        return
    
    def quit(self):
        """
        Quit the application.
        """
        try:
            self.closeAllWindows()
            QApplication.instance().quit()
        except Exception as e:
            print(e)
