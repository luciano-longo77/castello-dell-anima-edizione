# Il `teiHeader` del *Castello dell'anima* — Guida di lettura al file (MC1)

## A cosa serve questo documento

Guida di lettura al file XML. Le decisioni di merito sono in `2_MC-1_III_1-5-introduzione.md` (§3.1, §3.11, §3.12).

## Viewer

È disponibile un viewer HTML interattivo per consultare il `teiHeader` senza leggere l'XML grezzo.

*(link al viewer da inserire qui una volta pubblicato su GitHub Pages)*

## Dove trovare cosa, nel file XML

| Sezione | Cosa contiene |
|---|---|
| `fileDesc/titleStmt` | Titolo, autrice, curatore |
| `fileDesc/publicationStmt` | Editore, data, licenza |
| `fileDesc/notesStmt` | Note critiche e biografiche |
| `fileDesc/sourceDesc/msDesc/msContents` | Incipit/explicit dei tre libri |
| `fileDesc/sourceDesc/msDesc/physDesc` | Supporto, dimensioni, condizione, layout |
| `fileDesc/sourceDesc/msDesc/handDesc` | Le mani scriventi |
| `encodingDesc/projectDesc` | Obiettivi e workflow del modello |
| `encodingDesc/editorialDecl` | Criteri di trascrizione e apparato critico |
| `encodingDesc/tagsDecl` | Elenco dei tag usati nel testo |
| `encodingDesc/classDecl` | Tassonomie |
| `profileDesc/langUsage` | Descrizione della lingua del testo |
| `profileDesc/particDesc` | Persone e organizzazioni |
| `revisionDesc` | Cronologia degli interventi editoriali |

## Validare il file

```bash
xmllint --noout --relaxng tei_all.rng castello-anima-teiHeader-definitivo.xml
```

## Documenti correlati

- [Readme generale del progetto](https://github.com/luciano-longo77/castello-dell-anima-edizione/blob/main/tei-model/MC_readme-generale/readme.md)
- [1. README generale MC1](https://github.com/luciano-longo77/castello-dell-anima-edizione/blob/main/tei-model/MC_readme-generale/MC1_Castello_MicroCommit_III_1-5/doc/1_MC-1_README_generale.md)
- [2. Introduzione MC1 (Libro III, capp. I–V)](https://github.com/luciano-longo77/castello-dell-anima-edizione/blob/main/tei-model/MC_readme-generale/MC1_Castello_MicroCommit_III_1-5/doc/2_MC-1_III_1-5-introduzione.md)
- [3. Struttura capitoli e cartulazione](https://github.com/luciano-longo77/castello-dell-anima-edizione/blob/main/tei-model/MC_readme-generale/MC1_Castello_MicroCommit_III_1-5/doc/3_MC-1_III_1-5-Struttura%20capitoli%20e%20cartulazione.md)
