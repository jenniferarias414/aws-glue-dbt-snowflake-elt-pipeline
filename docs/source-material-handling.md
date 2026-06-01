# Source Material Handling

This project was completed as a guided data engineering lab and then organized into a portfolio-ready GitHub repository.

## Public Repo Content

The public repo includes:

- project overview
- architecture explanation
- AWS Glue extraction script
- Snowflake setup SQL
- dbt models and macros
- validation screenshots
- troubleshooting notes
- learning notes written for a technical/business audience

The goal of the public repo is to demonstrate the project clearly without exposing private course material, credentials, or personal study notes.

## Private / Excluded Content

The following content should stay private and should not be committed:

- copied course instructions
- raw bootcamp notes
- personal study notes
- interview preparation notes
- credentials
- account IDs
- passwords
- external IDs
- unblurred screenshots with sensitive details

Private notes can be kept locally under:

```text
notes/private/
```

This folder is excluded in `.gitignore`.

## Guided Project Disclosure

This project is described as a guided learning project because the overall lab structure came from data engineering coursework.

The implementation, screenshots, documentation, architecture explanation, troubleshooting notes, and portfolio packaging were expanded to show the work clearly and make the project easier to review.

## Screenshot Handling

Screenshots are used as validation evidence, not as a replacement for project documentation.

Before publishing screenshots, sensitive values should be cropped or blurred.

## Data Source

The project uses a public JSON source file containing country details data.

AWS Glue extracts the file and writes it to S3. Snowflake reads the S3 file through an external stage, and dbt models the data into raw, transform, and mart layers.

## Repo Cleanliness

The clean portfolio repo should only contain files related to this AWS Glue + Snowflake + dbt project.

The dbt Cloud workspace used for development included older practice files from a previous lab, but the portfolio repo includes only the project-specific dbt files under:

```text
dbt/models/glue_snowflake/
```