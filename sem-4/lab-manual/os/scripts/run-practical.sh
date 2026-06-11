#!/bin/bash

set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"

mapfile -t practicals < <(ls "$SCRIPT_DIR"/practical-*.sh 2>/dev/null | sort)

if [ "${#practicals[@]}" -eq 0 ]; then
  echo "No practical scripts found in: $SCRIPT_DIR"
  exit 1
fi

echo "=== Practical Script Launcher ==="
for i in "${!practicals[@]}"; do
  name="$(basename "${practicals[$i]}")"
  printf "%2d) %s\n" "$((i + 1))" "$name"
done

echo " 0) Exit"
read -rp "Select a practical to run: " choice

if [[ "$choice" == "0" ]]; then
  echo "Exiting."
  exit 0
fi

if ! [[ "$choice" =~ ^[0-9]+$ ]]; then
  echo "Invalid input. Enter a number."
  exit 1
fi

index=$((choice - 1))
if [ "$index" -lt 0 ] || [ "$index" -ge "${#practicals[@]}" ]; then
  echo "Invalid choice."
  exit 1
fi

selected="${practicals[$index]}"
echo
echo "Running: $(basename "$selected")"
echo "----------------------------------------"
bash "$selected"
