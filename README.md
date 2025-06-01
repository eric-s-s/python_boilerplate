# Python Boilerplate Template

## What Is This?

These are my own preferences for setting up a python package and/or repo.
It collects tools and dev dependencies for all the things I like when
I start a new python project.

- pytest
- pre-commit: If you don't use it, you should start.
- ruff: For all your linting and formatting needs.
- uv: A fast package/environment manager
- ipython: Run with `uv run ipython`. Nicer than regular interpreter
- github actions: There are basic github action for CI
- Makefile: a convenient way to run scripts

## Dev Install

This requires [uv package manager](https://docs.astral.sh/uv/getting-started/installation/)
They have installation instructions.

### Linux/Mac

`make install`

### Windows

You will first need to install `make`.

`make` is standard on linux devices but needs to be installed on Windows.
see: https://stackoverflow.com/a/32127632 for a long discussion or ...

1. install [chocolatey](https://chocolatey.org/install)
2. run `choco install make`

then `make install`

## Running Stuff

### With `make`

You can run most commands you want from the `Makefile`

- `make install`
- `make lint`
- `make test`
- `make upgrade` to upgrade all of the libraries and pre-commit

### With `uv run`

Any commands that would run in your envronment, you can do with a `uv run`
prefix.  So `pytest`, `ipython`, `pre-commit` just add `uv run <command> <args>`
like `uv run pytest -s -v --durations=10`

### Pre-Commit

Sometimes you'll have a commit that won't pass but you'll fix it later.
Bypass checks on your commit with the `-n` flag. So instead of
`git commit -m 'my message'`, do `git commit -m 'my message' -n`.


## Repo Setup

### Github Actions

This repo contains two actions
