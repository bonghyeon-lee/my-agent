#!/bin/bash

# Usage: ./.agents/skills/reorganize-commits/scripts/analyze_diff.sh <target-branch>

TARGET_BRANCH=$1

if [ -z "$TARGET_BRANCH" ]; then
  # Source .env if exists to get DEFAULT_TARGET_BRANCH
  if [ -f ".agents/.env" ]; then
    source .agents/.env
  fi

  # Default to DEFAULT_TARGET_BRANCH or 'yskim-hori/dev'
  if [ -n "$DEFAULT_TARGET_BRANCH" ] && git rev-parse --verify "$DEFAULT_TARGET_BRANCH" >/dev/null 2>&1; then
    TARGET_BRANCH="$DEFAULT_TARGET_BRANCH"
  elif git rev-parse --verify "yskim-hori/dev" >/dev/null 2>&1; then
    TARGET_BRANCH="yskim-hori/dev"
  elif git show-ref --verify --quiet refs/heads/main; then
    TARGET_BRANCH="main"
  else
    TARGET_BRANCH="master"
  fi
fi

CURRENT_BRANCH=$(git branch --show-current)

echo "Analyzing differences between [$CURRENT_BRANCH] and [$TARGET_BRANCH]..."

# Get changed files
CHANGED_FILES=$(git diff --name-only "$TARGET_BRANCH...$CURRENT_BRANCH")

if [ -z "$CHANGED_FILES" ]; then
  echo "No changes found."
  exit 0
fi

echo -e "\n### Logical Grouping Suggestions ###\n"

# Simple grouping logic based on paths
echo "--- Components & UI ---"
echo "$CHANGED_FILES" | grep -E "src/components/|src/feature/.*/components/" || echo "(none)"

echo -e "\n--- Services & Business Logic ---"
echo "$CHANGED_FILES" | grep -E "src/services/|src/feature/.*/services/" || echo "(none)"

echo -e "\n--- API & Actions ---"
echo "$CHANGED_FILES" | grep -E "src/api/|src/feature/.*/actions/|src/lib/api" || echo "(none)"

echo -e "\n--- DB & Schema ---"
echo "$CHANGED_FILES" | grep -E "src/lib/db/|drizzle/" || echo "(none)"

echo -e "\n--- Others (Config, I18n, etc.) ---"
echo "$CHANGED_FILES" | grep -vE "src/(components|services|api|feature|lib/db)|drizzle" || echo "(none)"

echo -e "\n------------------------------------"
echo "Total changed files: $(echo "$CHANGED_FILES" | wc -l)"
