#!/usr/bin/env bash
# =====================================================================
# make-checksums.sh — genera SHA256SUMS.txt degli asset di release MC-1.
# Da eseguire al momento del deposito Zenodo, per fissare l'impronta
# crittografica degli artefatti archiviati (riproducibilità/integrità).
#
# Uso:  cd Micro-commits/MC-1/release && ./make-checksums.sh
# =====================================================================
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
