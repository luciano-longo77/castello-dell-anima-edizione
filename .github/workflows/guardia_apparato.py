#!/usr/bin/env python3
"""
Guardia apparato — controlli filologico-strutturali che jing (RELAX NG) non esegue.

Sul file del testo (i fenomeni controllati stanno nel <text>, non serve XInclude)
verifica quattro invarianti del modello genetico dichiarate in prosa nell'ODD e nei doc:

  1. retrace: ogni <retrace> ha @hand="#ink_3-dark", @resp="#s-teresa" e sta FUORI da <app>.
  2. varSeq: @varSeq compare solo in un <app> con ≥2 <rdg> concorrenti.
  3. corr: ogni <corr> porta @resp (intervento editoriale sempre attribuito).
  4. cartulazione: la sequenza dei <pb>/@n è esattamente 158r…168r (21 facciate), monotòna,
     senza salti né duplicati (coerente con docs/Struttura-cartulazione.md).

Esce con codice 1 (e messaggi ::error:: per GitHub Actions) se qualcosa non torna.

Uso:  python3 guardia_apparato.py [TEXT_XML]
      (default: Micro-commits/MC-1/data/castello-anima-text.xml)
"""
import sys
from lxml import etree

NS = "http://www.tei-c.org/ns/1.0"
def q(n): return f"{{{NS}}}{n}"

TEXT = sys.argv[1] if len(sys.argv) > 1 else "Micro-commits/MC-1/data/castello-anima-text.xml"

try:
    root = etree.parse(TEXT).getroot()
except Exception as e:
    print(f"::error::parsing fallito su {TEXT}: {e}")
    sys.exit(1)

errors = []

# 1) retrace: @hand / @resp / fuori da <app>
retraces = list(root.iter(q("retrace")))
for r in retraces:
    if r.get("hand") != "#ink_3-dark":
        errors.append(f"[retrace] @hand=\"{r.get('hand')}\" ≠ \"#ink_3-dark\"")
    if r.get("resp") != "#s-teresa":
        errors.append(f"[retrace] @resp=\"{r.get('resp')}\" ≠ \"#s-teresa\"")
    if any(a.tag == q("app") for a in r.iterancestors()):
        errors.append("[retrace] collocato dentro <app>: deve stare fuori dall'apparato")

# 2) @varSeq solo con ≥2 <rdg> nello stesso <app>
for app in root.iter(q("app")):
    rdgs = app.findall(q("rdg"))
    if len(rdgs) < 2:
        for rdg in rdgs:
            if rdg.get("varSeq") is not None:
                errors.append("[varSeq] presente in un <app> con una sola <rdg> (riservato a ≥2 letture concorrenti)")

# 3) corr sempre con @resp
for c in root.iter(q("corr")):
    if not c.get("resp"):
        errors.append(f"[corr] senza @resp: \"{(c.text or '').strip()[:24]}\"")

# 4) cartulazione: pb/@n == 158r…168r
pbs = [pb.get("n") for pb in root.iter(q("pb"))]
expected = [f"{f}{s}" for f in range(158, 168) for s in ("r", "v")] + ["168r"]
if pbs != expected:
    errors.append(f"[cartulazione] sequenza <pb>/@n inattesa (attesa 158r…168r, {len(expected)} facciate): {pbs}")

if errors:
    print(f"::error::Guardia apparato: {len(errors)} problemi in {TEXT}")
    for e in errors:
        print("  -", e)
    sys.exit(1)

print(f"Guardia apparato superata su {TEXT}: {len(retraces)} retrace conformi (#ink_3-dark/#s-teresa, fuori app); "
      f"@varSeq disciplinato; {sum(1 for _ in root.iter(q('corr')))} corr con @resp; "
      f"cartulazione {pbs[0]}–{pbs[-1]} ({len(pbs)} facciate).")
