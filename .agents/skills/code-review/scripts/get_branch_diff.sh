#!/bin/bash

# Usage: ./.agents/skills/code-review/scripts/get_branch_diff.sh <target-branch>

TARGET_BRANCH=$1

if [ -z "$TARGET_BRANCH" ]; then
  # Default to 'yskim-hori/dev' if not specified
  if git rev-parse --verify "yskim-hori/dev" >/dev/null 2>&1; then
    TARGET_BRANCH="yskim-hori/dev"
  elif git show-ref --verify --quiet refs/heads/main; then
    TARGET_BRANCH="main"
  else
    TARGET_BRANCH="master"
  fi
fi

CURRENT_BRANCH=$(git branch --show-current)

echo "Comparing current branch [$CURRENT_BRANCH] with target branch [$TARGET_BRANCH]..."

# Check if target branch exists
if ! git rev-parse --verify "$TARGET_BRANCH" >/dev/null 2>&1; then
  echo "Error: Target branch '$TARGET_BRANCH' does not exist."
  exit 1
fi

# Get list of changed files
echo "Changed files:"
git diff --name-status "$TARGET_BRANCH...$CURRENT_BRANCH"

echo -e "\n--- Full Diff ---"
git diff "$TARGET_BRANCH...$CURRENT_BRANCH"
