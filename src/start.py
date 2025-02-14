import subprocess
import win32job
import win32api
import win32con
import ctypes
import sys
import time
import psutil
import os

# pyinstaller --onefile --exclude-module tkinter --strip --upx-dir=D:\Programs\upx-4.2.4-win64\upx.exe src/start.py

SCRIPT_DIR = os.path.dirname(os.path.abspath(sys.executable))
TIMEOUT = 5

GAME_PROCESS_NAME = "eldenring.exe"
PARENT_PROCESS_PATH = os.path.join(SCRIPT_DIR, "ersc_launcher.exe")
CHILD_PROCESS_PATH = os.path.join(SCRIPT_DIR, "er_kbm_script.exe")

print(PARENT_PROCESS_PATH)
print(CHILD_PROCESS_PATH)

def is_admin():
    try:
        return ctypes.windll.shell32.IsUserAnAdmin()
    except:
        return False
    
def run_as_admin():
    if not is_admin():
        print("Requesting admin privileges...")
        script = sys.executable
        params = " ".join(f'"{arg}"' for arg in sys.argv)
        ctypes.windll.shell32.ShellExecuteW(None, "runas", script, params, None, 1)
        sys.exit()

def find_process_by_name(name):
    for proc in psutil.process_iter(["pid", "name"]):
        if proc.info["name"] == name:
            return proc
    return None

def create_job_object():
    job = win32job.CreateJobObject(None, "")
    info = win32job.QueryInformationJobObject(job, win32job.JobObjectExtendedLimitInformation)
    info["BasicLimitInformation"]["LimitFlags"] |= win32job.JOB_OBJECT_LIMIT_KILL_ON_JOB_CLOSE
    win32job.SetInformationJobObject(job, win32job.JobObjectExtendedLimitInformation, info)
    return job

def assign_process_to_job(job, pid):
    process = win32api.OpenProcess(win32con.PROCESS_ALL_ACCESS, False, pid)
    win32job.AssignProcessToJobObject(job, process)

def start_processes():
    try:
        parent_proc = subprocess.Popen(PARENT_PROCESS_PATH)
        print(f"Elden Ring Seamless Coop launcher process started with PID: {parent_proc.pid}.")
            
        game_proc = None
        start_time = time.time()
        while True:
            game_proc = find_process_by_name(GAME_PROCESS_NAME)
            if game_proc:
                print(f"Elden ring process started with PID: {game_proc.pid}.")
                break
            if time.time() - start_time > TIMEOUT:
                print(f"Timeout reached. {GAME_PROCESS_NAME} not found after {TIMEOUT} seconds.")
                return
            time.sleep(1)

        job = create_job_object()
        assign_process_to_job(job, game_proc.pid)

        child_proc = subprocess.Popen(CHILD_PROCESS_PATH)
        print(f"Keyboard and mouse script' process started with PID: {child_proc.pid}.")
        assign_process_to_job(job, child_proc.pid)
        
        game_proc.wait()

        child_proc.terminate()
        child_proc.wait()

        print("Elden Ring process ended. The keyboard mouse script automatically terminated.")
    except Exception as e:
        print(f"Error: {e}")

if __name__ == "__main__":
    run_as_admin()
    start_processes()