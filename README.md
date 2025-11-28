Linux L2 Patching – User Guide

Author: Ramkumar V

Email: ramkumar.a.v@capgemini.com

Version: 1.0.0

Date: 2025-11-23

Purpose

This User Guide provides instructions for executing Linux Level-2 patching tasks using a Python script integrated with Ansible playbooks. 
It explains the steps, menu options, workflow, and sample outputs for clarity.

Prerequisites


•	Python 3 installed on the control node

•	Ansible installed and configured

•	SSH access to target Linux servers

•	Sudo privileges on target systems

•	Network access to repositories

•	Script location: /home/rvi2815-2/linux_patching/patching_bundle.py

Execution Steps (CLI)

1. Navigate to the script directory:
 	cd /home/rvi2815-2/linux_patching
2. Run the script:
python3 patching_bundle.py
3. Select the desired option from the menu:
   
•	Pre-requisite

•	Precheck

•	Patching

•	Download all packages only

5. Provide server details when prompted.
   
Menu Display

##########################################################################################
#                              Linux L2 Patching                                         #
##########################################################################################

Please select the task you want to run:
1. Pre-requisite
2. Precheck
3. Patching
4. Download all packages only
**********************************************************************************

Menu Options Explained:

------------------------
1. Pre-requisite:
   - Cleans subscription manager and YUM cache
   - Removes old repo files
   - Registers system to Satellite based on OS version

2. Precheck:
   - Uploads and executes precheck script
   - Consolidates output files
   - Checks disk space for critical mounts

3. Patching:
   - Applies all available patches
   - Cleans YUM cache
   - Reboots the server
   - Performs postcheck and validation
   - Verify disk match after reboot 

4. Download all packages only:
   - Verifies disk space
   - Downloads updates without installing them
----------------------------------------------------------------------------------

Workflow:
---------
Start -> Display Menu -> User Selection -> Build Ansible Command -> Run Playbook -> Output Results -> End
