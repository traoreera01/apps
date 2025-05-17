from datetime import datetime
from http.client import HTTPException
import requests, re, os
from .RSA import Cryptings

from settings import Settings


class Converter:

    @staticmethod
    def converter_datetime(date_str:str):
        formats = [
            "%Y-%m-%d %H:%M:%S",  # Format standard avec heure
            "%Y-%m-%d",           # Format date seule
            "%d/%m/%Y",           # Format européen
            "%d-%m-%Y",           # Autre format européen
            "%m/%d/%Y",           # Format américain
            "%d %B %Y",           # Format avec mois écrit (ex: 01 Janvier 2024)
            "%Y-%m-%dT%H:%M:%SZ", # Format ISO 8601
            "%Y-%m-%dT%H:%M:%S.%fZ", # Format ISO 8601 avec millisecondes
        ]
        for fmt in formats:
            try:
                return datetime.strptime(date_str, fmt)
            except ValueError:
                continue
    
        raise ValueError(f"Format de date non reconnu : {date_str}")

class Validators:
    @staticmethod
    def validate_email(email: str) -> bool:
        """Valide un format d'email."""
        pattern = r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$'
        return bool(re.match(pattern, email))

    @staticmethod
    def validate_password(password: str) -> bool:
        """Vérifie la force d'un mot de passe."""
        return bool(re.match(r'^(?=.*[A-Z])(?=.*[a-z])(?=.*\d)(?=.*[@$!%*?&]).{8,}$', password))

    @staticmethod
    def validate_date(date_str: str, format='%Y-%m-%d') -> bool:
        """Valide une date selon un format donné."""
        try:
            datetime.strptime(date_str, format)
            return True
        except ValueError:
            return False


class Tools(Validators, Converter):
    def token_validation(func):
        """Décorateur pour valider la session utilisateur via un token."""
        def wrapper(self, *args, **kwargs):
            token = self.get_token()
            if not token:
                print("Aucun token trouvé.")
                return None

            headers = self.headers_auth(token)
            try:
                response = self.session.post(
                    f'{self.base_url}/auth/token',
                    headers=headers,
                    json={'token': token},
                    timeout=self.timeout
                )
                response.raise_for_status()
            except requests.RequestException as e:
                print(f"Erreur d'authentification : {str(e)}")
                return None

            return func(self, *args, **kwargs)
        return wrapper


class API(Tools):
    def __init__(self, base_url='http://127.0.0.1:8000/api/', version='v1', timeout=10) -> None:
        self.base_url = f'{base_url}{version}'
        self.session = requests.Session()
        self.timeout = timeout
        self.cookies: dict  ={}
        
        try:
            if not os.path.exists(Settings.RSAConfig.PUBLIC_KEY):
                self.get_public_key()
            self.rsa_tools:Cryptings = Cryptings()
        except Exception as e:
            raise f"Failed to create Cryptings instance: {e}"
        
    def get_token(self) -> str | None:
        return self.cookies.get('token')

    def public_header(self):
        return {'accept': 'application/json', 'Content-Type': 'application/json'}

    def headers_auth(self, token: str, token_type: str = "Bearer"):
        return {
            "accept": "application/json",
            "Content-Type": "application/json",
            "Authorization": f"{token_type} {token}"
        }

    def login(self, username: str, password: str, scope: str = 'manager', cookies:dict = {} ) -> dict | None:
        if not username or not password:
            raise ValueError("Username and password cannot be empty.")

        encrypted_username = self.rsa_tools.encrypt_message(username)
        encrypted_password = self.rsa_tools.encrypt_message(password)

        data = {
            "grant_type": "password",
            "username": encrypted_username,
            "password": encrypted_password,
            "scope": scope,
            "client_id": "string",
            "client_secret": "string",
        }

        try:
            response = self.session.post(f"{self.base_url}/auth/login", data=data, timeout=self.timeout)
            response.raise_for_status()
            response_data = response.json()

            token = response_data.get("userProfile", {}).get("access_token")
            if token:
                cookies['token'] = token
                self.cookies = cookies


            return response_data
        except requests.RequestException as e:
            print(f"Erreur de connexion : {str(e)}")
            return None

    @Tools.token_validation # type: ignore
    def logout(self) -> dict | None:
        """Déconnexion et suppression du token"""
        try:
            response = self.session.post(
                f"{self.base_url}/auth/logout",
                json={"token": self.get_token()},
                timeout=self.timeout
            )
            response.raise_for_status()
            self.session.cookies.clear()
            print("Déconnexion réussie.")
            return response.json()
        except requests.RequestException as e:
            print(f"Erreur lors de la déconnexion : {str(e)}")
            return None

    @Tools.token_validation
    def list_session(self) -> dict | None:
        """Liste les sessions actives."""
        try:
            response = self.session.get(
                f'{self.base_url}/auth/token',
                headers=self.headers_auth(self.get_token()), # type: ignore
                timeout=self.timeout
            )
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            print(f"Erreur lors de la récupération des sessions : {str(e)}")
            return None

    @Tools.token_validation
    def user_state(self, user_id: str, state: bool = False) -> dict | None:
        """Change l'état actif/inactif d'un utilisateur."""
        if not user_id:
            raise ValueError("L'ID utilisateur ne peut pas être vide.")

        data = {"id": user_id, "state": state}
        try:
            response = self.session.put(
                f'{self.base_url}/auth/users/{user_id}',
                json=data,
                headers=self.headers_auth(self.get_token()),
                timeout=self.timeout
            )
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            print(f"Erreur lors de la mise à jour de l'état de l'utilisateur : {str(e)}")
            return None

    def new_user(self, data: dict) -> dict | None:
        """Création d'un nouvel utilisateur."""
        if not data:
            raise ValueError("Les données utilisateur ne peuvent pas être vides.")

        if not self.validate_email(data.get('email', '')):
            print("Adresse email invalide.")
            return None

        try:
            response = self.session.post(
                f'{self.base_url}/auth/new_user',
                json=data,
                timeout=self.timeout
            )
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            print(f"Erreur lors de la création de l'utilisateur : {str(e)}")
            return None

    @Tools.token_validation
    def delete_user(self,user_id):
        try:
            response = self.session.delete(f'{self.base_url}/auth/users/{user_id}', headers=self.headers_auth(self.get_token()))
            if response.ok:
                return response.json()
            else:return None 
        except Exception as e:
            raise HTTPException(500,e)


    @Tools.token_validation
    def user_session(self,id:str, state:bool=True):

        if not id or state:
            raise ValueError("id or sate cannot to be empty.")
        
        try:
            response =self.session.get(f'{self.base_url}/auth/{id}:{state}', headers=self.headers_auth(self.get_token()))
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            print(f"Erreur lors du changement d'eta t du token de {id} : {str(e)}")
            return None

    @Tools.token_validation
    def user_list(self):
        try:
            response = self.session.get(f'{self.base_url}/auth/users',headers=self.headers_auth(self.get_token()))
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            print(f"Erreur lors de la recuperation de la liste d'utilisateur")
            return None
    
    def add_avatar_url(self, username:str,lastname:str, bacground:str="2f2f2f", color:str="FFF", bold:bool=True, supercase=False):

        url = f"https://avatar.iran.liara.run/username?username={username}+{lastname}&background={bacground}&color={color}&supercase={supercase}&bold={bold}"
        return url

    def Profile_update(self,user_id:str,adress:str,gender:str, avatar_url:str, birth_date:str):
        
        birth_date = birth_date if Tools.validate_date(birth_date) else None
        data:dict = {
            "user_id": user_id,
            "address": adress if adress else None,
            "birth_date": birth_date,
            "gender": gender if gender else 'male',
            "avatar_url":avatar_url if avatar_url else None,
        }
        
        
        try:
            response = self.session.put(url=f'{self.base_url}/auth/profile', json=data, headers=self.headers_auth(self.get_token()))
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            
            print(f"Erreur lors de la request de mise a jour du profile {e}")
            return None

    @Tools.token_validation
    def token_state(self,token_id,state):
        try:
            response = self.session.get(f'{self.base_url}/auth/token/{token_id}:{state}', headers=self.headers_auth(self.get_token()))
            response.raise_for_status()
            return response.json()
        except requests.RequestException as e:
            print(f"Erreur lors de la request de mise a jour des droits {e}")
            return e
        
        
    def get_public_key(self, file:str= Settings.RSAConfig.PUBLIC_KEY):
        try:
            response = self.session.get(f'{self.base_url}/tools/pemBiblioapp')
            response.raise_for_status()
            with open(file, "wb") as file:
                file.write(response.content)
            return None
        except requests.RequestException as e:
            print(f"Erreur lors de la request de mise a jour des droits {e}")
            return e
APIs = API()