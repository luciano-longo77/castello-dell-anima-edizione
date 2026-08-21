# (MC1) Micro‑progetto di Edizione Critica Digitale
## Registro delle decisioni editoriali — *Editorial Decision Log*
**Edizione critica digitale del *Castello dell'anima*** · **ms. Palermo, BCP, 2 Qq E 29**

[![License: CC BY 4.0](https://img.shields.io/badge/License-CC%20BY%204.0-lightgrey?logo=creativecommons)](https://creativecommons.org/licenses/by/4.0/)
![TEI P5](https://img.shields.io/badge/TEI-P5-blueviolet?logo=xml)
![Micro-commit](https://img.shields.io/badge/Micro--commit-MC1-informational)

## A cosa serve questo documento

Un'edizione critica non è solo il suo risultato, ma anche la **tracciabilità del perché**
di ogni scelta. Questo registro elenca le **decisioni editoriali sostanziali** prese nel
MC‑1, con motivazione, luogo (§) ed eventuale riscontro esterno. Completa i criteri
generali di [`Autorita-editoriali.md`](Autorita-editoriali.md) (lo *statuto* di ogni
marcatura) e i criteri ecdotici di [`Introduzione-III,1-5.md`](Introduzione-III,1-5.md)
§3, dando conto dei **casi singoli** decisi in sede di revisione.

Riscontro esterno: dove indicato «(gemello)», la lezione è stata confrontata con la
trascrizione interpretativa indipendente del progetto multiassiale gemello
(*castello-anima-TEI-IA*), condotta sullo stesso autografo.

## Principi applicati

- **`orig` = forma del manoscritto** (dato documentario); **`reg` = regolarizzazione
  esclusivamente grafica**. La morfologia dialettale non è "regolarizzata": resta la
  forma d'autrice.
- Il nesso latineggiante **`-ti-` (‑*tione*) non si normalizza** in ‑*zione*.
- La **scempia** del testimone si conserva (non si raddoppia d'ufficio).
- Ogni integrazione o congettura editoriale è **esplicita e attribuita** (`@resp`,
  `@cert`); il dato non è mai soppresso.

## 1. Trascrizione a due livelli — correzioni di refusi `orig`/`reg`

In nove `<choice>` la forma moderna era finita per errore nell'`orig` (che deve dire
*cosa c'è sulla carta*) e quella del ms nel `reg`. Poiché l'autografo è siciliano di fine
Seicento, la forma dialettale/scempia è quella materialmente presente: è stata riportata
in `orig`. In gran parte dei casi il `<choice>` era spurio (una sola forma esiste) ed è
stato **rimosso**, lasciando testo semplice.

| § / luogo | Decisione | Riscontro |
|---|---|---|
| II §16 | esiste solo **stamo** (non *stiamo*) → choice rimosso | (gemello) |
| II §18 | esiste solo **vuoluto** → choice rimosso | (gemello) |
| III §35 | **adormentarsi** (scempia); un solo choice `orig=ad' adormentarsi` / `reg=ad adormentarsi` | (gemello) |
| III §36 | **interpellatione** (nesso ‑*ti*‑ non normalizzato) → choice rimosso, spezzatura di riga conservata | (gemello) |
| III §39 | esiste solo **vuoler** → choice rimosso | (gemello) |
| III §42 | esiste solo **posesso** (scempia conservata) → choice rimosso | ms |
| V §62 | esiste solo **diffirente** → choice rimosso | (gemello) |
| V §65 | **subordenata** nel `lem` e nella `rdg` (allineati) | (gemello) |
| V (arg.) | «il **sù** detto» → choice rimosso (`suù` era refuso) | ms |

## 2. Membri vuoti nel `<choice>`

| § / luogo | Decisione |
|---|---|
| V §70 | *vita* è parola del ms (non integrazione): l'`<orig/>` vuoto era un refuso → **testo semplice** «tener vita mai da lei esperimentata» (gemello) |
| V §62 · §71 | parole spezzate dal richiamo di pagina (*l'…anima*, *cen…tro*): il frammento con `reg` vuoto è stato **rimosso**; la parola resta intera una sola volta, mentre `<fw type="catch">` e la nota documentano il richiamo (gemello) |

## 3. Apparato genetico e ricostruzione

- **§64 (aggiunta marginale guasta).** La `rdg` (Tb0) riproduce fedelmente il guasto
  (`gap`/`supplied`); la lezione ricostruita nel `lem`/`reg` è marcata **`@cert="medium"`**
  (congettura dichiarata: *crerrà→verrà*, *tempesta→tempo*, *franierà→bramerà*,
  *paria→patria*, *cen→centro*), coerentemente con la resa del gemello.
- **`@varSeq`**: usato solo con ≥2 `<rdg>` concorrenti — in MC‑1 non ricorre (0 casi).

## 4. Integrazioni su guasto (`<supplied>`)

Tutti i **25 `<supplied reason="hole">`** sono attribuiti con **`resp="#editor"` `cert="medium"`**:
un guasto materiale rende ogni restituzione un'inferenza dell'editore, quindi sempre
esplicitata e attribuita (allineato alla convenzione del gemello e al principio «i livelli
editoriali sono sempre attribuiti» di [`Autorita-editoriali.md`](Autorita-editoriali.md)).

## 5. Espunzioni (`sic`/`corr`)

Due dittografie al confine di richiamo sono espunte con `<corr resp="#editor"/>` vuoto
(la lezione del ms resta in `<sic>`): **§ (c. 166v)** «essendo» ripetuto dopo il richiamo;
**V §71** «e» spurio. L'intervento è editoriale e attribuito.

## 6. Modello e paratesto

- **`listWit` a due gruppi**: *stati genetici dell'autografo* (Tb0–T4) vs *livello
  editoriale* (Tc). **Tc non è un testimone** ma la lezione costituita dall'editore.
- **Bibliografia critica**: dichiarata in `<listBibl type="studi">` (6 voci), distinta
  dalle fonti dottrinali (`type="fontes"`).

---
## Licenza
Creative Commons Attribution 4.0 International (**CC BY 4.0**).

---

## 👤 Curatore
**Luciano Longo**
- Contatti: <luciano.longo@dedalus.com>
- ORCID: <https://orcid.org/0009-0005-7557-7546>
- GitHub: <https://github.com/luciano-longo77>
