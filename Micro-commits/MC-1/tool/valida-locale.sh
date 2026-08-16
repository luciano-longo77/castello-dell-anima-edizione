#!/usr/bin/env bash
#
# valida-locale.sh — Validazione locale del micro-commit (MC-1), prima di committare.
#
# Esegue gli STESSI quattro controlli della CI "Validate MC" (.github/workflows/validate.yml),
# riusando le guardie del repository (fonte unica, nessun duplicato):
#   1. NFC           (.github/workflows/guardia_nfc.py)
#   2. Ben formato + XInclude   (xmllint --xinclude: il <text> include il teiHeader)
#   3. RelaxNG       (jing castello-anima-odd.rng, sul documento risolto)
#   4. Guardia puntatori  (.github/workflows/guardia_puntatori.py)
#
# Prerequisiti:  xmllint (libxml2-utils), jing, python3 + lxml.
# Uso:           ./valida-locale.sh          (dalla cartella tool/ o da qualunque cartella)
#
set -euo pipefail

HERE="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"   # …/Micro-commits/MC-1/tool
MC="$(cd "$HERE/.." && pwd)"                            # …/Micro-commits/MC-1
ROOT="$(cd "$MC/../.." && pwd)"                         # radice del repo
DATA="$MC/data"
TEXT="$DATA/castello-anima-text.xml"
RNG="$DATA/castello-anima-odd.rng"
WF="$ROOT/.github/workflows"

echo "== MC-1 · validazione locale =="

# prerequisiti
command -v xmllint >/dev/null || { echo "::error:: manca xmllint  →  sudo apt-get install -y libxml2-utils"; exit 1; }
command -v jing    >/dev/null || { echo "::error:: manca jing     →  sudo apt-get install -y jing"; exit 1; }
python3 -c "import lxml" 2>/dev/null || { echo "::error:: manca lxml  →  pip install lxml"; exit 1; }
for f in "$TEXT" "$RNG" "$WF/guardia_nfc.py" "$WF/guardia_puntatori.py"; do
  [ -s "$f" ] || { echo "::error:: file richiesto mancante: $f"; exit 1; }
done

# 1) NFC
python3 "$WF/guardia_nfc.py" "$DATA"
# 2) ben formato + XInclude
xmllint --noout --xinclude "$TEXT" && echo "[2] ben formato + XInclude: OK"
# 3) RelaxNG sul documento risolto
RES="$(mktemp)"
xmllint --nofixup-base-uris --xinclude "$TEXT" > "$RES"
jing "$RNG" "$RES" && echo "[3] RelaxNG (jing): OK"
rm -f "$RES"
# 4) guardia puntatori
python3 "$WF/guardia_puntatori.py" "$TEXT"

echo "== MC-1: tutti i controlli superati =="
