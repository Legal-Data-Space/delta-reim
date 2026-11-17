# Ruleset kept for later

`main.json` encodes the rules of `CONTRIBUTING.md` for `main`: a pull request (no approval count: the review by
someone who did not write the change is recorded in its body, and the same account may open and merge), the
`ci-green` check from GitHub Actions, no force push, no deletion, squash merge only, and no bypass.

It is **not applied**: applying it is a repository settings change that needs the CTO's word. This repository is
public, so GitHub's free plan already allows rulesets here (unlike the private repositories).

**If the `ci-green` job of `.github/workflows/test.yml` is ever renamed, change `main.json` (and the applied ruleset)
in the same pull request**, or `main` will wait for a check that never comes.

To apply it (an admin of the repository, once):

```sh
gh api -X POST repos/Legal-Data-Space/delta-reim/rulesets --input .github/rulesets/main.json
```
