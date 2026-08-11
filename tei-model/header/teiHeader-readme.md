# Modello del `teiHeader` (Libro III)
## Micro‑progetto di Edizione Critica Digitale
**Edizione critica digitale del *Castello dell’anima*** **ms. Palermo, BCP, 2 Qq E 29**

![TEI P5](https://img.shields.io/badge/TEI-P5-blue)
![License](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey)
![Status](https://img.shields.io/badge/Status-Consolidated-brightgreen)
![Lang](https://img.shields.io/badge/Language-it--reg--sic%20%7C%20la-orange)

> **File**: `castello-anima-teiHeader-model.xml`  
> **Schema**: TEI P5 + ODD custom (`MC-1_castello-anima-odd.odd` → `.rng`)  
> **Testimone**: ms. 2 Qq E 29, Biblioteca Comunale di Palermo

---

## Abstract

Il *Castello dell'anima* è l'unica opera pervenutaci della terziaria carmelitana palermitana **Teresa di San Geronimo** (nata Anna La Longa, 1670–post 1703). Redatto tra il 1692 e il 1703 in un italiano regionale siciliano fortemente influenzato dal latino liturgico, il trattato si inserisce nella tradizione della teologia mistica post-tridentina, mostrando affinità con i modelli di Teresa d'Ávila, Giovanni della Croce e le correnti di spiritualità contemporanea.

Questo file descrive il **modello del `teiHeader`**: non il testo trascritto capitolo per capitolo, ma la struttura formale che lo sostiene. Il modello adotta un'architettura **leggera a tre layer**:

- **Layer filologico-grafico** — struttura, trascrizione a due livelli (`<choice>`) e apparato genetico (`<app>`/`<lem>`/`<rdg>`)
- **Layer mistico-dottrinale** — lessico agganciato via `<term ref>` a un **vocabolario controllato degli stati mistici**
- **Layer intertestuale** — citazioni e rimandi alle fonti (`<cit>`/`<quote>`/`<bibl>`, `<ref>`)

> **Nota sullo scope.** L'annotazione interpretativa multiassiale (le otto tassonomie su `@ana`, la segmentazione retorica con `<seg>`/`<figure>`, l'indice d'impatto `I = 0.40N + 0.35A + 0.25F`) **non** fa parte di questo header: è sviluppata nel repository separato [`castello-anima-TEI-IA`](https://github.com/luciano-longo77/castello-anima-TEI-IA). Qui l'header resta descrittivo + interpretativo *leggero* (un solo asse: `term/@ref` → stati).

---

## Struttura del `teiHeader` (scheletro TEI)

```text
<TEI>
└── <teiHeader>
    ├── <fileDesc>
    │   ├── <titleStmt>
    │   │   ├── <title/>
    │   │   ├── <author>
    │   │   │   ├── <name type="religious"/>   (Teresa di San Geronimo)
    │   │   │   └── <name type="secular"/>      (Anna La Longa)
    │   │   └── <respStmt> (<resp/>, <name/>)
    │   ├── <publicationStmt>
    │   │   ├── <publisher/>, <date/>, <idno/>
    │   │   └── <availability> (<p/>, <licence/> CC BY 4.0)
    │   ├── <notesStmt>
    │   │   ├── <noteGrp type="critical">        (material, prudential, linguistic,
    │   │   │                                     theological-risk, transmission, stylistic)
    │   │   ├── <noteGrp type="biographical">    (biography-early, biography-late)
    │   │   └── <noteGrp type="contextual">      (contextual-biographical, contextual-historical)
    │   └── <sourceDesc>
    │       ├── <listPlace> (<place>)
    │       ├── <bibl type="ms">
    │       ├── <msDesc>
    │       │   ├── <msIdentifier> (country, region, settlement, institution, repository, altIdentifier)
    │       │   ├── <msContents>
    │       │   │   ├── <msItem n="I">   (author, title, incipit, explicit, textLang)
    │       │   │   └── <!-- msItem II e III con stessa struttura -->
    │       │   ├── <physDesc>
    │       │   │   ├── <objectDesc> (supportDesc: support/extent/condition; layoutDesc)
    │       │   │   └── <handDesc>   (5 mani, vedi sotto)
    │       │   │       ├── <handNote xml:id="ink_1"/>          (bruno, stesura base)
    │       │   │       ├── <handNote xml:id="ink_2"/>          (bruno, glosse Libro III)
    │       │   │       ├── <handNote xml:id="ink_3-dark"/>     (scuro, interventi tardivi)
    │       │   │       ├── <handNote xml:id="pencil_1"/>       (matita, stessa fase T3)
    │       │   │       └── <handNote xml:id="ink_4-external"/> (mano esterna non autografa)
    │       │   ├── <history> (<origin>)
    │       │   └── <additional> (<surrogates>)
    │       ├── <listBibl type="fontes">   (Vulgata, Molinos, Ávila)
    │       ├── <listBibl>                 (fonte primaria + descrizione ms.)
    │       └── <listWit>                  (7 livelli: Tb0, Tb1, T1–T3, T4, Tc)
    ├── <encodingDesc>
    │   ├── <ab xml:base="abstract"> (<seg/>)
    │   ├── <projectDesc>            (i tre layer: filologico-grafico, mistico-dottrinale, intertestuale)
    │   ├── <refsDecl> (<p/>)
    │   ├── <editorialDecl>
    │   │   ├── <p/>  (trascrizione semidiplomatica a due livelli via <choice>)
    │   │   ├── <correction><p/></correction>
    │   │   ├── <hyphenation><p/></hyphenation>
    │   │   └── <normalization><p/></normalization>
    │   ├── <tagsDecl> (<namespace> → tag set core dei tre layer)
    │   ├── <variantEncoding method="parallel-segmentation" location="internal"/>
    │   ├── <classDecl>
    │   │   ├── <taxonomy xml:id="stati-mistici">  (vocabolario controllato → term/@ref)
    │   │   └── <taxonomy xml:id="fase">           (tassonomia di lavoro → revisionDesc)
    │   └── <schemaRef/>
    ├── <profileDesc>
    │   ├── <langUsage> (it-reg-sic, la)
    │   └── <particDesc>
    │       ├── <listPerson> (<person xml:id="Anna-La-Longa"> + fonti, direttore, curatore)
    │       └── <listOrg>    (BCP, Carmelo, Sant'Uffizio)
    ├── <xenoData n="mets">  (puntatore a pacchetto METS)
    └── <revisionDesc status="consolidated">
        └── <change when="" who="" ana="#fase-…">
```

---

## Dettaglio delle sezioni

### 1. `<fileDesc>` — metadati e descrizione del testimone
- **Autrice**: `Anna La Longa` (nome secolare) / `Teresa di San Geronimo` (nome religioso).
- **Note (`notesStmt`)**: raggruppate in tre macro-aree —
  - `critical`: analisi materiale, strategie prudenziali, instabilità linguistiche, rischi teologici, trasmissione e stile;
  - `biographical`: fasi giovanili e tardive della vita dell'autrice;
  - `contextual`: inserimento nel panorama mistico siciliano e nel contesto inquisitoriale.
- **Descrizione manoscritto (`msDesc`)**:
  - struttura in 3 Libri (`msItem n="I|II|III"`) con incipit/explicit puntuali;
  - supporto cartaceo, formato 20.5×19 cm, 1 colonna, 40 righe;
  - **Mani (`handDesc`)**: **cinque** mani/fasi — quattro autografe di Teresa (`ink_1` e `ink_2` a inchiostro bruno, `ink_3-dark` a inchiostro scuro, `pencil_1` a matita) più la mano esterna `ink_4-external`, corrispondenti alla stratificazione genetica Tb0–T4;
  - **Testimoni genetici (`listWit`)**: **sette** livelli — `txt-b0` (Tb0, base), `txt-b1` (Tb1, ripensamenti immediati), `txt-1`/`txt-2`/`txt-3` (T1–T3, stratificazione autografa), `txt-4` (T4, esterno) e `txt-c` (Tc, testo critico costituito, `@resp="#editor"`, richiamato da `<lem wit="#txt-c">`).

### 2. `<encodingDesc>` — dichiarazione di codifica
- **Tre layer (`projectDesc`)**: (1) filologico-grafico — struttura, trascrizione a due livelli, apparato genetico; (2) mistico-dottrinale — `term/@ref` al vocabolario controllato; (3) intertestuale — `cit`/`quote`/`bibl` e `ref`.
- **Principi editoriali (`editorialDecl`)**: trascrizione semidiplomatica, conservazione di oscillazioni grafiche e interpunzione; nessuna normalizzazione oltre quella dichiarata e reversibile via `<choice>` (`<orig>`/`<reg>`, `<abbr>`/`<expan>`, `<sic>`/`<corr>`). Apparato critico in *parallel segmentation* (`<app>`/`<lem>`/`<rdg>` con `@varSeq`).
- **Tag set core (`tagsDecl`)**: elenca **esattamente** gli elementi impiegati, raggruppati per layer (struttura, front matter, trascrizione a due livelli, apparato genetico, lessico mistico, intertesto, nomi/identificatori). Sono **fuori** dal tag set gli elementi dell'annotazione interpretativa multiassiale (`seg`/`@ana`, `figure`, `interp`).
- **Vocabolario controllato (`classDecl`)**: un solo asse per il testo, `taxonomy xml:id="stati-mistici"`, i cui `@xml:id` sono i bersagli di `term/@ref`. Accanto, la sola tassonomia di lavoro `taxonomy xml:id="fase"`, che descrive il **workflow editoriale** ed è usata da `revisionDesc`.

| Categoria (`xml:id`) | Stato mistico |
|---|---|
| `silentio` | Silentio (primo stato d'unione) |
| `otio` | Otio / quiete passiva |
| `oblivione-sonno` | Oblivione o sonno |
| `scordanza` | Scordanza del creato e di sé |
| `indifferenza` | Indifferenza (unione delle volontà) |
| `notte` | Notte dello spirito |
| `purga` | Purga / purificazione passiva |
| `unione` | Unione con Dio |
| `quiete` | Quiete |
| `contemplazione-infusa` | Contemplazione infusa |
| `nudita-anima`, `bacio`, `matrimonio-spirituale`, `cella-secreta`, `trasformazione`, `deificazione` | Stati delle celle superiori del Libro III |

### 3. `<profileDesc>` — profilo linguistico e partecipanti
- **Lingue**: `it-reg-sic` (italiano regionale siciliano XVII sec.) e `la` (latino liturgico e biblico per citazioni e formule).
- **Persone (`listPerson`)**: autrice storica, fonti dottrinali (Ávila, Giovanni della Croce, Molinos), direttore spirituale, mano esterna, curatore.
- **Organizzazioni (`listOrg`)**: Biblioteca Comunale di Palermo (`BCP`), Ordine del Carmelo (`Carmelo`), Sant'Uffizio (`SantUffizio`).

### 4. `<xenoData>` & `<revisionDesc>`
- `xenoData n="mets"`: puntatore ai metadati strutturali del pacchetto METS.
- `revisionDesc status="consolidated"`: registro cronologico degli interventi editoriali, ciascuno classificato secondo la tassonomia di lavoro `fase`.

---

## Validazione e uso

### Prerequisiti
- Validatore TEI P5 (Jing, oXygen XML Editor) o lo schema ODD di progetto (`.rng`)
- Parser XML con supporto namespace TEI

### Validazione locale
```bash
# Buona formazione
xmllint --noout castello-anima-teiHeader-model.xml

# Validazione contro lo schema ODD di progetto (RELAX NG + Schematron)
java -jar jing.jar MC-1_castello-anima-odd.rng castello-anima-teiHeader-model.xml
```

### Query esempio (XPath)
```xpath
//handNote[@xml:id='ink_3-dark']/p
//taxonomy[@xml:id='stati-mistici']//category/@xml:id
//witness/@xml:id
//change[contains(@ana, 'fase')]
```

---

## Licenza e citazione

### Licenza
```
© 2026 Luciano Longo (Editor)

Questa edizione TEI e la documentazione associata sono rilasciate con licenza
Creative Commons BY 4.0: uso e riuso consentiti, anche a fini commerciali, con attribuzione.
Le riproduzioni digitali del manoscritto sono proprietà della Biblioteca Comunale di Palermo
e consultabili solo in modalità off-line autorizzata.
```

### Citazione accademica
```bibtex
@dataset{longo2026castello,
  author = {La Longa, Anna and Longo, Luciano},
  title = {Castello dell'anima — Edizione digitale TEI},
  year = {2026},
  publisher = {GitHub},
  url = {https://github.com/luciano-longo77/castello-dell-anima-edizione},
  note = {Manoscritto autografo: Palermo, Biblioteca Comunale, ms. 2 Qq E 29}
}
```

---

## Risorse

- [Linee guida TEI P5](https://tei-c.org/release/doc/tei-p5-doc/it/html/)
- [Scheda manoscritto](https://opac.comune.palermo.it) (Biblioteca Comunale di Palermo)
- [`castello-anima-TEI-IA`](https://github.com/luciano-longo77/castello-anima-TEI-IA) — sperimentazione multiassiale e IA (fuori scope di questo header)

---

## 👤 Curatore
**Luciano Longo**
- Contatti: <luciano.longo@dedalus.com>
- ORCID: <https://orcid.org/0009-0005-7557-7546>
- GitHub: <https://github.com/luciano-longo77>
- Website: <https://luciano-longo77.github.io>
