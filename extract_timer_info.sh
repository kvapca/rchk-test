#!/usr/bin/env bash

TARGET_DIR="$(dirname "$0")/results/timed"

if [ ! -d "$TARGET_DIR" ]; then
  echo "Error: '$TARGET_DIR' is not a directory." >&2
  exit 1
fi

FILES=$(ls "$TARGET_DIR"/R.bin.* "$TARGET_DIR"/survival.so.* 2>/dev/null)
echo $FILES

# Keep only lines containing "[Timer]". change the original files. check is filename isnt this script itself
for FILE in $FILES; do
  echo $FILE
  if [ -f "$FILE" ]; then
    grep -F "[Timer]" "$FILE" > "${FILE}.tmp"
    mv "${FILE}.tmp" "$FILE"
    rm -f "${FILE}.tmp"
  fi
done

# Concatenate all files into one file
OUTPUT_FILE="$TARGET_DIR/combined_results.timer"
> "$OUTPUT_FILE" # Clear the output file if it already exists
for FILE in $FILES; do
  if [ -f "$FILE" ]; then
    cat "$FILE" >> "$OUTPUT_FILE"
    echo -e "\n" >> "$OUTPUT_FILE" # Add a newline between files
  fi
done

sort -k3,3 -k2,2 "$OUTPUT_FILE" > "${OUTPUT_FILE}.sorted"
