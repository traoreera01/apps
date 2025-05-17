from .database import Base
from datetime import datetime
from sqlalchemy import (
    JSON,
    Column,
    LargeBinary,
    String,
    Integer,
    DateTime,
    Boolean,
    Enum,
    TIMESTAMP
)




class User(Base):
    
    __tablename__ = "users"
    id = Column(String, primary_key=True, unique=True)
    username = Column(String(50), unique=True, nullable=False)
    email = Column(String(100), unique=True, nullable=False)
    first_name = Column(String(50))
    last_name = Column(String(50))
    phone = Column(String(20))
    
    remember = Column(Boolean, nullable=False)
    
    
    def __init__(self, username, email, first_name=None, last_name=None, phone=None, remember=False):
        self.username = username
        self.email = email
        self.first_name = first_name
        self.last_name = last_name
        self.phone = phone
        self.remember = remember
    
    
    def response_Models(self):
        
        return {
            'id': self.id,
            "username": self.username,
            "email": self.email
        }

class UserProfile(Base):
    __tablename__ = "user_profiles"

    id = Column(String, primary_key=True, unique=True)
    user_id = Column(String, nullable=False, unique=True)
    birth_date = Column(TIMESTAMP)
    address = Column(String)
    gender = Column(Enum('male', 'female', 'other', name="gender_types"))
    avatar_url = Column(LargeBinary)

    def response_models(self,):

        return {
            "address": self.address,
            "birth_date": self.birth_date,
            "gender": self.gender,
            "avatar_url": self.avatar_url,
        }

class UserSession(Base):
    __tablename__ = "user_sessions"

    id = Column(String, primary_key=True, unique=True)
    user_id = Column(String, nullable=False, unique=True)
    token = Column(String, nullable=False, unique=True)
    created_at = Column(DateTime, nullable=False, default=datetime.utcnow)
    
    def __init__(self, user_id, token, created_at=None):
        self.user_id = user_id
        self.token = token
        self.created_at = created_at
        
    def response_models(self,):

        return {
            "token": self.token,
            "expiration": self.expiration,
            "created_at": self.created_at,
        }

class Settings(Base):
    __tablename__ = "settings"

    id = Column(Integer, primary_key=True, unique=True,autoincrement=True)
    key = Column(String, nullable=False, unique=True)
    value = Column(JSON, nullable=False)
    created_at = Column(DateTime, nullable=False, default=datetime.utcnow)
    updated_at = Column(DateTime, nullable=False, default=datetime.utcnow)

    def __init__(self, key, value, created_at=None, updated_at=None):
        self.key = key
        self.value = value
        self.created_at = created_at
        self.updated_at = updated_at
    
    def responseModel(self):
        return self.value