# Edizione Critica Digitale *Il Castello dell'anima* (Libro III)
## Introduzione

[![TEI P5](https://img.shields.io/badge/TEI-P5-334155)](https://tei-c.org/) ![DSE](https://img.shields.io/badge/DSE-Digital_Scholarly_Editing-8B0000) [![Castello dell'anima](https://img.shields.io/badge/Castello%20dell%27anima-7b2d3b)](https://github.com/luciano-longo77/castello-anima-TEI-IA)

**Autrice**: Teresa di San Geronimo (Anna La Longa, 1670–post 1703)  
**Editor**: Luciano Longo  
**Licenza**: CC BY 4.0 

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
- [Workflow TEI](#workflow-tei)
- [Conclusione](#conclusione)

## Obiettivo principale

Realizzare un’**edizione critica digitale** del **III libro** del *Castello dell’anima* di suor Teresa di San Geronimo, con particolare attenzione alla dimensione genetica, alle dinamiche correttive e alle modalità di autocontrollo dottrinale presenti nell’autografo.

L’edizione si fonda sull’assunto metodologico che il manoscritto autografo *Palermo, Biblioteca Comunale, ms. 2 Qq E 29*  costituisca l’**unica tradizione diretta dell’opera**. Tutti i fenomeni grafici, materiali e linguistici sono pertanto trattati come potenzialmente rilevanti sul piano filologico, storico e interpretativo.

## Fase 1: Edizione critica del III libro
## Introduzione al progetto
### Contesto storico e teologico

Il Castello dell’anima articola il percorso di perfezione spirituale secondo tre stadi progressivi:

- anime incipienti
- anime proficienti
- anime perfette

**Suor Teresa di San Geronimo** (Anna La Longa, 1670–post 1703), terziaria carmelitana palermitana, sviluppa la propria riflessione mistica in un contesto caratterizzato da forte sorveglianza dottrinale. A partire dalla fine del Seicento, temi quali l’**unione mistica**, la **quiete** e l’**otium delle potenze** erano considerati suscettibili di equivoci teologici e frequentemente associati al sospetto di quietismo.

Nel **III libro**, tali tensioni emergono con particolare evidenza attraverso:

- un incremento delle aggiunte marginali e interlineari;
- riscritture e precisazioni dottrinali;
- dichiarazioni esplicite di adesione all’ortodossia cattolica.

### Struttura del trattato

Il **III libro** è dedicato allo stadio delle **anime perfette** e rappresenta la sezione più densa dal punto di vista dottrinale e genetico. Per questo motivo è assunto come focus dell’edizione critica, con attenzione specifica alla stratificazione scrittoria e ai processi di revisione autoriale.

## Edizione digitale del III libro
### Trascrizione e digitalizzazione

Il lavoro editoriale si articola in due passaggi principali:

1. **Trascrizione diplomatico-interpretativa** del manoscritto autografo, condotta senza operare alcuna normalizzazione grafica, ortografica o morfosintattica. La trascrizione conserva integralmente la patina linguistica del testo, incluse oscillazioni diacritiche, grafiche e sintattiche, considerate parte costitutiva del dato autografo. Le abbreviazioni materiali che comprometterebbero la leggibilità (ad es. dunq., total.te, V.R.) sono sciolte per esteso.

2. **Codifica in XML‑TEI** (P5), finalizzata alla strutturazione, interrogabilità e versionabilità del testo, senza sovrapporre al testo base livelli interpretativi o normalizzanti.

### Elementi TEI utilizzati nella trascrizione

La codifica si articola in **tre layer** — filologico‑grafico, mistico‑dottrinale, intertestuale — che poggiano su una **trascrizione a due livelli** (diplomatico ⇄ interpretativo) resa con `<choice>`:

 ```xml
<!-- Layer filologico-grafico: trascrizione a due livelli -->

<choice>
<orig>à</orig>
<reg>a</reg>
</choice>  --> grafia originale ⇄ regolarizzata

<choice>
<abbr>dunq</abbr>
<expan>dunque</expan>
</choice>  --> abbreviazione ⇄ scioglimento

<choice>
<sic>ad</sic>
<corr>al</corr>
</choice>   --> lezione erronea ⇄ correzione editoriale

<add>        aggiunte marginali o interlineari
<del>        cancellazioni
<subst>      sostituzione (del + add come evento unico)
<unclear>    grafia indecifrabile
<gap>        lacune o abrasioni
<supplied>   integrazioni su guasto meccanico

<!-- Layer mistico-dottrinale: lessico agganciato al vocabolario degli stati -->
stato mistico
<term ref="#unione">unione</term>                    

<!-- Layer intertestuale: rimandi e citazioni -->
rimando a fonte
<ref target="#avila-castello">castello dell'anima</ref>   

citazione con fonte
<cit>
<quote xml:lang="lat">…</quote>
<bibl/>
</cit>   

brano in lingua diversa
<foreign xml:lang="lat">…</foreign>                  
```

La trascrizione a **due livelli**, in cui la *lezione diplomatica* e la sua *regolarizzazione* coesistono via `<choice>`, è tenuta distinta dalla *trascrizione interpretativa* ampiamente regolarizzata, sviluppata nel repository separato **`castello-anima-TEI-IA`**: quest'ultima è un livello *derivato*, prodotto a soli fini computazionali, e non fa parte del testo dell'edizione.

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
  <handNote xml:id="pencil_1">...</handNote>
  <handNote xml:id="ink_4-external">...</handNote>
</handDesc>
```

Le mani descritte sono **cinque**: quattro autografe di Teresa 
-`ink_1` e `ink_2` (inchiostro bruno),
- `ink_3-dark` (inchiostro scuro),
- `pencil_1` (matita)
- più la mano esterna `ink_4-external`.

#### Apparato critico

```xml
<app>
  <lem wit="#txt-c">lezione critica costituita</lem>
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
  <witness xml:id="txt-c" resp="#editor">Testo critico costituito (lemma)</witness>
</listWit>
```

Le `witness` dichiarate sono **sette**: i sei livelli genetici (Tb0, Tb1, T1–T4) più il livello costituito **Tc** (`txt-c`, `@resp="#editor"`), che `<lem wit="#txt-c">` richiama come lezione dell'edizione.

### Strutturazione del testo

```xml
<div type="book" n="3">
  <div type="chapter" n="1">
    <head>Capitolo primo</head>

    <argument>
        <p>Si tratta della dispositione che lascia
            nell'anima la <term ref="#notte">notte dello spirito</term>.
        </p>
    </argument>

    <p n="1" xml:id="III-cap1-p1">Quando più un'anima è ragionata di
      <term>croce</term> e <term>travagli</term>,
        <choice>
          <orig>altri tanto</orig>
          <reg>altritanto</reg>
        </choice>
        è più sicuro lo stato suo (...)</p>
  </div>
</div>
```

L'unità testuale di riferimento è il paragrafo **`<p n="…">`**, mentre il lessico mistico è isolato da **`<term ref="…">`**.

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


## Workflow TEI
1. Ricognizione materiale del manoscritto (`<msDesc>`)
2. Trascrizione diplomatico‑conservativa
3. Definizione delle mani (`<handDesc>`)
4. Strutturazione del testo (`<div>`, `<p>`) e trascrizione a due livelli (`<choice>`)
5. Codifica delle varianti (`<app>`, `<lem>`, `<rdg>`)
6. Collegamento ai facsimili (`<pb>`)
7. Revisione filologica e validazione XML
8. Pubblicazione e documentazione metodologica

## Conclusione
L’edizione critica digitale del III del *Castello dell’anima* mira a restituire il testo come processo stratificato, influenzato dal contesto storico‑dottrinale e dalle pratiche di autocontrollo. La separazione tra edizione critica e sperimentazione computazionale consente di coniugare rigore filologico e innovazione metodologica senza compromettere lo statuto del testo.

## Licenza
Creative Commons Attribution 4.0 International (**CC BY 4.0**).  

---

## 👤 Curatore
**Luciano Longo**   
- Contatti: <luciano.longo@dedalus.com> 
- ORCID: <https://orcid.org/0009-0005-7557-7546> 
- GitHub: <https://github.com/luciano-longo77>
- Website: <https://luciano-longo77.github.io>
