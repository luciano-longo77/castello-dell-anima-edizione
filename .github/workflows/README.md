# CI dell'edizione - validazione

A ogni `push`/`pull_request` che tocca i dati (`Micro-commits/**/data/**`), i modelli generici
(`tei-model/**`) o il workflow, GitHub Actions verifica che ciascun micro-commit resti
**ben formato, valido e coerente**.

[![Validate MC](https://github.com/luciano-longo77/castello-dell-anima-edizione/actions/workflows/validate.yml/badge.svg?branch=main)](https://github.com/luciano-longo77/castello-dell-anima-edizione/actions/workflows/validate.yml)

## Il workflow

| File | Nome | Quando parte |
|---|---|---|
| `validate.yml` | **Validate MC** | modifiche a `Micro-commits/**/data/**`, a `tei-model/**`, al workflow o agli script; avvio manuale (`workflow_dispatch`) |

Per ogni `Micro-commits/*/data/castello-anima-text.xml`, in sequenza:

1. **NFC** — tutti gli `*.xml` e `*.odd` della cartella `data/` in forma Unicode NFC (`guardia_nfc.py`).
2. **Ben formato + XInclude** — `xmllint --noout --xinclude`: il `<text>` include il `teiHeader`
   (`<xi:include href="TEI-Header.xml" xpointer="element(/1/1)"/>`) e il documento risolto è ben formato.
3. **RelaxNG** — `jing castello-anima-odd.rng` sul documento **risolto** (header + text).
4. **Guardia puntatori** (`guardia_puntatori.py`) — sul documento risolto ricontrolla i vincoli che
   `jing` non esegue (lo Schematron incorporato non è eseguito da jing) più l'aggancio del layer 2, tre invarianti:
   integrità referenziale di `@wit/@hand/@resp/@ref/@target/@corresp/@ana/@scribeRef/@sameAs/@who/@select/@source`
   (perimetro = Schematron *rule 1* dell'ODD — `@who/@select/@source` — **più** `@wit/@hand`, propri
   dell'apparato genetico e non coperti dallo Schematron),
   `term/@ref` → categoria di `#stati-mistici`, `change/@ana` → categoria di `#fase`.
5. **Guardia apparato** (`guardia_apparato.py`) — controlli *filologico-strutturali* del modello
   genetico che né `jing` né la guardia puntatori coprono: ogni `<retrace>` con `@hand="#ink_3-dark"`,
   `@resp="#s-teresa"` e fuori da `<app>`; `@varSeq` solo in un `<app>` con ≥2 `<rdg>`; ogni `<corr>`
   con `@resp`; sequenza `<pb>/@n` = 158r…168r (21 facciate, monotòna, senza salti), coerente con
   `docs/Struttura-cartulazione.md`. **Nota:** resta un controllo *strutturale*, non di correttezza
   filologica (un `corr` opinabile ma ben formato passa comunque).

> **Perché sul documento risolto.** Header e testo sono file separati uniti via XInclude: la
> validazione (schema e puntatori) ha senso solo dopo la risoluzione dell'include, quando i
> puntatori del testo trovano gli `xml:id` dichiarati nel `teiHeader`.

Infine, sui **modelli generici** (`tei-model/**/*.xml`) si esegue una verifica di **sola forma**
(NFC + buona formazione `xmllint --noout`). I modelli **non** sono validati contro l'ODD di
progetto: sono scheletri con placeholder (elementi vuoti, un solo `msItem` esemplificativo, ecc.)
la cui conformità piena si controlla in oXygen, non in CI.

## Lo schema è uno *snapshot* per micro-commit
Ogni `Micro-commits/MC-<n>/data/castello-anima-odd.rng` è una **copia congelata** dello schema con
cui quel micro-commit è stato validato e pubblicato: è parte della release, non un duplicato
accidentale. La CI valida sempre ogni testo **contro l'RNG che sta nella sua stessa cartella**, così
un MC già rilasciato resta riproducibile anche se lo schema evolve in un MC successivo. Lo schema è
generato dall'ODD (`castello-anima-odd.odd` → `.rng`); l'ODD è la fonte normativa.

## Eseguire la validazione in locale (prima di committare)
```bash
pip install lxml
sudo apt-get install -y libxml2-utils jing
DIR=Micro-commits/MC-1/data
python3 .github/workflows/guardia_nfc.py "$DIR"
xmllint --noout --xinclude "$DIR/castello-anima-text.xml"
xmllint --nofixup-base-uris --xinclude "$DIR/castello-anima-text.xml" > resolved.xml
jing "$DIR/castello-anima-odd.rng" resolved.xml
python3 .github/workflows/guardia_puntatori.py "$DIR/castello-anima-text.xml"
```
