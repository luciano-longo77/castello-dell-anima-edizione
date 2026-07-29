# Il `teiHeader` del *Castello dell'anima* Guida al primo micro-commit (MC1)
![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey?logo=creativecommons)
![TEI P5](https://img.shields.io/badge/TEI-P5-blueviolet?logo=xml)
## A cosa serve questo documento

Questo file spiega **cosa contiene il `teiHeader`**, **come è organizzato** e **quali obiettivi persegue** in questa prima fase del progetto (MC1, Libro III, capp. I–V). 
È pensato come guida di lettura per chi apre il file XML senza aver seguito lo sviluppo del progetto, e come promemoria per le fasi successive (MC2 e oltre), che dovranno mantenere la coerenza qui stabilita o dichiararne esplicitamente le variazioni.

Il `teiHeader` è mantenuto come componente concettualmente distinta dal file dati del `<text>` e dal README narrativo del MC1: descrive *il modello*, non il contenuto trascritto capitolo per capitolo.

## Indice

- [A cosa serve questo documento](#a-cosa-serve-questo-documento)
- [Perché un `teiHeader` così esteso](#perché-un-teiheader-così-esteso)
- [Struttura del `teiHeader` e cosa fa ciascuna sezione](#struttura-del-teiheader-e-cosa-fa-ciascuna-sezione)
  - [`fileDesc`](#filedesc)
  - [`encodingDesc`](#encodingdesc)
  - [`profileDesc`](#profiledesc)
  - [`revisionDesc`](#revisiondesc)
- [Il tag set core: cosa è dentro, cosa è fuori, e perché](#il-tag-set-core-cosa-è-dentro-cosa-è-fuori-e-perché)
- [Le tassonomie: un sistema multiassiale, non gerarchico](#le-tassonomie-un-sistema-multiassiale-non-gerarchico)
- [Licenza e datazione: due chiarimenti necessari](#licenza-e-datazione-due-chiarimenti-necessari)
- [In sintesi](#in-sintesi)

## Perché un `teiHeader` così esteso

A differenza di un'edizione digitale minima, dove l'header si limita a pochi metadati bibliografici, qui il `teiHeader` è deliberatamente ricco perché deve sostenere due funzioni insieme:

1. **Funzione descrittiva classica**: chi ha scritto cosa, quando, su quale supporto, con quali mani, sotto quale licenza.
2. **Funzione interpretativa**: dichiarare in modo esplicito e verificabile le categorie con cui il testo viene annotato (tassonomie in `classDecl`), così che l'attributo `@ana` sui `<seg>` del testo non sia testo libero non controllabile, ma rimandi a un vocabolario formalmente definito.

Questa seconda funzione è ciò che rende l'edizione più di una semplice trascrizione: permette di interrogare il testo per funzione retorica, stato mistico, livello di rischio dottrinale, e così via, in modo sistematico e riproducibile da altri.

## Struttura del `teiHeader` e cosa fa ciascuna sezione

### `fileDesc`
Contiene i metadati editoriali in senso stretto: titolo, autrice (con nome religioso e secolare), curatore, licenza, e la descrizione approfondita del manoscritto (`sourceDesc/msDesc`), identificazione archivistica, contenuto dei tre libri con incipit/explicit, descrizione fisica del supporto, e soprattutto `handDesc`, che distingue cinque mani/fasi di scrittura, quattro autografe di Teresa (`ink_1` e `ink_2` a inchiostro bruno, `ink_3-dark` a inchiostro scuro e `pencil_1` a matita) più una mano esterna non identificata (`ink_4-external`), corrispondenti alla stratificazione genetica del testo (Tb0–T4).

Le `notesStmt` raccolgono le note critiche di inquadramento (materiale, prudenziale, linguistico, sul rischio teologico, sulla trasmissione, stilistico) e le note biografiche e contestuali sull'autrice, il commento filologico che precede e giustifica le scelte editoriali applicate nel testo.

### `encodingDesc`
Qui si dichiara **come** il testo viene codificato:
- `projectDesc` descrive gli obiettivi del modello (segmentazione strutturata, apparato genetico, tassonomie multiassiali) e la fase in cui si trova il progetto.
- `editorialDecl` fissa i criteri editoriali: trascrizione semidiplomatica (e interpretativa), apparato critico in *parallel segmentation*, nessuna normalizzazione se non minima e dichiarata.
- `tagsDecl` elenca **esattamente** gli elementi TEI usati nel testo — il "tag set core" di questo commit (vedi sotto).
- `classDecl` contiene le tassonomie: otto assi interpretativi (`func`, `impact`, `risk`, `mystic_state`, `operation`, `exposition`, `phase`, `relation`) più la tassonomia di lavoro editoriale (`fase`), usata per tracciare la cronologia degli interventi in `revisionDesc`.

### `profileDesc`
Descrive la lingua del testo (italiano regionale siciliano di fine Seicento, con fenomeni fonetici, morfologici, lessicali e sintattici dettagliati) e le persone/organizzazioni coinvolte: l'autrice, le fonti dottrinali (Santa Teresa d'Ávila, Giovanni della Croce, Miguel de Molinos), il direttore spirituale, l'editore, e le istituzioni storiche (Carmelo, Inquisizione).

### `revisionDesc`
Registra la cronologia granulare degli interventi editoriali, ciascuno classificato secondo la tassonomia `fase`.

## Il tag set core: cosa è dentro, cosa è fuori, e perché

Il `tagsDecl` di questo `teiHeader` non è un elenco esaustivo di tutto ciò che TEI permette, ma il **tag set minimo** deciso per MC1, coerente con quanto dichiarato nel README narrativo del micro-commit (§3.11–3.12). Include:

- **Struttura**: `div`, `head`, `argument`, `p`, `pb`, `fw`, `text`, `body`
- **Front matter**: `front`, `listWit`/`witness`, `listPerson`/`person`, `listBibl`/`title`/`author`, `titlePage`/`docTitle`/`titlePart`/`docAuthor`
- **Segmentazione e retorica**: `seg`, `term`, `figure`, `ref`, `note`
- **Apparato critico e fenomeni materiali**: `app`/`lem`/`rdg`, `del`/`add`/`subst`, `unclear`/`gap`/`supplied`
- **Citazioni**: `cit`/`quote`/`foreign`
- **Identificatori**: `idno` (in particolare per VIAF)

## Le tassonomie: un sistema multiassiale, non gerarchico

Le otto tassonomie in `classDecl` non sono livelli di una stessa scala, ma **assi indipendenti** dello stesso fenomeno testuale:

| Tassonomia | Cosa cattura |
|---|---|
| `func` | La funzione retorica del segmento (legittimazione, pedagogia, gestione del rischio...) |
| `mystic_state` | Lo stato mistico coinvolto (purificazione, quiete, otium, unione...) |
| `risk` | Il livello di pericolo dottrinale (quietismo, panteismo, impeccabilità, ambiguità) |
| `operation` | Il meccanismo discorsivo usato per gestire il rischio (attenuatio, precisatio, declaratio...) |
| `exposition` | Il giudizio interpretativo sul livello di esposizione dottrinale |
| `impact` | Il peso interpretativo calcolato del segmento |
| `phase` | La posizione del segmento nel discorso (introduttiva, mediana, conclusiva, critica) |
| `relation` | Il legame con altri passaggi o fonti esterne (intertesto biblico, liturgico, teresiano, molinista) |

Una stessa occorrenza testuale riceve normalmente più etichette contemporaneamente, una per asse pertinente, combinate nello stesso attributo `@ana`. Questo è ciò che rende possibile, ad esempio, isolare tutti i segmenti che attenuano un rischio di quietismo indipendentemente dal capitolo in cui compaiono.

La tassonomia `fase`, distinta dalle otto sopra, non descrive il testo ma il **lavoro editoriale**: è il vocabolario controllato con cui `revisionDesc` traccia la cronologia degli interventi.

## Licenza e datazione: due chiarimenti necessari

- **Licenza**: CC BY 4.0, allineata al README generale del progetto (fonte di verità per questa decisione). Le riproduzioni digitali del manoscritto restano soggette a restrizioni dell'ente conservatore, distinte dalla licenza del testo TEI.
- **Datazione**: la redazione del Libro III si colloca nel 1692–1694; l'intervallo più ampio (1692–1703) copre l'intera traiettoria compositiva dell'opera (Libri I–III, comprese le glosse prudenziali successive) fino alla condanna dell'autrice. Il `teiHeader` dichiara esplicitamente questa distinzione per evitare che le due datazioni sembrino in conflitto.

## In sintesi

Questo `teiHeader` non è un contenitore neutro di metadati: è la dichiarazione formale, verificabile e citabile, di come e perché il testo del Libro III, capp. I–V, viene rappresentato in questo specifico commit. Ogni scelta (tag set limitato, tassonomie multiassiali, esclusione dell'IA, licenza, datazione) è tracciabile a una decisione motivata, documentata in parallelo nel README narrativo del MC1 e nella cronologia di `revisionDesc`.

## Documenti correlati

- [Readme generale del progetto](https://github.com/luciano-longo77/castello-dell-anima-edizione/blob/main/tei-model/MC_readme-generale/readme.md) — piano editoriale complessivo e roadmap dei micro-commit (MC1–MC8)
- [1. README generale MC1](https://github.com/luciano-longo77/castello-dell-anima-edizione/blob/main/tei-model/MC_readme-generale/MC1_Castello_MicroCommit_III_1-5/doc/1_MC-1_README_generale.md) — descrizione sintetica e mappa topografica del micro-commit
- [2. Introduzione MC1 (Libro III, capp. I–V)](https://github.com/luciano-longo77/castello-dell-anima-edizione/blob/main/tei-model/MC_readme-generale/MC1_Castello_MicroCommit_III_1-5/doc/2_MC-1_III_1-5-introduzione.md) — commento critico ai capitoli, politiche editoriali e tag set core
- [3. Struttura capitoli e cartulazione](https://github.com/luciano-longo77/castello-dell-anima-edizione/blob/main/tei-model/MC_readme-generale/MC1_Castello_MicroCommit_III_1-5/doc/3_MC-1_III_1-5-Struttura%20capitoli%20e%20cartulazione.md) — mappa codicologica capitolo/carta del manoscritto
