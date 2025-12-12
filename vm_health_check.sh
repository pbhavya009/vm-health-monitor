#!/bin/bash

# VM HEALTH CHECK – Unified Email Alert Script

FROM_EMAIL="bpuri261@gmail.com"
TO_EMAIL="bpuri261@gmail.com"
APP_PASSWORD="yk************jx"    # Gmail App Password

HOST=$(hostname)
TIME=$(date "+%Y-%m-%d %H:%M:%S")

# Thresholds
CPU_WARN=70
CPU_CRIT=90
RAM_WARN=75
RAM_CRIT=90
DISK_WARN=70
DISK_CRIT=90

# Collect Metrics

# CPU Usage
CPU=$(top -bn1 | grep "Cpu(s)" | awk '{print 100 - $8}')
CPU_INT=${CPU%.*}

# RAM Usage
RAM=$(free | grep Mem | awk '{print ($3/$2)*100}')
RAM_INT=${RAM%.*}

# Disk Usage
DISK=$(df / | awk 'NR==2 {print $5}' | sed 's/%//')

# Top CPU Processes

TOP_CPU=$(ps -eo pid,cmd,%cpu,%mem --sort=-%cpu | head -6 | \
awk '{printf "%-8s %-30s %-6s %-6s\n", $1, $2, $3, $4}')

# Top RAM Processes

TOP_RAM=$(ps -eo pid,cmd,%cpu,%mem --sort=-%mem | head -6 | \
awk '{printf "%-8s %-30s %-6s %-6s\n", $1, $2, $3, $4}')

# Determine Alert Severity

SEVERITY="NORMAL"
if [ "$CPU_INT" -ge "$CPU_CRIT" ] || [ "$RAM_INT" -ge "$RAM_CRIT" ] || [ "$DISK" -ge "$DISK_CRIT" ]; then
    SEVERITY="CRITICAL"
elif [ "$CPU_INT" -ge "$CPU_WARN" ] || [ "$RAM_INT" -ge "$RAM_WARN" ] || [ "$DISK" -ge "$DISK_WARN" ]; then
    SEVERITY="WARNING"
fi

# Build Email Body

MESSAGE="
🚨 VM HEALTH ALERT ($SEVERITY)
────────────────────────────────────

Host       : $HOST
Timestamp  : $TIME

CPU Usage  : ${CPU_INT} %
RAM Usage  : ${RAM_INT} %
Disk Usage : ${DISK} %

Top CPU Processes
────────────────────────────────────
PID      CMD                           %CPU   %MEM
$TOP_CPU

Top Memory Processes
────────────────────────────────────
PID      CMD                           %CPU   %MEM
$TOP_RAM
"


# Send Email


/usr/bin/sendemail \
    -f "$FROM_EMAIL" \
    -t "$TO_EMAIL" \
    -u "[$SEVERITY] VM Health Alert – $HOST" \
    -m "$MESSAGE" \
    -s "smtp.gmail.com:587" \
    -xu "$FROM_EMAIL" \
    -xp "$APP_PASSWORD" \
    -o tls=yes

exit 0
