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

1. **Filologico-grafico** — struttura (`div`/`head`/`argument`/`p`, `pb`/`lb`/`fw`), trascrizione a due livelli (`<choice>`) e apparato genetico (`<app>`/`<lem>`/`<rdg>` con `<del>`/`<add>`/`<subst>` dentro l'apparato), le rivergature a inchiostro (`<retrace>`) e i guasti materiali (`<unclear>`/`<gap>`/`<supplied>`).
2. **Mistico-dottrinale** — lessico agganciato via `<term ref="…">` al **vocabolario controllato degli stati** dichiarato nel `teiHeader` (`taxonomy xml:id="stati-mistici"`).
3. **Intertestuale** — citazioni e rimandi alle fonti (`<cit>`/`<quote>`/`<foreign>`/`<bibl>`, `<ref target="…">`).

> **Nota sullo scope.** L'annotazione interpretativa multiassiale (`<seg>` con `@ana`, `<figure>`, `<spanGrp>`/`<span>`, `<rs>`, `<val>`, le catene semantiche `<linkGrp>`/`<link>` e l'indice d'impatto) **non** fa parte di questo modello: l'edizione adotta un modello leggero e tiene fuori tale sperimentazione interpretativa e computazionale. Qui **l'unità di riferimento è il paragrafo `<p n="…">`**, non il `<seg>`.

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
        ├── <fw>, <pb>, <lb> (segnaletica materiale: foliazione e cambi-riga; edizione facs-free)
        ├── <head>
        ├── <div type="preface"> (protesta/prologo)
        │   ├── <head>
        │   └── <p>   (paragrafi del proemio; il preface non usa <argument>)
        └── <div type="chapter" n="*">
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
Dentro l'apparato (`<app>`): `<del>` (cancellature), `<add>` (aggiunte marginali/interlineari, con `@place`/`@hand`/`@resp`), `<subst>` (sostituzione come evento unico). Inline, **fuori** dall'apparato: `<retrace>` (rivergatura a inchiostro, mano `#ink_3-dark`, testo invariato), `<unclear>`, `<gap>`, `<supplied>`.

### Apparato genetico d'autrice
Ogni `<app>` ha un `<lem wit="#txt-c">` e **una sola** `<rdg wit="#txt-b0">`, con `<del>`/`<add>`/`<subst>` **dentro** la lettura; `@varSeq` si usa **solo** quando concorrono ≥2 `<rdg>` (0 casi in MC-1). I blocchi marginali sono una `<rdg>` con `<add>` senza `<subst>`.

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
<ref target="#avila-castello"/>   <!-- rimando a fonte -->
<cit>
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
4. **Fedeltà materiale**: posizione, mano e fase sono preservate tramite `@place`/`@hand`/`@resp` su `<del>`/`<add>`/`<subst>` (dentro `<app>`) e su `<retrace>`, e tramite `<pb>`/`<lb>`/`<fw>`. Edizione **facs-free**: nessun `@facs` (immagini non autorizzate).
5. **Aggancio controllato**: `term/@ref` e `ref/@target` puntano solo a identificatori dichiarati nel `teiHeader`.

---

## Validazione

```bash
# buona formazione
xmllint --noout text-model.xml
# validazione contro lo schema ODD di progetto (RELAX NG + Schematron)
java -jar jing.jar ../../Micro-commits/MC-1/data/castello-anima-odd.rng text-model.xml
```

---

## 👤 Curatore
**Luciano Longo**
- Contatti: <luciano.longo@dedalus.com>
- ORCID: <https://orcid.org/0009-0005-7557-7546>
- GitHub: <https://github.com/luciano-longo77>
- Website: <https://luciano-longo77.github.io>
