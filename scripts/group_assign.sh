#!/bin/bash

# Config
LOG_FILE=~/user-provisioning/logs/provisioning.log
USERS_FILE=~/user-provisioning/users/new_users.csv

echo "========================================" | tee -a $LOG_FILE
echo "Group Assignment Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

# Skip header, read each user
tail -n +2 $USERS_FILE | while IFS=',' read username fullname group shell
do
    # Check if user exists
    if id "$username" &>/dev/null; then

        # Check if group exists, create if not
        if ! getent group "$group" &>/dev/null; then
            groupadd "$group"
            echo "[GROUP CREATED] $group" | tee -a $LOG_FILE
        fi

        # Assign user to group
        usermod -aG "$group" "$username"
        echo "[GROUP ASSIGNED] $username -> $group" | tee -a $LOG_FILE

    else
        echo "[ERROR] User $username does not exist!" | tee -a $LOG_FILE
    fi
done

echo "Group Assignment Completed: $(date)" | tee -a $LOG_FILE
