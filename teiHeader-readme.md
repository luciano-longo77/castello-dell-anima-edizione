# 🏰 Castello dell'Anima — Edizione Digitale TEI

![TEI P5](https://img.shields.io/badge/TEI-P5-blue)
![License](https://img.shields.io/badge/License-CC%20BY--NC%204.0-lightgrey)
![Status](https://img.shields.io/badge/Status-Consolidated-brightgreen)
![Lang](https://img.shields.io/badge/Language-it--reg--sic%20%7C%20la-orange)

> **File**: `data/tei/header/castello-anima-teiHeader.xml`  
> **Schema**: TEI P5 + ODD custom (`1_ODD/castello-anima.odd`)  
> **Testimone**: ms. 2 Qq E 29, Biblioteca Comunale di Palermo

---

## 📖 Abstract

Il *Castello dell’anima* è l’unica opera pervenutaci della terziaria carmelitana palermitana **Teresa di San Geronimo** (nata Anna La Longa, 1670–post 1703). Redatto tra il 1692 e il 1703 in un italiano regionale siciliano fortemente influenzato dal latino liturgico, il trattato si inserisce nella tradizione della teologia mistica post-tridentina, mostrando affinità con i modelli di Teresa d’Ávila, Giovanni della Croce e le correnti di spiritualità contemporanea.

Questa edizione digitale adotta il modello **TEI P5** per:
- 🧾 Documentare la materialità del manoscritto autografo (mani, inchiostri, ductus, interventi marginali)
- 🔍 Rendere interrogabili le strategie prudenziali dell'autrice (attenuationes, declarationes, precisazioni)
- 📐 Implementare un sistema di annotazione semantica stratificata tramite l'attributo `@ana`
- 📊 Applicare una metrica euristica di impatto interpretativo (formula N/A/F) per segmenti critici
- 🔄 Tracciare il workflow editoriale e le fasi di revisione critica nel `<revisionDesc>`

---

## 🗂️ Struttura del Repository

```
castello-anima-edition/
├── README.md
├── LICENSE
├── CITATION.cff
├── data/
│   ├── tei/
│   │   ├── header/castello-anima-teiHeader.xml
│   │   └── text/libro-{I,II,III}.xml
│   ├── mets.xml
│   └── config/workflow.json
├── schema/1_ODD/castello-anima.odd
├── facsimiles/ (JPEG + manifest)
├── xslt/tei-to-html.xsl
├── css/edition.css
├── scripts/validate-tei.sh
└── docs/
    ├── editorial-principles.md
    ├── taxonomies.md
    └── workflow-guide.md
```

---

## 🌳 Struttura del `teiHeader` (Scheletro TEI)

```text
<TEI>
└── <teiHeader>
    ├── <fileDesc>
    │   ├── <titleStmt>
    │   │   ├── <title/>
    │   │   ├── <author>
    │   │   │   ├── <name type="religious"/>
    │   │   │   └── <name type="secular"/>
    │   │   └── <respStmt>
    │   │       ├── <resp/>
    │   │       └── <name/>
    │   ├── <publicationStmt>
    │   │   ├── <publisher/>
    │   │   ├── <date/>
    │   │   ├── <idno/>
    │   │   └── <availability>
    │   │       ├── <p/>
    │   │       └── <licence/>
    │   ├── <notesStmt>
    │   │   ├── <noteGrp type="critical">
    │   │   │   ├── <note type="material"><p/></note>
    │   │   │   ├── <note type="prudential"><p/></note>
    │   │   │   ├── <note type="linguistic"><p/></note>
    │   │   │   ├── <note type="theological-risk"><p/></note>
    │   │   │   ├── <note type="transmission"><p/></note>
    │   │   │   └── <note type="stylistic"><p/></note>
    │   │   ├── <noteGrp type="biographical">
    │   │   │   ├── <note type="biography-early"><p/></note>
    │   │   │   └── <note type="biography-late"><p/></note>
    │   │   └── <noteGrp type="contextual">
    │   │       ├── <note type="contextual-biographical"><p/></note>
    │   │       └── <note type="contextual-historical"><p/></note>
    │   └── <sourceDesc>
    │       ├── <listPlace>
    │       │   └── <place>
    │       │       ├── <placeName/>
    │       │       └── <note/>
    │       ├── <bibl type="ms">
    │       │   ├── <settlement/>
    │       │   ├── <affiliation/>
    │       │   ├── <idno/>
    │       │   ├── <date/>
    │       │   └── <title/>
    │       ├── <msDesc>
    │       │   ├── <msIdentifier>
    │       │   │   ├── <country><name/></country>
    │       │   │   ├── <region><name/></region>
    │       │   │   ├── <settlement><name/></settlement>
    │       │   │   ├── <institution/>
    │       │   │   ├── <repository/>
    │       │   │   └── <altIdentifier><idno/></altIdentifier>
    │       │   ├── <msContents>
    │       │   │   ├── <msItem n="I">
    │       │   │   │   ├── <author/>
    │       │   │   │   ├── <title/>
    │       │   │   │   ├── <incipit><locus/><seg/></incipit>
    │       │   │   │   ├── <explicit><locus/><seg/></explicit>
    │       │   │   │   └── <textLang/>
    │       │   │   └── <!-- msItem II e III con stessa struttura -->
    │       │   ├── <physDesc>
    │       │   │   ├── <objectDesc>
    │       │   │   │   ├── <supportDesc>
    │       │   │   │   │   ├── <support><p><material/><date/></p></support>
    │       │   │   │   │   ├── <extent><dimensions><height/><width/></dimensions></extent>
    │       │   │   │   │   └── <condition><p/></condition>
    │       │   │   │   └── <layoutDesc>
    │       │   │   │       └── <layout><p/></layout>
    │       │   │   └── <handDesc>
    │       │   │       ├── <handNote xml:id="ink_1"><p/></handNote>
    │       │   │       ├── <handNote xml:id="ink_2"><p/></handNote>
    │       │   │       ├── <handNote xml:id="ink_3-dark"><p/></handNote>
    │       │   │       └── <handNote xml:id="ink_4-external"><p/></handNote>
    │       │   ├── <history>
    │       │   │   └── <origin>
    │       │   │       └── <p>
    │       │   │           ├── <origPlace><placeName/></origPlace>
    │       │   │           ├── <origDate/>
    │       │   │           └── <note/>
    │       │   └── <additional>
    │       │       └── <surrogates><p/></surrogates>
    │       ├── <listBibl>
    │       │   └── <bibl/>
    │       └── <listWit>
    │           └── <witness/>
    ├── <encodingDesc>
    │   ├── <ab xml:base="abstract">
    │   │   └── <seg/>
    │   ├── <projectDesc>
    │   │   ├── <p ana="#validazione"/>
    │   │   └── <!-- altri paragrafi di workflow editoriale -->
    │   ├── <refsDecl>
    │   │   └── <p/>
    │   ├── <editorialDecl>
    │   │   ├── <p/>
    │   │   ├── <correction><p/></correction>
    │   │   ├── <hyphenation><p/></hyphenation>
    │   │   ├── <normalization><p/></normalization>
    │   │   └── <interpretation>
    │   │       └── <ab>
    │   │           ├── <hi/>
    │   │           └── <list><item><label/><p/></item></list>
    │   ├── <tagsDecl>
    │   │   └── <namespace>
    │   │       └── <tagUsage gi="TEI"/> <!-- + altri tagUsage -->
    │   ├── <variantEncoding/>
    │   ├── <classDecl>
    │   │   ├── <taxonomy xml:id="func">
    │   │   │   └── <category><desc/></category> <!-- + categorie annidate -->
    │   │   └── <!-- altre tassonomie: impact, risk, mystic_state, operation, ecc. -->
    │   └── <schemaRef/>
    ├── <profileDesc>
    │   ├── <langUsage>
    │   │   ├── <language ident="it-reg-sic"/>
    │   │   └── <language ident="la"/>
    │   └── <particDesc>
    │       ├── <listPerson>
    │       │   └── <person xml:id="Anna-La-Longa">
    │       │       ├── <persName><forename/><surname/></persName>
    │       │       ├── <birth/>
    │       │       ├── <death/>
    │       │       ├── <sex/>
    │       │       ├── <occupation/>
    │       │       ├── <trait><note/></trait>
    │       │       └── <note/>
    │       └── <listOrg>
    │           └── <org xml:id="controllo_workflow">
    │               ├── <name/>
    │               └── <trait><note/></trait>
    ├── <xenoData>
    │   └── <!-- JSON metadata configurazione workflow -->
    ├── <xenoData type="mets">
    │   └── <!-- puntatore a pacchetto METS -->
    └── <revisionDesc status="consolidated">
        └── <change when="" who="" ana="">
            <!-- descrizione del cambiamento editoriale -->
```

---

## 📑 Dettaglio delle Sezioni

### 1. `<fileDesc>` — Metadati e Descrizione del Testimone
- **Autore**: `Anna La Longa` (nome secolare) / `Teresa di San Geronimo` (nome religioso)
- **Note (`notesStmt`)**: Raggruppate in tre macro-aree:
  - `critical`: analisi materiale, strategie prudenziali, instabilità linguistiche, rischi teologici, trasmissione e stile
  - `biographical`: fasi giovanili e tardive della vita dell'autrice
  - `contextual`: inserimento nel panorama mistico siciliano e nel contesto inquisitoriale
- **Descrizione manoscritto (`msDesc`)**:
  - Struttura in 3 Libri (`msItem n="I|II|III"`) con incipit/explicit puntuali
  - Supporto cartaceo, formato 20.5×19 cm, 1 colonna, 40 righe
  - **Mani (`handDesc`)**: `ink_1` (stesura base), `ink_2` (glosse Libro III), `ink_3-dark` (interventi tardivi), `ink_4-external` (note non autografe)
  - **Testimoni genetici (`listWit`)**: `Tb0` (base), `Tb1` (ripensamenti), `T1-T3` (stratificazione autografa), `T4` (esterno), `Tc` (edizione critica)

### 2. `<encodingDesc>` — Dichiarazione di Codifica
- **Principi editoriali**: Trascrizione semidiplomatica, conservazione di oscillazioni grafiche e interpunzione. Apparato critico in *parallel segmentation* (`<app>/<lem>/<rdg>`).
- **Normalizzazione**: Interventi minimi tramite `<orig>/<reg>`, `<sic>/<corr>`, `<abbr>/<expan>`. Sillabazione mantenuta solo se rilevante.
- **Metrica di Impatto (`interpretation`)**: Formula euristica `I = 0.40×N + 0.35×A + 0.25×F` per valutare necessità interpretativa, riduzione ambiguità e funzione prudenziale.
- **Tassonomie (`classDecl`)**: 12 categorie semantiche per l'attributo `@ana`:
  `func`, `impact`, `risk`, `mystic_state`, `operation`, `exposition`, `phase`, `relation`, `certainty`, `position`, `fase`, `workflow`

### 3. `<profileDesc>` — Profilo Linguistico e Partecipanti
- **Lingue**: 
  - `it-reg-sic`: Italiano regionale siciliano XVII sec. (fenomeni fonetici, morfologici, lessicali e sintattici documentati)
  - `la`: Latino liturgico e biblico per citazioni e formule dottrinali
- **Persone (`listPerson`)**: Autrice storica, entità scrivente, mano esterna, fonti dottrinali (Ávila, Giovanni della Croce, Molinos), direttore spirituale, editore, controllore qualità.
- **Organizzazioni (`listOrg`)**: Biblioteca Comunale di Palermo, Ordine del Carmelo, Sant’Uffizio, modulo di controllo workflow editoriale.

### 4. `<xenoData>` & `<revisionDesc>`
- Configurazione tecnica del workflow di validazione e metadati strutturali in formato JSON.
- Registro cronologico delle modifiche editoriali, allineamento tassonomico, verifiche filologiche e consolidamento strutturale (`status="consolidated"`).

---

## ⚙️ Validazione e Uso

### Prerequisiti
- Validatore TEI P5 (Jing, Oxygen XML Editor, o `tei-lite.rng`)
- Parser XML con supporto namespace TEI

### Validazione Locale
```bash
# Con Jing (RelaxNG)
java -jar jing.jar \
  http://www.tei-c.org/release/xml/tei/custom/schema/relaxng/tei_all.rng \
  data/tei/header/castello-anima-teiHeader.xml

# Con xmllint (validazione base)
xmllint --noout data/tei/header/castello-anima-teiHeader.xml
```

### Query Esempio (XPath)
```xpath
//seg[@ana[contains(., 'risk-quietismo')]]
//handNote[@xml:id='ink_3-dark']/p
//change[@who='#editor']/text()
//taxonomy[@xml:id='func']//category/desc
```

---

## 📜 Licenza e Citazione

### Licenza
```
© 2026 Luciano Longo (Editor)

Questa edizione TEI e la documentazione associata sono rilasciate con licenza
Creative Commons BY-NC 4.0: uso consentito con attribuzione, senza fini commerciali.
Le immagini del manoscritto sono proprietà della Biblioteca Comunale di Palermo
e consultabili solo in modalità off-line autorizzata.
```

### Citazione accademica
```bibtex
@dataset{longo2026castello,
  author = {La Longa, Anna and Longo, Luciano},
  title = {Castello dell'anima — Edizione digitale TEI},
  year = {2026},
  publisher = {GitHub},
  url = {https://github.com/tuo-username/castello-anima-edition},
  note = {Manoscritto autografo: Palermo, Biblioteca Comunale, ms. 2 Qq E 29}
}
```

---

## 🔗 Risorse

- 📜 [Linee guida TEI P5](https://tei-c.org/release/doc/tei-p5-doc/it/html/)
- 🗃️ [Scheda manoscritto](https://opac.comune.palermo.it) (Biblioteca Comunale di Palermo)
- 📬 Contatti: [luciano.longo@example.org](mailto:luciano.longo@example.org)

---
