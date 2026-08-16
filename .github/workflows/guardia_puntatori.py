#!/usr/bin/env python3
"""
Guardia puntatori — modello leggero (Castello dell'anima, edizione a micro-commit).

Sul documento con XInclude risolto (il <text> include il teiHeader via <xi:include>)
verifica tre invarianti, che corrispondono ai vincoli Schematron dichiarati nell'ODD
(jing non esegue lo Schematron incorporato, perciò li ricontrolliamo qui):

  1. Integrità referenziale: ogni puntatore '#…' in
     @wit/@hand/@resp/@ref/@target/@corresp/@ana/@scribeRef/@sameAs
     risolve a un xml:id realmente dichiarato nel documento.
  2. Layer 2: ogni term/@ref è una categoria del vocabolario #stati-mistici.
  3. revisionDesc: ogni change/@ana è una categoria della tassonomia di lavoro #fase.

Esce con codice 1 (e messaggi ::error:: per GitHub Actions) se qualcosa non torna.

Uso:  python3 guardia_puntatori.py [TEXT_XML]
      (default: Micro-commits/MC-1/data/castello-anima-text.xml)
"""
import sys
from lxml import etree

NS = "http://www.tei-c.org/ns/1.0"
XMLID = "{http://www.w3.org/XML/1998/namespace}id"
POINTER_ATTRS = ["wit", "hand", "resp", "ref", "target", "corresp", "ana", "scribeRef", "sameAs"]

TEXT = sys.argv[1] if len(sys.argv) > 1 else "Micro-commits/MC-1/data/castello-anima-text.xml"

def toks(v):
    return [t[1:] for t in (v or "").split() if t.startswith("#")]

try:
    tree = etree.parse(TEXT)
    tree.xinclude()  # risolve <xi:include> (il teiHeader)
except Exception as e:
    print(f"::error::parsing/XInclude fallito su {TEXT}: {e}")
    sys.exit(1)

root = tree.getroot()
def xp(q):
    return root.xpath(q, namespaces={"t": NS})

ids = {e.get(XMLID) for e in root.iter() if isinstance(e.tag, str) and e.get(XMLID) is not None}
errors = []

# 1) integrità referenziale
for el in root.iter():
    if not isinstance(el.tag, str):
        continue  # salta commenti / processing-instruction
    ln = etree.QName(el).localname
    for a in POINTER_ATTRS:
        for t in toks(el.get(a)):
            if t not in ids:
                errors.append(f"[integrità] @{a}=\"#{t}\" pendente in <{ln}>")

# 2) term/@ref -> #stati-mistici
stati = {c.get(XMLID) for c in xp(".//t:taxonomy[@xml:id='stati-mistici']//t:category")}
if not stati:
    errors.append("[layer2] taxonomy #stati-mistici non trovata (XInclude dell'header risolto?)")
for term in xp(".//t:term[@ref]"):
    for t in toks(term.get("ref")):
        if t not in stati:
            errors.append(f"[layer2] term/@ref=\"#{t}\" non è una categoria di #stati-mistici")

# 3) change/@ana -> #fase
fasi = {c.get(XMLID) for c in xp(".//t:taxonomy[@xml:id='fase']//t:category")}
for ch in xp(".//t:revisionDesc/t:change[@ana]"):
    for t in toks(ch.get("ana")):
        if t not in fasi:
            errors.append(f"[fase] change/@ana=\"#{t}\" non è una categoria di #fase")

if errors:
    print(f"::error::Guardia puntatori: {len(errors)} problemi in {TEXT}")
    for e in errors:
        print("  -", e)
    sys.exit(1)

print(f"Guardia puntatori superata su {TEXT}: {len(ids)} xml:id dichiarati; "
      f"@ref/@wit/@hand/@target/@ana e term/change coerenti.")
