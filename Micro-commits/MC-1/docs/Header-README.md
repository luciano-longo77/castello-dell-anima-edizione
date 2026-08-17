# (MC1) Micro‑progetto di Edizione Critica Digitale
## `teiHeader` - Libro III, Capitoli I–V
**Edizione critica digitale del *Castello dell’anima*** **ms. Palermo, BCP, 2 Qq E 29**

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey?logo=creativecommons)](https://creativecommons.org/licenses/by/4.0/)
![TEI P5](https://img.shields.io/badge/TEI-P5-blueviolet?logo=xml)
![Micro-commit](https://img.shields.io/badge/Micro--commit-MC1-informational)
![Libro III](https://img.shields.io/badge/Libro%20III-capp.%20I%E2%80%93V-blue)
![Datazione](https://img.shields.io/badge/Datazione-1692%E2%80%931694-8a6d3b)
![Manoscritto](https://img.shields.io/badge/ms.-Palermo%2C%20BCP%202%20Qq%20E%2029-8b4513)
![Status](https://img.shields.io/badge/status-in%20preparazione-orange)

## A cosa serve questo documento

Questo file spiega **cosa contiene il `teiHeader`**, **come è organizzato** e **quali obiettivi persegue** in questa prima fase del progetto (MC1, Libro III, capp. I–V). 
È pensato come guida di lettura per chi apre il file XML senza aver seguito lo sviluppo del progetto, e come promemoria per le fasi successive (MC2 e oltre), che dovranno mantenere la coerenza qui stabilita o dichiararne esplicitamente le variazioni. L'estensione dichiarata da questo header è **Libro III, proemio + capp. I–V, cc. 158r–168r** (§§ 1–72).

Il `teiHeader` è mantenuto come componente concettualmente distinta dal file dati del `<text>` e dal README narrativo del MC1: descrive *il modello*, non il contenuto trascritto capitolo per capitolo. Sul piano fisico i due file restano **separati**: il file dati (`castello-anima-text.xml`) richiama questo header via `<xi:include href="TEI-Header.xml" xpointer="element(/1/1)"/>`, così l'header è modellato una sola volta e i puntatori del testo risolvono a validazione (con l'elaborazione XInclude attiva in oXygen).

## Indice

- [A cosa serve questo documento](#a-cosa-serve-questo-documento)
- [Perché un `teiHeader` così esteso](#perché-un-teiheader-così-esteso)
- [Struttura del `teiHeader` e cosa fa ciascuna sezione](#struttura-del-teiheader-e-cosa-fa-ciascuna-sezione)
  - [`fileDesc`](#filedesc)
  - [`encodingDesc`](#encodingdesc)
  - [`profileDesc`](#profiledesc)
  - [`revisionDesc`](#revisiondesc)
- [Il tag set core: cosa è dentro, cosa è fuori, e perché](#il-tag-set-core-cosa-è-dentro-cosa-è-fuori-e-perché)
- [Il vocabolario controllato degli stati e le fonti](#il-vocabolario-controllato-degli-stati-e-le-fonti)
- [Licenza e datazione: due chiarimenti necessari](#licenza-e-datazione-due-chiarimenti-necessari)
- [Validazione e schema](#validazione-e-schema)
- [In sintesi](#in-sintesi)

## Perché un `teiHeader` così esteso

A differenza di un'edizione digitale minima, dove l'**header** si limita a pochi metadati bibliografici, qui il `teiHeader` è deliberatamente ricco perché deve sostenere due funzioni insieme:

1. **Funzione descrittiva**: chi ha scritto cosa, quando, su quale supporto, con quali mani, sotto quale licenza.
2. **Funzione interpretativa (leggera)**: dichiarare in modo esplicito e verificabile il **vocabolario controllato degli stati mistici** (`<classDecl>`) e le **fonti** (`<listBibl>`), così che l'attributo `@ref` sui `<term>` del testo e i rimandi intertestuali non siano stringhe libere non controllabili, ma puntino a categorie e a voci bibliografiche formalmente definite.

Questa seconda funzione è ciò che rende l'edizione più di una semplice trascrizione: permette di interrogare il testo per *stato mistico* e di collegare ogni citazione alla sua fonte, in modo sistematico e riproducibile da altri. Il commit 1 adotta una forma leggera: un solo asse interpretativo (`term/@ref` → stati), senza indice di impatto né segmentazione retorica multiassiale.

## Struttura del `teiHeader` e cosa fa ciascuna sezione

### `fileDesc`
Contiene i metadati editoriali in senso stretto: titolo, autrice (con nome religioso e secolare), curatore, licenza, e la descrizione approfondita del manoscritto (`sourceDesc/msDesc`), identificazione archivistica, contenuto dei tre libri con incipit/explicit, descrizione fisica del supporto, e soprattutto `handDesc`, che distingue cinque mani/fasi di scrittura, quattro autografe di Teresa (`ink_1` e `ink_2` a inchiostro bruno, `ink_3-dark` a inchiostro scuro — mano T3 dei `<retrace>` e delle glosse prudenziali — e `pencil_1` a matita) più una mano esterna non identificata (`ink_4-external`), corrispondenti alla stratificazione genetica del testo (Tb0–T4).

Le `notesStmt` raccolgono le note critiche di inquadramento (materiale, prudenziale, linguistico, sul rischio teologico, sulla trasmissione, stilistico) e le note biografiche e contestuali sull'autrice, il commento filologico che precede e giustifica le scelte editoriali applicate nel testo.

### `encodingDesc`
Qui si dichiara **come** il testo viene codificato:
- `projectDesc` descrive gli obiettivi del modello (tre layer: filologico‑grafico, mistico‑dottrinale, intertestuale; trascrizione a due livelli; apparato genetico) e la fase in cui si trova il progetto.
- `editorialDecl` fissa i criteri editoriali e in particolare la **trascrizione a due livelli**: la lezione diplomatica e la sua regolarizzazione coesistono nel file, affiancate da `<choice>` (`<orig>`/`<reg>`, `<abbr>`/`<expan>`, `<sic>`/`<corr>`); apparato genetico in *parallel segmentation* a registrazione **a *currente calamo*** (`<lem wit="#txt-c">` + `<rdg wit="#txt-b0">` con `<del>`/`<add>`/`<subst>` interni a `<app>`), integrato da `<retrace>` per i ripassi a inchiostro (mano `#ink_3-dark`, testo invariato) — `@varSeq` **non è il default**: opzionale e riservato ai casi di ≥2 `<rdg>` concorrenti, non ricorre in MC1; nessuna normalizzazione del testo trascritto se non quella dichiarata e reversibile via `<choice>`.
- `tagsDecl` elenca **esattamente** gli elementi TEI usati nel testo — il "tag set core" di questo commit (vedi sotto).
- `classDecl` contiene il **vocabolario controllato degli stati mistici** (`taxonomy xml:id="stati-mistici"`): le categorie (`#silentio`, `#otio`, `#annichilimento`, `#oblivione-sonno`, `#scordanza`, `#indifferenza`, `#nudita-anima`, `#bacio`, `#matrimonio-spirituale`, `#cella-secreta`, `#contemplazione-infusa`, `#trasformazione`, `#deificazione`, `#notte`, `#purga`, `#unione`, `#quiete`, ecc.) sono i bersagli di `term/@ref` nel testo. Le otto tassonomie interpretative multiassiali e l'indice di impatto **non** fanno parte di questo header.

### `profileDesc`
Descrive la lingua del testo (italiano regionale siciliano di fine Seicento, con fenomeni fonetici, morfologici, lessicali e sintattici dettagliati) e le persone/organizzazioni coinvolte: l'autrice, le fonti dottrinali (Santa Teresa d'Ávila, Giovanni della Croce, Miguel de Molinos), il direttore spirituale, l'editore, e le istituzioni storiche (Carmelo, Inquisizione).

### `revisionDesc`
Registra la cronologia sintetica degli interventi editoriali (voci proforma), ciascuno classificato secondo la tassonomia `fase`.

## Il tag set core: cosa è dentro, cosa è fuori, e perché

Il `tagsDecl` di questo `teiHeader` non è un elenco esaustivo di tutto ciò che TEI permette, ma il **tag set minimo** deciso per MC1, coerente con quanto dichiarato nel README narrativo del micro-commit. Include:

- **Struttura** (layer filologico‑grafico): `div`, `head`, `argument`, `p`, `pb` (`@n`/`@xml:id`; `@facs` ammesso dallo schema ma **non usato** — MC1 è *facs‑free*, es. `<pb n="158r" xml:id="f158r"/>`), `fw`, `text`, `body`
- **Front matter**: `front`, `listWit`/`witness` (sette **stati testuali di un unico autografo** — non sette manoscritti — incluso il testo critico costituito `txt-c` con `@resp="#editor"`), `listPerson`/`person`, `listBibl`/`title`/`author`, `titlePage`/`docTitle`/`titlePart`/`docAuthor`
- **Trascrizione a due livelli** (layer filologico‑grafico): `choice` con `orig`/`reg`, `abbr`/`expan`, `sic`/`corr`
- **Apparato genetico** (correzioni a *currente calamo*): `app`/`lem`/`rdg` (`@wit`; `@varSeq` opzionale, solo con ≥2 `rdg` concorrenti — assente in MC1), `del`/`add`/`subst` (`@place`/`@hand`/`@resp`/`@type`) **interni a `app`**, `retrace` (`@hand="#ink_3-dark"`/`@resp` — ripasso a inchiostro, testo invariato, fuori da `app`), `unclear`/`gap`/`supplied`
- **Lessico mistico** (layer mistico‑dottrinale): `term` con `@ref` al vocabolario degli stati
- **Intertesto** (layer intertestuale): `ref` (`@target`), `cit`/`quote`/`bibl`/`foreign`
- **Identificatori e fonti**: `idno` (in particolare per VIAF), `listBibl type="fontes"` (Vulgata, Molinos, Ávila)

Sono **fuori** dal tag set di questo commit gli elementi dell'annotazione interpretativa multiassiale — `figure`, `interp`/`interpGrp`, `rs` e il linking stand-off `span`/`link` — che lo schema ODD rimuove. Restano invece ammessi, nel loro **uso standard**, `seg` (dentro `incipit`/`explicit` del `msDesc`) e l'attributo `@ana`, quest'ultimo limitato ai `<change>` del `revisionDesc` (aggancio alla tassonomia `fase`): non sono quindi il perno di un'annotazione multiassiale, ma servizi puntuali dell'header.

## Il vocabolario controllato degli stati e le fonti

Nel commit 1 il `classDecl` non ospita più le otto tassonomie interpretative, ma un solo **vocabolario controllato degli stati mistici**, dichiarato come `taxonomy xml:id="stati-mistici"`. Ogni categoria ha un `@xml:id` che funge da bersaglio per l'attributo `@ref` dei `<term>` nel testo:

| Categoria (`xml:id`) | Stato mistico |
|---|---|
| `silentio` | Silentio (primo stato d'unione) |
| `otio` | Otio / quiete passiva |
| `annichilimento` | Annichilazione della volontà propria |
| `oblivione-sonno` | Oblivione o sonno |
| `scordanza` | Scordanza del creato e di sé |
| `indifferenza` | Indifferenza (unione delle volontà) |
| `notte` | Notte dello spirito |
| `purga` | Purga / purificazione passiva |
| `unione` | Unione con Dio |
| `quiete` | Quiete |
| `contemplazione-infusa` | Contemplazione infusa |
| `nudita-anima`, `bacio`, `matrimonio-spirituale`, `cella-secreta`, `trasformazione`, `deificazione` | Stati delle celle superiori del Libro III |

Un `<term ref="#unione">unione</term>` nel testo risolve così a una categoria dichiarata una sola volta nell'header: questo è ciò che rende possibile isolare *tutte* le occorrenze di uno stato (p. es. l'unione) indipendentemente dal capitolo, senza importare l'apparato multiassiale a otto tassonomie né l'indice di impatto. I termini di lessico non‑stato restano `<term>` nudi.

Accanto al vocabolario, il `<listBibl type="fontes">` dichiara le **fonti** richiamate dall'intertesto — la Vulgata (`#bible-vulgate`), la *Guida spirituale* di Molinos (`#molinos-guida`), il *Castello interiore* di Ávila (`#avila-castello`) — bersagli dei rimandi `<ref target="…">` e delle `<bibl>` interne alle citazioni `<cit>`.

Resta distinta da tutto ciò la tassonomia di lavoro `fase`, che non descrive il testo ma il **lavoro editoriale**: è il vocabolario controllato con cui `revisionDesc` traccia la cronologia degli interventi.

## Validazione e schema

Il modello descritto qui è formalizzato in uno **schema TEI P5 personalizzato**, prodotto con la metodologia ODD:

- **`castello-anima-odd.odd`** — la specifica *One Document Does it all*: documentazione del modello, selezione dei moduli TEI, confine del tag set (elementi esclusi) e vincoli Schematron.
- **`castello-anima-odd.rng`** — lo schema compilato (RELAX NG + Schematron incorporato) contro cui si validano i file dati. Si rigenera dall'ODD con oXygen (*TEI ODD → RELAX NG XML*).

Il file dati dichiara l'associazione in testa, con due PI verso lo stesso RNG:

```xml
<?xml-model href="castello-anima-odd.rng" type="application/xml"
    schematypens="http://relaxng.org/ns/structure/1.0"?>
<?xml-model href="castello-anima-odd.rng" type="application/xml"
    schematypens="http://purl.oclc.org/dsdl/schematron"?>
```

## Licenza e datazione: due chiarimenti necessari

- **Licenza**: CC BY 4.0, allineata al README generale del progetto (fonte di verità per questa decisione). Le riproduzioni digitali del manoscritto restano soggette a restrizioni dell'ente conservatore, distinte dalla licenza del testo TEI.
- **Datazione**: la redazione del Libro III si colloca nel 1692–1694; l'intervallo più ampio (1692–1703) copre l'intera traiettoria compositiva dell'opera (Libri I–III, comprese le glosse prudenziali successive) fino alla condanna dell'autrice. Il `teiHeader` dichiara esplicitamente questa distinzione per evitare che le due datazioni sembrino in conflitto.

## In sintesi

Questo `teiHeader` non è un contenitore neutro di metadati: è la dichiarazione formale, verificabile e citabile, di come e perché il testo del Libro III, capp. I–V, viene rappresentato in questo specifico commit. Ogni scelta (tag set limitato a tre layer, trascrizione a due livelli, vocabolario controllato degli stati, esclusione dell'annotazione multiassiale e dell'IA, licenza, datazione) è tracciabile a una decisione motivata, documentata in parallelo nel README narrativo del MC1 e nella cronologia di `revisionDesc`.

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

