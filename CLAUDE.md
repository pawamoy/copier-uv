# CLAUDE.md

This file provides guidance for AI assistants working on this **Copier template** repository.

## Critical Context

**copier-uv** is a [Copier](https://github.com/copier-org/copier) template for generating Python projects managed by [uv](https://github.com/astral-sh/uv). This is NOT a regular Python project—it's a **Copier template** that generates Python projects.

> **Credits**: Fork of [pawamoy/copier-uv](https://github.com/pawamoy/copier-uv) by [Timothée Mazzucotelli](https://pawamoy.github.io/). Maintain the spirit and quality of the original work.

### Key Implications

1. **Files in `project/` are templates** - Jinja2 syntax (`.jinja` extension)
2. **Changes need multiple places** - Template and docs must stay in sync
3. **Test by generating** - Verify with `copier copy`

## Quick Reference

```bash
# Generate test project (interactive - requires terminal)
# IMPORTANT: Use --vcs-ref HEAD to test uncommitted changes
copier copy --trust --vcs-ref HEAD . /tmp/test-project
copier copy --trust --vcs-ref HEAD -d include_notebooks=true . /tmp/test-project

# Run tests
cd tests && ./test_project.sh && ./test_filenames.sh

# Serve docs
make docs  # or: uv run mkdocs serve
```

## Testing Note

**Important:** The `copier copy` command requires interactive input and cannot be run programmatically without a terminal. When verifying template changes:
- **Always use `--vcs-ref HEAD`** to test uncommitted changes (without it, copier uses the last committed version)
- Use the existing test scripts in `tests/` for automated validation
- Manual interactive testing with `copier copy` should be done by the user
- Do not attempt to automate copier with piped input or data files in CI-like environments

## Standard Workflow

1. **Explore** - Understand current state of relevant files
2. **Plan** - Ask clarifying questions for architectural changes
3. **Implement** - Update ALL affected files (see consistency table)
4. **Verify** - Test with `copier copy --trust --vcs-ref HEAD . /tmp/test-project`

**Ask before:** Adding template variables, modifying file structure, multi-file changes.

## Repository Structure

```
copier-uv/
├── copier.yml       # Template config, prompts, variables
├── extensions.py    # Custom Jinja2 extensions
├── project/         # THE TEMPLATE - files that get copied
│   ├── *.jinja      # Template files
│   ├── config/      # Tool configurations
│   ├── src/         # Source code template
│   └── docs/        # Documentation template
├── docs/            # Docs for THIS template
└── tests/           # Tests for THIS template
```

## Consistency Rules

**When making changes, update ALL relevant places:**

| Change Type | Update These |
|-------------|--------------|
| New feature | `project/` templates, `copier.yml`, `docs/`, `README.md` |
| Template variable | `copier.yml`, all `.jinja` files using it |
| Tool config | `project/config/`, `project/pyproject.toml.jinja` |
| Task (make target) | `project/pyproject.toml.jinja` (taskipy), `project/CLAUDE.md.jinja` |

## Jinja2 Syntax

```jinja2
{{ variable }}                    {# Substitution #}
{% if condition %}...{% endif %}  {# Conditional #}
{% raw %}{{ literal }}{% endraw %} {# Escape #}
{{ name | slugify }}              {# Filter #}
```

## Commit Messages

**Format:** `<type>[(scope)]: Subject`

**Types:** `feat`, `fix`, `docs`, `style`, `refactor`, `perf`, `test`, `build`, `ci`, `chore`, `deps`

## Key Files

| File | Purpose |
|------|---------|
| `copier.yml` | Template config, variables |
| `extensions.py` | Custom Jinja2 extensions |
| `project/CLAUDE.md.jinja` | AI guidance for generated projects |
| `project/pyproject.toml.jinja` | Dependencies and taskipy tasks |
| `project/.pre-commit-config.yaml.jinja` | Pre-commit hooks config |

## Do's and Don'ts

**DO:**
- ✅ Update ALL related files when making changes
- ✅ Test with `copier copy --trust --vcs-ref HEAD . /tmp/test-project`
- ✅ Document variables in `copier.yml`
- ✅ Use conditional blocks for optional features

**DON'T:**
- ❌ Edit only one file when changes affect multiple places
- ❌ Add features without documenting in `project/CLAUDE.md.jinja`
- ❌ Commit generated files (like `site/`)
- ❌ Break existing template variables
