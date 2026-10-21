#!/bin/bash

# Report location
report="security-report.txt"

# Send all script output to the terminal and report
exec > >(tee "$report") 2>&1

# Linux Permissions & Security Auditor
# Checks directories for insecure file permissions

echo "===================================="
echo "       Linux Security Auditor       "
echo "===================================="

echo ""

read -r -p "Enter the directory to scan: " directory

# Check if directory exists
if [ ! -d "$directory" ]; then
    echo "Error: Directory does not exist!"
    exit 1
fi

echo ""
echo "Scanning: $directory"

warnings=0
info=0

echo ""
echo "Checking for world-writable files..."

while IFS= read -r -d '' file; do
    echo "[WARNING] World-writable file: $(basename "$file")"
	warnings=$((warnings + 1))
done < <(find "$directory" -type f -perm -0002 -print0)

echo ""
echo "Checking for world-readable files..."

while IFS= read -r -d '' file; do
    echo "[INFO] World-readable file: $(basename "$file")"
	info=$((info + 1))
done < <(find "$directory" -type f -perm -0004 -print0)


echo ""
echo "Checking for exposed sensitive files..."

while IFS= read -r -d '' file; do
    filename=$(basename "$file")

    case "$filename" in
        *password*|*.env|*secret*|*credential*)
            echo "[WARNING] Potentially sensitive file is world-readable: $filename"
            warnings=$((warnings + 1))
            ;;
    esac

done < <(find "$directory" -type f -perm -0004 -print0)


echo ""
echo "===================================="
echo "Security Audit Summary"
echo "Warnings: $warnings"
echo "Informational findings: $info"
echo "===================================="
