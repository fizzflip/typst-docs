# Assignments and Lab Manuals

This repository contains a collection of Active Learning Assessments (ALAs) and comprehensive lab manuals typeset using [Typst](https://typst.app/), the modern and fast markup-based typesetting system.

The documents in this repository represent course works and evaluations authored by me.

## Structure

The repository is organized by course and assessment types:

```text
typst-docs/
├── cle-ala/              # Cyber Law & Ethics (CLE) — ALAs, Policy Comparisons, and Interview Prep
├── cv-ala/               # Computer Vision (CV) — Active Learning Assessments (Placeholder)
├── cv-lab-manual/        # Computer Vision (CV) — Comprehensive Lab Manual (with Python & Nix devenv)
├── dbms-ala/             # Database Management Systems (DBMS) — Normalization & Triggers
├── os/                   # Operating Systems (OS) Coursework
│   ├── ala/              # Deadlock assignments, scheduling, thread/process creation
│   └── lab-manual/       # OS Lab Manual
├── python-ala/           # Python — Project Blueprints, Scope, & Execution Reports
├── misc/                 # Miscellaneous academic materials and metadata
└── old/                  # Legacy/Archived documents (Heat Transfer, older OS Lab Manuals)
```

### Course Breakdown

| Subject / Directory | Key Topics / Content | Format & Source Files |
| :--- | :--- | :--- |
| **`cle-ala`** | Cyber Law & Ethics: policy comparison, gap analysis, ethics policy, presentation slides | `.typ`, `.md` |
| **`cv-lab-manual`** | Computer Vision: lab manual, test samples, compilation scripts, Python environment | `.typ`, `.py`, `.nix` |
| **`dbms-ala`** | Database Management Systems: normalization steps, triggers, relational database models | `.typ`, `.pdf` |
| **`os/ala`** | Operating Systems: deadlock assignments, process scheduling algorithms, Java & Python thread creation | `.typ`, `.pdf`, `.md` |
| **`os/lab-manual`** | Operating Systems: custom systems programming and Unix/Linux lab experiments | `.typ`, `.pdf` |
| **`python-ala`** | Python Projects: scope blueprints, execution plans, proposal documents | `.typ`, `.pdf`, `.png` |

---

## Workflows

### Compiling Typst Documents

To view or build the final PDF documents, you will need the `typst` CLI installed. You can compile any `.typ` source file directly to a PDF:

```bash
# Compile a specific document to PDF
typst compile path/to/document.typ

# Compile and automatically watch for modifications (auto-recompiles on save)
typst watch path/to/document.typ
```

### Nix Development Environment (`devenv`)

For more complex directories like `cv-lab-manual/`, a fully reproducible Nix developer shell is configured using [devenv](https://devenv.sh/). It provisions dependencies such as:

- **Python** with `uv` for automated workspace package management.
- **Pandoc** for document formats transformation.
- Libraries like `libGL`, `libxcb`, `zbar`, and more for OpenCV and image processing workflows.

To enter the shell in these directories, simply run:

```bash
devenv shell
# OR, for an alternative profile
devenv shell --profile=marimo
```
