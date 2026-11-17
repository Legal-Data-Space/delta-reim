# Contributing to the Delta Reim marketplace

How changes reach `main`, and what CI checks. This repository is **public**: everything committed here, history
included, can be read by anyone.

## Branches and commits

- `main` is the trunk. **Nobody pushes to it directly**: every change reaches it through a pull request.
- Work on a branch named by its kind and subject: `feat/…`, `fix/…`, `docs/…`, `chore/…`, `ci/…`
  (for example `feat/skill-courrier-relance`).
- Commit messages and pull request titles follow [Conventional Commits](https://www.conventionalcommits.org/):
  `<type>: <short description>`, in English, with types `feat`, `fix`, `docs`, `chore`, `ci`, `refactor`.
  The body says why, not what. Skill content itself is in French, for the Delta Reim team.
- Stage files by name. Never commit secrets, keys, `.env` files or real client data: examples (`exemples/`) are
  fictitious, and skills hold no Delta Reim data.

## Pull requests

- **One pull request = one coherent piece**: a skill, a fix or a document set that makes sense on its own.
- **Reviewed by someone who did not write it** (a person, or a fresh reviewer that took no part in writing it), and
  **tested before it opens**: `scripts/build-zips.sh` passes locally, and a changed skill has been tried in Claude
  with synthetic input. The body follows the template (`.github/pull_request_template.md`).
- **Squash merge only.** The pull request title becomes the commit on `main`.
- **Merged by the maintainers once CI is green** (the `ci-green` check) and the review is in the body.
- **Never without the CTO's word:** tags, releases, force pushes, and any change to the gate itself (next section).

### Changes to the gate

A pull request that touches `.github/` (workflows, scripts, rulesets, this template), `.githooks/`, `.gitleaks*`, or
adds a `gitleaks:allow` comment anywhere, changes the checks that let content into `main`. It needs the CTO's word.
Before merging any pull request, the maintainer who merges checks the diff for these paths and that comment
(`git diff --stat origin/main...HEAD` and a search for `gitleaks:allow`), and stops if one appears without that word.

## What CI runs

The workflow `.github/workflows/test.yml` runs on every pull request and on every push to `main`, on GitHub's hosted
Ubuntu 24.04 runners. A newer push to a pull request cancels its running checks; each push to `main` runs in a group of its own, so none
is dropped and every merge keeps its own result. Run steps use `bash -eo pipefail`.
GitHub Actions minutes are free on a public repository.

| Job | What it runs |
|---|---|
| `Plugin checks (manifests, skills, scripts)` | shellcheck on every shell script; the marketplace and plugin manifests parse, each listed plugin exists with a `plugin.json` of the same name, and every folder under `plugins/` is listed; `scripts/build-zips.sh` (each `SKILL.md` name equals its folder, name at most 64 characters, description at most 200; builds the upload zips, discarded) |
| `Secret scan (gitleaks)` | gitleaks over the commits the pull request (or the push) brings, merge commits included (against each parent), with `.gitleaks.toml`; not the whole history. It fails closed on a range that does not resolve, an empty range or a rewritten `main` (`.github/scripts/secret-scan.sh`) |
| `ci-green` | Passes only if every job above passed. This is the one check to require on `main`. |

There is no test suite: a skill is tried in Claude by the person who changes it, and the result goes in the pull
request body.

## Running the checks locally

Requirements: `bash`, `jq`, `zip`, `shellcheck`, and [gitleaks](https://github.com/gitleaks/gitleaks) 8.30.1 for the
secret scan.

```sh
shellcheck scripts/*.sh .github/scripts/*.sh .githooks/pre-push
scripts/build-zips.sh
gitleaks git --redact --config .gitleaks.toml --log-opts="-m origin/main..HEAD" .   # your branch's commits, as CI
```

## The pre-push hook

`.githooks/pre-push` refuses a push whose target is `main`, and a push that sends tags (they need the CTO's word).
Enable it once per clone:

```sh
git config core.hooksPath .githooks
```

It is a reminder, not a lock: `git push --no-verify` skips it.

## Enforcement

The rules above are kept by the team; GitHub does not enforce them yet. The ruleset to apply on `main` (pull request
required, `ci-green` required, no force push, no deletion, squash only) is kept in `.github/rulesets/main.json`; see
`.github/rulesets/README.md`.

## Publishing

There is no release workflow. The upload zips are built by `scripts/build-zips.sh` into `dist/` (ignored by git) and
handed over by Legal Data Space; the marketplace itself is read from `main`.
