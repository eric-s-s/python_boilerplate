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
image_tag_sha := python-boilerprlate:$(shell git rev-parse HEAD)

image:
	docker build --progress plain --no-cache \
	-t $(image_tag_latest) \
	-t $(image_tag_sha) \
	--build-arg UV_VERSION=$(uv_version) \
	--build-arg APP_IMAGE=$(app_image) \
	--build-arg DEV_IMAGE=$(dev_image) \
	--label git-shaw=$(shell git rev-parse HEAD) \
	./
.PHONY: image

run-image:
	docker run --rm -it $(image_tag_sha)

testing:
	echo $(file < UV_VERSION)
