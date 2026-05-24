# Test commands (`dbt test`)

[← Back to commands index](README.md)

Tests in this project come from two places:

| Type | Location | Examples |
|------|----------|----------|
| **Singular** | `tests/*.sql` | `non_negative_test` |
| **Generic (YAML)** | `models/bronze/properties.yml` | `not_null`, `unique` on `bronze_sales`; `generic_non_negative` on `gross_amount` |

---

## Run all tests

```bash
dbt test
```

---

## Run a single singular test (one file)

Singular test name = **SQL filename without `.sql`**:

```bash
dbt test --select non_negative_test
```

File: `tests/non_negative_test.sql` (validates `bronze_sales`).

---

## Run a single singular test (by path)

```bash
dbt test --select path:tests/non_negative_test.sql
```

---

## Run all tests for one model

Runs every generic + singular test that depends on that model:

```bash
dbt test --select bronze_sales
```

Other models with YAML tests:

```bash
dbt test --select bronze_store
```

---

## Run one **type** of test on one model

Only `unique` tests on `bronze_sales`:

```bash
dbt test --select bronze_sales,test_type:unique
```

Only `not_null` tests on `bronze_sales`:

```bash
dbt test --select bronze_sales,test_type:not_null
```

All singular tests in the project:

```bash
dbt test --select test_type:singular
```

All generic (YAML) tests:

```bash
dbt test --select test_type:generic
```

---

## Run one specific generic test (exact node name)

Generic tests get auto-generated names like `not_null_bronze_sales_sales_id`. **List them first:**

```bash
dbt ls --resource-type test --select bronze_sales
```

Example output (names may vary slightly by dbt version):

```
dbt_learning.not_null_bronze_sales_sales_id
dbt_learning.unique_bronze_sales_sales_id
dbt_learning.generic_non_negative_bronze_sales_gross_amount
```

Run exactly one:

```bash
dbt test --select unique_bronze_sales_sales_id
```

Or with package/project prefix if required:

```bash
dbt test --select dbt_learning.unique_bronze_sales_sales_id
```

**Tip:** If the name is ambiguous, use the full name from `dbt ls`.

---

## Run tests on a column (by model + test type)

Pattern: model + test type (runs all tests of that type on the model):

```bash
dbt test --select bronze_store,test_type:accepted_values
```

---

## Run model build + its tests

```bash
dbt build --select bronze_sales
```

Equivalent to `dbt run --select bronze_sales` then `dbt test --select bronze_sales`.

---

## Run tests without rebuilding models

```bash
dbt test --select bronze_sales
```

Assumes `bronze_sales` already exists in the warehouse from a prior `dbt run`.

---

## Exclude tests

Run all tests **except** one singular test:

```bash
dbt test --exclude non_negative_test
```

---

## Preview what will run

```bash
dbt ls --select non_negative_test
dbt ls --select bronze_sales,test_type:unique
dbt ls --resource-type test
```

---

## Test files in this repo

| Command | What runs |
|---------|-----------|
| `dbt test --select non_negative_test` | `tests/non_negative_test.sql` |
| `dbt test --select bronze_sales` | YAML tests on `bronze_sales` + any singular test referencing it |
| `dbt test --select bronze_store` | `not_null`, `unique`, `accepted_values`, etc. on `bronze_store` |

`tests/generic_non_negative.sql` is typically invoked via YAML (`data_tests: generic_non_negative`), not as a standalone `dbt test --select generic_non_negative` unless defined as a singular test node — use `dbt ls` to confirm.

---

## More selector patterns

See [selectors.md](selectors.md).
