#!/usr/bin/env python3
"""
Regressione della validazione — MC-1 (Castello dell'anima).

La CI dimostra che i dati BUONI passano. Questa suite dimostra il complemento,
necessario per un'edizione affidabile: che gli input SBAGLIATI vengano RESPINTI
da schema e guardie. Ogni test parte dai dati reali, applica UNA mutazione
errata a runtime (i dati di release non vengono toccati) e verifica che il
validatore competente FALLISCA (exit != 0). Include controlli positivi.

Copre: guardia_apparato.py, guardia_puntatori.py e lo schema RELAX NG (jing).

Uso:   python3 Micro-commits/MC-1/tests/run_regression.py
Exit:  0 se tutti i test passano (cioè: buoni accettati, cattivi respinti); 1 altrimenti.
Richiede: python3 + lxml, xmllint, jing (gli stessi della CI).
"""
import subprocess, sys, os, shutil, tempfile, copy
from lxml import etree

HERE = os.path.dirname(os.path.abspath(__file__))
ROOT = os.path.abspath(os.path.join(HERE, "..", "..", ".."))
DATA = os.path.join(ROOT, "Micro-commits", "MC-1", "data")
TEXT = os.path.join(DATA, "castello-anima-text.xml")
HEADER = os.path.join(DATA, "TEI-Header.xml")
RNG = os.path.join(DATA, "castello-anima-odd.rng")
GUARD = os.path.join(ROOT, ".github", "workflows")
NS = "http://www.tei-c.org/ns/1.0"
def q(n): return "{%s}%s" % (NS, n)

results = []
def record(name, rejected):
    results.append((name, bool(rejected)))

def run(cmd):
    r = subprocess.run(cmd, capture_output=True, text=True)
    return r.returncode

def guardia(script, tree):
    """Serializza l'albero <text> in una tmpdir (con l'header per l'XInclude),
    esegue la guardia, ritorna il return code."""
    d = tempfile.mkdtemp()
    try:
        shutil.copy(HEADER, os.path.join(d, "TEI-Header.xml"))
        p = os.path.join(d, "castello-anima-text.xml")
        tree.write(p, encoding="utf-8", xml_declaration=True)
        return run(["python3", os.path.join(GUARD, script), p])
    finally:
        shutil.rmtree(d, ignore_errors=True)

def jing(tree):
    """Valida un documento (già risolto) contro l'RNG con jing; ritorna il return code."""
    d = tempfile.mkdtemp()
    try:
        p = os.path.join(d, "doc.xml")
        tree.write(p, encoding="utf-8", xml_declaration=True)
        return run(["jing", RNG, p])
    finally:
        shutil.rmtree(d, ignore_errors=True)

def text_tree():
    return etree.parse(TEXT)

def resolved_tree():
    """Documento risolto (header + text) senza xml:base, come in CI (xmllint --nofixup-base-uris)."""
    out = subprocess.run(["xmllint", "--nofixup-base-uris", "--xinclude", TEXT],
                         capture_output=True)
    return etree.ElementTree(etree.fromstring(out.stdout))

# ============================ CONTROLLI POSITIVI ============================
record("[+] guardia_apparato accetta il testo valido",  guardia("guardia_apparato.py",  text_tree()) == 0)
record("[+] guardia_puntatori accetta il testo valido", guardia("guardia_puntatori.py", text_tree()) == 0)
record("[+] jing accetta il documento risolto valido",  jing(resolved_tree()) == 0)

# ===================== NEGATIVI — guardia_apparato =========================
# 1) retrace collocato DENTRO <app> (deve stare fuori dall'apparato)
t = text_tree(); r = t.getroot()
app = r.find(".//" + q("app")); retr = r.find(".//" + q("retrace"))
app.find(q("lem")).append(copy.deepcopy(retr))
record("[apparato] retrace dentro <app> viene respinto", guardia("guardia_apparato.py", t) != 0)

# 2) @varSeq su un <app> con una sola <rdg>
t = text_tree(); r = t.getroot()
r.find(".//" + q("app") + "/" + q("rdg")).set("varSeq", "1")
record("[apparato] @varSeq con una sola rdg viene respinto", guardia("guardia_apparato.py", t) != 0)

# 3) <corr> senza @resp
t = text_tree(); r = t.getroot()
c = r.find(".//" + q("corr") + "[@resp]"); del c.attrib["resp"]
record("[apparato] corr senza @resp viene respinto", guardia("guardia_apparato.py", t) != 0)

# 4) sequenza <pb> spezzata (cartulazione 158r-168r)
t = text_tree(); r = t.getroot()
r.find(".//" + q("pb")).set("n", "199r")
record("[apparato] pb fuori sequenza viene respinto", guardia("guardia_apparato.py", t) != 0)

# 5) retrace con @hand diverso da #ink_3-dark
t = text_tree(); r = t.getroot()
r.find(".//" + q("retrace")).set("hand", "#ink_1")
record("[apparato] retrace con @hand errato viene respinto", guardia("guardia_apparato.py", t) != 0)

# ===================== NEGATIVI — guardia_puntatori ========================
# 6) term/@ref verso uno stato inesistente
t = text_tree(); r = t.getroot()
r.find(".//" + q("term") + "[@ref]").set("ref", "#stato-inventato")
record("[puntatori] term/@ref a stato inesistente viene respinto", guardia("guardia_puntatori.py", t) != 0)

# 7) @wit pendente (verso un testimone non dichiarato)
t = text_tree(); r = t.getroot()
r.find(".//" + q("rdg") + "[@wit]").set("wit", "#txt-999")
record("[puntatori] @wit pendente viene respinto", guardia("guardia_puntatori.py", t) != 0)

# ========================= NEGATIVI — schema (jing) ========================
# 8) elemento <interp> (cancellato dall'ODD) inserito nel corpo
t = resolved_tree(); r = t.getroot()
etree.SubElement(r.find(".//" + q("p")), q("interp"))
record("[schema] <interp> (cancellato dall'ODD) viene respinto", jing(t) != 0)

# 9) elemento inesistente <zzz>
t = resolved_tree(); r = t.getroot()
etree.SubElement(r.find(".//" + q("p")), q("zzz"))
record("[schema] elemento inesistente <zzz> viene respinto", jing(t) != 0)

# ================================ REPORT ===================================
ok = sum(1 for _, passed in results if passed)
for name, passed in results:
    print(("  OK  " if passed else "  FAIL ") + name)
print("\n%d/%d test superati (buoni accettati, cattivi respinti)." % (ok, len(results)))
sys.exit(0 if ok == len(results) else 1)
