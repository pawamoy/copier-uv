# Generating a project

To generate a project, run the following command:

```bash
copier copy --trust "https://github.com/oedokumaci/copier-uv.git" /path/to/your/new/project
```

Or with a shorter command:

```bash
copier copy --trust "gh:oedokumaci/copier-uv" /path/to/your/new/project
```

You can even generate a project without installing Copier, using [uv](https://docs.astral.sh/uv/):

```bash
uvx --with copier-templates-extensions copier copy --trust "gh:oedokumaci/copier-uv" /path/to/your/new/project
```

## Questions

*The following examples are not up-to-date,
they simply illustrate how the template works.*

Copier will ask you to answer some questions:

```
Your project name
project_name? Format: str
🎤 [None]: My Project
```

The project name can use spaces and capitals.
It will be used as the main heading in the README for example.

---

```
Your project description
project_description? Format: str
🎤 [None]: My super project!
```

The project description can be as long as you want,
and use any character you want.

---

```
Your full name
author_fullname? Format: str
🎤 [None]: Your Name
```

The full name will appear as "author" in the project's metadata.

---

```
Your email
author_email? Format: str
🎤 [your@email.com]: 
```

The email will appear as "author email" in the project's metadata.
It defaults to your git config `user.email` value.

---

```
Your username (e.g. on GitHub)
author_username? Format: str
🎤 [your-username]: 
```

The username you are using on the git repository provider.
It defaults to your git config `user.name` value.

---

```
Your repository provider
repository_provider? Format: str
🎤
(1) github.com
Choice [1]: 
```

The repository provider on which you plan to store your project.
This template only supports GitHub, but the question is left in
case we add support for more providers in the future.

---

```
Your repository namespace
repository_namespace? Format: str
🎤 [your-username]: 
```

The namespace (or account) on which the project will be stored.
It defaults to the username you provided.

---

```
Your repository name
repository_name? Format: str
🎤 [my-project]: 
```

The repository name on the selected provider.
It defaults to a slugified version of your project's name.

---

```
The name of the person/entity holding the copyright
copyright_holder? Format: str
🎤 [Your Name]: 
```

The name of the person or entity holding the copyright on the project.
It defaults to the full name your provided.

---

```
The email of the person/entity holding the copyright
copyright_holder_email? Format: str
🎤 [your@email.com]: 
```

The email of the person or entity holding the copyright on the project.
It defaults to the email your provided.

---

```
The copyright date
copyright_date? Format: str
🎤 [2021]: 
```

The date to apply to the copyright.
It defaults to the current year.

---

```
Your project's license
copyright_license? Format: str
🎤
(1) Academic Free License v3.0
(2) Apache License 2.0
(3) Artistic License 2.0
(4) BSD 2-Clause "Simplified" License
(5) BSD 3-Clause Clear License
(6) BSD 3-Clause "New" or "Revised" License
(7) Boost Software License 1.0
(8) Creative Commons Attribution 4.0
(9) Creative Commons Attribution Share Alike 4.0
(10) Creative Commons Zero v1.0 Universal
(11) Do What The F*ck You Want To Public License
(12) Educational Community License v2.0
(13) Eclipse Public License 1.0
(14) Eclipse Public License 2.0
(15) European Union Public License 1.1
(16) European Union Public License 1.2
(17) GNU Affero General Public License v3.0
(18) GNU General Public License v2.0
(19) GNU General Public License v3.0
(20) GNU Lesser General Public License v2.1
(21) GNU Lesser General Public License v3.0
(22) ISC License
(23) LaTeX Project Public License v1.3c
(24) MIT License
(25) Mozilla Public License 2.0
(26) Microsoft Public License
(27) Microsoft Reciprocal License
(28) University of Illinois/NCSA Open Source License
(29) SIL Open Font License 1.1
(30) Open Software License 3.0
(31) PostgreSQL License
(32) The Unlicense
(33) zlib License
Choice [22]: 
```

A license from choosealicence.com.
It defaults to ISC License (my personal preference).

---

```
Your Python package distribution name (for `pip install NAME`)
python_package_distribution_name? Format: str
🎤 [my-project]: 
```

The name under which your Python package will be distributed.
This will be the name of your project on pypi.org for example.

---

```
Your Python package import name (for `import NAME` in Python code)
python_package_import_name? Format: str
🎤 [my_project]: 
```

The name that will be used to import your package in Python code.
Yes, distribution name and import name can be different!

## Output

At this point, Copier will generate the project in the specified directory:

```
    create  pyproject.toml
    create  mkdocs.yml
    create  .copier-answers.yml
    create  README.md
    create  LICENSE
    create  CONTRIBUTING.md
    create  CHANGELOG.md
    create  CLAUDE.md
    create  .gitignore
    create  tests/
    create  tests/conftest.py
    create  tests/__init__.py
    create  tests/test_main.py
    create  src/
    create  src/my_project/
    create  src/my_project/__init__.py
    create  src/my_project/__main__.py
    create  src/my_project/_internal/
    create  src/my_project/_internal/__init__.py
    create  src/my_project/_internal/cli.py
    create  src/my_project/_internal/debug.py
    create  src/my_project/_internal/logging.py
    create  scripts/
    create  scripts/gen_credits.py
    create  docs/
    create  docs/index.md
    create  docs/contributing.md
    create  docs/changelog.md
    create  docs/css/
    create  docs/css/mkdocstrings.css
    create  config/
    create  config/pytest.ini
    create  config/ruff.toml
    create  config/coverage.ini
    create  .github/
    create  .github/workflows/
    create  .github/workflows/ci.yml
    create  .github/ISSUE_TEMPLATE/
    create  .github/ISSUE_TEMPLATE/1-bug.md
    create  .github/ISSUE_TEMPLATE/2-feature.md

Initialized empty Git repository in /path/to/your/new/project/.git/

Project successfully generated!
Run `uvx --from taskipy task --list` to show the available tasks.
```

The project includes an initialized git repository. See the next chapter to learn how to work on this new project.
