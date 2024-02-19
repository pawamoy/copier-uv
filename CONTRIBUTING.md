# Contributing

Contributions are welcome, and they are greatly appreciated!
Every little bit helps, and credit will always be given.

## Environment setup

You only need two tools, [uv](https://github.com/astral-sh/uv)
and [Copier](https://github.com/copier-org/copier).

```bash
python3 -m pip install --user pipx
pipx install uv
pipx install copier
```

## Running tests

To run the tests, use:

```
make test
```

## Serving docs

You can create a new virtualenv
and install `mkdocs` and `mkdocs-material`:

```bash
python3 -m venv venv
. venv/bin/activate
pip install mkdocs mkdocs-material
mkdocs serve
```

You can also install `mkdocs` with `pipx` and
inject `mkdocs-material` in its venv,
this way you don't need to create one yourself:

```bash
python3 -m pip install --user pipx
pipx install mkdocs
pipx inject mkdocs mkdocs-material
mkdocs serve
```
