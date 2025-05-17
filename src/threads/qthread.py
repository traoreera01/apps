from threading import Thread


class QThread_:
    def __init__(self):
        super(QThread_, self).__init__()

    def stop(self):
        self.app_plug_threads.join(timeout=0.5)
        
    def run(self):
        self.app_plug_threads = Thread(target=self.plugin_thread)
        self.app_plug_threads.daemon = True
        self.app_plug_threads.start()

    @staticmethod
    def plugin_thread():
        #from Plugin_Manager import Managers
        #app = Managers()
        #app.run_always()
        #TODO: make well plug thread
        pass