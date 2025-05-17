from .import APIs
from PySide6.QtCore import QObject, Signal, Slot
from property import InsertProperty, Wintools
from PySide6.QtWidgets import QApplication




class Login(QObject,):
    """A class to handle user login functionality."""
    signal = Signal(str)
    
    def __init__(self,app: QApplication,parent =None, objectName=None, ):
        super().__init__(parent, objectName=objectName)
        self.wintools = Wintools(app)
        
        
    @Slot(str, str, bool)
    def logins(self, username: str, password: str, remeberme:bool):
        
        response = APIs.login(username=username, password=password,  scope='user')
        if response:
            print(response)
            APIs.logout()
        


class LoadLogin(InsertProperty):

    def __init__(self, Displayname:str="Etudiant"):
        super().__init__()
        #self.app.setWindowIcon(QIcon(os.path.join(SubUrls.imagePath, "onedark-bash.png")))
        self.app.setApplicationName("OnedarkBash")
        self.app.setOrganizationName("OnedarkBash")
        self.app.setOrganizationDomain("OnedarkBash")
        self.app.setApplicationDisplayName(Displayname)
        self.app.setApplicationVersion("1.0.0")

    def load_ui(self, page_path:str=".\\UI\\pages\\Login.qml"):
        return super().load_ui(page_path)