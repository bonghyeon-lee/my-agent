# Git-Worktree Skill Usage Examples

## Scenario 1: Creating a worktree for a new feature branch

**User Request:** "feature/auth-refactor 브랜치로 작업할 수 있게 worktree 하나 만들어줘."

**Agent Action:**

1. Check if the branch exists.
2. Run the helper script: `.agents/skills/git-worktree/scripts/create_worktree.sh feature/auth-refactor`
3. Inform the user that the worktree is created at `../vora_service_feature_auth-refactor`.

## Scenario 2: Creating a worktree in a specific path

**User Request:** "bugfix/usage-fix 작업을 위해 ../vora_debug 폴더에 worktree 생성해줘."

**Agent Action:**

1. Run the helper script: `.agents/skills/git-worktree/scripts/create_worktree.sh bugfix/usage-fix ../vora_debug`
2. Inform the user that the worktree is created at `../vora_debug`.
