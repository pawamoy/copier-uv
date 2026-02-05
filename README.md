# Copier UV

[![ci](https://github.com/pawamoy/copier-uv/workflows/ci/badge.svg)](https://github.com/pawamoy/copier-uv/actions?query=workflow%3Aci)
[![documentation](https://img.shields.io/badge/docs-zensical%20material-orange.svg?style=flat)](https://pawamoy.github.io/copier-uv/)
[![gitter](https://badges.gitter.im/join%20chat.svg)](https://app.gitter.im/#/room/#copier-uv/community:gitter.im)

[Copier](https://github.com/copier-org/copier) template for Python projects managed by [uv](https://github.com/astral-sh/uv).

This copier template is mainly for my own usage, but feel free to try it out, or fork it!

Similar templates:

- [copier-pdm](https://github.com/pawamoy/copier-pdm), with [PDM](https://github.com/pdm-project/pdm)
- [copier-poetry](https:///github.com/pawamoy/copier-poetry), with [Poetry](https://github.com/python-poetry/poetry)

## Features

- [uv](https://github.com/astral-sh/uv) setup, with pre-defined `pyproject.toml`
- Pre-configured tools for code formatting, quality analysis and testing:
  [ruff](https://github.com/charliermarsh/ruff),
  [ty](https://github.com/astral-sh/ty),
- Tests run with [pytest](https://github.com/pytest-dev/pytest) and plugins, with [coverage](https://github.com/nedbat/coveragepy) support
- Documentation built with [Zensical](https://github.com/zensical/zensical)
- Cross-platform tasks with [duty](https://github.com/pawamoy/duty)
- Support for GitHub workflows
- Auto-generated `CHANGELOG.md` from Git (conventional) commits
- All licenses from [choosealicense.com](https://choosealicense.com/appendix/)

## Quick setup and usage

Make sure all the [requirements](https://pawamoy.github.io/copier-uv/requirements) are met, then:

```bash
copier copy --trust "https://github.com/pawamoy/copier-uv.git" /path/to/your/new/project
```

Or even shorter:

```bash
copier copy --trust "gh:pawamoy/copier-uv" /path/to/your/new/project
```

See the [documentation](https://pawamoy.github.io/copier-uv) for more details.
