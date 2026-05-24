# Analysis commands (`dbt compile`)

[← Back to commands index](README.md)

Analyses are **not** executed by `dbt run`. They are compiled to plain SQL under `target/compiled/`.

This project:

| Analysis | File |
|----------|------|
| `lookup_analysis` | `analyses/lookup_analysis.sql` |

---

## Compile all analyses (and rest of project)

```bash
dbt compile
```

---

## Compile a single analysis (by name)

```bash
dbt compile --select lookup_analysis
```

Short form:

```bash
dbt compile -s lookup_analysis
```

---

## Compile a single file (by path)

```bash
dbt compile --select path:analyses/lookup_analysis.sql
```

---

## Dependencies first

`lookup_analysis` uses `ref('lookup_test')`. The seed must exist before you run compiled SQL in the warehouse:

```bash
dbt seed --select lookup_test
dbt compile --select lookup_analysis
```

If bronze models are referenced in other analyses, run those models first:

```bash
dbt run --select bronze_sales
dbt compile --select my_analysis_name
```

Compile **with** upstream nodes (dbt 1.x+):

```bash
dbt compile --select +lookup_analysis
```

---

## Where compiled SQL is written

After compile:

```
target/compiled/dbt_learning/analyses/lookup_analysis.sql
```

Open that file and run it in Databricks SQL (or your SQL client). dbt does not execute analyses automatically unless you use adapter-specific preview commands.

---

## List analyses

```bash
dbt ls --resource-type analysis
dbt ls --select lookup_analysis
```

---

## Preview results (optional)

If your dbt + adapter version supports it:

```bash
dbt show --select lookup_analysis
```

Runs a limited preview in the terminal. Availability depends on Databricks adapter version.

---

## There is no `dbt run` for analyses

These will **not** build an analysis as a table:

```bash
# Not applicable for analyses
dbt run --select lookup_analysis
```

Use **compile**, then run the SQL in the warehouse.

---

## More detail

Conceptual docs: [analyses/README.md](../analyses/README.md)

Selector reference: [selectors.md](selectors.md)
