---
name: generate-commit-message
description: Git의 Staged 변경 사항을 분석하여 Conventional Commits 형식에 맞춘 커밋 메시지를 생성합니다.
---

# Generate-Commit-Message

이 스킬은 현재 Staged(`git add`된) 변경 사항을 분석하고, 프로젝트의 관례에 맞는 의미 있는 커밋 메시지를 제안하는 데 도움을 줍니다.

## 주요 지침

1. **변경 사항 분석**:
   - `git diff --cached` 결과를 세밀하게 분석합니다.
   - 변경된 파일의 종류, 수정된 함수/컴포넌트, 그리고 변경의 의도를 파악합니다.

2. **Conventional Commits 형식 준수**:
   - 메시지는 `<type>: <subject>` 형식을 따릅니다. (scope는 작성하지 않습니다.)
   - **Types**:
     - `feat`: 새로운 기능 추가
     - `fix`: 버그 수정
     - `docs`: 문서 수정
     - `style`: 코드 포맷팅, 세미콜론 누락 등 (코드 변경 없음)
     - `refactor`: 코드 리팩토링 (기능 변화 없음)
     - `test`: 테스트 코드 추가/수정
     - `chore`: 빌드 업무 수정, 패키지 매니저 설정 등
     - `perf`: 성능 개선
     - `ci`: CI 설정 수정
     - `build`: 빌드 시스템 관련 수정

3. **Subject 가이드라인**:
   - 메시지는 반드시 **간결한 영문**으로 작성합니다.
   - 명령조(Imperative mood)를 사용합니다. (예: "add user auth logic", "fix typo in env key")
   - 첫 글자는 소문자로 시작하며, 끝에 마침표를 찍지 않습니다.

4. **Body (선택 사항)**:
   - 변경 사항이 복잡하거나 중요한 결정 사항이 있는 경우 상세 내용을 포함합니다. (영문 작성)
   - "무엇을" 했는지보다 "왜" 했는지를 설명하는 데 집중합니다.

## 사용 방법

1. 커밋할 변경 사항을 스테이징합니다: `git add .`
2. 변경 사항을 확인합니다: `git diff --cached`
3. 이 스킬의 지침에 따라 아래 단계로 메시지를 생성합니다:
   - 요약된 제목(Subject) 작성
   - 필요한 경우 상세 설명(Body) 추가
   - `breaking change`가 있는 경우 명시

## Best Practices

- 한 번의 커밋에는 하나의 논리적 변경 사항만 담습니다.
- 너무 긴 커밋 메시지는 피하고, 핵심을 찌르는 제목을 작성합니다.
- `refactor`나 `chore` 타입을 적절히 사용하여 커밋 로그의 가독성을 높입니다.
