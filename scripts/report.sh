#!/bin/bash

# Config
REPORT_DIR=~/user-provisioning/reports
REPORT_FILE=$REPORT_DIR/report_$(date +%Y%m%d_%H%M%S).txt
LOG_FILE=~/user-provisioning/logs/provisioning.log

echo "========================================" > $REPORT_FILE
echo "   USER PROVISIONING REPORT             " >> $REPORT_FILE
echo "   Generated: $(date)                   " >> $REPORT_FILE
echo "========================================" >> $REPORT_FILE

# Total users
echo "" >> $REPORT_FILE
echo "--- USERS CREATED ---" >> $REPORT_FILE
tail -n +2 ~/user-provisioning/users/new_users.csv | while IFS=',' read username fullname group shell
do
    if id "$username" &>/dev/null; then
        echo "[OK] $username ($fullname) - Group: $group" >> $REPORT_FILE
    else
        echo "[NOT FOUND] $username" >> $REPORT_FILE
    fi
done

# Group info
echo "" >> $REPORT_FILE
echo "--- GROUP INFO ---" >> $REPORT_FILE
for group in developers devops sysadmin
do
    members=$(getent group $group | cut -d: -f4)
    echo "[$group] Members: $members" >> $REPORT_FILE
done

# Permissions info
echo "" >> $REPORT_FILE
echo "--- FOLDER PERMISSIONS ---" >> $REPORT_FILE
ls -la /opt/userdata/ >> $REPORT_FILE

# Home directories
echo "" >> $REPORT_FILE
echo "--- HOME DIRECTORIES ---" >> $REPORT_FILE
ls -la /home/ >> $REPORT_FILE

# Log summary
echo "" >> $REPORT_FILE
echo "--- LOG SUMMARY ---" >> $REPORT_FILE
cat $LOG_FILE >> $REPORT_FILE

echo "" >> $REPORT_FILE
echo "========================================" >> $REPORT_FILE
echo "   Report Complete!" >> $REPORT_FILE
echo "========================================" >> $REPORT_FILE

echo "Report generated at: $REPORT_FILE"
