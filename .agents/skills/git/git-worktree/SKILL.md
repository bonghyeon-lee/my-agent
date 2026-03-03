---
name: git-worktree
description: 이 스킬은 git worktree를 생성하고 관리하는 작업을 도와줍니다.
---

# Git-Worktree Skill

이 스킬은 프로젝트 외부 디렉토리에 새로운 git worktree를 생성하여, 현재 작업 컨텍스트를 유지하면서 다른 브랜치나 커밋에서 병렬로 작업할 수 있게 합니다.

## 주요 기능

1. **Worktree 생성**: 특정 브랜치나 커밋을 대상으로 새로운 worktree를 생성합니다.
2. **디렉토리 관리**: 워크스페이스 상위 디렉토리에 일관된 명명 규칙으로 worktree를 배치합니다.
3. **자동 설정**: 생성된 worktree 디렉토리로 이동하여 필요한 초기 설정을 수행할 수 있도록 안내합니다.

## 사용 방법

에이전트에게 다음과 같이 요청할 수 있습니다:

- "새로운 기능 개발을 위해 `feature/new-task` 브랜치로 worktree를 만들어줘."
- "`bugfix/issue-1` 작업을 위해 `../vora_service_bugfix` 위치에 worktree 생성해줘."

## 설계 원칙

- **경로 규칙**: 기본적으로 `../[repo-name]_[branch-name]` 형태의 경로를 사용합니다.
- **안전성**: 이미 존재하는 디렉토리에 덮어쓰지 않도록 체크합니다.
- **워크플로우**: 생성 후 해당 디렉토리에서 작업할 수 있도록 정보를 제공합니다.

## 헬퍼 스크립트

`.agents/skills/git-worktree/scripts/create_worktree.sh` 스크립트를 사용하여 안전하게 worktree를 생성합니다.

```bash
# 사용 예시
./.agents/skills/git-worktree/scripts/create_worktree.sh [branch-name] [path]
```
