# (MC1) Micro‑progetto di Edizione Critica Digitale
## `<text>` — Libro III, Capitoli I–V
**Edizione critica digitale del *Castello dell’anima*** **ms. Palermo, BCP, 2 Qq E 29**

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey?logo=creativecommons)](https://creativecommons.org/licenses/by/4.0/)
![TEI P5](https://img.shields.io/badge/TEI-P5-blueviolet?logo=xml)
![Micro-commit](https://img.shields.io/badge/Micro--commit-MC1-informational)
![Libro III](https://img.shields.io/badge/Libro%20III-capp.%20I%E2%80%93V-blue)
![Carte: 158r–168r](https://img.shields.io/badge/carte-158r%E2%80%93168r-556B2F)
![Status](https://img.shields.io/badge/status-validato-brightgreen)

## A cosa serve questo documento

Questo file spiega **cosa contiene il file dati `castello-anima-text.xml`** (il testo trascritto del Libro III, capp. I–V) e **come è codificato**. È il complementare di [`Header-README.md`](Header-README.md): quello descrive il `teiHeader` (il modello descrittivo e interpretativo), questo il `<text>` (il contenuto trascritto capitolo per capitolo).

Sul piano fisico i due file restano **separati**: `castello-anima-text.xml` richiama l’header via `<xi:include href="TEI-Header.xml" xpointer="element(/1/1)"/>`, così l’header è modellato una sola volta e i puntatori del testo (`@wit`, `@hand`, `@ref`, `@target`) risolvono a validazione agli `xml:id` dichiarati nell’header (con l’elaborazione XInclude attiva in oXygen).

> **File**: `castello-anima-text.xml` (dati) · include `TEI-Header.xml` via XInclude
> **Schema**: TEI P5 + ODD di progetto (`castello-anima-odd.odd` → `.rng`)
> **Testimone**: ms. 2 Qq E 29, Biblioteca Comunale di Palermo
> **Estensione**: proemio + capp. I–V, cc. 158r–168r (21 `<pb>`), §§ 1–72

## Cartulazione e struttura del Libro III

- **Fascia materiale**: cc. **158r–168r** (21 facciate; i `<pb>` sono monotòni, senza salti né duplicati).
- **Numerazione continua d’autrice**: §§ **1–72** sull’intero MC‑1, senza azzerarsi a inizio capitolo — proemio §§1–2 · I §§3–12 · II §§13–33 · III §§34–47 · IV §§48–55 · V §§56–72.
- L’autorità sulla cartulazione (tabella topografica, carte condivise ai confini) è [`Struttura-cartulazione.md`](Struttura-cartulazione.md).

## Modello a tre layer

Il corpo testuale adotta lo **stesso profilo leggero del `teiHeader`**, articolato in tre layer:

1. **Filologico-grafico** — struttura (`div`/`head`/`argument`/`p`, `pb`/`lb`/`fw`), trascrizione a due livelli (`<choice>`) e apparato genetico (`<app>`/`<lem>`/`<rdg>` con `<del>`/`<add>`/`<subst>` dentro l’apparato), le rivergature a inchiostro (`<retrace>`) e i guasti materiali (`<unclear>`/`<gap>`/`<supplied>`).
2. **Mistico-dottrinale** — lessico agganciato via `<term ref="…">` al **vocabolario controllato degli stati** dichiarato nel `teiHeader` (`taxonomy xml:id="stati-mistici"`).
3. **Intertestuale** — citazioni e rimandi alle fonti (`<cit>`/`<quote>`/`<foreign>`/`<bibl>`, `<ref target="…">`).

> **Nota sullo scope.** L’annotazione interpretativa multiassiale (`<seg>` con `@ana`, `<figure>`, `<spanGrp>`/`<span>`, `<rs>`, le catene semantiche `<linkGrp>`/`<link>` e l’indice d’impatto) **non** fa parte di questo modello: l’edizione adotta un modello leggero e tiene fuori tale sperimentazione interpretativa e computazionale. Qui **l’unità di riferimento è il paragrafo `<p n="…">`**, non il `<seg>`.

---

## Architettura strutturale

In MC‑1 il `<body>` contiene **solo il Libro III** (i Libri I–II non sono trascritti in questo commit); il proemio è reso come `<div type="preface">`, i capitoli come `<div type="chapter">`.

```text
<text>
├── <front>
│   └── <titlePage> (<docTitle>/<titlePart>, <docAuthor>)
│       <!-- listWit / listPerson / listBibl NON stanno nel <front>:
│            sono dichiarati una sola volta nel teiHeader; qui si puntano via @wit/@ref -->
└── <body>
    └── <div type="book" n="3" xml:id="Libro-III">        (Libro III — l'unico presente in MC-1)
        ├── <head>, <fw>, <pb>, <lb>   (segnaletica materiale: foliazione e cambi-riga; facs-free)
        ├── <div type="preface" xml:id="III-proem">        (Proemio, §§1–2; il preface non usa <argument>)
        │   ├── <head>Proemio</head>
        │   └── <p n="1"/>, <p n="2"/>
        └── <div type="chapter" n="1..5" xml:id="III-capN">
            ├── <head>, <argument>
            └── <p n="*" xml:id="*">   ← unità di riferimento
                ├── layer 1: <choice> (orig/reg, abbr/expan, sic/corr)
                ├── layer 1: <lb>, <retrace>, <unclear>/<gap>/<supplied>
                ├── layer 1: <app> (<lem wit="#txt-c"/>, <rdg wit="#txt-b0"> con <del>/<add>/<subst>)
                ├── layer 2: <term ref="#…"/>
                └── layer 3: <ref target="#…"/>, <cit>/<quote>/<foreign>/<bibl>
```

---

## Layer 1 — filologico-grafico

### Trascrizione a due livelli (`<choice>`)
La lezione diplomatica e la sua regolarizzazione coesistono, senza che l’una sostituisca l’altra (in MC‑1 se ne contano 670 coppie: 581 `orig`/`reg`, 30 `abbr`/`expan`, 59 `sic`/`corr`):

```xml
<choice>
    <orig>à</orig>
    <reg>a</reg>
</choice>              <!-- grafia originale ⇄ regolarizzata -->

<choice>
    <abbr>dunq</abbr>
    <expan>dunque</expan>
</choice>  <!-- abbreviazione ⇄ scioglimento -->

<choice>
    <sic>ad</sic>
    <corr>al</corr>
</choice>            <!-- lezione erronea ⇄ correzione editoriale -->
```

### Fenomeni materiali e correzioni autoriali
Dentro l’apparato (`<app>`): `<del>` (cancellature), `<add>` (aggiunte marginali/interlineari, con `@place`/`@hand`/`@resp`), `<subst>` (sostituzione come evento unico). Inline, **fuori** dall’apparato: `<retrace>` (rivergatura a inchiostro, mano `#ink_3-dark`, testo invariato; 18 occorrenze in MC‑1), `<unclear>`, `<gap>`, `<supplied>` (25 integrazioni editoriali per lacuna).

### Apparato genetico d’autrice (« currente calamo »)
Ogni `<app>` (50 in MC‑1) ha un `<lem wit="#txt-c">` e **una sola** `<rdg wit="#txt-b0">`, con `<del>`/`<add>`/`<subst>` **dentro** la lettura; `@varSeq` si usa **solo** quando concorrono ≥2 `<rdg>` (0 casi in MC‑1). I blocchi marginali sono una `<rdg>` con `<add>` senza `<subst>`.

```xml
<app>
  <lem wit="#txt-c">…</lem>                       <!-- Tc: testo critico costituito (lemma) -->
  <rdg wit="#txt-b0">                              <!-- Tb0: strato genetico d'autrice -->
    <subst>
      <del hand="#ink_1" resp="#s-teresa">…</del>
      <add hand="#ink_1" resp="#s-teresa">…</add>
    </subst>
  </rdg>
</app>
```

I `@wit` puntano ai testimoni dichiarati **una sola volta nel `teiHeader`** (`sourceDesc/listWit`); nel `<text>` non si ridichiara la lista, si punta soltanto via `@wit`:

| `xml:id` | Livello genetico |
|---|---|
| `txt-b0` | Tb0 — testo base |
| `txt-b1` | Tb1 — interventi immediati |
| `txt-1` | T1 — riscrittura su testo base |
| `txt-2` | T2 — interventi correttivi-glossativi |
| `txt-3` | T3 — interventi correttivi successivi |
| `txt-4` | T4 — interventi glossativi esterni |
| `txt-c` | Tc — testo critico costituito (`@resp="#editor"`), lemma dell’edizione |

Le mani (`@hand`) rinviano ai `<handNote>` del `teiHeader` (`#ink_1`, `#ink_2`, `#ink_3-dark`, `#pencil_1`, `#ink_4-external`).

---

## Layer 2 — mistico-dottrinale

Il lessico degli stati mistici è isolato da `<term ref="…">`, agganciato al vocabolario controllato del `teiHeader` (in MC‑1: 139 `term/@ref` che risolvono a 14 dei 17 stati dichiarati):

```xml
<term ref="#unione">unione</term>
<term ref="#notte">notte dello spirito</term>
```

Questo consente di isolare *tutte* le occorrenze di uno stato (p. es. l’unione) indipendentemente dal capitolo. I termini di lessico non-stato restano `<term>` nudi.

---

## Layer 3 — intertestuale

```xml
<ref target="#avila-castello"/>   <!-- rimando a fonte -->
<cit>
  <quote xml:lang="lat"><foreign xml:lang="lat">…</foreign></quote>
  <bibl corresp="#bible-vulgate"/>
</cit>
```

I bersagli (`#bible-vulgate`, `#molinos-guida`, `#avila-castello`) sono dichiarati in `<listBibl type="fontes">` **nel `teiHeader`** (`sourceDesc`).

---

## Principi editoriali

1. **Unità di riferimento = paragrafo**: il testo è strutturato in `<p n="…">`; non si usa `<seg>` come unità di annotazione interpretativa.
2. **Trascrizione diplomatico-conservativa a due livelli**: nessuna normalizzazione oltre quella dichiarata e reversibile via `<choice>`.
3. **Apparato in situ**: le varianti genetiche sono codificate nel flusso testuale (parallel segmentation).
4. **Fedeltà materiale**: posizione, mano e fase sono preservate tramite `@place`/`@hand`/`@resp` su `<del>`/`<add>`/`<subst>` (dentro `<app>`) e su `<retrace>`, e tramite `<pb>`/`<lb>`/`<fw>`. Edizione **facs-free**: nessun `@facs` (immagini non autorizzate).
5. **Aggancio controllato**: `term/@ref` e `ref/@target` puntano solo a identificatori dichiarati nel `teiHeader`.

---

## Validazione

Header e testo sono file separati uniti via XInclude: la validazione ha senso **solo sul documento risolto** (header + text), quando i puntatori del testo trovano gli `xml:id` dell’header.

```bash
# buona formazione con risoluzione dell'XInclude (il <text> include il teiHeader)
xmllint --noout --xinclude castello-anima-text.xml
# validazione RELAX NG (+ Schematron incorporato) sul documento risolto
xmllint --nofixup-base-uris --xinclude castello-anima-text.xml > resolved.xml
jing castello-anima-odd.rng resolved.xml
```

Il file dati dichiara l’associazione allo schema in testa, con due PI verso lo stesso RNG (RELAX NG e Schematron):

```xml
<?xml-model href="castello-anima-odd.rng" type="application/xml"
    schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="castello-anima-odd.rng" type="application/xml"
    schematypens="http://purl.oclc.org/dsdl/schematron"?>
```

## In sintesi

`castello-anima-text.xml` è il **contenuto trascritto** del Libro III, capp. I–V (cc. 158r–168r, §§1–72), codificato secondo il modello leggero a tre layer e verificato contro lo schema ODD di progetto. Descrive il *testo*; il suo complementare [`Header-README.md`](Header-README.md) descrive il *modello* (`teiHeader`). Ogni puntatore del testo risolve a un identificatore dichiarato una sola volta nell’header.

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
