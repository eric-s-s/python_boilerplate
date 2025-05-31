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
	uv run pytest
.PHONY: test
