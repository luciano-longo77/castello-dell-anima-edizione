# Edizione Critica Digitale Modulare (Micro-commits) 
## *Il Castello dell'anima* - Libro III

[![TEI P5](https://img.shields.io/badge/TEI-P5-334155)](https://tei-c.org/) ![DSE](https://img.shields.io/badge/DSE-Digital_Scholarly_Editing-8B0000) [![Castello dell'anima](https://img.shields.io/badge/Castello%20dell%27anima-7b2d3b)](https://github.com/luciano-longo77/castello-anima-TEI-IA)

Progetto di edizione critica digitale del **III libro** del *Castello dell’anima* (1692–1694) di **suor Teresa di San Geronimo** (Anna La Longa), basato sul manoscritto autografo conservato presso la Biblioteca Comunale di Palermo (ms. 2 Qq E 29).

---

## 1. Obiettivi e Metodologia
Il progetto adotta una strategia di **rilascio granulare (Micro-commits)**. Ogni commit rappresenta un'unità dottrinale e materiale coerente, permettendo una revisione filologica puntuale e una citabilità dei dati secondo i principi **FAIR**.

### Principi Editoriali
* **Trascrizione a due livelli:**
- diplomatica ⇄ interpretativa, con la lezione conservativa e la sua regolarizzazione affiancate da `<choice>` (`<orig>`/`<reg>`, `<abbr>`/`<expan>`, `<sic>`/`<corr>`), senza che l'una sostituisca l'altra; focalizzata sulle correzioni autografe e le glosse marginali.

* **Modellazione TEI su tre layer:**
  - **(1)** filologico‑grafico - struttura, trascrizione a due livelli e apparato genetico (`<app>`/`<lem>`/`<rdg>` con `@varSeq`, `<add>`/`<del>`/`<subst>`);
  - **(2)** mistico‑dottrinale - lessico agganciato via `<term ref>` a un vocabolario controllato degli stati;
  - **(3)** intertestuale - `<cit>`/`<quote>`/`<bibl>` e `<ref>` per fonti e rimandi. Documenta la genesi del testo e le strategie prudenziali dell'autrice.

* **Digital Philology (progetto separato):** la preparazione dei dati per analisi computazionali (NLP), l'annotazione interpretativa multiassiale e l'intertestualità assistita da IA sono sviluppate nel repository dedicato `castello-anima-TEI-IA`, distinto da questa edizione critica.

---

## 2. Struttura del Libro III (Piano dei Rilasci)

L'edizione è suddivisa in 8 Micro-Commits (MC) tematici:

| ID | Capitoli | Focus Tematico | Stato |
| :--- | :--- | :--- | :--- |
| **MC1** | III.1–5 | **Avvio della contemplazione infusa**: silentio e sonno spirituale. | 🏗️ In preparazione |
| **MC2** | III.6–10 | **Stabilizzazione**: otio e annichilimento. | 📅 Programmato |
| **MC3** | III.11–15 | **Matrice sponsale I**: pace e indifferenza. | 📅 Programmato |
| **MC4** | III.16–20 | **Matrice sponsale II**: liquefazione e bacio mistico. | 📅 Programmato |
| **MC5** | III.21–24 | **Purificazioni passive**: aridità e "purghe". | 📅 Programmato |
| **MC6** | III.25–29 | **Croce e trasformazione**: conformazione al Crocifisso. | 📅 Programmato |
| **MC7** | III.30–34 | **Deificazione**: presenza trinitaria abituale. | 📅 Programmato |
| **MC8** | III.35–Fine | **Compimento**: ultime celle e *stabilitas*. | 📅 Programmato |

---

## 3. Organizzazione del Repository
Ogni micro-commit (es. `MC1_Castello_MicroCommit_III_1-5/`) contiene:
* `data/`: File XML sorgente conformi allo standard TEI P5.
* `doc/`: Introduzione editoriale, note al testo e analisi della cartulazione.
* `out/`: Prototipi per la visualizzazione dinamica della struttura del manoscritto.
* `tool/`: Prototipi per l'interrogazione dinamica dell'edizione.
---

## 4. Requisiti Tecnici
I file XML sono validati rispetto a uno schema TEI **personalizzato**, generato dall'ODD di progetto (`MC-1_castello-anima-odd.odd`) e compilato in `MC-1_castello-anima-odd.rng` (RELAX NG con Schematron incorporato). Per la consultazione si raccomanda un editor XML (es. oXygen) o fogli di stile XSLT compatibili con lo standard TEI.

---

## 5. Citazione e Licenza
La codifica TEI e la documentazione sono rilasciate sotto licenza **Creative Commons Attribution 4.0 International (CC BY 4.0)**: uso e riuso consentiti, anche a fini commerciali, con attribuzione. Le riproduzioni digitali del manoscritto ne sono escluse e restano consultabili solo off-line, secondo le condizioni stabilite dall'ente conservatore.

**Citazione suggerita:**
> Longo, Luciano. (2026). *Il Castello dell’anima — Libro III: Edizione Critica Digitale (Micro-commits)* [Data set]. Zenodo. https://doi.org/[Pending]

---

## 👤 Curatore
**Luciano Longo**   
- Contatti: <luciano.longo@dedalus.com> 
- ORCID: <https://orcid.org/0009-0005-7557-7546> 
- GitHub: <https://github.com/luciano-longo77>
- Website: <https://luciano-longo77.github.io>
