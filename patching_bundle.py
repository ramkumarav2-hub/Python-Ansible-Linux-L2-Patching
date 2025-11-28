"""
Linux Patching Script with integrated Ansible playbook
==========================================================
Author: Ramkumar V
Email: ramkumar.a.v@capgemini.com
Version: 1.0.0
Date: 2025-11-23
Description:
    Lightweight Patches for Linux servers:
    - Pre-requisite
    - Precheck
    - Patching
    - Postcheck

    Output: human-readable text to stdout.
"""
__author__ = "Ramkumar V"
__version__ = "1.0.0"

import subprocess

# List of playbooks
playbooks = [
    "Pre-requisite",
    "Precheck",
    "Patching",
    "Download all packages only"
]

# Show menu
print("\n" + "#" * 90)
print("#" + " " * 30 + "Linux L2 Patching" + " " * 39 + "#")
print("#" * 90 + "\n")

print("Please select the task you want to run:\n")
for i, pb in enumerate(playbooks, start=1):
    print(f"{i}. {pb}")

print("\n" + "*" * 90 + "\n")

choice = input("Enter your choice (number): ").strip()

# Validate choice
if choice == "1":
    server_name = input("Enter the server name or IP [Press Enter to use default inventory]: ").strip()

    # Build command
    cmd = ["ansible-playbook", "/home/rvi2815-2/linux_patching/tasks/prerequisite.yml"]


    if server_name:
       cmd.extend(["-i", f"{server_name},"])

    # Run playbook
    print(f"\nRunning: {' '.join(cmd)}\n")

    try:
       subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as e:
       print(f"Error running playbook: {e}")

elif choice == "2":
    server_name = input("Enter the server name or IP [Press Enter to use default inventory]: ").strip()

    # Build command
    cmd = ["ansible-playbook", "/home/rvi2815-2/linux_patching/tasks/precheck.yml"]


    if server_name:
       cmd.extend(["-i", f"{server_name},"])

    # Run playbook
    print(f"\nRunning: {' '.join(cmd)}\n")

    try:
       subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as e:
       print(f"Error running playbook: {e}")

elif choice == "3":
    accept_code = input("Your are running Patch and Reboot playbook [Kindly confirm (yes/no)]: ").strip()
    if accept_code == "yes":
        server_name = input("Enter the server name or IP [Press Enter to use default inventory]: ").strip()

        # Build command
        cmd = ["ansible-playbook", "/home/rvi2815-2/linux_patching/tasks/patching.yml"]


        if server_name:
           cmd.extend(["-i", f"{server_name},"])

        # Run playbook
        print(f"\nRunning: {' '.join(cmd)}\n")

        try:
           subprocess.run(cmd, check=True)
        except subprocess.CalledProcessError as e:
           print(f"Error running playbook: {e}")
           
    else:
        print("Exiting....")

elif choice == "4":
    server_name = input("Enter the server name or IP [Press Enter to use default inventory]: ").strip()

    # Build command
    cmd = ["ansible-playbook", "/home/rvi2815-2/linux_patching/tasks/downloadonly.yml"]


    if server_name:
       cmd.extend(["-i", f"{server_name},"])

    # Run playbook
    print(f"\nRunning: {' '.join(cmd)}\n")

    try:
       subprocess.run(cmd, check=True)
    except subprocess.CalledProcessError as e:
       print(f"Error running playbook: {e}")

else:
    print("Invalid choice!")

