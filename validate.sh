#!/usr/bin/env bash
# =====================================================================
# validate.sh — validazione locale completa dell'edizione (un comando).
# Esegue gli stessi controlli della CI + la suite di regressione, e
# stampa le versioni degli strumenti (riproducibilità).
#
# Uso:   ./validate.sh [DIR_MC]        (default: Micro-commits/MC-1)
# Richiede: python3 + lxml, xmllint (libxml2-utils), jing.
# =====================================================================
set -euo pipefail

MC="${1:-Micro-commits/MC-1}"
DATA="$MC/data"
TEXT="$DATA/castello-anima-text.xml"
RNG="$DATA/castello-anima-odd.rng"
WF=".github/workflows"
RES="$(mktemp -t resolved.XXXXXX.xml)"
trap 'rm -f "$RES"' EXIT

echo "== Ambiente (versioni strumenti) =="
python3 --version
python3 - <<'PY'
import lxml.etree as e
print("lxml", e.__version__,
      "| libxml2", ".".join(map(str, e.LIBXML_VERSION)),
      "| libxslt", ".".join(map(str, e.LIBXSLT_VERSION)))
PY
xmllint --version 2>&1 | head -1 || true
echo "jing: $(command -v jing >/dev/null && echo presente || echo 'ASSENTE')"

echo "== 1) NFC =="
python3 "$WF/guardia_nfc.py" "$DATA"
echo "== 2) ben formato + XInclude =="
xmllint --noout --xinclude "$TEXT"
echo "== 3) RELAX NG (jing) sul documento risolto =="
xmllint --nofixup-base-uris --xinclude "$TEXT" > "$RES"
jing "$RNG" "$RES"
echo "== 4) guardia puntatori =="
python3 "$WF/guardia_puntatori.py" "$TEXT"
echo "== 5) guardia apparato =="
python3 "$WF/guardia_apparato.py" "$TEXT"
echo "== 6) regressione (gli input errati vengono respinti) =="
if [ -f "$MC/tests/run_regression.py" ]; then
  python3 "$MC/tests/run_regression.py"
else
  echo "  (nessuna suite di regressione in $MC/tests/ — salto)"
fi

echo
echo "✓ Validazione + regressione superate per $MC."
