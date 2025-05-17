from multiprocessing import Process, Queue, current_process
import time
import queue  # for queue.Empty
from typing import Callable, Tuple, Any, List

class TaskWorker:
    def __init__(self, task_queue: Queue, result_queue: Queue):
        self.task_queue = task_queue
        self.result_queue = result_queue

    def do_job(self):
        while True:
            try:
                func, args = self.task_queue.get_nowait()
            except queue.Empty:
                break
            else:
                task_desc = f"{func.__name__}{args}"
                print(f"[{current_process().name}] Executing: {task_desc}")
                try:
                    result = func(*args)
                    self.result_queue.put(f"✔ {task_desc} => {result}")
                except Exception as e:
                    self.result_queue.put(f"❌ {task_desc} => Error: {str(e)}")
                time.sleep(0.5)
        return True

class TaskManager:
    def __init__(self, num_processes=4):
        self.num_processes = num_processes
        self.tasks_to_accomplish = Queue()
        self.tasks_that_are_done = Queue()
        self.task_list: List[Tuple[Callable, Tuple[Any, ...]]] = []
        self.processes = []

    def add_task(self, func: Callable, args: Tuple[Any, ...] = ()):
        self.task_list.append((func, args))
        self.tasks_to_accomplish.put((func, args))

    def show_queued_tasks(self):
        print("\n📋 Liste des tâches prévues :")
        for i, (func, args) in enumerate(self.task_list):
            print(f"  {i+1}. {func.__name__}{args}")
        print()

    def start_workers(self):
        for _ in range(self.num_processes):
            worker = TaskWorker(self.tasks_to_accomplish, self.tasks_that_are_done)
            p = Process(target=worker.do_job)
            self.processes.append(p)
            p.start()

    def wait_for_completion(self):
        for p in self.processes:
            p.join()

    def print_results(self):
        print("\n✅ Résultats des tâches :")
        while not self.tasks_that_are_done.empty():
            print("  " + self.tasks_that_are_done.get())

    def run(self):
        self.show_queued_tasks()
        self.start_workers()
        self.wait_for_completion()
        self.print_results()
