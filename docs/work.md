# Working on a project

The generated project has this structure:

```
📁 your_project ------------------- # your freshly created project!
├── 📄 CHANGELOG.md --------------- #
├── 📄 CODE_OF_CONDUCT.md --------- #
├── 📁 config --------------------- # tools configuration files
│   ├── 📄 coverage.ini ----------- #
│   ├── 📄 mypy.ini --------------- #
│   ├── 📄 pytest.ini ------------- #
│   └── 📄 ruff.toml -------------- #
├── 📄 CONTRIBUTING.md ------------ #
├── 📁 docs ----------------------- # documentation pages
│   ├── 📄 changelog.md ----------- #
│   ├── 📄 code_of_conduct.md ----- #
│   ├── 📄 contributing.md -------- #
│   ├── 📄 credits.md ------------- #
│   ├── 📁 css -------------------- # extra CSS files
│   │   ├── 📄 material.css ------- #
│   │   └── 📄 mkdocstrings.css --- #
│   ├── 📄 index.md --------------- #
│   └── 📄 license.md ------------- #
├── 📄 duties.py ------------------ # the project's tasks
├── 📄 LICENSE -------------------- #
├── 📄 Makefile ------------------- # for auto-completion (it calls scripts/make)
├── 📄 mkdocs.yml ----------------- # docs configuration
├── 📄 pyproject.toml ------------- # project metadata and dependencies
├── 📄 README.md ------------------ #
├── 📁 scripts -------------------- # helper scripts
│   ├── 📄 gen_credits.py --------- # script to generate credits
│   ├── 📄 gen_ref_nav.py --------- # script to generate code reference nav
│   └── 📄 make ------------------- # a convenience script to run tasks
├── 📁 src ------------------------ # the source code directory
│   └── 📁 your_package ----------- # your package
│       ├── 📄 cli.py ------------- # the command line entry point
│       ├── 📄 __init__.py -------- #
│       ├── 📄 __main__.py -------- #
│       └── 📄 py.typed ----------- #
└── 📁 tests ---------------------- # the tests directory
    ├── 📄 conftest.py ------------ # pytest fixtures, etc.
    ├── 📄 __init__.py ------------ #
    └── 📄 test_cli.py ------------ #
```

## Environment

The project is configured to use [direnv](https://direnv.net/).
If direnv is loaded in your shell, allow it in the project with
`direnv allow`. It will add the `scripts` folder to your PATH
when you enter the repository (and remove it when you exit it).
The `scripts` folder has a `make` Bash script in it:
it will shadow any `make` command you have in your PATH
(this is indented!).

If you don't have or don't use direnv, you can still use
the official `make` command, though you won't be able
to pass arguments to some of the actions.

In the rest of the documentation, we will use `make` commands,
but you can also directly call `scripts/make`.

See [Tasks](#tasks) to learn more.

## Python versions

To specify which Python versions you would like to work with,
define the `PYTHON_VERSIONS` environment variable:

```bash
export PYTHON_VERSIONS="3.10 3.11 3.12"
```

By default it is set to active versions of Python
(non-EOL, in development).

## Initialize Git Repository

This project uses dynamic versioning based on Git tags. Initialize your project as a Git repository:

```
git init .
```

## Dependencies and virtual environments

Dependencies are managed by [uv](https://github.com/astral-sh/uv).

Use `make setup` or `uv sync` to install the dependencies.

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
ci = [
  "ruff",
]
```

## Tasks

The tasks are written in Python (for cross-platform compatibility),
and based on the task-runner called [duty](https://github.com/pawamoy/duty).
They are written in the `duties.py` file,
and decorated with the `@duty` decorator.

Example:

```python title="duties.py"
@duty
def check_docs(ctx):
    """Check if the documentation builds correctly."""
    ctx.run("mkdocs build -s", title="Building documentation")
```

To run a task, use `make TASK [ARG=VALUE...]`.
You can run multiple tasks at once: `make TASK1 ARG=VALUE TASK2`.
You can list the available tasks with `make help`.

Available tasks:

- `build`: Build source and wheel distributions.
- `changelog`: Update the changelog in-place with latest commits.
  See [the Changelog section](#changelog).
- `check`: Check it all!
  See [the Quality Analysis section](#quality-analysis).
- `check-quality`: Check the code quality.
  See [the check-quality section](#check-quality).
- `check-docs`: Check if the documentation builds correctly.
  See [the check-docs section](#check-docs).
- `check-types`: Check that the code is correctly typed.
  See [the check-types section](#check-types).
- `clean`: Delete temporary files.
- `coverage`: Report coverage as text and HTML.
- `docs`: Serve the documentation (localhost:8000).
  See [the Documentation section](#documentation).
  Arguments:
    - `host="127.0.0.1"`: The host to serve the docs from.
    - `port=8000`: The port to serve the docs on.
- `format`: Run formatting tools on the code.
- `publish`: Publish source and wheel distributions to PyPI.
- `release`: Release a new Python package.
  See [the Releases section](#releases).
  Arguments:
    - `version` The Python package version.
- `test`: Run the test suite.
  See [the Tests section](#tests).
  Arguments:
    - `match=""`: A pytest expression to filter selected tests.
- `vscode`: Configure VSCode for the project.
  See [VSCode setup](#vscode-setup).

The `make` script provides some additional commands:

- `make help`: Print available commands and tasks.
- `make setup`: Install project and dependencies for all configured Python versions,
  as well as in a default virtual environment (`.venv` + `.venvs/*`).
- `make run command --args`: run arbitrary commands in the default Python virtual environment (`.venv`).
  This command can be useful to run a Python interpreter without having to activate the venv:
  `make run python`.
- `make multirun command --args`: run arbitrary commands for all configured Python versions (`.venvs/*`).
  This command can be useful to check something on all Python versions:
  `make multirun python -c 'import sys; print(sys.version_info)'`.
- `make allrun command --args`: run arbitrary commands in *all* Python virtual environments (`.venv` + `.venvs/*`).
  This command can be useful to override some of the installed dependencies,
  or to install local packages as editable:
  `make allrun pip install -U some-dependency==2.0`, `make allrun pip install -e ../some-project`.
- `make 3.x command --args`: run arbitrary commands for a specific Python versions (`.venvs/3.x`).
  This command can be useful to check something on a specific Python version:
  `make 3.13 duty docs`.

### VSCode setup

If you work in VSCode, we provide a `make vscode` action
that configures settings and tasks. **It will overwrite the following existing
files, so make sure to back them up:**

- `.vscode/launch.json`
- `.vscode/settings.json`
- `.vscode/tasks.json`

## Workflow

The first thing you should run when entering your repository is:

```bash
make setup
```

If you don't have the `make` command,
you can use `scripts/make setup` directly,
or even just `uv venv; uv pip install`
if you don't plan on using multiple Python versions.

This will install the project's dependencies in virtual environments:
one venv per chosen Python version in `.venvs/$python_version`,
and one default venv in `.venv/`.

The chosen Python versions are defined in the `scripts/make` Bash script.

Now you can start writing and editing code in `src/your_package`.

- You can auto-format the code with `make format`.
- You can run a quality analysis with `make check`.
- Once you wrote tests for your new code,
  you can run the test suite with `make test`.
- Once you are ready to publish a new release,
  run `make changelog`, then `make release version=x.y.z`,
  where `x.y.z` is the version added to the changelog.

To summarize, the typical workflow is:

```bash
make setup  # only once

<write code>
make format  # to auto-format the code

<write tests>
make test  # to run the test suite

make check  # to check if everything is OK

<commit your changes>

make changelog  # to update the changelog
<edit changelog if needed>

make release version=x.y.z
```

## Quality analysis

The quality checks are started with:

```
make check
```

This action is actually a composition of several checks:

- `check-quality`: Check the code quality.
- `check-docs`: Check if the documentation builds correctly.
- `check-types`: Check if the code is correctly typed.
- `check-api`: Check for breaking changes in your Python API.

For example, if you are only interested in checking types,
run `make check-types`.

### check-quality

The code quality analysis is done
with [Ruff](https://github.com/astral-sh/ruff).
The analysis is configured in `config/ruff.toml`.
In this file, you can deactivate rules
or activate others to customize your analysis.
Rules identifiers always start with one or more capital letters,
like `D`, `S` or `BLK`, then followed by a number.

You can ignore a rule on a specific code line by appending
a `noqa` comment ("no quality analysis/assurance"):

```python title="src/your_package/module.py"
print("a code line that triggers a Ruff warning")  # noqa: ID
```

...where ID is the identifier of the rule you want to ignore for this line.

Example:

```python title="src/your_package/module.py"
import subprocess
```

```console
$ make check-quality
✗ Checking code quality (1)
  > ruff check --config=config/ruff.toml src/ tests/ scripts/
  src/your_package/module.py:2:1: S404 Consider possible security implications associated with subprocess module.
```

Now add a comment to ignore this warning.

```python title="src/your_package/module.py"
import subprocess  # noqa: S404
```

```console
$ make check-quality
✓ Checking code quality
```

You can disable multiple different warnings on a single line
by separating them with commas:

```python title="src/your_package/module.py"
markdown_docstring = """
    Look at this docstring:

    ```python
    \"\"\"
    print("code block")
    \"\"\"
    ```
"""  # noqa: D300,D301
```

You can disable a warning globally by adding its ID
into the list in `config/ruff.toml`.

You can also disable warnings per file, like so:

```toml title="config/ruff.toml"
[per-file-ignores]
"src/your_package/your_module.py" = [
    "T201",  # Print statement
]
```

### check-docs

This action builds the documentation with strict behavior:
any warning will be considered an error and the command will fail.

The warnings/errors can be about incorrect docstring format,
or invalid cross-references.

See the [Documentation section](#documentation) for more information.

### check-types

This action runs [`mypy`](http://mypy-lang.org/) on the source code
to find potential typing errors.

If you cannot or don't know how to fix a typing error in your code,
as a last resort you can ignore this specific error with a comment:

```python title="src/your_package/module.py"
result = data_dict.get(key, None).value  # type: ignore[ID]
```

...where ID is the name of the warning, for example `arg-type` or `union-attr`.

### check-api

This actions runs [Griffe](https://github.com/mkdocstrings/griffe)
to search for API breaking changes since latest version. It is set
to allow failures, and is more about providing information than
preventing CI to pass.

## Tests

Run the test suite with:

```
make test
```

Behind the scenes, it uses [`pytest`](https://docs.pytest.org/en/stable/)
and plugins to collect and run the tests, and output a report.

Code source coverage is computed thanks to
[coveragepy](https://coverage.readthedocs.io/en/coverage-5.1/).

Sometimes you don't want to run the whole test suite,
but rather one particular test, or group of tests.
Pytest provides a `-k` option to allow filtering the tests.
The `test` command therefore accept a `match=` argument
to specify the value of Pytest's `-k` option:

```
make test match=training
make test match="app and route2"
```

Example of output:

```
Test session starts (platform: linux, Python 3.8.6, pytest 6.2.1, pytest-sugar 0.9.4)
Using --randomly-seed=281943462
rootdir: /home/pawamoy/data/dev/pawamoy/duty, configfile: config/pytest.ini
plugins: randomly-3.5.0, xdist-2.2.0, forked-1.3.0, cov-2.10.1, sugar-0.9.4
collecting ...
 tests/test_logic.py ✓✓✓✓✓✓✓✓✓✓✓✓                                          15% █▋
 tests/test_cli.py ✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓✓ 86% ████████▋
                   ✓✓✓✓✓✓✓✓✓✓✓                                            100% ██████████

----------- coverage: platform linux, python 3.8.6-final-0 -----------
Name                Stmts   Miss Branch BrPart     Cover
--------------------------------------------------------
src/duty/cli.py        62      0     20      0   100.00%
src/duty/logic.py      71      0     18      0   100.00%
--------------------------------------------------------
TOTAL                 133      0     38      0   100.00%


Results (0.76s):
      78 passed
```

## Continuous Integration

The quality checks and tests are executed in parallel
in a [GitHub Workflow](https://docs.github.com/en/actions/learn-github-actions/workflow-syntax-for-github-actions).
The CI is configured in `.github/workflows/ci.yml`.

To force a step to pass even when it fails,
add `nofail=CI` or `nofail=True` to the corresponding
`ctx.run` instruction in `duties.py`

## Changelog

Changelogs are absolutely useful when your software
is updated regularly, to inform your users about the new features
that were added or the bugs that were fixed.

But writing a changelog manually is a cumbersome process.

This is why we offer, with this template,
a way to automatically update the changelog.
There is one requirement though for it to work:
you must use the
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

The two most important are `feat` and `fix` types.
For other types of commits, you can do as you like.

Subject (and body) must be valid Markdown.
If you write a body, please add issues references at the end:

```
Body.

References: #10, #11.
Fixes #15.
```

Examples:

```
feat: Add training route
```

```
fix: Stop deleting user data
```

Following that convention will allow to generate
new entries in the changelog while following the rules
of [semantic versioning](https://semver.org/).

Once you are ready to publish a new release of your package,
run the following command:

```
make changelog
```

This will update the changelog in-place, using the latest,
unpublished-yet commits.

If this group of commits contains only bug fixes (`fix:`)
and/or commits that are not interesting for users (`chore:`, `style:`, etc.),
the changelog will gain a new **patch** entry.
It means that the new suggested version will be a patch bump
of the previous one: `0.1.1` becomes `0.1.2`.

If this group of commits contains at least one feature (`feat:`),
the changelog will gain a new **minor** entry.
It means that the new suggested version will be a minor bump
of the previous one: `0.1.1` becomes `0.2.0`.

If there is, in this group, a commit whose body contains
something like `Breaking change`,
the changelog will gain a new **major** entry,
unless the version is still an "alpha" version
(starting with 0), in which case it gains a **minor** entry.
It means that the new suggested version will be a major bump
of the previous one: `1.2.1` becomes `2.0.0`,
but `0.2.1` is only bumped up to `0.3.0`.
Moving from "alpha" status to "beta" or "stable" status
is a choice left to the developers,
when they consider the package is ready for it.

Finally, once your changelog has been updated,
make sure its contents are correct (add, remove or edit anything
you need), and use the new version (the one that was added
into the changelog) to create a new release:

```
make release version=x.y.z
```

...where x.y.z is the version added in the changelog.

## Releases

As seen in the previous section, you can use the `release` command
to publish new versions of the Python package.

Usually, just before running `make release version=x.y.z`,
you run `make changelog` to update the changelog and
use the newly added version as the argument to `make release`.

For example, if after running `make changelog`, the diff
shows a new `0.5.1` entry in the changelog, you must
release this exact same version with `make release version=0.5.1`.

The `release` action does several things, in this order:

- Stage the changelog file (`CHANGELOG.md`)
- Commit the changes with a message like `chore: Prepare release 0.5.1`
- Tag the commit with that version
- Push the commits
- Push the tags
- Build the package dist and wheel
- Publish the dist and wheel to PyPI.org
- Build and deploy the documentation site

## Documentation

The documentation is built with [Mkdocs](https://www.mkdocs.org/),
the [Material for Mkdocs](https://squidfunk.github.io/mkdocs-material/) theme,
and the [mkdocstrings](https://github.com/pawamoy/mkdocstrings) plugin.

### Writing

The pages are written in Markdown, and thanks to `mkdocstrings`,
even your Python docstrings can be written in Markdown.
`mkdocstrings` particularly supports the
[Google-style](https://sphinxcontrib-napoleon.readthedocs.io/en/latest/example_google.html)
for docstrings.

The documentation configuration is written into `mkdocs.yml`,
at the root of the project. The Markdown pages are written
in the `docs/` directory. You can use any level of nesting you want.
The left-sidebar navigation is configured through the `nav` key
in `mkdocs.yml`.

For example, with these docs structure:

```
📁 docs
├── 📄 changelog.md
├── 📄 index.md
└── 📁 reference
    ├── 📄 cli.md
    └── 📄 logic.md
```

...you can have these navigation items in `mkdocs.yml`:

```yaml title="mkdocs.yml"
nav:
- Overview: index.md
- Code Reference:
  - cli.py: reference/cli.md
  - logic.py: reference/logic.md
- Changelog: changelog.md
```

Note that we matched the sections in the navigation with the folder tree,
but that is not mandatory.

`mkdocstrings` allows you to inject documentation of Python objects
in Markdown pages with the following syntax:

```md
::: path.to.object
    OPTIONS
```

...where `OPTIONS` is a YAML block containing configuration options
for both the selection of Python objects and their rendering.

You can document an entire module or even package with a single instruction:

```md
::: your_package
```

...but it's usually better to have each module injected in a separate page.

The generated projects will by default render only the top-level module in the API reference page.
The template expects that all the API be exposed at the top-level. If you expose public submodules,
add a new page for each one of these submodules.

For more information about `mkdocstrings`,
check [its documentation](https://pawamoy.github.io/mkdocstrings).

### Serving

MkDocs provides a development server with files watching and live-reload.
Run `make docs` to serve your documentation on `localhost:8000`.

If you run it in a remote host (Linux VM) and would like to access it
from your local browser, bind the server to 0.0.0.0 instead:

```bash
make docs host=0.0.0.0
```

If needed, you can also change the port used:

```bash
make docs host=0.0.0.0 port=5000
```

### Deploying

MkDocs has a `gh-deploy` command that will deploy
you documentation on GitHub pages.
We make use of this command in the `docs-deploy` action:

```bash
make docs-deploy
```

If you'd prefer to deploy on ReadTheDocs instead,
you will likely have to write
a `readthedocs.yml` configuration file
and enable the project on ReadTheDocs.
