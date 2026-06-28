#!/bin/bash

# Config
LOG_FILE=~/user-provisioning/logs/provisioning.log

echo "========================================" | tee -a $LOG_FILE
echo "Permissions Setup Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

# Set ownership and permissions for each group folder

# Developers folder
chown root:developers /opt/userdata/developers
chmod 770 /opt/userdata/developers
echo "[PERMISSION SET] /opt/userdata/developers -> group:developers 770" | tee -a $LOG_FILE

# Devops folder
chown root:devops /opt/userdata/devops
chmod 770 /opt/userdata/devops
echo "[PERMISSION SET] /opt/userdata/devops -> group:devops 770" | tee -a $LOG_FILE

# Sysadmin folder
chown root:sysadmin /opt/userdata/sysadmin
chmod 770 /opt/userdata/sysadmin
echo "[PERMISSION SET] /opt/userdata/sysadmin -> group:sysadmin 770" | tee -a $LOG_FILE

# Home directory permissions
USERS_FILE=~/user-provisioning/users/new_users.csv
tail -n +2 $USERS_FILE | while IFS=',' read username fullname group shell
do
    if id "$username" &>/dev/null; then
        chmod 700 /home/$username
        echo "[HOME SECURED] /home/$username -> 700" | tee -a $LOG_FILE
    fi
done

echo "Permissions Setup Completed: $(date)" | tee -a $LOG_FILE
