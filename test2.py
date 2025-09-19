import socket
import threading
from typing import Callable


class Request:
    def __init__(self, raw_data: str):
        self.method, self.path, *_ = raw_data.split(" ", 2)


class Response:
    @staticmethod
    def build(body: str, status_code: int = 200, content_type: str = "text/html") -> bytes:
        return (
            f"HTTP/1.1 {status_code} OK\r\n"
            f"Content-Type: {content_type}\r\n"
            f"Content-Length: {len(body.encode())}\r\n"
            "Connection: close\r\n"
            "\r\n"
            f"{body}"
        ).encode()


class Server:
    def __init__(self, host: str = "0.0.0.0", port: int = 8080):
        self.host = host
        self.port = port
        self.routes: dict[str, Callable[[Request], str]] = {}

    def route(self, path: str):
        def decorator(func: Callable[[Request], str]):
            self.routes[path] = func
            return func
        return decorator

    def handle_client(self, conn: socket.socket, addr):
        print(f"[+] Connexion de {addr}")
        raw_data = conn.recv(1024).decode("utf-8")
        if not raw_data:
            conn.close()
            return
        request = Request(raw_data)
        print(f"--> {request.method} {request.path}")

        handler = self.routes.get(request.path)
        if handler:
            body = handler(request)
            response = Response.build(body)
        else:
            response = Response.build("<h1>404 Not Found</h1>", status_code=404)

        conn.sendall(response)
        conn.close()

    def run(self):
        print(f"[+] Serveur en cours sur http://{self.host}:{self.port}")
        with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as s:
            s.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
            s.bind((self.host, self.port))
            s.listen(5)

            while True:
                conn, addr = s.accept()
                thread = threading.Thread(target=self.handle_client, args=(conn, addr))
                thread.start()


# --- Exemple d'utilisation ---
if __name__ == "__main__":
    app = Server()

    @app.route("/")
    def home(request: Request):
        return "<h1>Bienvenue sur mon propre serveur web 🚀</h1>"

    @app.route("/about")
    def about(request: Request):
        return "<p>Ce serveur est écrit 100% en Python, sans framework externe !</p>"

    app.run()
