
# internet module
import requests

# personal modules
from settings import Settings 
import os

# security importation
from cryptography.hazmat.primitives.asymmetric import rsa, padding
from cryptography.hazmat.primitives import serialization, hashes
import base64


class Cryptings:

    def __init__(self):
        super(Cryptings, self).__init__()

    @classmethod
    def encrypt_message(self, message: str) -> str:
        try:
            if os.path.exists(Settings.RSAConfig.PUBLIC_KEY):
                with open(Settings.RSAConfig.PUBLIC_KEY, "rb") as f:
                    self.public_key = serialization.load_pem_public_key(
                        f.read()
                    )
            else:
                ption("Public key not found")
        except Exception as e:
            raise e

        encrypted_message = self.public_key.encrypt(
            message.encode(),
            padding.OAEP(
                mgf=padding.MGF1(algorithm=hashes.SHA256()),
                algorithm=hashes.SHA256(),
                label=None
            )
        )
        return base64.b64encode(encrypted_message).decode()