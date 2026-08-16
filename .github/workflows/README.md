# CI dell'edizione — validazione (modello leggero)

A ogni `push`/`pull_request` che tocca i dati (`Micro-commits/**/data/**`), GitHub Actions
verifica che ciascun micro-commit resti **ben formato, valido e coerente**.

[![Validate MC](https://github.com/luciano-longo77/castello-dell-anima-edizione/actions/workflows/validate.yml/badge.svg?branch=main)](https://github.com/luciano-longo77/castello-dell-anima-edizione/actions/workflows/validate.yml)

## Il workflow

| File | Nome | Quando parte |
|---|---|---|
| `validate.yml` | **Validate MC** | modifiche a `Micro-commits/**/data/**`, al workflow o agli script; avvio manuale (`workflow_dispatch`) |

Per ogni `Micro-commits/*/data/castello-anima-text.xml`, in sequenza:

1. **NFC** — tutti gli `*.xml` della cartella `data/` in forma Unicode NFC (`guardia_nfc.py`).
2. **Ben formato + XInclude** — `xmllint --noout --xinclude`: il `<text>` include il `teiHeader`
   (`<xi:include href="TEI-Header.xml" xpointer="element(/1/1)"/>`) e il documento risolto è ben formato.
3. **RelaxNG** — `jing castello-anima-odd.rng` sul documento **risolto** (header + text).
4. **Guardia puntatori** (`guardia_puntatori.py`) — riproduce i due vincoli Schematron dell'ODD
   (che `jing` non esegue): integrità referenziale di `@wit/@hand/@resp/@ref/@target/@corresp/@ana`,
   `term/@ref` → categoria di `#stati-mistici`, `change/@ana` → categoria di `#fase`.

> **Perché sul documento risolto.** Header e testo sono file separati uniti via XInclude: la
> validazione (schema e puntatori) ha senso solo dopo la risoluzione dell'include, quando i
> puntatori del testo trovano gli `xml:id` dichiarati nel `teiHeader`.

## Confine col progetto gemello
Questa CI è la versione **ridotta e coerente** di quella di
[`castello-anima-TEI-IA`](https://github.com/luciano-longo77/castello-anima-TEI-IA): non include le
guardie del modello multiassiale (indice d'impatto, co-occorrenza `@ana`, cit/glossa, commenti,
interventi, 8 tassonomie) né i workflow di generazione, perché quei costrutti non fanno parte
dell'edizione leggera.

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
