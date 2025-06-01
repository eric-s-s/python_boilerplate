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
`git commit -am 'my message'`, do `git commit -am 'my message' -n`.


## Repo Setup

### Github Actions

github actions must always be located in `.github/workflows`

This repo contains two actions

- Lint And Test: Run linter and pytest on PRs and merge to main.
  Located in: `.github/workflows/ci.yaml`
- Update Dependencies: Run a weekly update job and open PR on changes.
  Located in: `.github/workflows/updater.yaml`

#### Using the Update Dependencies Action

**If you use this action remove `eric-s-s` as an assignee in `updater.yaml`!**

This runs updates to all libraries on a weekly basis. If there are file
changes, it automatically creates a PR and assigns me (eric-s-s) to the PR.
If you want something like this you'll need to do some updating. Including
from the next section with personal access token management.

#### Personal Access Token Management for PR actions

**Use the new fine-grained access tokens!** You have no good reason
not to, and they are more secure.

The `create-pull-request` github action explains the following for
tokens and their requirements. I've also included the example I used.

- https://github.com/peter-evans/create-pull-request?tab=readme-ov-file#token
- https://github.com/peter-evans/create-pull-request/blob/main/docs/examples.md#update-npm-dependencies

And GitHub explains about personal access tokens and repo secrets here:

- https://docs.github.com/en/authentication/keeping-your-account-and-data-secure/managing-your-personal-access-tokens#creating-a-fine-grained-personal-access-token
- https://docs.github.com/en/actions/security-for-github-actions/security-guides/using-secrets-in-github-actions#creating-secrets-for-a-repository

### Repo Settings

#### General Repo Settings - Pull Request Section

`Pull Request` section let's you specify what kind of PR merging to allow
I tend to only do  `Allow squash merging` with `Default commit message`
set to `Pull request title and commit details`.

It also contains the `Automatically delete head branches`

#### Branch Rulesets

You should be able to view the branch rulesets for this branch
and export them and import someplace else or just copy them.

The required status checks part is a bit annoying. You need to pick
from an auto-generated list and you might need to run the action first

For the github action below I've seen it auto-complete on either

- basic-ci
- run linting and testing

```
jobs:
  basic-ci:
    name: run linting and testing
```
