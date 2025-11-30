# Copier UV

[![ci](https://github.com/oedokumaci/copier-uv/workflows/ci/badge.svg)](https://github.com/oedokumaci/copier-uv/actions?query=workflow%3Aci)
[![documentation](https://img.shields.io/badge/docs-mkdocs%20material-blue.svg?style=flat)](https://oedokumaci.github.io/copier-uv/)

[Copier](https://github.com/copier-org/copier) template
for Python projects managed by [uv](https://github.com/astral-sh/uv).

> **Credits**: This template is a fork of [pawamoy/copier-uv](https://github.com/pawamoy/copier-uv) by [Timothée Mazzucotelli](https://pawamoy.github.io/). Full credit to the original author for the excellent foundation.

## Features

- [uv](https://github.com/astral-sh/uv) setup, with pre-defined `pyproject.toml`
- Pre-configured tools for code formatting, quality analysis and testing:
  [ruff](https://github.com/charliermarsh/ruff),
  [mypy](https://github.com/python/mypy)
- Tests run with [pytest](https://github.com/pytest-dev/pytest) and plugins, with [coverage](https://github.com/nedbat/coveragepy) support
- Documentation built with [MkDocs](https://github.com/mkdocs/mkdocs)
  ([Material theme](https://github.com/squidfunk/mkdocs-material)
  and "autodoc" [mkdocstrings plugin](https://github.com/mkdocstrings/mkdocstrings))
- Cross-platform tasks with [duty](https://github.com/pawamoy/duty)
- Support for GitHub workflows
- Auto-generated `CHANGELOG.md` from Git (conventional) commits
- All licenses from [choosealicense.com](https://choosealicense.com/appendix/)

### Additional Features (this fork)

- **[marimo](https://marimo.io/) notebooks** support with `make marimo` commands
- **[loguru](https://github.com/Delgan/loguru)** for structured JSON logging
- **CLAUDE.md** for AI assistant guidance
- **Cursor IDE integration** via `.cursorrules` symlink (points to `CLAUDE.md`)

## Quick setup and usage

Make sure all the
[requirements](https://oedokumaci.github.io/copier-uv/requirements)
are met, then:

```bash
copier copy --trust "https://github.com/oedokumaci/copier-uv.git" /path/to/your/new/project
```

Or even shorter:

```bash
copier copy --trust "gh:oedokumaci/copier-uv" /path/to/your/new/project
```

See the [documentation](https://oedokumaci.github.io/copier-uv)
for more details.

## Acknowledgements

This project is based on [copier-uv](https://github.com/pawamoy/copier-uv) by [Timothée Mazzucotelli (pawamoy)](https://pawamoy.github.io/).

Similar templates by the original author:

- [copier-pdm](https://github.com/pawamoy/copier-pdm), with [PDM](https://github.com/pdm-project/pdm)
- [copier-poetry](https://github.com/pawamoy/copier-poetry), with [Poetry](https://github.com/python-poetry/poetry)
