#!/bin/bash

# Load config
LOG_FILE=~/user-provisioning/logs/provisioning.log
USERS_FILE=~/user-provisioning/users/new_users.csv

echo "========================================" | tee -a $LOG_FILE
echo "User Provisioning Started: $(date)" | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE

# Skip header line, read each user
tail -n +2 $USERS_FILE | while IFS=',' read username fullname group shell
do
    # Check if user already exists
    if id "$username" &>/dev/null; then
        echo "[SKIP] User $username already exists" | tee -a $LOG_FILE
    else
        # Create group if not exists
        groupadd -f $group

        # Create user
        useradd -m -c "$fullname" -s $shell -G $group $username

        # Set default password (username as password)
        echo "$username:$username@123" | chpasswd

        # Force password change on first login
        chage -d 0 $username

        echo "[SUCCESS] User $username created in group $group" | tee -a $LOG_FILE
    fi
done

echo "Provisioning Completed: $(date)" | tee -a $LOG_FILE
