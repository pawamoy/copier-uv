# Working on a project

The generated project has this structure:

```
📁 your_project ------------------- # your freshly created project!
├── 📄 CHANGELOG.md --------------- #
├── 📄 CLAUDE.md ------------------ # AI assistant guidance
├── 📄 .cursorrules --------------- # symlink to CLAUDE.md (for Cursor IDE)
├── 📄 .pre-commit-config.yaml ---- # pre-commit hooks configuration
├── 📁 config --------------------- # tools configuration files
│   ├── 📄 coverage.ini ----------- #
│   ├── 📄 pytest.ini ------------- #
│   ├── 📄 ruff.toml -------------- #
│   └── 📁 vscode ----------------- # VSCode/Cursor settings
│       ├── 📄 launch.json -------- #
│       ├── 📄 settings.json ------ #
│       └── 📄 tasks.json --------- #
├── 📄 CONTRIBUTING.md ------------ #
├── 📁 docs ----------------------- # documentation pages
│   ├── 📄 changelog.md ----------- #
│   ├── 📄 contributing.md -------- #
│   ├── 📄 credits.md ------------- #
│   ├── 📁 css -------------------- # extra CSS files
│   │   ├── 📄 material.css ------- #
│   │   └── 📄 mkdocstrings.css --- #
│   ├── 📄 index.md --------------- #
│   ├── 📄 license.md ------------- #
│   └── 📄 notebooks.md ----------- # (if notebooks enabled)
├── 📄 LICENSE -------------------- #
├── 📄 mkdocs.yml ----------------- # docs configuration
├── 📁 notebooks ------------------ # marimo notebooks (if enabled)
│   ├── 📄 README.md -------------- #
│   └── 📄 starter.py ------------- #
├── 📄 pyproject.toml ------------- # project metadata, dependencies, and tasks
├── 📄 README.md ------------------ #
├── 📁 scripts -------------------- # helper scripts
│   └── 📄 gen_credits.py --------- # script to generate credits
├── 📁 src ------------------------ # the source code directory
│   └── 📁 your_package ----------- # your package
│       ├── 📄 __init__.py -------- # public API exports
│       ├── 📄 __main__.py -------- # module entry point
│       ├── 📁 _internal ---------- # internal implementation
│       │   ├── 📄 __init__.py ---- #
│       │   ├── 📄 cli.py --------- # CLI implementation
│       │   ├── 📄 debug.py ------- # debug utilities
│       │   └── 📄 logging.py ----- # loguru configuration
│       └── 📄 py.typed ----------- #
└── 📁 tests ---------------------- # the tests directory
    ├── 📄 conftest.py ------------ # pytest fixtures, etc.
    ├── 📄 __init__.py ------------ #
    └── 📄 test_main.py ----------- # tests for main entry point
```

## Environment

The project uses [uv](https://github.com/astral-sh/uv) for dependency management
and [taskipy](https://github.com/taskipy/taskipy) for task running.

## Git Repository

This project uses dynamic versioning based on Git tags. The git repository is automatically initialized when you generate the project.

To add remote, you can do the following:                                        
                                                                                                                                
  `git add . && git commit -m "Initial commit from template"`                                                                     
                                                                                                                                
Then you can run the repo create command if you have `gh` installed:                                                                                       
                                                                                                                                
  `gh repo create <insert-name> --source=. --private --push`  

## Dependencies and virtual environments

Dependencies are managed by [uv](https://github.com/astral-sh/uv).

Use `uv sync` to install the dependencies and create the virtual environment.

Dependencies are written in `pyproject.toml`.
Runtime dependencies are listed under the `[project]` and `[project.optional-dependencies]` sections,
and development dependencies are listed under the `[dependency-groups]` section.

Example:

```toml title="pyproject.toml"
[project]
dependencies = [
  "fastapi>=1.0",
  "importlib-metadata>=2.0",
]

[project.optional-dependencies]
test = [
  "pytest",
]

[dependency-groups]
test = [
  "pytest>=8.2",
]
```

## Tasks

Tasks are defined in `pyproject.toml` using [taskipy](https://github.com/taskipy/taskipy).
Run tasks with `uvx --from taskipy task <name>`.

List all available tasks:

```bash
uvx --from taskipy task --list
```

Available tasks:

| Task | Description |
|------|-------------|
| `run` | Run module entrypoint |
| `setup` | Install dependencies |
| `format` | Format code (writes changes) |
| `lint` | Lint and auto-fix (writes changes) |
| `fix` | Format + lint auto-fix |
| `format_check` | Check code formatting (CI) |
| `lint_check` | Check linting (CI) |
| `typecheck` | Run type checking |
| `test` | Run test suite |
| `test_cov` | Run tests with coverage |
| `ci` | Run all CI checks (format, lint, typecheck, test) |
| `docs` | Serve documentation locally |
| `docs_build` | Build documentation (strict) |
| `changelog` | Update changelog |
| `clean` | Delete build artifacts and caches |
| `profile` | Profile module with Scalene (CPU, memory, GPU) |
| `profile_memory` | Profile module memory with Memray |
| `profile_memory_report` | Generate Memray flamegraph report |

## Pre-commit Hooks

The project includes pre-commit hooks for code quality. Install them with:

```bash
uvx pre-commit install
```

Run hooks manually on all files:

```bash
uvx pre-commit run --all-files
```

The hooks run:
- Code formatting with Ruff
- Linting with Ruff
- Type checking with ty

## Logging

- Logging uses [loguru](https://github.com/Delgan/loguru) and writes to **stderr** by default (JSON format).
- No log file is created unless you explicitly request one:
  - Programmatic: `configure_logging(log_file=Path("app.log"), json_logs=True, level="INFO")`
- Console format can be switched to human-readable with `json_logs=False` when calling `configure_logging`.

## Workflow

The first thing you should run when entering your repository is:

```bash
uvx --from taskipy task setup
```

This will install the project's dependencies in a virtual environment (`.venv/`).

Now you can start writing and editing code in `src/your_package`.

- Run your application with `uvx --from taskipy task run`.
- Auto-format and lint-fix the code with `uvx --from taskipy task fix`.
- Run a quality analysis with `uvx --from taskipy task ci`.
- Once you wrote tests for your new code,
  you can run the test suite with `uvx --from taskipy task test`.
- Once you are ready to publish a new release,
  run `uvx --from taskipy task changelog`, then tag the commit and push.

To summarize, the typical workflow is:

```bash
uvx --from taskipy task setup  # only once

<write code>
uvx --from taskipy task run    # to run your application

uvx --from taskipy task fix    # to auto-format and lint-fix

<write tests>
uvx --from taskipy task test   # to run the test suite

uvx --from taskipy task ci     # to run all CI checks

<commit your changes>

uvx --from taskipy task changelog  # to update the changelog
<edit changelog if needed>
<commit and tag>
```

## Quality analysis

The CI checks are started with:

```bash
uvx --from taskipy task ci
```

This runs format checking, linting, type checking, and tests.

For individual checks:

```bash
uvx --from taskipy task lint      # linting with auto-fix
uvx --from taskipy task typecheck # type checking only
uvx --from taskipy task test      # run tests
```

### Linting

Code quality analysis is done with [Ruff](https://github.com/astral-sh/ruff).
The analysis is configured in `config/ruff.toml`.
In this file, you can deactivate rules
or activate others to customize your analysis.

You can ignore a rule on a specific code line by appending
a `noqa` comment ("no quality analysis/assurance"):

```python title="src/your_package/module.py"
print("a code line that triggers a Ruff warning")  # noqa: ID
```

...where ID is the identifier of the rule you want to ignore for this line.

### Type checking

Type checking is done with [ty](https://github.com/astral-sh/ty).

If you cannot or don't know how to fix a typing error in your code,
as a last resort you can ignore this specific error with a comment:

```python title="src/your_package/module.py"
result = data_dict.get(key, None).value  # ty: ignore[ID]
```

## Tests

Run the test suite with:

```bash
uvx --from taskipy task test
```

Behind the scenes, it uses [`pytest`](https://docs.pytest.org/en/stable/)
and plugins to collect and run the tests, and output a report.

For tests with coverage:

```bash
uvx --from taskipy task test_cov
```

## Profiling

Profile your module with various tools:

```bash
# CPU, memory, and GPU profiling with Scalene
uvx --from taskipy task profile

# Memory profiling with Memray
uvx --from taskipy task profile_memory
uvx --from taskipy task profile_memory_report  # Generate flamegraph
```

These profiling tasks run your module's `__main__.py` entry point.

## Continuous Integration

The quality checks and tests are executed in parallel
in a [GitHub Workflow](https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions).
The CI is configured in `.github/workflows/ci.yml`.

## Changelog

Changelogs are absolutely useful when your software
is updated regularly, to inform your users about the new features
that were added or the bugs that were fixed.

Update the changelog with:

```bash
uvx --from taskipy task changelog
```

This uses [git-changelog](https://github.com/pawamoy/git-changelog)
to automatically update the changelog based on your commit messages.

For this to work properly, use the
[Angular commit message convention](https://github.com/angular/angular/blob/master/CONTRIBUTING.md#commit).

For a quick reference:

```
<type>[(scope)]: Subject

[Body]
```

Scope and body are optional. Type can be:

- `build`: About packaging, building wheels, etc.
- `chore`: About packaging or repo/files management.
- `ci`: About Continuous Integration.
- `docs`: About documentation.
- `feat`: New feature.
- `fix`: Bug fix.
- `perf`: About performance.
- `refactor`: Changes which are not features nor bug fixes.
- `style`: A change in code style/format.
- `tests`: About tests.

## Releases

To release a new version:

1. Update the changelog: `uvx --from taskipy task changelog`
2. Review and edit if needed
3. Commit the changes
4. Tag with the version: `git tag vX.Y.Z`
5. Push commits and tags: `git push && git push --tags`

## Documentation

The documentation is built with [Mkdocs](https://www.mkdocs.org/),
the [Material for Mkdocs](https://squidfunk.github.io/mkdocs-material/) theme,
and the [mkdocstrings](https://github.com/pawamoy/mkdocstrings) plugin.

### Serving

MkDocs provides a development server with files watching and live-reload.
Run `uvx --from taskipy task docs` to serve your documentation on `localhost:8000`.

### Building

Build the documentation with:

```bash
uvx --from taskipy task docs_build
```

### Deploying

MkDocs has a `gh-deploy` command that will deploy
your documentation on GitHub pages:

```bash
uv run mkdocs gh-deploy --force
```
