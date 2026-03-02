---
description: .agents/vault 내에 데이터가 과도하게 쌓였을 때, 가독성을 유지하고 AI의 컨텍스트 윈도우 부담을 줄이기 위한 아카이빙(Archive) 전략 및 실행 절차입니다.
---

# Vault Archive Strategy & Workflow

이 워크플로우(`/archive-vault`)는 `.agents/vault/records/` 하위의 데이터가 비대해져 검색 효율이 떨어지거나 시스템 컨텍스트에 부담이 될 때, 오래된 기록들을 체계적으로 압축 및 보관(Archive)합니다.

## 🗂 아카이빙 전략 (Archiving Strategy)

### 1. 시간 기반 계층화 (Time-based Partitioning)

- **전략**: 특정 기간(예: 3개월 전)이 지난 기록 파일들을 연도(YYYY) 및 월(MM) 폴더 구조로 이동시킵니다.
- **경로 예시**: `.agents/vault/records/2026-02_old.md` ➡️ `.agents/vault/archive/2026/02/2026-02_old.md`
- **효과**: 활성 작업 공간(`records/`)을 가볍게 유지하여 최근 맥락(Recent Context) 검색 속도와 정확도를 높입니다.

### 2. 주제별 요약 압축 (Topic-based Consolidation)

- **전략**: 동일한 태그(예: `#refactoring`, `#drizzle`)를 가진 오래된 아카이브 파일들을 분석하여, 중복된 내용이나 해결된 단순 에러 로그는 제거하고 **핵심 학습 포인트와 주요 아키텍처 결론만 하나의 마스터 마크다운 파일로 병합(Merge)**합니다.
- **파일 예시**: `archive/2026/02/drizzle-summary.md`
- **효과**: 토큰(Token) 사용량을 대폭 절약하면서도 과거의 핵심 지식은 잃지 않습니다.

### 3. 인덱싱 (Auto-Indexing)

- **전략**: 아카이빙 과정을 수행한 후, `.agents/vault/archive/index.md` 파일에 목차를 자동으로 갱신합니다.
- **효과**: AI가 사용자의 과거 해결책이나 지식을 탐색할 때 맵(Map) 역할을 하여 환각(Hallucination) 없이 정확한 파일로 찾아갈 수 있게 돕습니다.

---

## 🤖 실행 지침 (AI Execution Steps)

사용자가 `/archive-vault` 명령어를 실행하면 AI는 다음을 수행합니다:

1. **대상 식별**: `.agents/vault/records/` 디렉토리를 스캔하여 작성일 기준(파일명의 YYYY-MM-DD 또는 YAML Frontmatter) **한 달(또는 지정된 기간)이 지난 파일**들을 식별합니다.
2. **이동 및 디렉토리 생성**: 식별된 파일들을 옮길 `.agents/vault/archive/{YYYY}/{MM}/` 구조를 확인하고, 없다면 생성한 뒤 파일들을 이동(Move)시킵니다.
3. **선택적 압축 제안 (Optional)**: 이동된 파일들이 너무 많거나 주제가 겹칠 경우, 태그별로 내용을 합쳐서 "요약 압축(Consolidation)을 진행할까요?"라고 사용자에게 묻습니다.
4. **인덱스 업데이트**: `archive/index.md` 파일에 이번에 이동/압축된 내역을 연쇄적으로 업데이트하고 링크를 연결해 둡니다.
5. **결과 보고**: 총 몇 개의 파일이 아카이브되었는지 알림 메시지로 요약 리포팅합니다.
