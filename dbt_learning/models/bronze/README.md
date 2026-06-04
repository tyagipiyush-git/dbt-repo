# Bronze layer

The **bronze** layer in **dbt_learning** mirrors raw source data into the warehouse under schema **`bronze`**, with light structure and data quality tests. See the [project README](../../README.md) and [silver layer](../silver/README.md) for the next step.

---

## Purpose

| Bronze does | Bronze does not |
|-------------|-----------------|
| Load `source.*` tables via `source()` | Heavy business logic (that is silver/gold) |
| Stable names for downstream `ref()` | Final reporting metrics |
| Column tests on critical fields | Replace ingestion pipelines |

Bronze is **staging**: same grain as source, warehouse-native tables your project owns.

---

## Configuration

From `dbt_project.yml`:

```yaml
bronze:
  +materialized: table
  schema: bronze
```

All models in `models/bronze/` build to `dbt_learning_dev.bronze.<model_name>` (catalog/schema per your profile).

Custom schema behavior: [macros/generate_schema.sql](../../macros/generate_schema.sql).

---

## Sources

Declared in [../source/source.yml](../source/source.yml):

| Source table | Bronze model |
|--------------|--------------|
| `fact_sales` | `bronze_sales` |
| `fact_returns` | `bronze_returns` |
| `dim_customer` | `bronze_customer` |
| `dim_product` | `bronze_product` |
| `dim_date` | `bronze_date` |
| `dim_store` | `bronze_store` |

---

## Models

| Model | SQL pattern | Notes |
|-------|-------------|--------|
| [bronze_sales.sql](bronze_sales.sql) | `select * from source.fact_sales` | Tests: `sales_id` unique/not_null; `gross_amount` generic_non_negative |
| [bronze_returns.sql](bronze_returns.sql) | `select * from source.fact_returns` | Build before `silver_returns` |
| [bronze_customer.sql](bronze_customer.sql) | `select * from source.dim_customer` | Block config: `materialized: table` (overrides YAML view) |
| [bronze_product.sql](bronze_product.sql) | `select * from source.dim_product` | |
| [bronze_date.sql](bronze_date.sql) | `select * from source.dim_date` | Calendar attributes in source |
| [bronze_store.sql](bronze_store.sql) | `select * from source.dim_store` | Tests: store names, country |

---

## Tests

Generic and schema tests live in [properties.yml](properties.yml):

- `bronze_sales`: `not_null`, `unique` on `sales_id`; `generic_non_negative` on `gross_amount`
- `bronze_store`: `accepted_values` on `store_name`; `not_null` on `country`

Singular test example: [tests/non_negative_test.sql](../../tests/non_negative_test.sql) (references `bronze_sales`).

---

## Commands

```bash
# All bronze models
dbt run --select bronze

# One model
dbt run --select bronze_sales

# Bronze + tests
dbt build --select bronze

# New model (e.g. returns) — run before silver that refs it
dbt run --select bronze_returns
```

---

## Dependency graph

```text
source.fact_sales      → bronze_sales
source.fact_returns    → bronze_returns
source.dim_customer    → bronze_customer
source.dim_product     → bronze_product
source.dim_date        → bronze_date
source.dim_store       → bronze_store
        ↓
   silver layer (ref('bronze_*'))
```

---

## Run order with silver

Silver models depend on bronze tables existing in the warehouse:

```bash
dbt run --select bronze
dbt run --select silver
```

Or include parents automatically:

```bash
dbt run --select +silver
```

If you see `bronze_returns cannot be found`, run `dbt run --select bronze_returns` first.

---

## Further reading

- [Silver layer](../silver/README.md)
- [Tests](../../tests/README.md)
- [Macros / generic_non_negative](../../macros/README.md)
- [dbt sources](https://docs.getdbt.com/docs/build/sources)
