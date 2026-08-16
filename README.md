# Edizione critica digitale - *Il Castello dell'anima*
## Repository

[![TEI P5](https://img.shields.io/badge/TEI-P5-334155)](https://tei-c.org/) ![DSE](https://img.shields.io/badge/DSE-Digital_Scholarly_Editing-8B0000) [![Castello dell'anima](https://img.shields.io/badge/Castello%20dell%27anima-7b2d3b)](https://github.com/luciano-longo77/castello-anima-TEI-IA)

**Autrice**: Teresa di San Geronimo (Anna La Longa, 1670–post 1703)  
**Editor**: Luciano Longo  
**Licenza**: CC BY 4.0  

Repository del progetto di **edizione critica digitale del terzo libro del _Castello dell’anima_**
di *suor Teresa di San Geronimo* (ms. 2Qq E 29).

---

## About this repository

Questo repository ospita la **documentazione scientifica, metodologica e modellizzante**
del progetto di edizione critica digitale, con particolare attenzione alla
**filologia d’autore e alla critica genetica**.

La descrizione completa di:
- obiettivi del progetto,
- contesto storico‑dottrinale,
- criteri editoriali,
- impostazione filologica,

è contenuta nel file:

👉 [`project-readme.md`](./project-readme.md)

---

## TEI model

La cartella [`tei-model/`](./tei-model/) contiene i **modelli TEI generici** dell'edizione (header e text); i singoli micro-commit dell'edizione stanno in [`Micro-commits/`](./Micro-commits/) (MC-1, MC-2, …).

Il modello è concepito per:
- rappresentare la **stratificazione testuale** del manoscritto autografo;
- codificare **correzioni, aggiunte e riscritture** come dati genetici;
- fornire una base formale per lo sviluppo dell’edizione critica digitale.

Il modello TEI costituisce la **prima formalizzazione operativa dell’approccio editoriale**
descritto nel *project-readme.md*.

---

## Project status

Il progetto si trova in una fase di **definizione metodologica ed editoriale avanzata**,
con **modello TEI già strutturato** e **schema TEI P5 personalizzato (ODD → RELAX NG + Schematron)**.

Il primo micro‑commit (MC1, Libro III, capp. I–V) adotta un modello **a tre layer** —
filologico‑grafico (trascrizione a due livelli via `<choice>` + apparato genetico),
mistico‑dottrinale (`<term ref>` agganciato a un vocabolario controllato degli stati) e
intertestuale (`<cit>`/`<bibl>`, `<ref>`).

Le fasi successive prevedono l’integrazione del modello TEI in un
**ambiente di edizione critica digitale** e la pubblicazione online del testo.

---

## Repository contents

```text
.
├── README.md                     # Orientamento del repository
├── project-readme.md             # Documento scientifico dell'edizione
├── tei-model/                    # Modelli TEI generici dell'edizione
│   ├── header/                   # teiHeader-model.xml + readme + diagramma
│   └── text/                     # text-model.xml + readme + diagramma
└── Micro-commits/                # I micro-commit dell'edizione
    ├── readme-MC-general.md      # Piano editoriale e roadmap MC1…MC8
    └── MC-1/                     # Commit 1 — Libro III, capp. I–V
        ├── MC1-README_generale.md
        ├── data/                 # castello-anima.xml, TEI-Header.xml, ODD/RNG
        ├── docs/                 # Introduzione, Struttura-cartulazione, Header-README
        ├── output/               # Prototipi di visualizzazione
        └── tool/                 # Strumenti di ricerca (in preparazione)
```
--- 

## Licenza
Creative Commons Attribution 4.0 International (**CC BY 4.0**).  

---

## 👤 Curatore
**Luciano Longo**   
- Contatti: <luciano.longo@dedalus.com> 
- ORCID: <https://orcid.org/0009-0005-7557-7546> 
- GitHub: <https://github.com/luciano-longo77>
- Website: <https://luciano-longo77.github.io>
