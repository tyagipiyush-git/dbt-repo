Welcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt testWelcome to your new dbt project!

### Using the starter project

Try running the following commands:
- dbt run
- dbt test

### About dbt Tests

dbt tests are a powerful feature that ensures the quality and reliability of your data models. They allow you to define and enforce rules for your data, helping you catch data issues early in your pipeline. There are two main types of dbt tests:

1. **Generic Tests**: These are pre-built tests provided by dbt that can be applied to your models and columns. Examples include:
   - `not_null`: Ensures that a column does not contain any null values.
   - `unique`: Ensures that all values in a column are unique.
   - `accepted_values`: Validates that column values fall within a predefined set of acceptable values.

2. **Custom Tests**: These are user-defined tests written in SQL to handle more complex data validation logic specific to your use case.

#### Why Use dbt Tests?

- **Data Quality**: dbt tests help ensure that your data is accurate, complete, and consistent.
- **Early Detection**: By running tests regularly, you can catch data issues early in the pipeline before they impact downstream processes.
- **Automation**: Tests can be automated as part of your dbt runs, making data validation an integral part of your workflow.
- **Documentation**: Tests serve as a form of documentation, clearly defining the rules and expectations for your data.

#### How to Use dbt Tests

To use dbt tests, you define them in your `schema.yml` or `properties.yml` files under the `tests` or `data_tests` section for a specific column. For example:

```yaml
columns:
  - name: store_sk
    description: "The unique identifier for each store."
    tests:
      - not_null
      - unique

### About dbt Tests

dbt tests are a powerful feature that ensures the quality and reliability of your data models. They allow you to define and enforce rules for your data, helping you catch data issues early in your pipeline. There are two main types of dbt tests:

1. **Generic Tests**: These are pre-built tests provided by dbt that can be applied to your models and columns. Examples include:
   - `not_null`: Ensures that a column does not contain any null values.
   - `unique`: Ensures that all values in a column are unique.
   - `accepted_values`: Validates that column values fall within a predefined set of acceptable values.

2. **Custom Tests**: These are user-defined tests written in SQL to handle more complex data validation logic specific to your use case.

#### Why Use dbt Tests?

- **Data Quality**: dbt tests help ensure that your data is accurate, complete, and consistent.
- **Early Detection**: By running tests regularly, you can catch data issues early in the pipeline before they impact downstream processes.
- **Automation**: Tests can be automated as part of your dbt runs, making data validation an integral part of your workflow.
- **Documentation**: Tests serve as a form of documentation, clearly defining the rules and expectations for your data.

#### How to Use dbt Tests

To use dbt tests, you define them in your `schema.yml` or `properties.yml` files under the `tests` or `data_tests` section for a specific column. For example:

```yaml
columns:
  - name: store_sk
    description: "The unique identifier for each store."
    tests:
      - not_null
      - unique