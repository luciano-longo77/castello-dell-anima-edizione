# `tests/` — Regressione della validazione (MC-1)

La CI (`.github/workflows/validate.yml`) dimostra che i **dati buoni passano**.
Questa suite dimostra il complemento necessario a un'edizione affidabile: che gli
**input sbagliati vengano respinti** da schema e guardie. Non basta che lo schema
*accetti* il dataset corrente; deve anche *impedire* configurazioni errate.

## Come funziona

`run_regression.py` parte dai **dati reali** (`../data/`), applica **una mutazione
errata alla volta a runtime** — in memoria, i file di release **non vengono toccati** —
e verifica che il validatore competente **fallisca** (exit ≠ 0). Include tre
**controlli positivi** (i dati validi devono passare).

Casi coperti (12):

| # | Mutazione | Deve respingerla |
|---|---|---|
| + | testo valido | guardia_apparato / guardia_puntatori / jing |
| 1 | `retrace` dentro `<app>` | guardia_apparato |
| 2 | `@varSeq` con una sola `<rdg>` | guardia_apparato |
| 3 | `<corr>` senza `@resp` | guardia_apparato |
| 4 | `<pb>` fuori dalla sequenza 158r–168r | guardia_apparato |
| 5 | `retrace` con `@hand` ≠ `#ink_3-dark` | guardia_apparato |
| 6 | `term/@ref` a stato inesistente | guardia_puntatori |
| 7 | `@wit` pendente | guardia_puntatori |
| 8 | `<interp>` (elemento cancellato dall'ODD) | jing (RELAX NG) |
| 9 | elemento inesistente `<zzz>` | jing (RELAX NG) |

## Esecuzione

```bash
pip install lxml
sudo apt-get install -y libxml2-utils jing
python3 Micro-commits/MC-1/tests/run_regression.py
```

Esce con codice `0` se **tutti** i test passano (buoni accettati, cattivi respinti),
`1` altrimenti. È pensato per essere aggiunto alla CI come passo successivo alla
validazione dei dati.
