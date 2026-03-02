# PR 메시지 예시

아래는 `collect_pr_data.sh` 스크립트 출력을 기반으로 생성된 PR 메시지 예시입니다.

---

## 제목

```
[feat] 구독 관리 UI 개선 및 실시간 사용량 반영
```

---

## 본문

### 개요

구독 카드 UI를 ProductCard와 일관된 디자인으로 통일하고, Redis에서 실시간 사용량을 조회하여 UI에 즉시 반영되도록 개선했습니다. 또한 무료 도구에 대한 "기본 제공 도구" 레이블 표시와 전체 선택 오동작 버그를 수정했습니다.

---

### 변경 내용

#### ✨ 새로운 기능 / 개선

- `SubscriptionCard`: `ProductCard`와 동일한 카드 구조(border-radius 16px, dashed separator) 적용
- `purchase-service.ts`: Redis에서 실시간 잔여 할당량 조회하여 UI 지연 제거
- 무료 도구에 "기본 제공 도구" i18n 레이블 추가 (`store.freeToolLabel`)

#### 🐛 버그 수정

- 무료 도구가 전체 선택(`select all`) 시 체크박스가 비활성화됨에도 선택되는 버그 수정

#### ♻️ 리팩토링

- `UsageService`: Redis Lua 스크립트 적용으로 사용량 차감 원자성 보장
- `UsageWorker`: Redis 기반 버퍼링으로 재시작 시 데이터 유실 방지

#### 🧪 테스트

- `subscription-cancel-actions.test.ts`: 멀티 커런시 합산 로직 테스트 추가
- `subscription-sync-actions.test.ts`: 구독 동기화 시나리오 테스트 추가

---

### 테스트 확인 항목

- [x] 로컬 빌드 통과 (`npm run build`)
- [x] 타입 검사 통과 (`npm run type-check`)
- [x] 단위 테스트 통과 (`npm run test`)
- [x] 구독 카드 UI 다크/라이트 모드 육안 확인
- [x] 실시간 사용량 Redis 조회 동작 확인

---

### 참고 사항

- Paddle 결제 화면 테마 동기화는 후속 PR에서 진행 예정
- 관련 이슈: #142
