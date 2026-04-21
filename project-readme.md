# Edizione Critica Digitale del Terzo Libro del Castello dell’anima
## di suor Teresa di San Geronimo (Anna La Longa)

![Revision](https://img.shields.io/badge/revision-5-blue)

## Indice

- [Obiettivo principale](#obiettivo-principale)
- [Fase 1: Edizione critica del terzo libro](#fase-1-edizione-critica-del-terzo-libro)
  - [Introduzione al progetto](#introduzione-al-progetto)
    - [Contesto storico e teologico](#contesto-storico-e-teologico)
    - [Struttura del trattato](#struttura-del-trattato)
  - [Edizione digitale del terzo libro](#edizione-digitale-del-terzo-libro)
    - [Trascrizione e digitalizzazione](#trascrizione-e-digitalizzazione)
    - [Elementi TEI utilizzati nella trascrizione](#elementi-tei-utilizzati-nella-trascrizione)
    - [Criteri editoriali](#criteri-editoriali)
    - [Apparato critico](#apparato-critico)
    - [Strutturazione del testo](#strutturazione-del-testo)
    - [Note filologiche](#note-filologiche)
  - [Analisi delle correzioni e aggiunte](#analisi-delle-correzioni-e-aggiunte)
  - [Pubblicazione open access](#pubblicazione-open-access)
- [Testi derivati e sperimentazione TEI + AI](#testi-derivati-e-sperimentazione-tei--ai)
- [Workflow TEI](#workflow-tei)
- [Conclusione](#conclusione)

## Obiettivo principale

Realizzare un’edizione critica digitale del terzo libro del Castello dell’anima di suor Teresa di San Geronimo, con particolare attenzione alla dimensione genetica, alle dinamiche correttive e alle modalità di autocontrollo dottrinale presenti nell’autografo.

L’edizione si fonda sull’assunto metodologico che il manoscritto autografo  
Palermo, Biblioteca Comunale, ms. 2 Qq E 29  
costituisca l’unica tradizione diretta dell’opera. Tutti i fenomeni grafici, materiali e linguistici sono pertanto trattati come potenzialmente rilevanti sul piano filologico, storico e interpretativo.

## Fase 1: Edizione critica del terzo libro

## Introduzione al progetto

### Contesto storico e teologico

Il Castello dell’anima articola il percorso di perfezione spirituale secondo tre stadi progressivi:

- anime incipienti
- anime proficienti
- anime perfette

Suor Teresa di San Geronimo (Anna La Longa, 1670–1716), terziaria carmelitana palermitana, sviluppa la propria riflessione mistica in un contesto caratterizzato da forte sorveglianza dottrinale. A partire dalla fine del Seicento, temi quali l’unione mistica, la quiete e l’otium delle potenze erano considerati suscettibili di equivoci teologici e frequentemente associati al sospetto di quietismo.

Nel terzo libro, tali tensioni emergono con particolare evidenza attraverso:

- un incremento delle aggiunte marginali e interlineari;
- riscritture e precisazioni dottrinali;
- dichiarazioni esplicite di adesione all’ortodossia cattolica.

### Struttura del trattato

Il terzo libro è dedicato allo stadio delle anime perfette e rappresenta la sezione più densa dal punto di vista dottrinale e genetico. Per questo motivo è assunto come focus esclusivo dell’edizione critica, con attenzione specifica alla stratificazione scrittoria e ai processi di revisione autoriale.

## Edizione digitale del terzo libro

### Trascrizione e digitalizzazione

Il lavoro editoriale si articola in due passaggi principali:

1. Trascrizione diplomatico‑conservativa del manoscritto autografo, condotta senza operare alcuna normalizzazione grafica, ortografica o morfosintattica.  
   La trascrizione conserva integralmente la patina linguistica del testo, incluse oscillazioni diacritiche, grafiche e sintattiche, considerate parte costitutiva del dato autografo.  
   Le abbreviazioni materiali che comprometterebbero la leggibilità (ad es. dunq., total.te, V.R.) sono sciolte per esteso.

2. Codifica in XML‑TEI (P5), finalizzata alla strutturazione, interrogabilità e versionabilità del testo, senza sovrapporre al testo base livelli interpretativi o normalizzanti.

### Elementi TEI utilizzati nella trascrizione

 ```xml

<add>        aggiunte marginali o interlineari
<del>        cancellazioni
<abbr>       abbreviazioni materiali
<expan>      scioglimenti per leggibilità
<unclear>    grafia indecifrabile
<gap>        lacune o abrasioni
<supplied>   integrazioni su guasto meccanico
```

### Criteri editoriali
L’edizione adotta un approccio diplomatico‑conservativo, che:

* preserva integralmente la patina linguistica dell’autografo;
* conserva oscillazioni grafiche, diacritiche e morfosintattiche;
* non opera alcuna normalizzazione linguistica o ortografica;
* scioglie le abbreviazioni materiali esclusivamente per garantire la leggibilità del testo.

Le irregolarità linguistiche (italiano regionale siciliano, sintassi semicolta, interferenze latine) sono assunte come dati storici e sociolinguistici dell’autografo e non vengono corrette o interpretate nel testo base.

#### Mani scriventi
Le mani scriventi sono descritte mediante un apparato dedicato:

```xml
<handDesc>
  <handNote xml:id="ink_1">...</handNote>
  <handNote xml:id="ink_2">...</handNote>
  <handNote xml:id="ink_3-dark">...</handNote>
  <handNote xml:id="ink_4-external">...</handNote>
</handDesc>
```

#### Apparato critico

```xml
<app>
  <lem wit="#txt-c">testo base</lem>
  <rdg wit="#txt-b0">prima stesura</rdg>
  <rdg wit="#txt-1">riscrittura autoriale</rdg>
  <rdg wit="#txt-2">intervento correttivo‑glossativo</rdg>
  <rdg wit="#txt-3">intervento correttivo successivo</rdg>
</app>

<listWit>
  <witness xml:id="txt-b0">Testo base</witness>
  <witness xml:id="txt-b1">Interventi immediati</witness>
  <witness xml:id="txt-1">Riscrittura su testo base</witness>
  <witness xml:id="txt-2">Interventi correttivi‑glossativi</witness>
  <witness xml:id="txt-3">Interventi correttivi successivi</witness>
  <witness xml:id="txt-4">Interventi glossativi esterni</witness>
</listWit>
```

### Strutturazione del testo

```xml
<div type="book" n="3">
  <div type="chapter" n="1">
    <p n="1">
      <seg xml:id="III-cap-1-p1-001">...</seg>
    </p>
  </div>
</div>
```

### Note filologiche
L’edizione include:

* note filologiche ed esplicative:
  ```xml
  <note type="critical">...</note>
  <note type="contextual">...</note>
  ```
* identificazione delle mani scriventi (@hand);
* analisi delle strategie di mitigazione dottrinale.
  
## Analisi delle correzioni e aggiunte
Le modifiche testuali sono classificate come:

* varianti sostitutive;
* aggiunte marginali o interlineari;
* cancellazioni.

La posizione materiale delle modifiche è indicata tramite attributi di localizzazione e correlata alla foliazione originale.

## Pubblicazione open access
L’edizione è pubblicata in open access nei seguenti formati:

* XML/TEI (dati primari)
* HTML (interfaccia di consultazione)

## Testi derivati e sperimentazione TEI + AI
Accanto all’edizione critica del terzo libro, il progetto prevede la costruzione di una trascrizione interpretativa ampiamente regolarizzata; tale rappresentazione è utilizzata esclusivamente a fini computazionali (sperimentazione TEI + AI) e non costituisce in alcun modo il testo editoriale dell’edizione.

## Workflow TEI
1. Ricognizione materiale del manoscritto (`<msDesc>`)
2. Trascrizione diplomatico‑conservativa
3. Definizione delle mani (`<handDesc>`)
4. Strutturazione del testo (`<div>`, `<p>`, `<seg>`)
5. Codifica delle varianti (`<app>`, `<lem>`, `<rdg>`)
6. Collegamento ai facsimili (`<pb>`)
7. Revisione filologica e validazione XML
8. Pubblicazione e documentazione metodologica

## Conclusione
L’edizione critica digitale del terzo libro del Castello dell’anima mira a restituire il testo come processo stratificato, profondamente influenzato dal contesto storico‑dottrinale e dalle pratiche di autocontrollo dell’autrice. La separazione tra edizione critica e sperimentazione computazionale consente di coniugare rigore filologico e innovazione metodologica senza compromettere lo statuto del testo.
