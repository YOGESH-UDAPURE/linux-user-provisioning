#!/bin/bash

# ========================================
# MASTER SCRIPT - User Provisioning System
# ========================================

SCRIPTS_DIR=~/user-provisioning/scripts
LOG_FILE=~/user-provisioning/logs/provisioning.log

echo ""
echo "========================================" | tee -a $LOG_FILE
echo "   AUTOMATED USER PROVISIONING SYSTEM   " | tee -a $LOG_FILE
echo "   Started: $(date)                     " | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
echo ""

# Step 1: Create Users
echo "🔄 Step 1: Creating Users..." | tee -a $LOG_FILE
bash $SCRIPTS_DIR/user_create.sh
echo "✅ Step 1: Done!" | tee -a $LOG_FILE
echo ""

# Step 2: Assign Groups
echo "🔄 Step 2: Assigning Groups..." | tee -a $LOG_FILE
bash $SCRIPTS_DIR/group_assign.sh
echo "✅ Step 2: Done!" | tee -a $LOG_FILE
echo ""

# Step 3: Set Permissions
echo "🔄 Step 3: Setting Permissions..." | tee -a $LOG_FILE
bash $SCRIPTS_DIR/permissions.sh
echo "✅ Step 3: Done!" | tee -a $LOG_FILE
echo ""

# Step 4: Generate Report
echo "🔄 Step 4: Generating Report..." | tee -a $LOG_FILE
bash $SCRIPTS_DIR/report.sh
echo "✅ Step 4: Done!" | tee -a $LOG_FILE
echo ""

echo "========================================" | tee -a $LOG_FILE
echo "   ALL DONE! System Ready!              " | tee -a $LOG_FILE
echo "   Completed: $(date)                   " | tee -a $LOG_FILE
echo "========================================" | tee -a $LOG_FILE
echo ""
