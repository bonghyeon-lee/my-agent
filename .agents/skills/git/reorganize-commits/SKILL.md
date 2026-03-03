---
name: reorganize-commits
description: 현재 코드와 대상 브랜치를 비교하여 기능별로 커밋을 다시 정리하는 작업을 도와줍니다.
---

# Reorganize-Commits Skill

이 스킬은 PR을 올리기 전, 복잡하게 섞여있는 변경 사항들을 기능별(Feature)로 논리적으로 묶어 커밋을 재구성할 수 있도록 돕습니다.

## 주요 기능

1. **변경 사항 분석**: 대상 브랜치(`.agents/.env`의 `DEFAULT_TARGET_BRANCH` 또는 기본값)와 비교하여 변경된 파일들을 논리적 그룹으로 분류합니다.
2. **커밋 구조 제안**: 변경 사항의 연관성을 파악하여 어떤 단위로 커밋을 나누면 좋을지 가이드를 제공합니다.
3. **리베이스 지원**: `git rebase -i`를 사용하여 커밋을 합치거나(squash) 나누는 과정을 안내합니다.

## 사용 방법

1. **변동 사항 분석 수행**:
   `scripts/analyze_diff.sh [target-branch]` 스크립트를 실행하여 변경된 파일 목록과 논리적 그룹을 확인합니다.
   (예: `./.agents/skills/reorganize-commits/scripts/analyze_diff.sh`)

2. **커밋 재구성 계획**:
   스크립트가 출력한 그룹을 바탕으로, `resources/reorg_checklist.md`의 절차에 따라 커밋을 정리합니다.

3. **대화형 리베이스**:
   정리가 필요한 경우 다음 명령어를 사용하여 커밋 히스토리를 수정합니다:

   ```bash
   git rebase -i <target-branch>  # 예: git rebase -i main
   ```

4. **커밋별 자동 검증 (선택 사항)**:
   리베이스된 모든 커밋이 빌드 및 테스트를 통과하는지 확인하려면 다음 명령어를 사용합니다:

   ```bash
   git rebase -i <target-branch> --exec "./.agents/skills/reorganize-commits/scripts/verify_commit.sh"
   ```

   이 명령어는 리베이스 과정 중 매 커밋마다 `verify_commit.sh`를 실행하며, 실패할 경우 리베이스를 일시 중지하여 즉시 수정할 수 있게 돕습니다.

## 재구성 가이드라인

- **독립적인 기능 단위**: 하나의 커밋은 하나의 완성된 기능이나 논리적 변경을 담아야 합니다.
- **문맥 위주 그룹화**: 관련 있는 UI 컴포넌트, 서비스 로직, API 연동은 같은 그룹으로 묶는 것이 좋습니다.
- **의존성 순서**: 기초가 되는 스키마나 공통 유틸리티 변경을 앞선 커밋에 배치합니다.
- **가독성 있는 메시지**: 재구성된 각 커밋에는 변경 의도가 명확히 드러나는 메시지를 작성합니다.
