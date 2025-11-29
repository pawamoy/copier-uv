# CLAUDE.md

This file provides guidance for AI assistants (Claude, Cursor, etc.) working on this **Copier template** repository.

## Project Overview

**copier-uv** is a [Copier](https://github.com/copier-org/copier) template for generating Python projects managed by [uv](https://github.com/astral-sh/uv).

> **Credits**: This template is a fork of [pawamoy/copier-uv](https://github.com/pawamoy/copier-uv) by [Timothée Mazzucotelli](https://pawamoy.github.io/). Full credit to the original author for the excellent foundation. When making changes, maintain the spirit and quality of the original work.

## Critical: This is a Template Repository

This is NOT a regular Python project. It's a **Copier template** that generates Python projects.

### Key Implications

1. **Files in `project/` are templates** - They use Jinja2 syntax (`.jinja` extension) and Copier variables
2. **Changes often need to be made in multiple places** - The template and documentation must stay in sync
3. **Test by generating a project** - Changes should be verified by running `copier copy`

## Repository Structure

```
copier-uv/
├── copier.yml              # Template configuration and prompts
├── extensions.py           # Custom Jinja2 extensions
├── project/                # THE TEMPLATE - files that get copied
│   ├── *.jinja             # Template files with Jinja2 syntax
│   ├── config/             # Tool configurations
│   ├── src/                # Source code template
│   ├── tests/              # Test template
│   └── docs/               # Documentation template
├── docs/                   # Documentation for THIS template
├── tests/                  # Tests for THIS template
├── site/                   # Built documentation (generated)
├── mkdocs.yml              # Docs config for THIS repo
└── README.md               # This repo's readme
```

### Template Variables

Key variables defined in `copier.yml`:
- `project_name` - The generated project's name
- `python_package_import_name` - Python import name
- `python_package_distribution_name` - PyPI package name
- `python_package_command_line_name` - CLI command name
- `include_notebooks` - Whether to include marimo notebooks
- `author_fullname`, `author_email`, `author_username`
- `repository_provider`, `repository_namespace`, `repository_name`
- `copyright_holder`, `copyright_date`, `copyright_license`

### Conditional Files

Some files/directories only exist based on template options:
- `{% if include_notebooks %}notebooks{% endif %}/` - Only when notebooks enabled
- `{% if python_package_command_line_name %}cli.py{% endif %}.jinja` - Only when CLI name provided

## Consistency Rules

### When Making Changes, Update ALL Relevant Places

Changes often need to be reflected in multiple locations:

| Change Type | Update These |
|-------------|--------------|
| New template feature | `project/` templates, `copier.yml` (if new variable), `docs/`, `README.md` |
| Template variable | `copier.yml`, all `.jinja` files using it |
| Documentation | `docs/` (this repo), `project/docs/` (generated projects) |
| Default tool config | `project/config/`, `project/pyproject.toml.jinja` |
| New Makefile target | `project/Makefile.jinja`, `project/duties.py.jinja`, `project/CLAUDE.md.jinja` |

### Example: Adding a New Feature

If adding marimo notebooks support (like we did):
1. Add `include_notebooks` variable to `copier.yml`
2. Create `project/{% if include_notebooks %}notebooks{% endif %}/` directory
3. Add notebook-related files with `.jinja` extension
4. Update `project/Makefile.jinja` with `marimo` targets
5. Update `project/duties.py.jinja` with marimo duties
6. Update `project/pyproject.toml.jinja` with marimo dependency
7. Update `project/CLAUDE.md.jinja` to document notebooks
8. Update `docs/` to document the feature
9. Update `README.md` to mention the feature

## Working with Jinja2 Templates

### Syntax

```jinja2
{# Comment #}
{{ variable }}                           {# Variable substitution #}
{% if condition %}...{% endif %}         {# Conditional #}
{% for item in items %}...{% endfor %}   {# Loop #}
{{ variable | filter }}                  {# Filter #}
```

### Common Filters Used

- `{{ name | slugify }}` - Convert to slug
- `{{ name | title }}` - Title case
- `{{ name | replace("_", "") }}` - Replace characters

### Escaping

When template files need literal Jinja2 syntax (e.g., in generated Jinja templates):
```jinja2
{% raw %}{{ this_wont_be_processed }}{% endraw %}
```

## Development Workflow

### Testing Template Changes

```bash
# Generate a test project
copier copy --trust . /tmp/test-project

# With specific options
copier copy --trust -d include_notebooks=true . /tmp/test-project

# Check generated files
ls -la /tmp/test-project
```

### Running Template Tests

```bash
# Run template tests
cd tests
./test_project.sh
./test_filenames.sh
```

### Documentation

```bash
# Serve docs locally
make docs

# Or manually
uv run mkdocs serve
```

## Commit Message Convention

Follow Angular/Karma convention:

```
<type>[(scope)]: Subject

[Body]
```

Types: `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `deps`

Examples:
```bash
feat: Add marimo notebooks support
fix(template): Correct mypy config path
docs: Update installation instructions
refactor: Simplify Jinja2 extensions
```

## Do's and Don'ts

### DO

- ✅ Credit the original author (pawamoy) when relevant
- ✅ Update ALL related files when making changes (consistency!)
- ✅ Test changes by generating a project with `copier copy`
- ✅ Keep template variables documented in `copier.yml`
- ✅ Use conditional blocks for optional features
- ✅ Maintain backwards compatibility when possible

### DON'T

- ❌ Edit only one file when changes affect multiple places
- ❌ Forget to update `project/CLAUDE.md.jinja` when adding features
- ❌ Add features without documenting them
- ❌ Break existing template variables
- ❌ Commit generated files (like `site/`) without reason
- ❌ Remove attribution to the original author

## Key Files Reference

| File | Purpose |
|------|---------|
| `copier.yml` | Template configuration, prompts, variables |
| `extensions.py` | Custom Jinja2 extensions |
| `project/CLAUDE.md.jinja` | AI guidance for generated projects |
| `project/pyproject.toml.jinja` | Generated project's dependencies |
| `project/duties.py.jinja` | Generated project's task definitions |
| `project/Makefile.jinja` | Generated project's make targets |

## Attribution

This template is based on excellent work by [Timothée Mazzucotelli (pawamoy)](https://pawamoy.github.io/). See also:
- [copier-pdm](https://github.com/pawamoy/copier-pdm)
- [copier-poetry](https://github.com/pawamoy/copier-poetry)

