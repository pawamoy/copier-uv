# Requirements

To use this Copier template, you will need:

- [Git v2](https://git-scm.com/)
- [uv](https://docs.astral.sh/uv/)

To install Git version 2, [follow the official instructions](https://git-scm.com/downloads).

To install uv:

```bash
curl -LsSf https://astral.sh/uv/install.sh | sh
```

To install Python with uv:

```bash
uv python install 3.X  # Replace X with your desired version, e.g., 3.12
```

Then generate a project with:

```bash
uvx --with copier-templates-extensions copier copy --trust "gh:oedokumaci/copier-uv" /path/to/your/new/project
```
