# Seed commands (`dbt seed`)

[← Back to commands index](README.md)

Seeds live in `seeds/`. This project has:

| Seed | File |
|------|------|
| `lookup_test` | `seeds/lookup_test.csv` |

Configured in `dbt_project.yml` to load into schema **bronze** as a table.

---

## Load all seeds

```bash
dbt seed
```

---

## Load a single seed (by name)

Name = **CSV filename without extension**:

```bash
dbt seed --select lookup_test
```

Short form:

```bash
dbt seed -s lookup_test
```

---

## Load a single file (by path)

```bash
dbt seed --select path:seeds/lookup_test.csv
```

---

## Full refresh one seed

Recreates the table (needed after column renames or type changes):

```bash
dbt seed --select lookup_test --full-refresh
```

---

## Seed then run models that use it

`lookup_analysis` and future models may `ref('lookup_test')`. Order:

```bash
dbt seed --select lookup_test
dbt run --select +lookup_test
```

Or one shot (seed + downstream models + their tests):

```bash
dbt build --select +lookup_test
```

---

## Preview selection

```bash
dbt ls --resource-type seed
dbt ls --select lookup_test
```

---

## Notes

- Seeds do **not** run on `dbt run` alone — use `dbt seed` or include them in `dbt build --select ...`.
- Fix CSV headers before seeding on Databricks (no spaces in column names). See [seeds/README.md](../seeds/README.md).

---

## More selector patterns

See [selectors.md](selectors.md).
