#!/usr/bin/env bash
set -euo pipefail
cd "$(dirname "$0")"

# asset di release (percorsi relativi a data/release/)
ASSETS=(
  "castello-anima-MC1-completed.xml"
  "../../output/castello-anima-lettura.html"
  "../../output/castello-anima-teiHeader.html"
  "../../output/teiHeader_viewer.html"
  "../../output/cartulazione/schema-carte.html"
  "../../tool/viewer-stati-mistici.html"
)

sha256sum "${ASSETS[@]}" > SHA256SUMS.txt
echo "SHA256SUMS.txt generato in $(pwd):"
cat SHA256SUMS.txt
