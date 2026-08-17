# (MC1) Micro‑progetto di Edizione Critica Digitale
## `docs/` - Documentazione critica e metodologica del MC1
### Libro III, capp. I–V · ms. Palermo, BCP, 2 Qq E 29

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey?logo=creativecommons)](https://creativecommons.org/licenses/by/4.0/)
![TEI P5](https://img.shields.io/badge/TEI-P5-blueviolet?logo=xml)
![Micro-commit](https://img.shields.io/badge/Micro--commit-MC1-informational)
![Carte: 158r–168r](https://img.shields.io/badge/carte-158r%E2%80%93168r-556B2F)

## A cosa serve questa cartella

La cartella **`docs/`** raccoglie la **documentazione critica e metodologica** del micro‑commit MC1 (proemio + capp. I–V del Libro III): il *perché* e il *come* delle scelte editoriali, distinti dai **dati** veri e propri.

Nel pacchetto del micro‑commit i piani restano separati:

| Cartella | Contenuto | Ruolo |
|---|---|---|
| `data/` | `TEI-Header.xml`, `castello-anima-text.xml`, `castello-anima-odd.odd`/`.rng` | **fonte autorevole** (TEI validato a schema) |
| **`docs/`** | i tre documenti descritti qui sotto | **documentazione** (descrive, non normativa) |
| `output/` · `tool/` | viewer e schema-carte HTML | **artefatti derivati** (visualizzazione) |

In caso di divergenza fa fede il TEI conforme allo schema ODD in `data/`; questi documenti lo *descrivono*.

## I documenti

| File | Che cosa contiene |
|---|---|
| [`Introduzione-III,1-5.md`](Introduzione-III,1-5.md) | **Presentazione del MC1.** Contesto storico‑spirituale e profilo dell'opera; analisi capitolo per capitolo (I–V); politiche editoriali (trascrizione diplomatico‑conservativa a due livelli); **tag set core** con giustificazione critica; metadati e roadmap MC1–MC8. |
| [`Struttura-cartulazione.md`](Struttura-cartulazione.md) | **Autorità sulla cartulazione.** Fascia materiale **158r–168r**, struttura capitolare dettagliata, tabella topografica; **numerazione continua d'autrice §§1–72** e carte condivise ai confini di capitolo (162r fra II e III, 164v fra III e IV). |
| [`Header-README.md`](Header-README.md) | **Guida al `teiHeader`.** Che cosa contiene e come è organizzato (`fileDesc`/`encodingDesc`/`profileDesc`/`revisionDesc`); tag set core, vocabolario controllato degli stati e fonti; validazione e schema. |

## Il modello in breve (comune ai tre documenti)

- **Edizione leggera**: tre layer (filologico‑grafico, mistico‑dottrinale, intertestuale) su **due livelli** di trascrizione resi con `<choice>`; unità di riferimento il paragrafo `<p n="…">`, non il `<seg>`. Fuori scope l'annotazione interpretativa multiassiale (`seg/@ana`, indice d'impatto, standOff), che vive nel progetto gemello.
- **Apparato genetico « currente calamo »**: `<lem wit="#txt-c">` e un'unica `<rdg wit="#txt-b0">` con `<del>`/`<add>`/`<subst>` **dentro** l'apparato; `@varSeq` solo quando concorrono ≥2 `<rdg>`. Le rivergature a inchiostro (mano T3 `#ink_3-dark`) sono rese con `<retrace>`, fuori apparato.
- **Numerazione continua d'autrice**: §§1–72 sull'intero MC1 (proemio §§1–2; I §§3–12; II §§13–33; III §§34–47; IV §§48–55; V §§56–72).
- **Edizione facs-free**: `@facs` è previsto dallo schema ma non usato (le riproduzioni digitali non sono incluse).

## Riferimenti

- README del micro‑commit: [`../README.md`](../README.md)
- Dati TEI: [`../data/`](../data/) · Schema: `castello-anima-odd.rng`
- Modelli generici dell'edizione: [`../../../tei-model/`](../../../tei-model/)

---

## 👤 Curatore
**Luciano Longo**
- Contatti: <luciano.longo@dedalus.com>
- ORCID: <https://orcid.org/0009-0005-7557-7546>
- GitHub: <https://github.com/luciano-longo77>
- Website: <https://luciano-longo77.github.io>
