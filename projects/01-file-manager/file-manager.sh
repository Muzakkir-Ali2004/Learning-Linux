#!/bin/bash

# Linux File Manager
# Organises files into folders based on their extensions

echo "================================"
echo "       Linux File Manager       "
echo "================================"

echo ""

read -r -p "Enter the folder you want to organise: " folder

# Check whether the directory exists
if [ ! -d "$folder" ]; then
    echo "Error: That folder does not exist!"
    exit 1
fi

# Check whether the directory is writable
if [ ! -w "$folder" ]; then
    echo "Error: You do not have permission to modify this folder!"
    exit 1
fi

# Statistics
moved=0
skipped=0

# Create a log file
logfile="$folder/file-manager.log"

echo ""
echo "Organising files..."
echo "Started: $(date)" >> "$logfile"

# Loop through the files
for file in "$folder"/*; do

    # Skip directories and the log file
    [ -f "$file" ] || continue
    [ "$file" = "$logfile" ] && continue

    # Extract filename
    filename=$(basename "$file")

    # Identify file type
    case "$filename" in

        *.jpg|*.jpeg|*.png)
            destination="Images"
            ;;

        *.pdf|*.txt)
            destination="Documents"
            ;;

        *.sh)
            destination="Scripts"
            ;;

        *)
            skipped=$((skipped + 1))
            echo "Skipped: $filename (unsupported file type)"
            continue
            ;;

    esac

    # Create destination folder
    mkdir -p "$folder/$destination"

    # Check for duplicate files
    if [ -e "$folder/$destination/$filename" ]; then

        echo "Skipped: $filename (already exists)"
        echo "SKIPPED: $filename already exists" >> "$logfile"

        skipped=$((skipped + 1))

    else

        # Move file without overwriting an existing destination
        if mv -n -- "$file" "$folder/$destination/"; then
            echo "Moved: $filename → $destination"
            echo "MOVED: $filename to $destination" >> "$logfile"

            moved=$((moved + 1))
        else
            echo "Error: Could not move $filename"
            echo "ERROR: Could not move $filename" >> "$logfile"

            skipped=$((skipped + 1))
        fi

    fi

done

echo "Completed: $(date)" >> "$logfile"

echo ""
echo "================================"
echo "Files moved: $moved"
echo "Files skipped: $skipped"
echo "================================"
echo "Log saved to: $logfile"
