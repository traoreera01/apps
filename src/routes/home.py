# The above class defines an application class in Python that includes methods for handling host
# requests and loading a user interface.
# The statement `from .import APIs` is attempting to import a module named `APIs` from the current
# package or directory. The dot `.` before `import` indicates that the module is located in the same
# package or directory as the current module. However, there seems to be a syntax error in the
# statement. The correct syntax should be `from . import APIs` with a space between the dot and the
# `import` keyword.
from .import APIs
from threading import Thread
from PySide6.QtQml import QQmlContext
from PySide6.QtWidgets import QApplication
from property import InsertProperty, Wintools
from PySide6.QtCore import QObject, Signal, Slot



class App(QObject):
    signal = Signal(str)
    
    def __init__(self,app: QApplication,context:QQmlContext,parent =None, objectName=None,):
        super().__init__(parent, objectName=objectName)
        self.app = app
        self.context = context
        self.wintools = Wintools(self.app)
        return
    
    @Slot()
    def host_requesting(self):
        
        #request api to etablish connection
        try:
            status = True
            self.context.setContextProperty('status_host', status)
        except Exception as e:
            status = False
            self.context.setContextProperty('status_host', status)



class LoadApp(InsertProperty):
    
    def __init__(self, Displayname:str="Etudiant"):
        super().__init__()
        #self.app.setWindowIcon(QIcon(os.path.join(SubUrls.imagePath, "onedark-bash.png")))
        self.app.setApplicationName("OnedarkBash")
        self.app.setOrganizationName("OnedarkBash")
        self.app.setOrganizationDomain("OnedarkBash")
        self.app.setApplicationDisplayName(Displayname)
        self.app.setApplicationVersion("1.0.0")
        
        return
    
    def load_ui(self, page_path:str=".\\UI\\pages\\App.qml"):
        return super().load_ui(page_path)