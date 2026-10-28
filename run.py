import argparse
import os
import signal
import socket
import subprocess
import sys
import shutil
import threading
import time
from collections import deque

ROOT = os.path.dirname(os.path.abspath(__file__))
pub_bin = os.path.expandvars(r"%LOCALAPPDATA%\Pub\Cache\bin")
if pub_bin not in os.environ.get("PATH", ""):
    os.environ["PATH"] = pub_bin + os.pathsep + os.environ.get("PATH", "")

parser = argparse.ArgumentParser(description="Start Campus Pulse app")
parser.add_argument("--web", action="store_true", help="Run Flutter in Chrome")
parser.add_argument(
    "--timeout",
    type=int,
    default=int(os.environ.get("BACKEND_TIMEOUT", "180")),
    help="Backend readiness timeout in seconds (default: 180)",
)
args, _ = parser.parse_known_args()

tools = {
    "flutter": "Flutter SDK missing.\n  Install from: https://docs.flutter.dev/get-started/install\n  Add flutter/bin to PATH.",
    "dart": "Dart SDK missing.\n  Run with Flutter or install: https://dart.dev/get-dart",
    "serverpod": "Serverpod CLI missing.\n  Run: dart pub global activate serverpod_cli\n  Add to PATH: $env:Path += \";$env:LOCALAPPDATA\\Pub\\Cache\\bin\"",
}

for tool, fix in tools.items():
    if not shutil.which(tool):
        print(f"Error: '{tool}' is not installed or not in PATH.\nFix:\n  {fix}")
        sys.exit(1)

web_flag = ["-d", "chrome"] if args.web else []
procs = []
recent_logs = deque(maxlen=60)
is_cleaned_up = False

def kill_process_tree(proc):
    if proc and proc.poll() is None:
        try:
            if sys.platform == "win32":
                subprocess.run(
                    f"taskkill /F /T /PID {proc.pid}",
                    shell=True,
                    stdout=subprocess.DEVNULL,
                    stderr=subprocess.DEVNULL,
                )
            else:
                proc.terminate()
        except Exception:
            pass

def cleanup(*_):
    global is_cleaned_up
    if is_cleaned_up:
        return
    is_cleaned_up = True
    print("\nStopping processes...")
    for p in procs:
        kill_process_tree(p)

signal.signal(signal.SIGINT, cleanup)
if hasattr(signal, "SIGTERM"):
    signal.signal(signal.SIGTERM, cleanup)

def stream_logs(pipe):
    try:
        for line in iter(pipe.readline, ""):
            sys.stdout.write(line)
            sys.stdout.flush()
            recent_logs.append(line)
    except Exception:
        pass
    finally:
        pipe.close()

def check_port_ready(server_proc, host="localhost", port=8080, timeout=180):
    print(f"Checking backend port {port} readiness (timeout: {timeout}s)...")
    start_time = time.time()
    while time.time() - start_time < timeout:
        if server_proc.poll() is not None:
            print(f"\nBackend process terminated unexpectedly with exit code {server_proc.poll()}.")
            return False
        try:
            with socket.create_connection((host, port), timeout=1.0):
                print(f"\nBackend is ready (port {port} is open and accepting connections).")
                return True
        except (socket.timeout, ConnectionRefusedError, OSError):
            time.sleep(1)
    print(f"\nReadiness check timed out after {timeout} seconds (backend port {port} did not respond).")
    return False

try:
    print("Starting backend...")
    server = subprocess.Popen(
        ["serverpod", "start"],
        cwd=os.path.join(ROOT, "campus_pulse_server"),
        stdout=subprocess.PIPE,
        stderr=subprocess.STDOUT,
        text=True,
        bufsize=1,
        shell=True,
    )
    procs.append(server)

    log_thread = threading.Thread(target=stream_logs, args=(server.stdout,), daemon=True)
    log_thread.start()

    if not check_port_ready(server, "localhost", 8080, timeout=args.timeout):
        print("\n--- Last relevant backend output ---")
        if recent_logs:
            for l in list(recent_logs)[-25:]:
                sys.stderr.write(l)
            sys.stderr.flush()
        else:
            print("(No backend output captured)")
        print("\nBackend readiness check failed. Flutter will not be started.")
        cleanup()
        sys.exit(1)

    print("Backend ready. Starting Flutter app...")
    flutter = subprocess.Popen(["flutter", "run"] + web_flag, cwd=os.path.join(ROOT, "campus_pulse_flutter"), shell=True)
    procs.append(flutter)
    code = flutter.wait()
    if code != 0:
        cleanup()
        sys.exit(code)
except Exception as e:
    print(f"Error: {e}")
    cleanup()
    sys.exit(1)
finally:
    cleanup()
