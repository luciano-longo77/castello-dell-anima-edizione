# Castello dell’Anima — Modello TEI per il Corpo Testuale (`<text>`)

![TEI P5](https://img.shields.io/badge/TEI-P5-blue)
![Schema](https://img.shields.io/badge/Model-semantic%20annotation-orange)
![Status](https://img.shields.io/badge/Encoding-fine--grained-brightgreen)

> **File**: `data/tei/text/castello-anima-text.xml`  
> **Scopo**: Documentare la struttura, il sistema annotativo, l'apparato genetico e le reti semantiche implementate nell'elemento `<text>`.  
> **Allineamento**: Coerente con le tassonomie e i principi editoriali dichiarati nel `teiHeader`.

---

## 🗂️ Architettura Strutturale

Il corpo testuale segue una gerarchia rigida che rispetta la tripartizione mistica dell'opera e la progressione redazionale del manoscritto:

```text
<text>
├── <front>
│   ├── <div rend="witness"> → <listWit> (7 testimoni: Tb0, Tb1, T1–T3, T4, Tc)
│   ├── <div rend="list:person"> → <listPerson>
│   ├── <div rend="list:cit-bibl"> → <listBibl> (Vulgata, Molinos, Ávila)
│   └── <titlePage> (<docTitle>, <docAuthor>)
└── <body>
    ├── <div type="book" n="1|2|3"> (Libri I, II, III)
    │   ├── <fw>, <pb> (segnaletica materiale e facsimili)
    │   ├── <head>
    │   ├── <div type="preface"> (solo Libro III)
    │   │   ├── <head> (<seg> titolario)
    │   │   └── <argument> (<p> → <seg> introduttivi)
    │   └── <div type="chapter" n="*">
    │       ├── <head>, <argument>
    │       ├── <p n="*"> (unità paragrafale editoriale)
    │       │   └── <seg> ×N (unità atomica di annotazione)
    │       └── <linkGrp> ×M (catene semantiche post-capitolo)
```

---

## 🔍 Unità di Annotazione: `<seg>` e Sistema `@ana`

Ogni segmento (`<seg>`) è la cellula minima interpretativa. È marcato con un set di attributi che ne definiscono funzione retorica, posizione materiale, rischio dottrinale e stato mistico.

### Sintassi dell'attributo `@ana`
I valori sono concatenati con punto e virgola, secondo lo schema:
```xml
ana="
  function:...;
  relation:...;
  impact:...;
  risk:...;
  certainty:...;
  mystic-state:...;
  operation:...;
  exposition:...;
  phase:...;
  layer:...;
  position:..."
```

| Categoria | Esempi di Valori | Funzione nel Modello |
|-----------|------------------|----------------------|
| `function` | `ethos-obbedienza`, `pedagogia-introduzione`, `gestione-rischio`, `ineffabilitas` | Scopo retorico-dottrinale del segmento |
| `relation` | `premessa-conseguenza`, `causa-effetto`, `intertesto-biblico`, `notte-dello-spirito` | Nesso logico o intertestuale |
| `impact` | `impact-high`, `impact-critical`, `impact-supportive`, `impact-structural` | Peso interpretativo sulla comprensione del passo |
| `risk` | `risk-dottrinale`, `risk-quietismo`, `risk-impeccabilita`, `risk-ambiguita` | Livello di esposizione teologica o ambiguità semantica |
| `mystic-state` | `unione`, `quiete`, `otium`, `purificazione`, `illuminatio` | Stato del cammino spirituale descritto |
| `operation` | `attenuatio`, `precisatio`, `declaratio`, `negatio`, `comparatio` | Strategia prudenziale o dispositivo retorico |
| `exposition` | `expo-bassa`, `expo-media`, `expo-alta`, `expo-critica` | Densità dottrinale e complessità lessicale |
| `phase` | `fase-iniziale`, `fase-mediana`, `fase-critica`, `fase-conclusiva` | Collocazione nel arco discorsivo del capitolo |
| `layer` | `hand1_ink`, `hand2_ink`, `hand3_dark`, `hand4_external` | Riferimento alla mano scrivente |
| `position` | `center`, `margin`, `interlinear`, `top`, `bottom` | Collocazione grafica nel foglio |

---

## 📐 Strati Semantici e Arricchimento

All'interno di ciascun `<seg>`, la semantica è ulteriormente stratificata tramite elementi TEI specializzati:

| Elemento | Ruolo nell'Encoding | Esempio d'Uso |
|----------|---------------------|---------------|
| `<rs>` | Segnale referente: entità teologiche, antropologiche o ruoli discorsivi | `<rs type="divinita" ana="entity:Deus; role:destinatario">mio Dio</rs>` |
| `<term>` | Tecnico mistico o categoria concettuale | `<term ana="term:quiete; categoria:mistica">quiete</term>` |
| `<figure>` | Dispositivo retorico, ethos autoriale o gesto performativo | `<figure ana="figura:autodemotio; ethos:umilta"/>` |
| `<spanGrp>` / `<span>` | Zone di focus semantico interrogabili | `<span ana="focus:cessazione-desiderio"/>` |
| `<cit>` / `<quote>` / `<foreign>` | Citazioni intertestuali (bibliche, liturgiche, mistiche) | `<cit type="bible"><quote><foreign xml:lang="la">...</foreign></quote><ref target="#Phil.2.8"/></cit>` |
| `<ptr>` / `<ref>` | Rinvii interni (capitoli, paragrafi) o esterni (opere modello) | `<ptr target="#Libro-II" ana="ptr:rinvio-interno"/>` |

---

## 📖 Apparato Genetico e Critico

Le fasi redazionali e gli interventi autoriali sono codificati *in situ* secondo la metodologia della **parallel segmentation**:

```xml
<app>
  <lem wit="#txt-c">godere</lem>
  <rdg wit="#txt-b1">
    <add place="inline" hand="#pen0" resp="#p-teresa" type="integration">godere</add>
  </rdg>
  <rdg wit="#txt-b0"/>
</app>
```

| Categoria TEI | Funzione Ecdotica |
|---------------|-------------------|
| `<app>` | Contenitore dell'apparato variantistico |
| `<lem>` | Testo base o lezione adottata nell'edizione critica |
| `<rdg>` | Varianti d'autore (Tb0, Tb1, T1, T2, T3) o interventi esterni (T4) |
| `<del>` / `<add>` / `<subst>` | Cancellature, aggiunte e sostituzioni materiali |
| `@wit` | Riferimento ai testimoni definiti in `<listWit>` |

---

## 🔗 Reti Semantiche: `<linkGrp>`

Al termine di ciascun capitolo, i segmenti sono collegati in **catene semantiche** tramite `<linkGrp>` e `<link>`. Questo modello permette di tracciare la progressione dottrinale, metaforica o epistemica oltre i confini paragrafali.

### Tipologie di Catene Implementate
| Tipo di Catena | Scopo Analitico | Esempio di `@subtype` |
|----------------|-----------------|------------------------|
| `catena-dottrinale` | Sequenza logica di concetti teologici | `notte-dello-spirito`, `croce-purificazione-pace` |
| `catena-antropologica` | Progressione delle potenze, sensi e anima | `dispositio-animae`, `concupiscibile-purgato` |
| `catena-teologica` | Relazioni tra Dio, luce, unione e grazia | `deus-sapientia-obedientia`, `lux-divina` |
| `catena-retorica` | Pattern stilistici e dispositivi persuasivi | `introductio-comparatio-exhortatio`, `assertio-conclusio` |
| `catena-epistemica` | Dinamiche conoscere/non-conoscere/ineffabile | `non-videre→non-conoscere`, `ignoranza-mistica` |
| `catena-rischi` | Nodi critici e gestione del quietismo | `patimento-interpretatio-negatio`, `quietismus-periculum` |
| `intertext` | Reti di citazioni e riferimenti modello | `scriptura`, `teresiano-molinos` |
| `metafora` | Campi figurativi ricorrenti | `sole`, `acqua`, `abbraccio`, `sonno-oblio-otio` |

### Sintassi di Collegamento
```xml
<linkGrp type="catena-dottrinale" subtype="unio-progressus" xml:id="III-cap-1-catena-unio">
  <link type="catena-dottrinale" subtype="unio-progressus"
        ana="chain-element:unio-progressus; role:istanza"
        target="#III-cap-1-p6-007 #III-cap-1-p7-007 #III-cap-1-p8-008 #III-cap-1-p8-012"/>
</linkGrp>
```

---

## 📜 Principi Editoriali

1. **Segmentazione fine**: Il testo è suddiviso in `<seg>` omogenei per unità semantica e funzione retorica.
2. **Multi-stratificazione**: Ogni segmento accumula marcatori trasversali (`@ana`, `<spanGrp>`, `<figure>`, `<term>`) per consentire interrogazioni incrociate.
3. **Fedeltà materiale**: La posizione delle glosse, il tipo di inchiostro e le fasi di scrittura sono preservati tramite `@hand`, `@layer` e `@position`.
4. **Apparato in situ**: Le varianti sono codificate nel flusso testuale, mantenendo visibile la dinamica genetica del manoscritto.
5. **Reti esplicite**: Le relazioni semantiche sono formalizzate tramite `<linkGrp>`, rendendo la struttura dottrinale machine-actionable.

---



