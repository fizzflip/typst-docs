#!/usr/bin/env bash
set -euo pipefail

cd "$(dirname "$0")"

echo "=== Generating CV Lab Manual Outputs ==="
echo ""

for i in $(seq 1 12); do
    echo "--- Running practical-${i}.py ---"
    python "practical-${i}.py"
    echo ""
done

echo "=== All outputs generated ==="
ls -la output/
