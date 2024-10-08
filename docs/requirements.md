# Requirements

To use this Copier template, you will need:

- [Git v2](https://git-scm.com/)
- [Python 3](https://www.python.org)
- [Copier](https://copier.readthedocs.io/en/stable/)

To install Git version 2, [follow the official instructions](https://git-scm.com/downloads).

To install Python 3, download and install it from [the official website](https://www.python.org/downloads/), or install it with [uv](https://docs.astral.sh/uv/):

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
uv python install 3.12
```

To install Copier, use [`uv`](https://docs.astral.sh/uv/) or [`pipx`](https://pipx.pypa.io/stable/):

```bash
uv tool install copier --with copier-templates-extensions
```

```bash
pipx install copier
pipx inject copier copier-templates-extensions
```
