# Node selection syntax (`--select` / `--exclude`)

[← Back to commands index](README.md)

Almost every dbt command accepts **`--select`** (`-s`) and **`--exclude`** (`-e`) to target specific nodes.

Works with: `run`, `test`, `seed`, `build`, `compile`, `ls`, `show` (where supported).

---

## Basic rules

| Rule | Example |
|------|---------|
| Name = file stem (no extension) | `bronze_sales`, `lookup_test`, `non_negative_test` |
| Use forward slashes in paths | `path:models/bronze/bronze_sales.sql` |
| Comma = OR | `bronze_sales,bronze_store` |
| Space in shell | Quote if needed: `--select "bronze_sales+"` |

---

## By resource name

```bash
dbt run --select bronze_sales
dbt seed --select lookup_test
dbt test --select non_negative_test
dbt compile --select lookup_analysis
```

---

## By file path

```bash
dbt run --select path:models/bronze/bronze_sales.sql
dbt seed --select path:seeds/lookup_test.csv
dbt test --select path:tests/non_negative_test.sql
dbt compile --select path:analyses/lookup_analysis.sql
```

---

## By folder path

```bash
dbt run --select path:models/bronze
dbt test --select path:models/bronze
```

---

## Graph operators

| Operator | Meaning | Example |
|----------|---------|---------|
| `+` prefix | Select node **and all upstream** parents | `dbt run --select +bronze_sales` |
| `+` suffix | Select node **and all downstream** children | `dbt run --select bronze_sales+` |
| `@` | Select node, parents, and children | `dbt run --select @bronze_sales` |
| `N+` | Upstream to depth N | `dbt run --select 1+bronze_sales` |

Seed → downstream models:

```bash
dbt build --select +lookup_test
```

---

## By resource type

```bash
dbt ls --resource-type model
dbt ls --resource-type test
dbt ls --resource-type seed
dbt ls --resource-type analysis
```

Combine with selection:

```bash
dbt test --select test_type:singular
dbt test --select test_type:generic
dbt test --select bronze_sales,test_type:unique
```

---

## Sources

```bash
dbt run --select source:source.fact_sales+
```

Format: `source:<source_name>.<table_name>`. See `models/source/source.yml` for names (`source` is the source name).

Verify with:

```bash
dbt ls --select source:source.dim_customer
```

---

## Exclusions

Run all bronze models except one:

```bash
dbt run --select path:models/bronze --exclude bronze_date
```

Run all tests except one singular test:

```bash
dbt test --exclude non_negative_test
```

---

## `dbt build` vs `run` / `test` / `seed`

| Command | Behavior |
|---------|----------|
| `dbt run --select X` | Build model X only |
| `dbt test --select X` | Test X (model or test name) only |
| `dbt seed --select X` | Load seed X only |
| `dbt build --select X` | Seeds (if in graph) + run models + run tests for selection |

Example — one model end-to-end:

```bash
dbt build --select bronze_sales
```

---

## Discover names (always when unsure)

```bash
dbt ls
dbt ls --select path:models/bronze
dbt ls --resource-type test --select bronze_sales
```

Copy exact test ids from `dbt ls` output for single generic test runs.

---

## Command cheat sheet

| Intent | Command |
|--------|---------|
| Single model | `dbt run -s bronze_sales` |
| Single seed | `dbt seed -s lookup_test` |
| Single singular test | `dbt test -s non_negative_test` |
| All tests on model | `dbt test -s bronze_sales` |
| One generic test type on model | `dbt test -s bronze_sales,test_type:unique` |
| Single analysis | `dbt compile -s lookup_analysis` |
| Model + tests | `dbt build -s bronze_sales` |
| Upstream + node | `dbt run -s +bronze_sales` |
| Node + downstream | `dbt run -s bronze_sales+` |

---

## Official reference

- [Node selection syntax](https://docs.getdbt.com/reference/node-selection/syntax)
- [Set operators](https://docs.getdbt.com/reference/node-selection/set-operators)
