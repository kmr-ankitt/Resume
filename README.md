# My Resume

This process dynamically generates my resume by fetching real-time project data from my GitHub profile.

## Prerequisites

Ensure you have the following installed:

- `pdflatex`

## How to Build

1. Fill your `.env` file according to `.env.example`.

2. Make the build script executable:

  ```bash
  chmod +x ./scripts/build-resume.sh
  ```

3. Run the script to generate the resume:

  ```bash
  ./scripts/build-resume.sh
  ```

4. The resume will be generated in the `out` directory.
