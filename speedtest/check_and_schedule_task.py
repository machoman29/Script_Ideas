import platform
import subprocess
import sys

def check_and_schedule_task():
    os_type = platform.system().lower()

    if os_type == "windows":
        print("Running Windows-specific task scheduler check...")
        task_name = "InternetSpeedCheck"  # Replace with your task name
        
        # Check if the task exists using PowerShell
        try:
            result = subprocess.run(
                ["powershell", "-Command", f"Get-ScheduledTask -TaskName {task_name}"],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE
            )
            if result.returncode == 0:
                task_output = result.stdout.decode("utf-8")
                if task_name in task_output:
                    print(f"Task '{task_name}' already exists.")
                else:
                    print(f"Task '{task_name}' not found in the scheduler.")
                    schedule_windows_task()  # Function to schedule the task
            else:
                print(f"Task '{task_name}' does not exist. Scheduling now...")
                schedule_windows_task()  # Function to schedule the task
        except Exception as e:
            print(f"Error checking Windows task: {e}")

    elif os_type == "linux":
        print("Running Linux-specific cron job check...")
        task_name = "internet_speed_check.py"  # Replace with your script name or unique identifier
        
        try:
            # Check for the task in crontab
            result = subprocess.run(
                ["crontab", "-l"],
                stdout=subprocess.PIPE,
                stderr=subprocess.PIPE
            )
            cron_jobs = result.stdout.decode("utf-8")
            
            if task_name in cron_jobs:
                print(f"Cron job for '{task_name}' already exists.")
            else:
                print(f"Cron job for '{task_name}' not found. Scheduling now...")
                schedule_linux_cron()  # Function to schedule the cron job
        except Exception as e:
            print(f"Error checking Linux cron: {e}")
    
    else:
        print("Unsupported OS.")
        sys.exit(1)

def schedule_windows_task():
    # Schedule a task in Windows using PowerShell
    print("Scheduling the task in Windows...")
    try:
        subprocess.run([
            "powershell", "-Command", 
            "schtasks /create /tn InternetSpeedCheck /tr 'python C:\\path\\to\\script.py' /sc once /st 12:00"
        ], check=True)
        print("Windows task scheduled successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error scheduling Windows task: {e}")

def schedule_linux_cron():
    # Schedule a cron job in Linux
    print("Scheduling the cron job in Linux...")
    try:
        # Add the cron job to the user's crontab
        cron_command = "echo '0 0 * * * python3 /path/to/internet_speed_check.py' | crontab -"
        subprocess.run(cron_command, shell=True, check=True)
        print("Linux cron job scheduled successfully.")
    except subprocess.CalledProcessError as e:
        print(f"Error scheduling Linux cron job: {e}")

if __name__ == "__main__":
    check_and_schedule_task()
