# Edizione Critica Digitale Modulare (Micro-commits) 
## *Il Castello dell'anima* - Libro III

[![TEI P5](https://img.shields.io/badge/TEI-P5-334155)](https://tei-c.org/) ![DSE](https://img.shields.io/badge/DSE-Digital_Scholarly_Editing-8B0000) ![CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-7b2d3b)

Progetto di edizione critica digitale del **III libro** del *Castello dell’anima* (1692–1694) di **suor Teresa di San Geronimo** (Anna La Longa), basato sul manoscritto autografo conservato presso la Biblioteca Comunale di Palermo (ms. 2 Qq E 29).

---

## 1. Obiettivi e Metodologia
Il progetto adotta una strategia di **rilascio granulare (Micro-commits)**. Ogni commit rappresenta un'unità dottrinale e materiale coerente, permettendo una revisione filologica puntuale e una citabilità dei dati secondo i principi **FAIR**.

### Principi Editoriali
* **Trascrizione a due livelli:**
- diplomatica ⇄ interpretativa, con la lezione conservativa e la sua regolarizzazione affiancate da `<choice>` (`<orig>`/`<reg>`, `<abbr>`/`<expan>`, `<sic>`/`<corr>`), senza che l'una sostituisca l'altra; focalizzata sulle correzioni autografe e le glosse marginali.

* **Modellazione TEI su tre layer:**
  - **(1)** filologico‑grafico - struttura (con `<lb>` per i cambi-riga, `@break="no"` a metà parola), trascrizione a due livelli (punteggiatura del ms su entrambi) e apparato genetico (`<app>`/`<lem>`/`<rdg>`, con `<del>`/`<add>`/`<subst>` dentro l'apparato; `@varSeq` solo con più letture concorrenti) e rivergature a inchiostro rese con `<retrace>` (mano `#ink_3-dark`, testo invariato, fuori apparato);
  - **(2)** mistico‑dottrinale - lessico agganciato via `<term ref>` a un vocabolario controllato degli stati;
  - **(3)** intertestuale - `<cit>`/`<quote>`/`<bibl>` e `<ref>` per fonti e rimandi. Documenta la genesi del testo e le strategie prudenziali dell'autrice.

* **Fuori scope:** la preparazione dei dati per analisi computazionali (NLP), l'annotazione interpretativa multiassiale e l'intertestualità assistita da IA non rientrano in questa edizione critica, che adotta un modello leggero.

---

## 2. Struttura del Libro III (Piano dei Rilasci)

L'edizione è suddivisa in 8 Micro-Commits (MC) tematici:

| ID | Capitoli | Focus Tematico | Stato |
| :--- | :--- | :--- | :--- |
| **MC1** | III.1–5 | **Primi stati d'unione**: disposizione post‑notte, silentio, oblivione/sonno, scordanza, indifferenza. | 🟢 Completato · validato (jing 0 · guardia 172 id · NFC) · **pubblicato** ([DOI 10.5281/zenodo.22058563](https://zenodo.org/records/22058563)) |
| **MC2** | III.6–10 | **Stabilizzazione**: otio e annichilimento. | 📅 Programmato |
| **MC3** | III.11–15 | **Matrice sponsale I**: pace e quiete. | 📅 Programmato |
| **MC4** | III.16–20 | **Matrice sponsale II**: liquefazione e bacio mistico. | 📅 Programmato |
| **MC5** | III.21–24 | **Purificazioni passive**: aridità e "purghe". | 📅 Programmato |
| **MC6** | III.25–29 | **Croce e trasformazione**: conformazione al Crocifisso. | 📅 Programmato |
| **MC7** | III.30–34 | **Deificazione**: presenza trinitaria abituale. | 📅 Programmato |
| **MC8** | III.35–Fine | **Compimento**: ultime celle e *stabilitas*. | 📅 Programmato |

---

## 📖 Leggi l'edizione (MC-1)

- **[Testo dell'edizione](https://luciano-longo77.github.io/castello-dell-anima-edizione/Micro-commits/MC-1/output/castello-anima-lettura.html)** — lettura a fronte (diplomatico ⇄ interpretativo), apparato genetico, stati mistici, ricerca.
- **[Descrizione dell'edizione (teiHeader)](https://luciano-longo77.github.io/castello-dell-anima-edizione/Micro-commits/MC-1/output/castello-anima-teiHeader.html)** — metadati completi del `teiHeader`.

---

## 3. Organizzazione del Repository
Ogni micro-commit (es. `Micro-commits/MC-1/`) contiene:
* `README.md`: introduzione sintetica e cartulazione del micro-commit.
* `data/`: file XML/TEI sorgente e schema di progetto (ODD/RNG).
* `docs/`: introduzione critica, struttura/cartulazione e guida al teiHeader.
* `output/`: prototipi per la visualizzazione dinamica della struttura del manoscritto.
* `tool/`: strumenti locali per l'interrogazione dinamica dell'edizione (es. `viewer-stati-mistici.html`, ricerca degli stati mistici nel browser).
---

## 4. Requisiti Tecnici
I file XML sono validati rispetto a uno schema TEI **personalizzato**, generato dall'ODD di progetto (`castello-anima-odd.odd`) e compilato in `castello-anima-odd.rng` (RELAX NG con Schematron incorporato). Per la consultazione si raccomanda un editor XML (es. oXygen) o fogli di stile XSLT compatibili con lo standard TEI.

---

## 5. Citazione e Licenza
La codifica TEI e la documentazione sono rilasciate sotto licenza **Creative Commons Attribution 4.0 International (CC BY 4.0)**: uso e riuso consentiti, anche a fini commerciali, con attribuzione. Le riproduzioni digitali del manoscritto ne sono escluse e restano consultabili solo off-line, secondo le condizioni stabilite dall'ente conservatore.

**Citazione suggerita:**
> Longo, Luciano. (2026). *Il Castello dell’anima — Libro III: Edizione Critica Digitale (Micro-commits)* [Data set]. Zenodo. https://doi.org/10.5281/zenodo.22058562

(*concept DOI*, rimanda sempre all’ultima versione; il DOI della versione MC-1 è `10.5281/zenodo.22058563`.)

---

## 👤 Curatore
**Luciano Longo**   
- Contatti: <luciano.longo@dedalus.com> 
- ORCID: <https://orcid.org/0009-0005-7557-7546> 
- GitHub: <https://github.com/luciano-longo77>
- Website: <https://luciano-longo77.github.io>
