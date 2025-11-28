check-requirements:
	uv --version
.PHONY: check-requirements


install: check-requirements
	uv python install
	uv sync --locked --all-groups
	uv run pre-commit install
.PHONY: install


upgrade:
	uv lock --upgrade
	uv run pre-commit autoupdate
.PHONY: upgrade


lint:
	uv run pre-commit run -a
.PHONY: lint


test:
	@echo "to add pytest args: `make test ARGS='--durations 5 -vv'`"
	uv run pytest $(ARGS)
.PHONY: test


build:
	uv build
.PHONY: build
