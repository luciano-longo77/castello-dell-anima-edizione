# Modello del `<text>` (Libro III)
## Micro‑progetto di Edizione Critica Digitale
**Edizione critica digitale del *Castello dell’anima*** **ms. Palermo, BCP, 2 Qq E 29**

![TEI P5](https://img.shields.io/badge/TEI-P5-blue)
![License](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey)
![Status](https://img.shields.io/badge/Status-Consolidated-brightgreen)
![Lang](https://img.shields.io/badge/Language-it--reg--sic%20%7C%20la-orange)

> **File**: `text-model.xml`  
> **Schema**: TEI P5 + ODD custom (`castello-anima-odd.odd` → `.rng`)  
> **Testimone**: ms. 2 Qq E 29, Biblioteca Comunale di Palermo

---

## Modello a tre layer

Il corpo testuale adotta lo **stesso profilo leggero del `teiHeader`**, articolato in tre layer:

1. **Filologico-grafico** — struttura (`div`/`head`/`argument`/`p`, `pb`/`fw`), trascrizione a due livelli (`<choice>`) e apparato genetico (`<app>`/`<lem>`/`<rdg>`, `<add>`/`<del>`/`<subst>`, `<unclear>`/`<gap>`/`<supplied>`).
2. **Mistico-dottrinale** — lessico agganciato via `<term ref="…">` al **vocabolario controllato degli stati** dichiarato nel `teiHeader` (`taxonomy xml:id="stati-mistici"`).
3. **Intertestuale** — citazioni e rimandi alle fonti (`<cit>`/`<quote>`/`<foreign>`/`<bibl>`, `<ref target="…">`).

> **Nota sullo scope.** L'annotazione interpretativa multiassiale (`<seg>` con `@ana`, `<figure>`, `<spanGrp>`/`<span>`, `<rs>`, `<val>`, le catene semantiche `<linkGrp>`/`<link>` e l'indice d'impatto) **non** fa parte di questo modello: è sviluppata nel repository separato [`castello-anima-TEI-IA`](https://github.com/luciano-longo77/castello-anima-TEI-IA). Qui **l'unità di riferimento è il paragrafo `<p n="…">`**, non il `<seg>`.

---

## Architettura strutturale

```text
<text>
├── <front>
│   └── <titlePage> (<docTitle>/<titlePart>, <docAuthor>)
│       <!-- listWit / listPerson / listBibl NON stanno nel <front>:
│            sono dichiarati una sola volta nel teiHeader; qui si puntano via @wit/@ref -->
└── <body>
    ├── <div type="book" n="1"> (Libro I)
    ├── <div type="book" n="2"> (Libro II)
    └── <div type="book" n="3"> (Libro III — focus)
        ├── <fw>, <pb> (segnaletica materiale e facsimili)
        ├── <head>
        ├── <div type="preface"> (protesta/prologo)
        │   ├── <head>
        │   └── <p>   (paragrafi del proemio; il preface non usa <argument>)
        └── <div type="chapter" n="*">
            ├── <head>, <argument>
            └── <p n="*" xml:id="*">   ← unità di riferimento
                ├── layer 1: <choice> (orig/reg, abbr/expan, sic/corr)
                ├── layer 1: <add>/<del>/<subst>, <unclear>/<gap>/<supplied>
                ├── layer 1: <app> (<lem wit="#txt-c"/>, <rdg wit="#txt-b0…"/>)
                ├── layer 2: <term ref="#…"/>
                └── layer 3: <ref target="#…"/>, <cit>/<quote>/<foreign>/<bibl>
```

---

## Layer 1 — filologico-grafico

### Trascrizione a due livelli (`<choice>`)
La lezione diplomatica e la sua regolarizzazione coesistono, senza che l'una sostituisca l'altra:

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
`<add>` (aggiunte marginali/interlineari, con `@place`/`@hand`/`@resp`/`@type`), `<del>` (cancellature), `<subst>` (sostituzione come evento unico), `<unclear>`, `<gap>`, `<supplied>`.

### Apparato genetico (parallel segmentation)
```xml
<app>
  <lem wit="#txt-c">…</lem>          <!-- testo critico costituito (lemma) -->
  <rdg wit="#txt-b0" varSeq="1">…</rdg>  <!-- Tb0, prima stesura -->
  <rdg wit="#txt-1"  varSeq="2">…</rdg>  <!-- T1, riscrittura autoriale -->
  <rdg wit="#txt-2"  varSeq="3">…</rdg>  <!-- T2, intervento correttivo-glossativo -->
  <rdg wit="#txt-3"  varSeq="4">…</rdg>  <!-- T3, intervento successivo -->
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
| `txt-c` | Tc — testo critico costituito (`@resp="#editor"`), lemma dell'edizione |

Le mani (`@hand`) rinviano ai `<handNote>` del `teiHeader` (`#ink_1`, `#ink_2`, `#ink_3-dark`, `#pencil_1`, `#ink_4-external`).

---

## Layer 2 — mistico-dottrinale

Il lessico degli stati mistici è isolato da `<term ref="…">`, agganciato al vocabolario controllato del `teiHeader`:

```xml
<term ref="#unione">unione</term>
<term ref="#notte">notte dello spirito</term>
```

Questo consente di isolare *tutte* le occorrenze di uno stato (p. es. l'unione) indipendentemente dal capitolo. I termini di lessico non-stato restano `<term>` nudi.

---

## Layer 3 — intertestuale

```xml
<ref target="#avila-castello" type="model"/>   <!-- rimando a fonte -->
<cit type="bible">
  <quote xml:lang="la"><foreign xml:lang="la">…</foreign></quote>
  <bibl corresp="#bible-vulgate"/>
</cit>
```

I bersagli (`#bible-vulgate`, `#molinos-guida`, `#avila-castello`) sono dichiarati in `<listBibl type="fontes">` **nel `teiHeader`** (`sourceDesc`).

---

## Principi editoriali

1. **Unità di riferimento = paragrafo**: il testo è strutturato in `<p n="…">`; non si usa `<seg>` come unità di annotazione interpretativa.
2. **Trascrizione diplomatico-conservativa**: nessuna normalizzazione oltre quella dichiarata e reversibile via `<choice>`.
3. **Apparato in situ**: le varianti genetiche sono codificate nel flusso testuale (parallel segmentation).
4. **Fedeltà materiale**: posizione, mano e fase sono preservate tramite `@place`/`@hand`/`@resp` su `<add>`/`<del>`/`<subst>` e tramite `<pb>`/`<fw>` (`@facs` per i facsimili).
5. **Aggancio controllato**: `term/@ref` e `ref/@target` puntano solo a identificatori dichiarati nel `teiHeader`.

---

## Validazione

```bash
xmllint --noout text-model.xml
```

---

## 👤 Curatore
**Luciano Longo**
- Contatti: <luciano.longo@dedalus.com>
- ORCID: <https://orcid.org/0009-0005-7557-7546>
- GitHub: <https://github.com/luciano-longo77>
- Website: <https://luciano-longo77.github.io>
