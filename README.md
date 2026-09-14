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

### Building using Docker 

1. Build the Docker image:

```
docker build -t resume .
```

2. Run the Docker container to generate the resume:

```bash
docker run --rm -v "$PWD/out:/resume/out" resume
```

3. The resume will be generated in the `out` directory.
