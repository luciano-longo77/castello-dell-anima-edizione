# Micro‑progetto di Edizione Critica Digitale
## Il Castello dell'anima
### Libro III, Capitoli I–V
### Avvio della contemplazione infusa (MC1)

**Autore dell'edizione:** Luciano Longo 
**ORCID:** [https://orcid.org/0009-0005-7557-7546](https://orcid.org/0009-0005-7557-7546)

**Fonte primaria:** Palermo, Biblioteca Comunale, ms. 2 Qq E 29 (autografo), *Il Castello dell'anima* di suor Teresa di San Geronimo (Anna La Longa), 1692–1694.

> **Nota editoriale.** Il `teiHeader` completo (metadati descrittivi, note critiche, tassonomie, descrizione del manoscritto) è mantenuto come documento a parte, separato da questo README e dal file dati del `<text>`. Questo documento descrive esclusivamente i contenuti, le politiche editoriali e il tag set adottato per la codifica del corpo testuale.

---

## Indice

- [Abstract](#abstract)
- [1. Contesto storico-spirituale e profilo dell'opera](#1-contesto-storicospirituale-e-profilo-dellopera)
- [2. Perché i Capitoli I–V del Libro III costituiscono il primo micro-commit ideale](#2-perché-i-capitoli-iv-del-libro-iii-costituiscono-il-primo-microcommit-ideale)
  - [2.1. Capitolo I – La disposizione lasciata dalla notte dello spirito](#21-capitolo-i--la-disposizione-lasciata-dalla-notte-dello-spirito)
  - [2.2. Capitolo II – Il silentio come primo stato d'unione](#22-capitolo-ii--il-silentio-come-primo-stato-dunione)
  - [2.3. Capitolo III – Oblivione o sonno](#23-capitolo-iii--oblivione-o-sonno)
  - [2.4. Capitolo IV – Scordanza](#24-capitolo-iv--scordanza)
  - [2.5. Capitolo V – Stato d'indifferenza](#25-capitolo-v--stato-dindifferenza)
- [3. Politiche editoriali](#3-politiche-editoriali)
  - [3.1. Principi di fondo](#31-principi-di-fondo)
  - [3.2. Grafia e diacritici](#32-grafia-e-diacritici)
  - [3.3. Unione e separazione delle parole](#33-unione-e-separazione-delle-parole)
  - [3.4. Abbreviazioni](#34-abbreviazioni)
  - [3.5. Interpunzione](#35-interpunzione)
  - [3.6. Segnatura di carta](#36-segnatura-di-carta)
  - [3.7. Guasti, lacune, incertezze](#37-guasti-lacune-incertezze)
  - [3.8. Cancellature, aggiunte, ripensamenti](#38-cancellature-aggiunte-ripensamenti)
  - [3.9. Glosse](#39-glosse)
  - [3.10. Struttura TEI prevista](#310-struttura-tei-prevista)
  - [3.11. Tag set "core" (elementi e attributi)](#311-tag-set-core-elementi-e-attributi)
  - [3.12. Giustificazione critica del tag set adottato](#312-giuatificazione-critica-del-tag-set-adottato)
- [4. Modellizzazione descrittiva dei capitoli (struttura interna)](#4-modellizzazione-descrittiva-dei-capitoli-struttura-interna)
- [5. Struttura del pacchetto del micro-commit](#5-struttura-del-pacchetto-del-microcommit)
- [6. Metadati](#6-metadati)
- [7. Risultati attesi](#7-risultati-attesi)
- [8. Roadmap](#8-roadmap)

---

### Abstract

Il presente micro‑commit inaugura l'edizione critica digitale del Libro III del *Castello dell'anima*, testi destinati "alle anime perfette", secondo la tripartizione originaria. I capitoli I–V costituiscono un'unità autonoma che segna il passaggio dagli stati purgativi e luminosi del Libro II all'avvio della contemplazione infusa, caratterizzata da:

- sospensione progressiva di sensi e potenze;
- instaurarsi del *silentio*, distinto dalla quiete acquisita;
- ingresso nel "sonno" spirituale come oblio delle potenze;
- distacco radicale dal creato (*scordanza*);
- perfetta coincidenza della volontà dell'anima con quella divina (*indifferenza*).

Questi capitoli presentano un'elevata densità mistico‑dottrinale, un uso continuo di comparazioni, e mostrano la natura semicolta dell'italiano regionale di Sicilia di fine Seicento: oscillazioni grafiche, variazioni morfosintattiche, frantumazioni sintattiche tipiche del parlato devozionale. In questa fase della ricerca, il micro‑commit fornisce la descrizione critica integrale, la struttura retorica e la cornice storico‑spirituale, insieme alla definizione delle politiche editoriali coerenti con la marcatura TEI.

**Parole chiave:** Castello dell'anima; mistica secentesca; contemplazione infusa; unione mistica; linguistica storica; italiano regionale di Sicilia.

### 1. Contesto storico‑spirituale e profilo dell'opera

Il *Castello dell'anima* è l'unico testo superstite di Teresa di San Geronimo (Anna La Longa), terziaria carmelitana palermitana vissuta tra il 1670 e il primo Settecento. La sua opera si colloca nel clima religioso siciliano della seconda metà del Seicento, segnato da arretratezza del clero, presenza diffusa di devozioni popolari e penetrazione intermittente dei modelli mistici spagnoli. L'autrice, come emerge dall'Introduzione, fu coinvolta in un procedimento inquisitoriale: il suo trattato, circolato tra religiosi e laici, contribuì alle accuse di quietismo e di guida spirituale impropria. Il manoscritto 2 Qq E 29 è autografo, presenta numerosi indizi di ripensamenti, glosse marginali, e mostra come la progressione del testo sia stata stesa in fasi successive: il Libro III, in particolare, contiene interventi rapidi, cancellature, chiarificazioni dottrinali che cercano di prevenire possibili letture eterodosse. Il Libro III è dedicato alle anime "perfette", ovvero a quelle che, dopo la fase dell'unione abituale e dello stato di sposalizio, iniziano a ricevere gradi elevati di contemplazione infusa: *silentio*, sonno, *scordanza*, *indifferenza* e, più avanti, lo stato di matrimonio spirituale.

### 2. Perché i Capitoli I–V del Libro III costituiscono il primo micro‑commit ideale

I cinque capitoli selezionati costituiscono la soglia effettiva del Libro III: introducono le categorie che strutturano tutto ciò che segue. Sono un modulo chiuso e autosufficiente, con una dinamica ascensionale progressiva e coerente. La struttura dei contenuti segue un ordine interno netto:

#### 2.1. Capitolo I – La disposizione lasciata dalla notte dello spirito

Il capitolo si apre con un'affermazione fondamentale: *Quando più un'anima è ragionata di croce e travagli, tanto è più sicuro lo stato suo*. L'anima, esposta alla "notte" trattata nel Libro II, si trova ora purgata, alleggerita, "astinuata", pronta a ricevere luce. L'immagine delle statue esposte al sole, che si seccano e diventano leggere, costituisce una comparazione chiave: il calore della luce divina "stenua", dissolve i residui passionali e rende l'anima "capace" dell'amato. Il testo descrive inoltre segnali di sicurezza interiore (Arca di Noè che appare nel "terreno dell'anima"), manifestazione simbolica di pacificazione dopo i travagli. Il capitolo termina con l'immagine del viaggiatore che, dopo un itinerario faticoso, si ferma per contemplare retrospettivamente gli affanni trascorsi.

#### 2.2. Capitolo II – Il silentio come primo stato d'unione

Il *silentio* non coincide con la semplice sospensione passiva delle potenze: se nella quiete acquisita le potenze "ricevono", qui Dio opera "dal fondo dell'anima", senza passare per potenze e sensi. La comparazione del giardino irrigato prima dalla pioggia e poi da una fonte sotterranea chiarisce la differenza: nel *silentio* non si avverte più "lo strepito della pioggia" (metafora della *notitia confusa*), ma l'acqua "nasce nel fondo". L'autrice sottolinea che il linguaggio di questo stato è "oscuro", non perché confuso, ma perché ineffabile: un parlare che "si deve dire in silentio". L'anima percepisce un profumo, una forza, una quiete che nulla può togliere. Le potenze non sono distrutte, ma inattive, perché Dio opera "totalmente".

#### 2.3. Capitolo III – Oblivione o sonno

Qui inizia lo stato superiore. L'autrice lo distingue con precisione dal *silentio*: quest'ultimo sospende le potenze; il sonno le aliena. Non è però lo stato di estasi dello sposalitio, che era transitorio: qui il sonno è "habituale", continuo, stabile. La comperazione delle due statuette di cera calda che si fondono fino a quasi diventare una sola è una delle più potenti immagini dell'intero manoscritto. Pur precisando che le due sostanze restano distinte (Dio e anima), l'autrice descrive una congiunzione strettissima, anticipazione del matrimonio spirituale. L'anima sperimenta un aumento della luce (più il sole batte sulla pietra diamantina, più la rischiara) e insieme un aumento della consapevolezza del proprio "niente".

#### 2.4. Capitolo IV – Scordanza

La *scordanza*, che nel Libro II era episodica, diventa qui stato. L'anima è "sommersa in un profondissimo oceano d'amore": torna la metafora marittima, estesa con lunga comperazione. Il testo distingue la *scordanza* di questo stadio dallo stato estatico dello sposalitio: quest'ultimo era transitorio e coinvolgeva potenze e sensi; la *scordanza* del Libro III è fondata nel fondo dell'anima, stabile, senza annullamento dell'operatività esterna.

#### 2.5. Capitolo V – Stato d'indifferenza

L'anima "non ha più sua volontà, ma quella di Dio". Non si tratta dell'esercizio ascetico della *conformitas*, ma di un processo divino: la volontà dell'anima viene interiormente trasformata in quella di Dio, senza sforzo proprio. Da ciò deriva la cessazione dei desideri ("né vita, né morte, né croce"), non per tiepidezza ma per saturazione. Anche la carità verso il prossimo muta: non genera più pena, perché qui l'anima partecipa della pace di Dio.

### 3. Politiche editoriali

#### 3.1. Principi di fondo

La trascrizione adottata in questo micro‑commit si colloca integralmente nel quadro metodologico delineato nel documento di progetto *Edizione Critica Digitale del Terzo Libro del Castello dell'anima*. Il testo base dell'edizione è costituito da una trascrizione diplomatico‑conservativa del manoscritto autografo, condotta senza operare normalizzazioni grafiche, ortografiche o morfosintattiche. Ogni fenomeno materiale, grafico e linguistico dell'autografo è trattato come dato filologicamente e storicamente rilevante e viene pertanto conservato nel testo editoriale. Eventuali interventi di regolarizzazione o interpretazione sono ammessi esclusivamente in livelli testuali derivati e utilizzati a fini di leggibilità o sperimentazione computazionale.

#### 3.2. Grafia e diacritici

Nel testo base dell'edizione non viene applicata alcuna normalizzazione sistematica dei diacritici o delle grafie oscillanti. Sono pertanto conservate integralmente: oscillazioni come *à / a / hà*; *ò / o / hò*; variazioni nell'uso dell'accento grafico (*si / sì*; *ne / né*); grafie non standard o incoerenti all'interno del manoscritto. Tali fenomeni sono considerati parte costitutiva dell'italiano semicolto e regionale dell'autografo.

#### 3.3. Unione e separazione delle parole

Le forme di unione o separazione delle parole attestate nel manoscritto sono rigorosamente conservate nel testo base dell'edizione, anche quando divergono dall'uso moderno (es. *inquestitempi*, *alcun'altra*, *nontrattenere*). Tali fenomeni sono trattati come indizi di scrittura semicolta, tracce di oralità devozionale o segnali di velocità esecutiva.

#### 3.4. Abbreviazioni

Le abbreviazioni materiali del manoscritto sono:

- sciolte per esteso nel testo base, al solo fine di garantire la leggibilità;
- registrate in codifica TEI mediante la coppia: `<abbr>...</abbr>` `<expan>...</expan>`.

Lo scioglimento non implica normalizzazione linguistica né interpretazione semantica.

#### 3.5. Interpunzione

L'interpunzione originale del manoscritto è conservata nel testo base dell'edizione, anche quando risulta irregolare o incoerente secondo i criteri moderni.

#### 3.6. Segnatura di carta

La foliazione originale del manoscritto è indicata con precisione:

- nella trascrizione, tramite indicazioni esplicite di carta;
- nella codifica TEI, mediante: `<pb n="158r" facs="images/f158r.jpg" xml:id="f158r"/>`.

#### 3.7. Guasti, lacune, incertezze

Le porzioni di testo illeggibili, lacunose o meccanicamente danneggiate sono segnalate senza interventi arbitrari. In TEI vengono utilizzati: `<unclear/>`, `<gap reason="illegible"/>`, `<supplied reason="conjecture"/>`.

#### 3.8. Cancellature, aggiunte, ripensamenti

Le cancellature, le aggiunte marginali o interlineari e le riscritture autoriali sono considerate dati genetici primari. Nel testo editoriale esse sono rappresentate e distinte attraverso la codifica TEI: `<del>...</del>`, `<add place="margin">...</add>`, `<subst>...</subst>`.

#### 3.9. Glosse

Il Libro III include fasi in cui l'autrice aggiunge chiarificazioni successive. In TEI: `<note type="glossa" subtype="corrigenda">`.

#### 3.10. Struttura TEI prevista

La versione finale TEI comprenderà:

```xml
<TEI>
 <teiHeader> … </teiHeader>
 <text>
   <body>
      <div type="book" n="III">
        <div type="chapter" n="I"> … </div>
        <div type="chapter" n="II"> … </div>
        <div type="chapter" n="III"> … </div>
        <div type="chapter" n="IV"> … </div>
       <div type="chapter" n="V"> … </div>
      </div>
   </body>
 </text>
</TEI>
```

#### 3.11. Tag set "core" (elementi e attributi)

Il tag set minimo adottato per la codifica del testo (elemento `<text>`) comprende gli elementi seguenti, con i rispettivi attributi.

**Struttura**

- `<div>` — `@type` (`book`, `preface`, `chapter`); `@n`; `@xml:id`
- `<head>` — nessun attributo
- `<argument>` — nessun attributo
- `<p>` — `@n`
- `<pb>` — `@n` (foliazione, es. `158r`/`158v`); `@facs`; `@xml:id`
- `<fw>` — `@type` (`sig`); `@place` (`bottom`); `@xml:id`

**Front matter**

- `<listWit>` — nessun attributo
- `<witness>` — `@resp`; `@ana`
- `<listPerson>` — nessun attributo
- `<person>` — `@xml:id` (obbligatorio, per essere richiamabile da `@resp`/`@ana`)
- `<persName>` — nessun attributo
- `<idno>` — `@type` (`VIAF`) — identificatore di autorità per persone e fonti dottrinali
- `<listBibl>` — nessun attributo
- `<bibl>` — `@ref`
- `<title>` — `@level` (`m`)
- `<author>` — nessun attributo (in questo contesto, come figlio di `<bibl>`)
- `<titlePage>` — nessun attributo
- `<docTitle>` — nessun attributo
- `<titlePart>` — `@type` (`main`, `sub`)
- `<docAuthor>` — `@resp`

**Segmentazione e retorica**

- `<seg>` — `@type` (`indicatio`); `@function`; `@subtype`; `@xml:id`; `@xml:lang`; `@hand` (`ink_1`, `ink_2`, `ink_3-dark`, `ink_4-external`); `@ana`
- `<term>` — `@ana`
- `<ref>` — `@target`; `@type` (`intertext`, `scripture`, `liturgy`); `@subtype`; `@ana`
- `<note>` — `@type`; `@subtype`; `@corresp`; `@hand`; `@place` (`margin`); `@ana`

**Apparato critico e fenomeni materiali**

- `<app>` — nessun attributo
- `<lem>` — `@wit`
- `<rdg>` — `@wit`
- `<del>` — `@place` (`inline`); `@hand`; `@resp`; `@type` (`correction`)
- `<add>` — `@place` (`inline`, `margin`); `@hand`; `@resp`; `@type` (`correction`, `substitution`, `integration`)
- `<subst>` — nessun attributo (contenitore di `<del>`+`<add>` per sostituzioni articolate)
- `<unclear>` — `@unit` (char, word, line)
- `<gap>` — `@reason` (`illegible`)
- `<supplied>` — `@reason` (`conjecture`)

**Citazioni**

- `<cit>` — `@type` (`bible`, `liturgy`); `@xml:id`; `@ana`
- `<quote>` — `@xml:lang`
- `<foreign>` — `@xml:lang`; `@ana`

L'attributo `@ana`, presente su più elementi, veicola le categorie della tassonomia interpretativa (funzione retorica, stato mistico, livello di rischio dottrinale, ecc.).

### 4. Modellizzazione descrittiva dei capitoli (struttura interna)

I capitoli I–V mostrano:

- **4.1. Una forte uniformità retorica:** avvii con "Dico dunque…", "Hor…"; frequenti comperazioni lineari e allungate; suddivisione interna in paragrafi numerati.
- **4.2. Un asse simbolico dominante:** luce (investimento, rischiaramento, sole); acqua (pioggia, sorgente, oceano); fuoco (fuoco dell'amore; attrazione come "Mongibello"); materia plasmabile (cera, statua).
- **4.3. Un lessico mistico tecnico:** unione, sposalitio, purga, silentio, sonno, scordanza, indifferenza; concopiscibile, notitia confusa, potenze sospese.
- **4.4. Un registro linguistico semicolto:** fenomeni attestati nella Nota al testo — oscillazioni vocaliche, ipercorrettismi, variabilità dei pronomi clitici, forme verbali analogiche ("ponno", "stasse"), calchi sintattici secenteschi.

#### 3.12. Giustificazione critica del tag set adottato

**Struttura.** L'articolazione `<div type="book">` → `<div type="chapter">` riproduce la partizione originale dell'opera in tre libri, ciascuno diviso in capitoli numerati dall'autrice stessa; l'uso di `@n` accanto a `@type` permette di distinguere il livello gerarchico (libro vs. capitolo) dalla sua posizione numerica, requisito necessario per un'opera dove capitolo e libro condividono lo stesso schema di numerazione romana/araba. `<pb>` con `@n`, `@facs` e `@xml:id` ancora ogni carta sia alla foliazione originale sia all'immagine digitale corrispondente: nel caso di un autografo unico, questo è l'unico modo di garantire che ogni affermazione testuale sia verificabile contro il supporto materiale. `<fw>` registra le segnature a piè di pagina che nel manoscritto guidano la legatura dei fascicoli — dato codicologico minore ma necessario per chi volesse in futuro ricostruire la struttura fisica del fascicolo.

**Front matter — witness e persone.** `<listWit>`/`<witness>` dichiarano esplicitamente i sette livelli genetici del testo (Tb0, Tb1, T1, T2, T3, T4, Tc), ciascuno con `@resp` (chi ha prodotto quella fase: l'autrice, una mano esterna, il curatore) e `@ana` (l'identificativo che verrà richiamato da `@wit` nell'apparato). Questa dichiarazione preliminare è ciò che rende interpretabili, più avanti nel testo, valori altrimenti opachi come `wit="#txt-b0"`: senza il `<listWit>` a monte, l'apparato critico sarebbe una sigla senza chiave di lettura.

`<person>` con `@xml:id`, in combinazione con `<idno type="VIAF">`, è l'elemento che permette di ancorare le figure storiche nominate nel testo — l'autrice stessa, ma anche le fonti dottrinali richiamate come Teresa d'Ávila e Miguel de Molinos — a un'identità verificabile esternamente al progetto, tramite l'authority file VIAF. Senza VIAF, un riferimento come "Teresa d'Ávila" resterebbe una stringa di testo non disambiguata, indistinguibile da qualunque omonimo; con VIAF, il riferimento diventa un dato collegabile e interrogabile insieme ad altre biblioteche digitali e authority file internazionali.

`<bibl>`/`<title>`/`<author>` in `<listBibl>` documentano le fonti dottrinali citate o richiamate nel testo (Bibbia, *Guida spirituale* di Molinos, *Castello interiore* di Ávila): l'uso di `@ref` su `<bibl>` permette di collegare ogni citazione interna del testo alla sua fonte bibliografica dichiarata una sola volta in apertura, evitando di ripetere la descrizione bibliografica ogni volta che la fonte viene richiamata nel corpo del capitolo.

`<titlePage>`/`<docTitle>`/`<titlePart>`/`<docAuthor>` riproducono il frontespizio come si presenta nel manoscritto, distinguendo tramite `@type="main"`/`"sub"` il titolo principale dal sottotitolo — distinzione presente nell'originale ("Il Castello dell'Anima" / "Diviso in tre Libri per l'anime Incipienti, Proficienti e Perfette") e quindi non una scelta editoriale ma una trascrizione fedele della struttura del titolo storico.

**Segmentazione e retorica.** `<seg>` porta il peso maggiore dell'annotazione: `@function`/`@subtype` classificano l'atto retorico compiuto dal segmento (dichiarazione di obbedienza, protesta di ortodossia, comparazione, definizione di uno stato mistico), `@hand` ne registra la mano scrivente responsabile, `@xml:lang` distingue i rari segmenti non in volgare. Questa combinazione è motivata dal fatto che nel Libro III le unità retoriche e le fasi di scrittura non coincidono sempre: un segmento della stesura base (`ink_1`) può essere seguito, nello stesso paragrafo, da una glossa di mano successiva (`ink_3-dark`) che ne attenua il contenuto — la codifica deve poter distinguere le due cose sullo stesso piano testuale.

`<term>` isola il lessico tecnico mistico dell'autrice (*silentio*, *scordanza*, *indifferenza*, *sposalitio*) mantenendolo interrogabile separatamente dal resto del testo — utile in un'opera il cui vocabolario mistico non sempre coincide con quello di Ávila o Giovanni della Croce, pur muovendo dalla stessa tradizione.

`<ref target="#avila-castello">`/`<ref target="#molinos-guida">` con `@type="intertext"` rendono esplicito, a livello di markup, un dato che nel testo resta implicito: il rapporto di dipendenza strutturale tra quest'opera e i suoi modelli, in particolare con Molinos, la cui *Guida spirituale* fu condannata nel 1687 — un collegamento che ha peso interpretativo diretto sulla comprensione del rischio dottrinale corso dall'autrice.

`<note type="glossa" subtype="corrigenda">` con `@hand` e `@place="margin"` distingue le glosse marginali con cui l'autrice, in un secondo momento, precisa o attenua un'affermazione già scritta, da qualunque altra nota di natura diversa — fenomeno materiale specifico e ricorrente nel Libro III, dove tali glosse costituiscono la principale traccia visibile della sua auto-censura dottrinale.

**Apparato critico.** `<app>`/`<lem wit="#txt-c">`/`<rdg wit="#txt-b0">` costituiscono il nucleo dell'apparato genetico: il lemma riporta la lezione dell'edizione critica, le lezioni alternative sono ancorate ai testimoni dichiarati in `<listWit>` tramite `@wit`. All'interno di ciascun `<rdg>`, `<del>` e `<add>` — con `@place` (`inline`/`margin`), `@hand`, `@resp` e `@type` (`correction`/`substitution`/`integration`) — permettono di specificare non solo che una variante esiste, ma la sua natura materiale precisa: una cancellatura interlineare di mano dell'autrice non ha lo stesso peso filologico di un'aggiunta marginale di mano esterna, e il tag set core li rende entrambi tracciabili distintamente. `<subst>` è previsto per le sostituzioni che comportano insieme una cancellatura e un'aggiunta come evento unico, distinguendole dai casi in cui le due operazioni sono invece disgiunte nel tempo.

`<unclear>`, `<gap reason="illegible">` e `<supplied reason="conjecture">` completano l'apparato per le porzioni di testo materialmente compromesse — coerenti con quanto già dichiarato nella descrizione fisica del manoscritto, dove si segnalano abrasioni, scolorimenti e guasti meccanici marginali.

**Citazioni.** `<cit type="bible">`/`<cit type="liturgy">` con `<quote xml:lang="la">` e `<foreign xml:lang="la">` isolano le citazioni bibliche e liturgiche che l'autrice inserisce come suggello di autorità nei punti dottrinalmente più esposti — un uso retorico specifico e ricorrente nella prefazione e nei capitoli codificati, dove ogni protesta di ortodossia è quasi sempre accompagnata da una citazione scritturale a sostegno.

### 5. Struttura del pacchetto del micro‑commit

- Documento descrittivo
- Trascrizione TEI diplomatica vs trascrizione regolarizzata
- Trascrizione TEI interpretativa
- Apparati: varianti, fenomeni materiali, note linguistiche
- Metadati

### 6. Metadati

- **Titolo:** Il Castello dell'anima, Libro III, capp. I–V
- **Autore:** Teresa di San Geronimo (Anna La Longa), 1670–post 1703
- **Datazione:** 1692–1694 (Libro III)
- **Manoscritto:** Palermo, Biblioteca Comunale, ms. 2 Qq E 29
- **Descrizione:** Prima edizione critica digitale TEI dei capp. I–V, con apparato genetico `<app>`/`<lem>`/`<rdg>`, sistema retorico via `<seg>`, autorità VIAF per persone e fonti dottrinali
- **Parole chiave:** Castello dell'anima; mistica secentesca; contemplazione infusa; TEI; edizione critica digitale

### 7. Risultati attesi

- Base critica per la marcatura TEI;
- Definizione del blocco ascensionale del Libro III;
- Preparazione del terreno per MC2 (capp. VI–VIII).

### 8. Roadmap

- **MC1:** Capp. I–V (stati introduttivi dell'unione).
- **MC2:** Capp. VI–VIII (sviluppo dell'unione).
- **MC3:** Capp. IX–XII (zone più complesse).
- **MC finale:** integrazione.
