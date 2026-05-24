# dbt CLI commands (dbt_learning)

Run all commands from the **project directory** (where `dbt_project.yml` lives):

```bash
cd c:\dbt_tutorial\dbt_learning
```

This folder is a **command reference** for this repo. Concept docs live elsewhere ([seeds](../seeds/README.md), [tests](../tests/README.md), [analyses](../analyses/README.md)).

---

## Before you run anything

| Step | Command | Purpose |
|------|---------|---------|
| 1 | [setup.md](setup.md) → `dbt debug` | Verify profile and warehouse connection |
| 2 | `dbt deps` | Install packages (if you add `packages.yml`) |
| 3 | See resource guides below | Run only what you need |

---

## Quick reference (this project)

| Goal | Command |
|------|---------|
| Run **one model** | `dbt run --select bronze_sales` |
| Run **all bronze models** | `dbt run --select path:models/bronze` |
| Load **one seed** | `dbt seed --select lookup_test` |
| Run **one singular test** | `dbt test --select non_negative_test` |
| Run **all tests on one model** | `dbt test --select bronze_sales` |
| **Compile** one analysis | `dbt compile --select lookup_analysis` |
| Run model **and** its tests | `dbt build --select bronze_sales` |
| List nodes (find exact names) | `dbt ls --select bronze_sales` |

Use **forward slashes** in `path:` selectors even on Windows.

---

## Guides by resource

| File | Contents |
|------|----------|
| [setup.md](setup.md) | `debug`, `clean`, `deps`, profiles, troubleshooting |
| [models.md](models.md) | Single model, folder, layer, `run` vs `build`, full-refresh |
| [seeds.md](seeds.md) | Single seed, full-refresh, order with models |
| [tests.md](tests.md) | Single test file, one model’s tests, one generic test, listing test names |
| [analyses.md](analyses.md) | Compile one analysis, dependencies, compiled output path |
| [selectors.md](selectors.md) | `--select` grammar: `path:`, `test_type:`, `+`, `@`, exclusions |

---

## Typical workflows

### First-time or after clone

```bash
dbt debug
dbt seed
dbt run
dbt test
```

### Change one bronze model only

```bash
dbt run --select bronze_customer
dbt test --select bronze_customer
```

### Change seed + model that uses it

```bash
dbt seed --select lookup_test
dbt run --select +lookup_test
```

(`+` includes downstream models that depend on the seed — see [selectors.md](selectors.md).)

### Everything for one area (seed → downstream)

```bash
dbt build --select +lookup_test
```

`dbt build` = run seeds (if selected), run models, run tests — in dependency order.

---

## Discover what dbt will run

When you are unsure of the exact node name:

```bash
# List models
dbt ls --resource-type model

# List tests (note full test ids for generic tests)
dbt ls --resource-type test

# Preview selection without executing
dbt ls --select bronze_sales
dbt ls --select bronze_sales,test_type:unique
```

---

## Official docs

- [dbt command reference](https://docs.getdbt.com/reference/dbt-commands)
- [Node selection syntax](https://docs.getdbt.com/reference/node-selection/syntax)
