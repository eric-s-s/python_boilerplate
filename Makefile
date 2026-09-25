help:
	@echo "Usage: make <target>"
	@echo "Targets:"
	@echo "  install - install dependencies"
	@echo "  upgrade - upgrade dependencies"
	@echo "  lint - lint code"
	@echo "  test - run tests"
	@echo "  build - build package"
	@echo "  image - build a docker image"
	@echo "  run-image - run the docker image"
.PHONY: help

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
	@echo "to add pytest args: make test ARGS='--durations 5 -vv'"
	uv run pytest $(ARGS)
.PHONY: test


build:
	uv build
.PHONY: build

uv_version := $(file < UV_VERSION)
python_version := $(file < .python-version)
app_image := alpine:latest
dev_image := python:$(python_version)-alpine
image_tag_latest := python-boilerplate:latest
image_tag_sha := python-boilerplate:$(shell git rev-parse HEAD)

image:
	docker build --progress plain --no-cache \
	-t $(image_tag_latest) \
	-t $(image_tag_sha) \
	--build-arg UV_VERSION=$(uv_version) \
	--build-arg PYTHON_VERSION=$(python_version) \
	--label git-sha=$(shell git rev-parse HEAD) \
	./
.PHONY: image


run-image:
	@echo "to add params to 'python': make run-image CMD='-m main.main'"
	@echo "to add options like entrypoints: make run-image OPTIONS='--entrypoint demo-script'"
	@echo "in general, using scripts can be very delicate with distroless images and you should avoid it."
	docker run --rm -it $(OPTIONS) $(image_tag_sha) $(CMD)
