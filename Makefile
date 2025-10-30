help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  all - install, format, lint, test, build"
	@echo "  install - install dependencies"
	@echo "  upgrade - upgrade dependencies"
	@echo "  format - format code"
	@echo "  lint - lint code"
	@echo "  test - run tests"
	@echo "  build - build package"
.PHONY: help


all: install format lint test build
.PHONY: all


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


format:
	uv run ruff format
.PHONY: format


lint:
	uv run pre-commit run -a
.PHONY: lint


test:
	uv run pytest
.PHONY: test


build:
	uv build
.PHONY: build
