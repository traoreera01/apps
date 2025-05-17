import tempfile
from .import APIs
from models.cruds import crud_users
from PySide6.QtQml import QQmlContext
from settings.tools import Notifications
from PySide6.QtWidgets import QApplication
from property import  Wintools, InsertProperty
from PySide6.QtCore import QObject, Signal, Slot



notify = Notifications(
    default_notification_title="StudentLive",
    default_notification_message="Default Message",
    default_notification_application_name="BIblioapp",
    timeout=20,
)

class Profile(QObject,):
    """A class to handle user login functionality."""
    signal = Signal(str)
    
    def __init__(self,app: QApplication,context:QQmlContext,parent =None, objectName=None, ):
        super().__init__(parent, objectName=objectName)
        self.wintools = Wintools(app)
        self.context = context
        
    
    @Slot()
    def changeUser_Image(self,):
        try:
            #remove prefixes
            path = path.removeprefix("file:///")
            # read the image    
            with open(path, "rb") as f:
                #create tmp image file
                tmp_file = tempfile.NamedTemporaryFile(delete=False)
                tmp_file.write(f.read())
                tmp_file.close()
            # set the new image path
            self.context.setContextProperty('user_image', tmp_file.name)
            notify.message("Profile Image", "Image changed successfully", 'low')
        except Exception as e:
            notify.message("Profile Image", f"Error changing image: {e}", 'critical')
            print(e)


class ProfileVariable():
    
    
    def __init__(self, context:QQmlContext,):
        
        self.context = context
    
    def profile_image(self,):
        try:
            #insert img on qml app
            self.context.setContextProperty('userPPImages', )
        except Exception as e:
            notify.message("Profile Image", f"Error changing image: {e}", 'critical')



class UpdateUI_profile(ProfileVariable):
    
    def __init__(self, context):
        super().__init__(context)
    
    @Slot()
    def UpdateUI(self,):
        
        #maj- user interface for putching data using app context from Profile Variable
        try:
            pass
        except:
            pass