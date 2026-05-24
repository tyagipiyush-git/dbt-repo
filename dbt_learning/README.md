# dbt_learning

Hands-on dbt project for transformations, data quality, and a medallion-style layout (`bronze` → `silver` → `gold`).

Concept documentation lives **next to the code** — one README per folder. **CLI how-to** is in `commands/`:

| Folder | Topic | README |
|--------|--------|--------|
| `commands/` | CLI: run one file, one test, selectors | [commands/README.md](commands/README.md) |
| `seeds/` | CSV reference data loaded with `dbt seed` | [seeds/README.md](seeds/README.md) |
| `tests/` | Data quality tests (generic, singular, macros) | [tests/README.md](tests/README.md) |
| `models/` | SQL transformations (`dbt run`) | *coming soon* |
| `macros/` | Reusable Jinja/SQL | *coming soon* |
| `snapshots/` | Slowly changing dimensions | *coming soon* |
| `analyses/` | Compiled exploratory SQL (not materialized) | [analyses/README.md](analyses/README.md) |

---

## Quick start

```bash
cd dbt_learning
dbt debug          # verify connection
dbt seed           # load seeds — see seeds/README.md
dbt run            # build models
dbt test           # run tests — see tests/README.md
```

Run **one resource only** (model, seed, test, analysis): see [commands/README.md](commands/README.md).

Or run models and tests together:

```bash
dbt build
```

---

## Project layout

```
dbt_learning/
├── commands/       # CLI reference (single file, single test, selectors)
├── seeds/          # CSV → warehouse tables (dbt seed)
├── models/         # bronze / silver / gold SQL
├── tests/          # singular & project-specific tests
├── macros/         # shared Jinja macros
├── snapshots/      # SCD-style captures
├── analyses/       # one-off SQL (not materialized)
├── dbt_project.yml
└── profiles.yml    # connection (keep secrets out of git)
```

---

## Resources

- [What is dbt?](https://docs.getdbt.com/docs/introduction)
- [dbt command reference](https://docs.getdbt.com/reference/dbt-commands)
