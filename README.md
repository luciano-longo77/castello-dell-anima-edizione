# **Edizione Critica Digitale del Terzo Libro del *Castello dell’anima* di suor Teresa di S. Geronimo**

## **Indice**

* [Obiettivo principale](#obiettivo-principale)
* [Fase 1: Edizione critica del terzo libro](#fase-1-edizione-critica-del-terzo-libro)

  * [1. Introduzione al progetto](#1-introduzione-al-progetto)

    * [Contesto storico e teologico](#contesto-storico-e-teologico)
    * [Struttura del trattato](#struttura-del-trattato)
  * [2. Edizione digitale del terzo libro](#2-edizione-digitale-del-terzo-libro)

    * [Trascrizione e digitalizzazione](#trascrizione-e-digitalizzazione)
    * [Criteri editoriali](#criteri-editoriali)
    * [Strutturazione del testo](#strutturazione-del-testo)
    * [Note filologiche](#note-filologiche)
  * [3. Analisi delle correzioni e aggiunte](#3-analisi-delle-correzioni-e-aggiunte)
  * [4. Pubblicazione open access](#4-pubblicazione-open-access)
* [Workflow TEI](#workflow-tei)

  * [Fase 1: Preparazione e trascrizione](#fase-1-preparazione-e-trascrizione)
  * [Fase 2: Codifica TEI](#fase-2-codifica-tei)
  * [Fase 3: Varianti e apparato critico](#fase-3-varianti-e-apparato-critico)
  * [Fase 4: Citazioni e riferimenti](#fase-4-citazioni-e-riferimenti)
  * [Fase 5: Revisione e validazione](#fase-5-revisione-e-validazione)
  * [Fase 6: Pubblicazione](#fase-6-pubblicazione)
* [Conclusione](#conclusione)

---

## **Obiettivo principale**

Realizzare un’edizione critica digitale del terzo libro del *Castello dell’anima* di suor Teresa di S. Geronimo, con un’analisi filologica approfondita delle correzioni e delle aggiunte presenti nel manoscritto autografo **2Qq E 29**.

L’edizione sarà progettata per un utilizzo accademico avanzato, garantendo accessibilità, interoperabilità e trasparenza metodologica.

---

# **Fase 1: Edizione critica del terzo libro**

## **1. Introduzione al progetto**

### **Contesto storico e teologico**

Il *Castello dell’anima* è un’opera mistica che descrive il percorso di perfezione spirituale attraverso tre stadi:

* anime incipienti
* anime proficienti
* anime perfette

Suor Teresa di S. Geronimo (1648–1716), appartenente all’Ordine Carmelitano, sviluppa una riflessione sulla contemplazione e sulla perfezione spirituale in un contesto segnato da tensioni dottrinali.

La condanna del 1697, legata all’accusa di *“nuova mistica”*, si inserisce in un clima di controllo teologico e di vigilanza inquisitoriale, che influenza direttamente la trasmissione del testo.

---

### **Struttura del trattato**

Il terzo libro è dedicato alla fase avanzata del cammino spirituale, in cui l’anima tende alla perfezione e all’unione contemplativa.

Questa sezione costituisce il focus dell’edizione critica, con particolare attenzione alla stratificazione testuale.

---

## **2. Edizione digitale del terzo libro**

### **Trascrizione e digitalizzazione**

Il lavoro si articola in due fasi principali:

1. **Trascrizione diplomatica** del manoscritto
2. **Codifica digitale in XML-TEI (P5)**

La trascrizione conserverà le caratteristiche originali del testo (grafia, varianti, correzioni), mentre la codifica permetterà una rappresentazione strutturata e interrogabile.

---

### **Criteri editoriali**

L’edizione adotterà un approccio **semi-diplomatico**, che:

* preserva le forme originali
* espande le abbreviazioni (segnalate)
* distingue chiaramente tra:

  * testo base
  * correzioni
  * aggiunte

Le varianti saranno registrate in apparato critico.

---

### **Strutturazione del testo**

Il testo sarà organizzato secondo la struttura TEI:

```xml
<div type="chapter" n="x">
  <p>...</p>
</div>
```

#### **Correzioni e aggiunte**

```xml
<corr>...</corr>
<add>...</add>
<del>...</del>
```

#### **Gestione delle varianti**

```xml
<app>
  <lem>testo base</lem>
  <rdg>variante</rdg>
</app>
```

#### **Citazioni**

```xml
<quote type="biblical">...</quote>
<quote xml:lang="la">...</quote>
```

---

### **Note filologiche**

L’edizione includerà:

* note esplicative e filologiche
* glossario dei termini mistici e teologici
* confronto con la tradizione carmelitana
* identificazione delle mani scrittorie (`@hand`)

---

## **3. Analisi delle correzioni e aggiunte**

Le modifiche saranno analizzate secondo una tipologia precisa:

* **varianti sostitutive**
* **aggiunte marginali o interlineari**
* **cancellazioni**

L’analisi considererà:

* funzione stilistica
* funzione teologica
* possibile intervento censorio

Particolare attenzione sarà data ai fascicoli aggiunti (es. cc. 197r, 217v–218r, 258v), per determinarne la paternità.

---

## **4. Pubblicazione open access**

L’edizione sarà pubblicata su **Zenodo**, con i seguenti formati:

* XML/TEI
* PDF
* HTML (interfaccia web)

### **Metadata**

* titolo
* autore
* descrizione del progetto
* fonte manoscritta
* data
* DOI
* licenza (es. CC-BY 4.0)

---

# **Workflow TEI**

## **Fase 1: Preparazione e trascrizione**

* acquisizione del manoscritto (2Qq E 29)
* trascrizione diplomatica
* identificazione delle varianti

---

## **Fase 2: Codifica TEI**

* definizione dello schema (TEI P5)
* creazione del **TEI Header**
* strutturazione del testo
* marcatura semantica

Esempio:

```xml
<note type="marginal">...</note>
```

---

## **Fase 3: Varianti e apparato critico**

* codifica con `<app>`, `<lem>`, `<rdg>`
* distinzione delle mani (`@hand`)
* commento delle varianti

---

## **Fase 4: Citazioni e riferimenti**

```xml
<quote type="biblical">...</quote>
<quote xml:lang="la">...</quote>
```

---

## **Fase 5: Revisione e validazione**

* revisione filologica
* controllo sintattico XML
* validazione rispetto allo schema TEI

---

## **Fase 6: Pubblicazione**

* esportazione dei formati
* caricamento su Zenodo
* documentazione metodologica

---

# **Conclusione**

Il progetto di edizione critica digitale del terzo libro del *Castello dell’anima* mira a valorizzare un testo significativo della spiritualità carmelitana del XVII secolo.

L’integrazione tra filologia tradizionale e tecnologie digitali consente:

* una rappresentazione accurata della stratificazione testuale
* una maggiore accessibilità del testo
* nuove possibilità di ricerca

La pubblicazione open access garantirà la diffusione e l’utilizzo del lavoro nella comunità scientifica internazionale.
