# Model commands (`dbt run` / `dbt build`)

[← Back to commands index](README.md)

Models live under `models/`. In this project, bronze models include:

| Model | File |
|-------|------|
| `bronze_sales` | `models/bronze/bronze_sales.sql` |
| `bronze_customer` | `models/bronze/bronze_customer.sql` |
| `bronze_store` | `models/bronze/bronze_store.sql` |
| `bronze_product` | `models/bronze/bronze_product.sql` |
| `bronze_date` | `models/bronze/bronze_date.sql` |

---

## Run all models

```bash
dbt run
```

---

## Run a single model (by name)

Use the **filename without `.sql`**:

```bash
dbt run --select bronze_sales
```

Other examples:

```bash
dbt run --select bronze_customer
dbt run --select bronze_store
```

Short form (same as `--select`):

```bash
dbt run -s bronze_sales
```

---

## Run a single file (by path)

```bash
dbt run --select path:models/bronze/bronze_sales.sql
```

Use forward slashes. Equivalent to selecting the model `bronze_sales`.

---

## Run all models in a folder

```bash
dbt run --select path:models/bronze
```

Runs every model under `models/bronze/`.

---

## Run model + everything downstream

```bash
dbt run --select bronze_sales+
```

Rebuilds `bronze_sales` and any models that `ref('bronze_sales')` (if added later).

---

## Run model + everything upstream first

```bash
dbt run --select +bronze_sales
```

Runs parents (sources, upstream models) then `bronze_sales`.

---

## Full refresh (tables / incremental)

For models materialized as tables (bronze defaults in `dbt_project.yml`):

```bash
dbt run --select bronze_sales --full-refresh
```

Drops and recreates the relation (adapter-specific behavior). Use after logic or schema changes that incremental strategies cannot fix.

---

## Run + test one model (`dbt build`)

```bash
dbt build --select bronze_sales
```

Runs the model, then tests attached to it (YAML in `models/bronze/properties.yml`).

---

## Preview selection (no run)

```bash
dbt ls --select bronze_sales
dbt ls --select path:models/bronze
```

---

## Sources (not models — `dbt run` does not build these)

Source tables are declared in `models/source/source.yml` (`dim_customer`, `fact_sales`, etc.). They are loaded **outside** dbt. Models read them with `source()`.

To run only models that depend on a source (when configured in DAG):

```bash
dbt run --select source:source.dim_customer+
```

Exact syntax may vary by dbt version; use `dbt ls --select source:source.dim_customer+` to verify.

---

## More selector patterns

See [selectors.md](selectors.md).
