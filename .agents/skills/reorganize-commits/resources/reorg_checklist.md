# Commit Reorganization Checklist

이 체크리스트는 산재된 변경 사항을 깔끔한 커밋 히스토리로 정리하는 과정을 가이드합니다.

## 1. 초기 분석

- [ ] `analyze_diff.sh`를 실행하여 모든 변경된 파일 확인
- [ ] 논리적으로 분리 가능한 기능(Feature) 식별
- [ ] 각 기능 간의 의존성 파악 (예: DB 스키마 -> 서비스 -> UI)

## 2. 재구성 전략 선택

### 상황 A: 현재 커밋들이 너무 세분화되어 있음 (Squash 필요)

- [ ] `git rebase -i [target-branch]` 실행
- [ ] 관련 있는 작은 커밋들을 하나로 합침 (`pick` 대신 `squash` 또는 `fixup` 사용)

### 상황 B: 현재 커밋 하나에 너무 많은 기능이 들어있음 (Split 필요)

- [ ] `git reset HEAD^`로 최신 커밋을 언스테이징
- [ ] 파일별 또는 라인별(`git add -p`)로 나누어 다시 커밋

### 상황 C: 커밋 순서가 논리적이지 않음 (Reorder 필요)

- [ ] `git rebase -i` 목록에서 줄의 위치를 변경하여 순서 조정

## 3. 최종 검토 및 자동화

- [ ] `git rebase -i [branch] --exec "./.agents/skills/reorganize-commits/scripts/verify_commit.sh"`를 사용하여 모든 커밋 자동 검증
- [ ] 각 커밋이 독립적으로 빌드/테스트를 통과하는가?
- [ ] 불필요한 디버깅 로그나 주석이 포함되지 않았는가?
- [ ] 커밋 메시지가 Conventional Commits 형식을 따르는가?
- [ ] 타겟 브랜치의 최신 상태가 반영되었는가? (`git merge` 또는 `git rebase`)

## 4. 수행 팁

- 작업 전 현재 브랜치의 백업을 만들어두세요: `git branch backup/my-feature`
- 리베이스 중 충돌이 나면 당황하지 말고 충돌 해결 후 `git rebase --continue`를 수행하세요.
- 도저히 정리가 안 될 경우 `git checkout -b new-clean-branch`를 만들고 하나씩 파일을 옮겨오는 방법도 있습니다.
