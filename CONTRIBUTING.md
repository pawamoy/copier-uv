# Contributing

Contributions are welcome, and they are greatly appreciated!
Every little bit helps, and credit will always be given.

## Environment setup

You only need two tools, [uv](https://github.com/astral-sh/uv)
and [Copier](https://github.com/copier-org/copier).

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
uv tool install copier --with copier-templates-extensions
```

Then you can clone the repository, enter it and set it up with:

```bash
git clone https://github.com/pawamoy/copier-uv
cd copier-uv
make setup
```

## Running tests

To run the tests, use:

```bash
make test
```

## Serving docs

To serve the docs locally, use:

```bash
make docs
```
