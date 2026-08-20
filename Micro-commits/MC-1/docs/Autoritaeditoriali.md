# (MC1) Micro‑progetto di Edizione Critica Digitale
## Mappa delle autorità editoriali — che cosa è dato, che cosa è intervento
**Edizione critica digitale del *Castello dell’anima*** **ms. Palermo, BCP, 2 Qq E 29**

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey?logo=creativecommons)](https://creativecommons.org/licenses/by/4.0/)
![TEI P5](https://img.shields.io/badge/TEI-P5-blueviolet?logo=xml)
![Micro-commit](https://img.shields.io/badge/Micro--commit-MC1-informational)

## A cosa serve questo documento

In un'edizione genetico-documentaria il rischio maggiore non è tecnico ma **epistemologico**: confondere *ciò che è nel manoscritto* con *ciò che l'editore decide*. Questo documento rende **esplicito e verificabile** lo **statuto** di ogni elemento della marcatura — se registra un **dato materiale**, una **trascrizione**, un'**interpretazione**, una **costituzione** del testo o un'**annotazione**. È la chiave di lettura filologica dell'edizione: consolida in un unico prospetto quanto già dichiarato in prosa in [`Introduzione-III,1-5.md`](Introduzione-III,1-5.md) §3.1.

Principio guida: **la marcatura si aggiunge, non sostituisce il documento.** Ogni intervento dell'editore è esplicito (`@resp`), reversibile (via `<choice>`) e distinto dal dato.

## I cinque livelli di autorità

```text
1. DOCUMENTO       ciò che è materialmente sulla carta        (osservazione)
      ↓
2. TRASCRIZIONE    come lo rappresentiamo, senza interpretare  (livello diplomatico)
      ↓
3. INTERPRETAZIONE come comprendiamo il fenomeno               (regolarizzazione, emendamento, mano)
      ↓
4. COSTITUZIONE    quale lezione scegliamo come testo da leggere (lemma dell'edizione)
      ↓
5. ANNOTAZIONE     strati aggiunti di lettura                  (stati mistici, intertesto)
```

I livelli 1–2 sono **conservativi** (il dato non è mai soppresso); i livelli 3–5 sono **editoriali/interpretativi** e sempre attribuiti.

## Prospetto: elemento → statuto → responsabilità

| Marcatura | Che cosa registra | Statuto epistemico | `@resp` |
|---|---|---|---|
| `pb`, `lb`, `fw` | foliazione, cambio-riga, richiami | **dato materiale** (osservazione) | — |
| `orig` (in `choice`) | grafia originale | **dato documentario** | — |
| `abbr` (in `choice`) | abbreviazione materiale | **dato documentario** | — |
| `sic` (in `choice`) | lezione del testimone *così com'è* | **dato documentario** | — |
| `add` · `del` · `subst` | aggiunta, cancellatura, sostituzione d'autrice | **fenomeno materiale** (osservazione) | `@hand` + `@resp` (`#s-teresa`/`#esterno`) |
| `retrace` | rivergatura: ripasso a inchiostro, **testo invariato** | **fenomeno materiale** (osservazione) | `@hand="#ink_3-dark"` + `@resp="#s-teresa"` |
| `gap` · `unclear` | guasto / illeggibilità | **dato materiale** (osservazione) | — |
| `reg` (in `choice`) | regolarizzazione grafica | **normalizzazione editoriale** | `#editor` |
| `expan` (in `choice`) | scioglimento di abbreviazione | **intervento editoriale** (espansione) | `#editor` |
| `corr` (in `choice`) | correzione di errore materiale | **intervento editoriale** (*emendatio*) | `#editor` (+ `@cert`) |
| `supplied` | integrazione di lacuna | **integrazione editoriale** | `#editor` (+ `@cert`) |
| `lem` (`@wit="#txt-c"`) | lezione accolta | **costituzione dell'edizione** | `#editor` |
| `term` (`@ref`) | aggancio a uno stato mistico | **annotazione interpretativa** | progetto |
| `ref` · `cit` · `quote` · `bibl` | rimando a fonte | **annotazione intertestuale** | progetto |

Regola di lettura: **tutto ciò che porta `@resp="#editor"` (o `@cert`) è intervento, non dato.** `reg`/`expan`/`corr`/`supplied`/`lem` sono editoriali; `orig`/`abbr`/`sic` e i fenomeni materiali (`add`/`del`/`subst`/`retrace`/`gap`/`unclear`) sono documentari.

## Il punto più delicato: stati genetici ≠ testimoni; e Tc è costituzione, non stato

La tradizione diretta è l'**autografo unico**. Perciò:

- **Tb0, Tb1, T1–T4** non sono *testimoni* di una tradizione plurima (in senso lachmanniano), ma **stati genetici** — campagne scrittorie del medesimo documento. L'uso di `<witness>`/`@wit` è un espediente tecnico per renderli interrogabili in apparato, **non** un'affermazione stemmatica.
- **Tc** (`#txt-c`, `@resp="#editor"`) **non è un ulteriore stato del manoscritto**: è la **lezione costituita dall'editore**, il testo scelto come da leggere. Per questo nel `teiHeader` il `<listWit>` distingue esplicitamente il gruppo *stati genetici dell'autografo* dal *livello editoriale* (vedi [`Header-README.md`](Header-README.md)).

Di conseguenza, in `<app>`, il rapporto `lem (Tc) ↔ rdg (Tb0)` **non** è «lezione giusta vs variante sbagliata», ma **«forma costituita ↔ stato genetico che la precede»**: rappresenta la *genesi*, con la scelta editoriale dichiarata a parte.

## Che cosa la validazione garantisce (e che cosa no)

La CI (`.github/workflows/`) verifica la **coerenza strutturale e referenziale** — ben formato, schema RELAX NG, puntatori risolti, `retrace`/`@varSeq`/`term@ref` conformi al modello. **Non** verifica la **correttezza filologica** delle scelte (un `corr` plausibile ma opinabile passa comunque). Vale quindi la distinzione:

> **validazione tecnica ≠ validazione filologica.** La prima è automatica e garantita; la seconda è responsabilità dell'editore ed è documentata qui e nei criteri editoriali.

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
