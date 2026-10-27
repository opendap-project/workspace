#!/bin/sh
# Rebuild the OpenDAP workspace with whatever repositories you can access.
#
#   scripts/bootstrap.sh [--public-only] [--update] [--json]
#
# - Public repositories (repos.tsv) are always cloned.
# - Private repositories are listed in the private overlay (opendap-project/workspace-private,
#   cloned to private/workspace-private). Each one is cloned only if your git credentials can
#   reach it; anything you cannot access is skipped and reported. Never prompts for passwords.
# - --update fast-forwards repositories that are already present.
# - pre-commit is installed in every clone when it is available.
set -eu
cd "$(dirname "$0")/.."
public_only=0; update=0; json=0
for a in "$@"; do
  case "$a" in
    --public-only) public_only=1 ;;
    --update) update=1 ;;
    --json) json=1 ;;
    *) echo "unknown option: $a" >&2; exit 2 ;;
  esac
done
export GIT_TERMINAL_PROMPT=0
results=""
record() { results="$results$1	$2	$3
"; [ $json -eq 1 ] || printf '%-10s %-40s %s\n' "$1" "$2" "$3"; }

reachable() { git ls-remote --heads "https://github.com/$1.git" >/dev/null 2>&1; }

sync_repo() { # path repo
  path="$1"; repo="$2"
  if [ -d "$path/.git" ]; then
    if [ $update -eq 1 ]; then git -C "$path" pull -q --ff-only && record updated "$path" "$repo" || record conflict "$path" "$repo"
    else record present "$path" "$repo"; fi
  elif reachable "$repo"; then
    git clone -q --recurse-submodules "https://github.com/$repo.git" "$path" && record cloned "$path" "$repo"
  else
    record skipped "$path" "$repo (no access)"
    return 0
  fi
  if command -v pre-commit >/dev/null 2>&1 && [ -f "$path/.pre-commit-config.yaml" ]; then
    (cd "$path" && pre-commit install >/dev/null 2>&1) || true
  fi
}

# Here-documents keep the loops in this shell, so the report survives.
while IFS="$(printf '\t')" read -r path repo; do sync_repo "$path" "$repo"; done <<EOF_PUBLIC
$(tail -n +2 repos.tsv)
EOF_PUBLIC

if [ $public_only -eq 0 ]; then
  sync_repo private/workspace-private opendap-project/workspace-private
  if [ -f private/workspace-private/repos.tsv ]; then
    while IFS="$(printf '\t')" read -r path repo; do
      [ "$path" = private/workspace-private ] && continue
      sync_repo "$path" "$repo"
    done <<EOF_PRIVATE
$(tail -n +2 private/workspace-private/repos.tsv)
EOF_PRIVATE
  fi
fi

if [ $json -eq 1 ]; then
  printf '{"schema":"opendap.workspace-bootstrap/v1","items":['
  printf '%s' "$results" | awk -F'\t' 'NF==3 {printf "%s{\"status\":\"%s\",\"path\":\"%s\",\"repository\":\"%s\"}", (n++?",":""), $1, $2, $3}'
  printf ']}\n'
fi
