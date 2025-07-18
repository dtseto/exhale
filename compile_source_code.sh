#!/bin/bash

# Get the directory where the script is located
script_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

# Folder to search for files (same as the script location)
input_folder="$script_dir"

# Output file
output_file="full_source_code.txt"

# Configurable file types to search for
file_types=("*.swift" "*.ts" "*.tsx","*.cpp", "*.h")

# Configurable folders to ignore
ignored_folders=("node_modules" "ios" "android" "__tests__")

# Clear the output file if it exists
> "$output_file"

# Build the find command dynamically
find_command="find \"$input_folder\""

for folder in "${ignored_folders[@]}"; do
  find_command+=" -name '$folder' -prune -o"
done

find_command+=" \( "
for ((i=0; i<${#file_types[@]}; i++)); do
  find_command+=" -name '${file_types[$i]}'"
  if [ $i -lt $((${#file_types[@]} - 1)) ]; then
    find_command+=" -o"
  fi
done
find_command+=" \) -print0"

# Execute the find command and process files
eval $find_command | while IFS= read -r -d '' file; do
  # Add a header for each file with its full path
  echo "### File: $(realpath "$file") ###" >> "$output_file"
  # Append the contents of the file
  cat "$file" >> "$output_file"
  # Add a separator between files
  echo -e "\n\n" >> "$output_file"
done