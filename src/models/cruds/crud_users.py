from models.database import Base, get_db
from models.model_users import User, UserSession, UserProfile
from sqlalchemy.orm import Session
import datetime


class Login:
    def __init__(self):
        self.db = next(get_db())
    
    def adds(self, Response:dict):
        expirated_at = datetime.utcnow() + datetime.timedelta(days=1)
        
        if Response['login_value']:
            
            session = UserSession(
                user_id=Response['id'], 
                token=Response['userProfile']['access_token'],
                created_at=datetime.utcnow(),
            )
            
            user = User(
                username= Response['userProfile']['username'],
                email=Response['userProfile']['email'],
                first_name=Response['userProfile']['first_name'],
                last_name=Response['userProfile']['last_name'],
                phone=Response['userProfile']['phone'],
            )