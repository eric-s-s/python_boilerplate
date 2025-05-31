# python_boilerplate

my basic python package.  This is what you'll need to
run a basic python package.  It includes github actions
and pre-commit.

## Setup

This requires [uv package manager](https://docs.astral.sh/uv/getting-started/installation/)
and `make`.  `make` is standard on linux devices but needs to be installed on Windows.
see: https://stackoverflow.com/a/32127632 for a long discussion or ...

1. install [chocolatey](https://chocolatey.org/install)
2. run `choco install make`


Then you can run `make install`

## Other `make` commands

- `make lint` to lint all the files
- `make test` to run the test suite
- `make upgrade` to upgrade pre-commit and packages
