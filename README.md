# Edizione Critica Digitale del Terzo Libro del *Castello dell’anima*  
## di suor Teresa di San Geronimo (Anna La Longa)

## Indice

- [Obiettivo principale](#obiettivo-principale)
- [Fase 1: Edizione critica del terzo libro](#fase-1-edizione-critica-del-terzo-libro)
  - [1. Introduzione al progetto](#1-introduzione-al-progetto)
    - [Contesto storico e teologico](#contesto-storico-e-teologico)
    - [Struttura del trattato](#struttura-del-trattato)
  - [2. Edizione digitale del terzo libro](#2-edizione-digitale-del-terzo-libro)
    - [Trascrizione e digitalizzazione](#trascrizione-e-digitalizzazione)
    - [Criteri editoriali](#criteri-editoriali)
    - [Strutturazione del testo](#strutturazione-del-testo)
    - [Note filologiche](#note-filologiche)
  - [3. Analisi delle correzioni e aggiunte](#3-analisi-delle-correzioni-e-aggiunte)
  - [4. Pubblicazione open access](#4-pubblicazione-open-access)
- [Workflow TEI](#workflow-tei)
- [Conclusione](#conclusione)

---

## Obiettivo principale

Realizzare un’edizione critica digitale del terzo libro del *Castello dell’anima* di suor Teresa di San Geronimo, con un’analisi filologica approfondita delle correzioni e delle aggiunte presenti nel manoscritto autografo **Palermo, Biblioteca Comunale, ms. 2 Qq E 29**.

L’edizione è progettata per un utilizzo accademico avanzato e si fonda sull’assunto metodologico che l’autografo costituisca **l’unica tradizione diretta dell’opera**. Tutti i fenomeni grafici, materiali e linguistici sono pertanto trattati come **potenzialmente rilevanti sul piano genetico e interpretativo**.

---

## Fase 1: Edizione critica del terzo libro

### 1. Introduzione al progetto

#### Contesto storico e teologico

Il *Castello dell’anima* descrive il percorso di perfezione spirituale attraverso tre stadi progressivi:
- anime incipienti
- anime proficienti
- anime perfette

Suor Teresa di San Geronimo (1648–1716), terziaria carmelitana palermitana, elabora una riflessione mistica in un contesto segnato da una forte sorveglianza dottrinale. A partire dalla fine del Seicento, temi come l’unione mistica, la quiete e l’otio delle potenze erano considerati ad alto rischio di equivocità teologica.

Nel terzo libro tali tensioni si traducono materialmente in:
- incremento delle aggiunte marginali e interlineari;
- riscritture e precisazioni dottrinali;
- dichiarazioni esplicite di adesione all’ortodossia cattolica.

---

#### Struttura del trattato

Il terzo libro è dedicato allo stadio delle *anime perfette* e costituisce la sezione più densa dal punto di vista sia dottrinale sia genetico. Per questo motivo è assunto come **focus esclusivo dell’edizione critica**, con particolare attenzione alla stratificazione testuale e alla dinamica correttiva dell’autrice.

---

### 2. Edizione digitale del terzo libro

#### Trascrizione e digitalizzazione

Il lavoro editoriale si articola in due passaggi principali:

1. **Trascrizione semi‑diplomatica** del manoscritto autografo
2. **Codifica in XML‑TEI (P5)**

La trascrizione conserva grafia, interpunzione, oscillazioni linguistiche e distribuzione spaziale del testo, mentre la codifica consente una rappresentazione strutturata, interrogabile e verificabile.

##### Elementi TEI utilizzati nella trascrizione

```xml
<add>        <!-- aggiunte marginali o interlineari -->
<del>        <!-- cancellazioni -->
<subst>      <!-- sostituzioni (del + add) -->
<abbr>       <!-- abbreviazioni -->
<expan>      <!-- scioglimenti -->
<sic> <corr> <!-- errore materiale e correzione editoriale -->
<unclear>    <!-- grafia indecifrabile -->
<gap>        <!-- lacune o abrasioni -->
<supplied>   <!-- integrazioni editoriali -->
````

***

#### Criteri editoriali

L’edizione adotta un approccio **semi‑diplomatico**, che:

*   preserva le forme originali;
*   segnala l’espansione delle abbreviazioni;
*   distingue tra testo corrente, correzioni e aggiunte.

Le irregolarità linguistiche (italiano regionale siciliano, sintassi semicolta, interferenze latine) **non sono normalizzate**, poiché costituiscono la cifra stilistica e sociolinguistica dell’autrice.

##### Mani scriventi

Le mani sono descritte attraverso un apparato dedicato basato su:

```xml
<handDesc>
  <handNote xml:id="ink_1">...</handNote>
  <handNote xml:id="ink_2">...</handNote>
  <handNote xml:id="ink_3-dark">...</handNote>
  <handNote xml:id="ink_4-external">...</handNote>
</handDesc>
```

Ogni intervento testuale è collegato alla relativa mano tramite l’attributo:

```xml
@hand
```

***

#### Strutturazione del testo

Il testo è organizzato secondo una segmentazione gerarchica stabile, conforme ai file TEI del progetto:

```xml
<div type="book" n="3">
  <div type="chapter" n="1">
    <p n="1">
      <seg xml:id="III-cap-1-p1-001">...</seg>
    </p>
  </div>
</div>
```

Questa struttura consente:

*   la rappresentazione della progressione mistica interna;
*   l’integrazione dell’apparato critico in situ;
*   il collegamento puntuale con il supporto materiale.

***

#### Note filologiche

L’edizione include:

*   note filologiche ed esplicative;
*   identificazione delle mani scriventi;
*   confronto con la tradizione mistica carmelitana;
*   analisi delle strategie di mitigazione dottrinale.

##### Apparato critico

L’apparato è rappresentato mediante **segmentazione parallela**, utilizzando:

```xml
<app>
  <lem wit="#txt-c">testo base</lem>
  <rdg wit="#txt-b0">variante</rdg>
  <rdg wit="#txt-1">riscrittura</rdg>
</app>
```

I testimoni interni sono dichiarati in:

```xml
<listWit>
  <witness xml:id="txt-b0"/>
  <witness xml:id="txt-b1"/>
  <witness xml:id="txt-1"/>
  <witness xml:id="txt-2"/>
  <witness xml:id="txt-3"/>
  <witness xml:id="txt-4"/>
  <witness xml:id="txt-c"/>
</listWit>
```

***

### 3. Analisi delle correzioni e aggiunte

Le modifiche testuali sono classificate come:

*   varianti sostitutive;
*   aggiunte marginali o interlineari;
*   cancellazioni.

La posizione materiale delle modifiche è indicata tramite:

```xml
@place="margin | interlinear | inline | top | bottom"
```

e correlata alla foliazione originale attraverso:

```xml
<pb n="158r"/>
```

Particolare attenzione è rivolta ai fascicoli e ai foglietti intercalati, registrati come parte integrante del dossier genetico.

***

### 4. Pubblicazione open access

L’edizione è pubblicata in open access nei seguenti formati:

*   XML/TEI (dati primari)
*   HTML (interfaccia di consultazione)

I metadati includono:

*   titolo
*   autore
*   descrizione del progetto
*   fonte manoscritta
*   data
*   licenza

***

## Workflow TEI

1.  Ricognizione materiale del manoscritto (`<msDesc>`)
2.  Trascrizione semi‑diplomatica
3.  Definizione delle mani (`<handDesc>`)
4.  Strutturazione del testo (`<div>`, `<p>`, `<seg>`)
5.  Codifica delle varianti (`<app>`, `<lem>`, `<rdg>`)
6.  Collegamento ai facsimili (`<pb>`, `<surface>`, `<graphic>`)
7.  Revisione filologica e validazione XML
8.  Pubblicazione e documentazione metodologica

***

## Conclusione

L’edizione critica digitale del terzo libro del *Castello dell’anima* mira a restituire il testo come **processo stratificato**, profondamente influenzato dal contesto storico‑dottrinale e dalla necessità di controllo prudenziale.

