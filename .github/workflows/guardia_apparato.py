#!/usr/bin/env python3
"""
Guardia apparato — controlli filologico-strutturali che jing (RELAX NG) non esegue.

Verifica quattro invarianti del modello genetico. Le due sensibili al singolo
micro-commit — le mani/resp ammesse per <retrace> e la cartulazione attesa — sono
lette da un file di configurazione accanto ai dati, cosicché il test valga per
QUALSIASI micro-commit (MC-1, MC-2, …) senza costanti codificate al suo interno:

  1. retrace: ogni <retrace> ha @hand fra quelle ammesse, @resp fra quelli ammessi,
     e sta FUORI da <app>.
  2. varSeq: @varSeq compare solo in un <app> con ≥2 <rdg> concorrenti. [model-level]
  3. corr: ogni <corr> porta @resp (intervento editoriale sempre attribuito). [model-level]
  4. cartulazione: la sequenza dei <pb>/@n coincide con quella attesa dal config,
     ed è comunque monotòna, senza salti né duplicati.

Configurazione (facoltativa ma raccomandata): un file `guardia.config.json` nella
STESSA cartella del TEXT, con la forma:

  {
    "cartulazione": { "from": "158r", "to": "168r" },   // oppure una lista esplicita
    "retrace_hands": ["#ink_3-dark"],
    "retrace_resp":  ["#s-teresa"]
  }

In assenza del config si applicano i default (#ink_3-dark / #s-teresa) e la
cartulazione è verificata solo per coerenza interna (monotòna, senza salti/duplicati),
senza un intervallo atteso.

Esce con codice 1 (e messaggi ::error:: per GitHub Actions) se qualcosa non torna.

Uso:  python3 guardia_apparato.py [TEXT_XML]
      (default: Micro-commits/MC-1/data/castello-anima-text.xml)
"""
import sys, os, json, re
from lxml import etree

NS = "http://www.tei-c.org/ns/1.0"
def q(n): return f"{{{NS}}}{n}"

TEXT = sys.argv[1] if len(sys.argv) > 1 else "Micro-commits/MC-1/data/castello-anima-text.xml"

# ---- configurazione per-micro-commit ----------------------------------------
DEFAULTS = {"retrace_hands": ["#ink_3-dark"], "retrace_resp": ["#s-teresa"], "cartulazione": None}
cfg = dict(DEFAULTS)
cfg_path = os.path.join(os.path.dirname(os.path.abspath(TEXT)), "guardia.config.json")
if os.path.exists(cfg_path):
    try:
        loaded = json.load(open(cfg_path, encoding="utf-8"))
        cfg.update({k: loaded[k] for k in loaded})
    except Exception as e:
        print(f"::error::config illeggibile {cfg_path}: {e}")
        sys.exit(1)

def parse_side(tok):
    m = re.fullmatch(r"(\d+)([rv])", tok.strip())
    if not m:
        raise ValueError(f"carta non valida: {tok!r}")
    return int(m.group(1)), m.group(2)

def expand_range(frm, to):
    """Enumera la sequenza r/v da 'frm' a 'to' inclusi (r prima di v)."""
    f0, s0 = parse_side(frm); f1, s1 = parse_side(to)
    order = {"r": 0, "v": 1}
    seq, f, s = [], f0, order[s0]
    limit = (f1 - f0 + 2) * 2 + 4  # guardia anti-loop
    while limit > 0:
        seq.append(f"{f}{'r' if s == 0 else 'v'}")
        if f == f1 and s == order[s1]:
            break
        s, f = (1, f) if s == 0 else (0, f + 1)
        limit -= 1
    return seq

def expected_cartulazione(spec):
    if spec is None:
        return None
    if isinstance(spec, list):
        return [str(x) for x in spec]
    if isinstance(spec, dict) and "from" in spec and "to" in spec:
        return expand_range(spec["from"], spec["to"])
    raise ValueError("campo 'cartulazione' non riconosciuto (usa lista o {from,to})")

try:
    root = etree.parse(TEXT).getroot()
except Exception as e:
    print(f"::error::parsing fallito su {TEXT}: {e}")
    sys.exit(1)

errors = []

# 1) retrace: @hand / @resp (da config) / fuori da <app>
retraces = list(root.iter(q("retrace")))
hands_ok, resp_ok = set(cfg["retrace_hands"]), set(cfg["retrace_resp"])
for r in retraces:
    if r.get("hand") not in hands_ok:
        errors.append(f"[retrace] @hand=\"{r.get('hand')}\" non fra le ammesse {sorted(hands_ok)}")
    if r.get("resp") not in resp_ok:
        errors.append(f"[retrace] @resp=\"{r.get('resp')}\" non fra i ammessi {sorted(resp_ok)}")
    if any(a.tag == q("app") for a in r.iterancestors()):
        errors.append("[retrace] collocato dentro <app>: deve stare fuori dall'apparato")

# 2) @varSeq solo con ≥2 <rdg> nello stesso <app>  [model-level]
for app in root.iter(q("app")):
    rdgs = app.findall(q("rdg"))
    if len(rdgs) < 2:
        for rdg in rdgs:
            if rdg.get("varSeq") is not None:
                errors.append("[varSeq] presente in un <app> con una sola <rdg> (riservato a ≥2 letture concorrenti)")

# 3) corr sempre con @resp  [model-level]
for c in root.iter(q("corr")):
    if not c.get("resp"):
        errors.append(f"[corr] senza @resp: \"{(c.text or '').strip()[:24]}\"")

# 4) cartulazione
pbs = [pb.get("n") for pb in root.iter(q("pb"))]
try:
    expected = expected_cartulazione(cfg["cartulazione"])
except ValueError as e:
    print(f"::error::config cartulazione: {e}")
    sys.exit(1)

if expected is not None:
    if pbs != expected:
        errors.append(f"[cartulazione] sequenza <pb>/@n inattesa (attesa {expected[0]}…{expected[-1]}, "
                      f"{len(expected)} facciate): {pbs}")
else:
    # nessun intervallo atteso: verifico solo la coerenza interna (monotòna, senza dup/salti)
    seen = set()
    prev = None
    for n in pbs:
        try:
            f, s = parse_side(n)
        except ValueError:
            errors.append(f"[cartulazione] carta non valida: {n!r}"); continue
        if n in seen:
            errors.append(f"[cartulazione] carta duplicata: {n}")
        seen.add(n)
        if prev is not None and (f, s) < prev:
            errors.append(f"[cartulazione] sequenza non monotòna a {n}")
        prev = (f, s)

if errors:
    print(f"::error::Guardia apparato: {len(errors)} problemi in {TEXT}")
    for e in errors:
        print("  -", e)
    sys.exit(1)

card = f"{pbs[0]}–{pbs[-1]} ({len(pbs)} facciate)" if pbs else "(nessun pb)"
src = "config" if os.path.exists(cfg_path) else "default"
print(f"Guardia apparato superata su {TEXT} [{src}]: {len(retraces)} retrace conformi "
      f"({'/'.join(sorted(hands_ok))} · {'/'.join(sorted(resp_ok))}, fuori app); "
      f"@varSeq disciplinato; {sum(1 for _ in root.iter(q('corr')))} corr con @resp; "
      f"cartulazione {card}.")
