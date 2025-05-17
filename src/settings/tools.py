# The `Notifications` class in the provided Python code handles displaying system notifications with
# user configuration settings.
from .Settings import NOTIFICATION
from notifypy import Notify
from models.cruds.crud_settings import  Settings_cruds


crudSettings = Settings_cruds()


class Notifications(Notify):
    
    def __init__(
        self, 
        default_notification_title="Default Title",
        default_notification_message="Default Message",
        default_notification_application_name="Python Application (notify.py)", 
        default_notification_urgency='normal', 
        default_notification_icon= NOTIFICATION.IMAGE, 
        default_notification_audio=NOTIFICATION.SOUND, 
        enable_logging=False,
        **kwargs
        ):

        super().__init__(default_notification_title, default_notification_message, default_notification_application_name, default_notification_urgency, default_notification_icon, default_notification_audio, enable_logging, **kwargs)

    def message(self, title:str, msg:str, urgency:str='normal'):
        if urgency in ['low', 'normal', 'critical']:
            self.urgency = urgency
            self.configure()

    def configure(self, icon:str=NOTIFICATION.IMAGE, audio:str=NOTIFICATION.SOUND):
        
        conf = self.ReadConfig()
        
        self.audio = audio if conf['audio_active'] else ''
        if conf["msgDisplay"] == True:
            self.send()
    
    def ReadConfig(self,):
        """
            `ReadConfig` for notifications
            ----------------------------------------------------------

            Args:
                None
            Returns:
                `dict` `{
                    "audio_active": bool,
                    "msgDisplay": bool
                    }`
            Example:
                >>> from settings import Notifications
                >>> n = Notifications()
                >>> n.ReadConfig()
                >>> {'audio_active': True, 'msgDisplay': True}

            Description:

            `ReadConfig` function using to setup all user notification users choises configuration for notification

        """
        try:
            data = crudSettings.get('notification')
            return data
        except Exception as e:
            print(e)

    def settings(self,audio:bool,msg_display:bool):
        """
        The `Settings` function is a class method in Python that updates notification settings with
        specified audio and message display preferences.
        
        :param audio_active: The `audio_active` parameter in the `Settings` method is a boolean parameter
        that determines whether audio notifications are active or not. By default, it is set to `True`,
        meaning that audio notifications are active, defaults to True
        :type audio_active: bool (optional)
        :param msgDisplay: The `msgDisplay` parameter in the `Settings` method is a boolean parameter that
        determines whether messages should be displayed or not. By default, it is set to `True`, meaning
        that messages will be displayed, defaults to True
        :type msgDisplay: bool (optional)
        """ 
        try:
            crudSettings.updates('notification', {
                "audio_active": audio,
                "msgDisplay": msg_display
            })
        
        except Exception as e:
            print(e)


