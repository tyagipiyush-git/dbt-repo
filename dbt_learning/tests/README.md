# dbt Tests

Documentation for the `tests/` folder in **dbt_learning**. See the [project README](../README.md) for other concepts.

---

## What are dbt tests?

dbt tests enforce rules on your data so quality issues surface in dev and CI before they reach dashboards or downstream systems. You can test **models**, **sources**, and **seeds**.

---

## Types of tests

### 1. Generic tests

Declared in YAML on columns (often in `properties.yml` / `schema.yml`). Built-in examples:

| Test | What it checks |
|------|----------------|
| `not_null` | No null values in the column |
| `unique` | All values are distinct |
| `accepted_values` | Values are in a defined list |
| `relationships` | Foreign-key style match to another model |

Example:

```yaml
columns:
  - name: store_sk
    description: "The unique identifier for each store."
    tests:
      - not_null
      - unique
```

### 2. Singular tests

SQL files in `tests/` that return **failing rows**. If the query returns any rows, the test fails.

Example in this project: `non_negative_test.sql` — validates business rules on `bronze_sales`.

### 3. Generic test macros

Reusable test logic defined under `macros/` (e.g. `generic_non_negative.sql`) and referenced from YAML like built-in generic tests.

---

## Why use tests?

- **Data quality** — duplicates, nulls, invalid enums, broken relationships.
- **Early detection** — fail in `dbt test` instead of in production reports.
- **Documentation** — tests encode expectations next to your models.

---

## Commands

```bash
dbt test                      # all tests
dbt test --select bronze_sales   # tests related to a model
```

Tests usually run after `dbt run` (or `dbt build`, which runs models and tests together).

---

## Files in this folder

| File | Type | Purpose |
|------|------|---------|
| `non_negative_test.sql` | Singular | Custom validation on `bronze_sales` |

Column-level generic tests (e.g. `generic_non_negative` on `gross_amount`) are defined in `models/bronze/properties.yml`. The reusable macro lives in `macros/generic_non_negative.sql` — do **not** put `{% test %}` blocks under `tests/`, or dbt will try to run them as singular tests and fail with empty SQL.

---

## Further reading

- [Data tests](https://docs.getdbt.com/docs/build/data-tests)
- [Custom generic tests](https://docs.getdbt.com/docs/build/best-practices/custom-generic-tests)
