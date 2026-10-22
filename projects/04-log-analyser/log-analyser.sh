#!/bin/bash

set -euo pipefail

# Linux Server Log Analyser
# Analyses Apache/Nginx-style access logs.

if [[ $# -ne 1 ]]; then
    echo "Usage: $0 <access-log-file>"
    exit 1
fi

LOG_FILE="$1"

if [[ ! -f "$LOG_FILE" || ! -r "$LOG_FILE" ]]; then
    echo "Error: Log file does not exist or is not readable."
    exit 1
fi

REPORT_DIR="reports"
mkdir -p "$REPORT_DIR"

TIMESTAMP=$(date +"%Y-%m-%d_%H-%M-%S")
REPORT="$REPORT_DIR/log-report-$TIMESTAMP.txt"

analyse_logs() {
    echo "========================================"
    echo "         LINUX SERVER LOG ANALYSER"
    echo "========================================"
    echo

    echo "Log File: $LOG_FILE"
    echo "Analysis Date: $(date)"
    echo

    echo "REQUEST STATISTICS"
    echo "----------------------------------------"

    awk '
    {
        total++

        # Extract HTTP status from a standard combined log entry
        if (match($0, /" [0-9][0-9][0-9] /)) {
            status = substr($0, RSTART + 2, 3)
            counts[status]++
        }
    }
    END {
        printf "Total Requests: %d\n", total
        printf "HTTP 200: %d\n", counts[200]
        printf "HTTP 403: %d\n", counts[403]
        printf "HTTP 404: %d\n", counts[404]
        printf "HTTP 500: %d\n", counts[500]
    }' "$LOG_FILE"

    echo
    echo "TOP 5 REQUESTING IP ADDRESSES"
    echo "----------------------------------------"

    awk '{print $1}' "$LOG_FILE" |
        sort |
        uniq -c |
        sort -nr |
        head -n 5

    echo
    echo "POTENTIALLY SUSPICIOUS IP ADDRESSES"
    echo "----------------------------------------"

    awk '{print $1}' "$LOG_FILE" |
        sort |
        uniq -c |
        awk '$1 >= 10 {
            printf "[WARNING] %s made %d requests\n", $2, $1
        }'

    echo
    echo "HTTP ERROR SUMMARY"
    echo "----------------------------------------"

    awk '
    match($0, /" [0-9][0-9][0-9] /) {
        status = substr($0, RSTART + 2, 3)

        if (status >= 400) {
            errors[status]++
        }
    }
    END {
        for (status in errors) {
            printf "HTTP %s: %d\n", status, errors[status]
        }
    }' "$LOG_FILE" | sort

    echo
    echo "========================================"
}

analyse_logs | tee "$REPORT"

echo "Report saved to: $REPORT"
