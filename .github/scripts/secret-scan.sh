#!/usr/bin/env bash
# Secret scan of the commits a CI run brings (job "Secret scan (gitleaks)"). Fails closed: a range that does not
# resolve, an empty range or a rewritten main is an error, never a pass on nothing.
# Env: EVENT (pull_request|push), PR_BASE, PR_HEAD, PUSH_BEFORE, PUSH_AFTER, GITLEAKS (binary),
#      GITLEAKS_CONFIG (default .gitleaks.toml). Run from the repository root.
set -euo pipefail

die() { echo "::error::secret scan: $*" >&2; exit 1; }
commit() { git rev-parse --verify --quiet "$1^{commit}" || die "$2 ($1) does not resolve to a commit in this clone"; }

ZERO=0000000000000000000000000000000000000000
CONFIG=${GITLEAKS_CONFIG:-.gitleaks.toml}
[ -x "${GITLEAKS:-}" ] || die "gitleaks binary missing (GITLEAKS='${GITLEAKS:-}')"
[ -f "$CONFIG" ] || die "config $CONFIG missing"
rewritten=no

case "${EVENT:-}" in
  pull_request)
    if [ -z "${PR_BASE:-}" ] || [ -z "${PR_HEAD:-}" ]; then die "pull request base or head sha missing"; fi
    base=$(commit "$PR_BASE" "the pull request base")
    head=$(commit "$PR_HEAD" "the pull request head")
    ;;
  push)
    [ -n "${PUSH_AFTER:-}" ] || die "pushed sha missing"
    head=$(commit "$PUSH_AFTER" "the pushed commit")
    if [ -z "${PUSH_BEFORE:-}" ] || [ "$PUSH_BEFORE" = "$ZERO" ]; then
      # First push of the branch: the pushed commit against its first parent.
      base=$(git rev-parse --verify --quiet "$head^1^{commit}") || die "first push of a root commit: nothing to compare with, scan it by hand"
      echo "First push of this branch: scanning the pushed commit against its first parent."
    else
      base=$(commit "$PUSH_BEFORE" "the previous tip (gone after a force push?)")
      if ! git merge-base --is-ancestor "$base" "$head"; then rewritten=yes; fi
    fi
    ;;
  *) die "unexpected event '${EVENT:-}'" ;;
esac

count=$(git rev-list --count "$base..$head")
[ "$count" -gt 0 ] || die "the range $base..$head holds no commit"
echo "Scanning $base..$head: $count commit(s); merge commits against each parent (-m)."
"$GITLEAKS" git --no-banner --redact --exit-code 1 --config "$CONFIG" --log-opts="-m $base..$head" .

if [ "$rewritten" = yes ]; then
  die "the previous tip $base is not an ancestor of $head (main was rewritten): the $count new commit(s) were scanned, but what the rewrite dropped or changed was not; check by hand"
fi
