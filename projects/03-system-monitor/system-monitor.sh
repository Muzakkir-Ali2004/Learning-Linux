#!/bin/bash

set -euo pipefail

# Linux System Monitor
# Displays CPU, memory, disk usage and resource-heavy processes.

REPORT_DIR="reports"
mkdir -p "$REPORT_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT="$REPORT_DIR/system-report-$TIMESTAMP.txt"

CPU_THRESHOLD=80
MEMORY_THRESHOLD=80
DISK_THRESHOLD=85

# Calculate CPU usage from two /proc/stat samples
get_cpu_usage() {
    local cpu user nice system idle iowait irq softirq steal guest guest_nice
    local idle1 total1 idle2 total2 idle_delta total_delta

    read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

    idle1=$((idle + iowait))
    total1=$((user + nice + system + idle + iowait + irq + softirq + steal))

    sleep 1

    read -r cpu user nice system idle iowait irq softirq steal guest guest_nice < /proc/stat

    idle2=$((idle + iowait))
    total2=$((user + nice + system + idle + iowait + irq + softirq + steal))

    idle_delta=$((idle2 - idle1))
    total_delta=$((total2 - total1))

    if ((total_delta == 0)); then
        echo 0
    else
        echo $(((100 * (total_delta - idle_delta)) / total_delta))
    fi
}

get_memory_usage() {
    free | awk '/^Mem:/ {
        if ($2 > 0) {
            printf "%.0f", (($2 - $7) / $2) * 100
        } else {
            print 0
        }
    }'
}

get_disk_usage() {
    df -P / | awk 'NR==2 {
        gsub("%", "", $5)
        print $5
    }'
}

check_threshold() {
    local name="$1"
    local usage="$2"
    local threshold="$3"

    if ((usage >= threshold)); then
        echo "[WARNING] $name usage is ${usage}% (threshold: ${threshold}%)"
    else
        echo "[OK] $name usage is ${usage}%"
    fi
}

generate_report() {
    echo "========================================"
    echo "          LINUX SYSTEM MONITOR"
    echo "========================================"
    echo

    echo "Hostname: $(hostname)"
    echo "Date: $(date)"
    echo "Kernel: $(uname -r)"
    echo "Uptime: $(uptime -p)"
    echo

    echo "SYSTEM RESOURCES"
    echo "----------------------------------------"

    CPU_USAGE=$(get_cpu_usage)
    MEMORY_USAGE=$(get_memory_usage)
    DISK_USAGE=$(get_disk_usage)

    echo "CPU Usage:    ${CPU_USAGE}%"
    echo "Memory Usage: ${MEMORY_USAGE}%"
    echo "Disk Usage:   ${DISK_USAGE}%"

    echo
    echo "TOP 5 CPU CONSUMING PROCESSES"
    echo "----------------------------------------"

    ps -eo pid,comm,%cpu --sort=-%cpu | head -n 6

    echo
    echo "TOP 5 MEMORY CONSUMING PROCESSES"
    echo "----------------------------------------"

    ps -eo pid,comm,%mem --sort=-%mem | head -n 6

    echo
    echo "SYSTEM HEALTH"
    echo "----------------------------------------"

    check_threshold "CPU" "$CPU_USAGE" "$CPU_THRESHOLD"
    check_threshold "Memory" "$MEMORY_USAGE" "$MEMORY_THRESHOLD"
    check_threshold "Disk" "$DISK_USAGE" "$DISK_THRESHOLD"

    echo
    echo "========================================"
}

generate_report | tee "$REPORT"

echo "Report saved to: $REPORT"
