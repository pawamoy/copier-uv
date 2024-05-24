.PHONY: $(MAKECMDGOALS)

changelog:
	@.venv/bin/git-changelog -Tio CHANGELOG.md -Bauto -c angular -n pep440

clean:
	@rm -rf tests/tmp

cleantests:
	@rm -rf tests/tmp/.git
	@rm -rf tests/tmp/empty
	@rm -rf tests/tmp/CHANGELOG.md

docs:
	@.venv/bin/mkdocs serve

docs-deploy:
	@.venv/bin/mkdocs gh-deploy

format:
	@.venv/bin/ruff format . project/scripts/make

gen generate:
	@bash -c 'source tests/helpers.sh && generate ${PWD} tests/tmp'

reset-history: gen
	@bash tests/reset_history.sh

release:
	@test -n "$(version)" || { echo "error: usage: make release version=x.y.z" >&2; exit 1; }
	@git add CHANGELOG.md
	@git commit -m "docs: Update changelog for version $(version)"
	@git tag $(version)
	@git push
	@git push --tags

setup:
	@uv venv --seed
	@uv pip install -r requirements.txt

test: cleantests
	@bash tests/test_filenames.sh
	@bash tests/test_project.sh
	@.venv/bin/python tests/test_licenses.py

wait-ci:
	@bash tests/wait_ci.sh

DUTIES = \
	test-changelog \
	test-check \
	test-check-api \
	test-check-docs \
	test-check-quality \
	test-check-types \
	test-clean \
	test-coverage \
	test-docs \
	test-docs-deploy \
	test-format \
	test-help \
	test-lock \
	test-release \
	test-setup \
	test-test

$(DUTIES):
	@cd tests/tmp && make $(subst test-,,$@)
