#!/usr/bin/env python3
"""Guardia NFC — verifica che tutti gli *.xml e *.odd della cartella indicata siano in forma Unicode NFC.
Uso: python3 guardia_nfc.py [DIR]   (default: cartella corrente)"""
import sys, glob, os, unicodedata
d = sys.argv[1] if len(sys.argv) > 1 else "."
files = sorted(glob.glob(os.path.join(d, "*.xml")) + glob.glob(os.path.join(d, "*.odd")))
bad = []
for f in files:
    s = open(f, encoding="utf-8").read()
    if s != unicodedata.normalize("NFC", s):
        bad.append(f)
if bad:
    print("::error::File non in forma Unicode NFC:")
    for f in bad:
        print("  -", f)
    sys.exit(1)
print(f"Guardia NFC superata in {d}/ ({len(files)} file XML/ODD)")
