#!/bin/bash

# Usage: ./.agents/skills/generate-pr-message/scripts/collect_pr_data.sh [target-branch]
# Collects commit history and changed files compared to the target branch.

TARGET_BRANCH=$1

if [ -z "$TARGET_BRANCH" ]; then
  if git rev-parse --verify "yskim-hori/dev" > /dev/null 2>&1; then
    TARGET_BRANCH="yskim-hori/dev"
  elif git show-ref --verify --quiet refs/heads/main; then
    TARGET_BRANCH="main"
  else
    TARGET_BRANCH="master"
  fi
fi

CURRENT_BRANCH=$(git branch --show-current)

echo "======================================"
echo " PR Data Collection"
echo "======================================"
echo "  Current Branch : $CURRENT_BRANCH"
echo "  Target Branch  : $TARGET_BRANCH"
echo "======================================"

# --- Commit List ---
echo -e "\n### Commits (newest first) ###\n"
git log --oneline "$TARGET_BRANCH...$CURRENT_BRANCH"

COMMIT_COUNT=$(git log --oneline "$TARGET_BRANCH...$CURRENT_BRANCH" | wc -l | tr -d ' ')
echo -e "\nTotal commits: $COMMIT_COUNT"

# --- Changed Files ---
CHANGED_FILES=$(git diff --name-only "$TARGET_BRANCH...$CURRENT_BRANCH")

if [ -z "$CHANGED_FILES" ]; then
  echo -e "\nNo changed files found."
  exit 0
fi

echo -e "\n### Changed Files by Category ###\n"

echo "--- Components & UI ---"
echo "$CHANGED_FILES" | grep -E "src/components/|src/feature/.*/components/" || echo "(none)"

echo -e "\n--- Services & Business Logic ---"
echo "$CHANGED_FILES" | grep -E "src/services/|src/feature/.*/services/" || echo "(none)"

echo -e "\n--- API & Actions ---"
echo "$CHANGED_FILES" | grep -E "src/api/|src/feature/.*/actions/|src/lib/api" || echo "(none)"

echo -e "\n--- Hooks ---"
echo "$CHANGED_FILES" | grep -E "src/feature/.*/hooks/|src/hooks/" || echo "(none)"

echo -e "\n--- DB & Schema ---"
echo "$CHANGED_FILES" | grep -E "src/lib/db/|drizzle/" || echo "(none)"

echo -e "\n--- Tests ---"
echo "$CHANGED_FILES" | grep -E "\.test\.(ts|tsx)$|\.spec\.(ts|tsx)$" || echo "(none)"

echo -e "\n--- Config, I18n & Others ---"
echo "$CHANGED_FILES" | grep -vE "src/(components|services|api|feature|hooks|lib/db)|drizzle|\.test\.|\.spec\." || echo "(none)"

echo -e "\n--------------------------------------"
echo "Total changed files: $(echo "$CHANGED_FILES" | wc -l | tr -d ' ')"
echo "======================================"
echo ""
echo "[Next Step]"
echo "위 출력 내용을 복사한 뒤, AI에게 다음과 같이 요청하세요:"
echo ""
echo "  '위 내용을 바탕으로 PR 메시지를 한국어로 작성해줘.'"
echo "  (resources/pr_template.md 형식을 참고하여 작성)"
echo "======================================"
