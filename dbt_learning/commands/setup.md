# Setup & environment commands

[← Back to commands index](README.md)

All commands assume:

```bash
cd c:\dbt_tutorial\dbt_learning
```

---

## Verify connection

```bash
dbt debug
```

Checks `profiles.yml`, adapter, and warehouse connectivity. Fix any **ERROR** before `run` / `seed` / `test`.

This project uses profile name **`dbt_learning`** (see `dbt_project.yml`).

---

## Install dependencies

```bash
dbt deps
```

Downloads dbt packages defined in `packages.yml` (if present). Run after pulling changes that add or update packages.

---

## Clean build artifacts

```bash
dbt clean
```

Removes `target/` and `dbt_packages/` (per `clean-targets` in `dbt_project.yml`). Use when compiled SQL or manifests look stale.

After `dbt clean`, run `dbt deps` again if you use packages, then re-run your usual `seed` / `run` / `test`.

---

## Parse without executing

```bash
dbt parse
```

Validates project structure and builds the manifest without hitting the warehouse for builds. Useful for CI syntax checks.

---

## Compile entire project

```bash
dbt compile
```

Renders all Jinja to SQL under `target/compiled/`. Does not create tables. See [analyses.md](analyses.md) for single-analysis compile.

---

## Common issues

| Symptom | What to try |
|---------|-------------|
| Profile not found | Run from `dbt_learning/`; check `profile:` in `dbt_project.yml` matches `profiles.yml` |
| Auth / token errors | Refresh Databricks / warehouse credentials in `profiles.yml` (do not commit secrets) |
| Relation does not exist | Run upstream `dbt seed` or `dbt run` first; see [selectors.md](selectors.md) `+` syntax |

---

## Next steps

- [models.md](models.md) — run SQL models
- [seeds.md](seeds.md) — load CSV seeds
- [tests.md](tests.md) — run data tests
