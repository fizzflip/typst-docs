# Assignments and Lab Manuals

This repository contains a collection of Active Learning Assessments (ALAs) and comprehensive lab manuals typeset using [Typst](https://typst.app/), the modern and fast markup-based typesetting system.

The documents in this repository represent coursework, lab experiments, and evaluations organized by academic semester.

## Structure

The repository is organized by semester and subject:

```text
typst-docs/
├── sem-4/
│   ├── ala/
│   │   ├── cle/          # Cyber Law & Ethics (CLE) — ALAs, Policy Comparisons, Gap Analysis, & Interview Prep
│   │   ├── dbms/         # Database Management Systems (DBMS) — Normalization & Triggers
│   │   ├── os/           # Operating Systems (OS) — Deadlock Assignments, Scheduling, & Thread/Process Creation
│   │   └── python/       # Python — Project Scope, Blueprints, Proposals, & Execution Reports
│   └── lab-manual/
│       ├── cv/           # Computer Vision (CV) — Comprehensive Lab Manual, ALAs, & Nix devenv (Python/uv)
│       └── os/           # Operating Systems (OS) — Lab Manual & Systems Programming Practicals
├── sem-5/
│   └── ala/
│       └── ada/          # Analysis and Design of Algorithms (ADA) — Sorting Algorithms Analysis & Benchmarks
├── misc/                 # Miscellaneous academic materials and metadata (e.g., student metadata)
└── old/                  # Legacy/Archived documents (Heat Transfer, older OS Lab Manuals)
```

### Course Breakdown

| Semester / Path | Subject | Key Topics / Content | Format & Source Files |
| :--- | :--- | :--- | :--- |
| **`sem-4/ala/cle`** | **Cyber Law & Ethics** | Policy comparison, gap analysis, ethics policy, presentation slides, interview prep | `.typ`, `.png` |
| **`sem-4/ala/dbms`** | **DBMS** | Normalization steps, triggers in DBMS, audit logs | `.typ`, `.pdf`, `.png` |
| **`sem-4/ala/os`** | **Operating Systems** | Deadlock assignment, process scheduling algorithms, process & thread creation | `.typ`, `.pdf` |
| **`sem-4/ala/python`** | **Python Programming** | Project scope plan, detailed project plan, execution report, proposal | `.typ`, `.pdf`, `.png` |
| **`sem-4/lab-manual/cv`** | **Computer Vision** | CV lab experiments, assignment ALAs, Python scripts, reproducible Nix dev shell | `.typ`, `.py`, `.nix`, `.toml` |
| **`sem-4/lab-manual/os`** | **Operating Systems** | Linux systems programming experiments, practical bash execution scripts | `.typ`, `.sh`, `.pdf` |
| **`sem-5/ala/ada`** | **ADA** | Sorting algorithms comparative analysis, time/space complexity, benchmark visualizers | `.typ`, `.pdf`, `.png` |
| **`old/`** | **Legacy Archives** | Heat Transfer coursework, legacy OS lab practicals | `.typ`, `.pdf`, `.svg` |

---

## Workflows

### Compiling Typst Documents

To view or build the final PDF documents, you will need the [Typst CLI](https://typst.app/) installed. You can compile any `.typ` source file directly to a PDF:

```bash
# Compile a specific document to PDF
typst compile path/to/document.typ

# Compile and automatically watch for modifications (auto-recompiles on save)
typst watch path/to/document.typ
```

### Nix Development Environment (`devenv`)

For environments with external dependencies such as OpenCV and Python in `sem-4/lab-manual/cv/`, a fully reproducible Nix developer shell is configured using [devenv](https://devenv.sh/). It provisions dependencies such as:

- **Python** with `uv` for package management.
- **Pandoc** for document format transformations.
- System libraries like `libGL`, `libxcb`, `zbar`, and more for image processing.

To enter the shell in `sem-4/lab-manual/cv/`, run:

```bash
cd sem-4/lab-manual/cv
devenv shell
```
