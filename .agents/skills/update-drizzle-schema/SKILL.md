---
name: update-drizzle-schema
description: DB의 현재 상태를 Drizzle ORM Schema(src/lib/db/schema.ts)에 안전하게 반영하는 가이드라인 및 도구입니다.
---

# Update Drizzle Schema

데이터베이스 스키마가 외부에서 변경되었을 때, 이를 안전하게 프로젝트의 `src/lib/db/schema.ts` 및 `relations.ts`에 동기화하는 스킬입니다.
단순히 introspect 결과를 덮어씌울 경우 프로젝트에 커스텀하게 추가된 타입(`$type<...>`)이나 `defaultRandom()` 같은 Drizzle ORM 애플리케이션 레벨의 기본값이 손실될 수 있으므로, 변경 사항만을 체리픽(Cherry-pick)하여 반영해야 합니다.

## 실행 절차

### 1. Drizzle Introspect 실행

먼저 DB의 현재 상태를 pull하여 `drizzle` 폴더에 임시 스키마 파일들을 생성합니다.

```bash
npm run db:pull
```

> 이 명령어는 `drizzle.config.ts` 설정에 따라 `drizzle/schema.ts`와 `drizzle/relations.ts`를 생성합니다.

### 2. 스키마 비교 내용 확인 (Schema Diffing)

생성된 `drizzle/schema.ts`와 기존 `src/lib/db/schema.ts`를 비교하여 어떤 테이블/컬럼이 추가되거나 삭제되었는지 식별합니다. 포함된 헬퍼 스크립트를 사용하여 차이를 쉽게 분석할 수 있습니다.

```bash
# 프로젝트 루트 디렉토리에서 아래 명령어를 순차적으로 실행합니다.
sed -i '' 's/unknown(/text(/g' drizzle/schema.ts  # pg_stat_statements 뷰의 unknown 타입 파싱 에러 방지용 임시 패치
npx tsx .agents/skills/update-drizzle-schema/scripts/compare-schema.ts
```

### 3. 수동 체리픽 (Cherry-pick) 적용

비교 스크립트 출력 결과(`+` 는 DB엔 있지만 src엔 없음, `-`는 src엔 있지만 DB엔 없음)를 토대로 `src/lib/db/schema.ts` 파일에 직접 변경 사항을 적용합니다.

- **주의사항 1:** `drizzle/schema.ts`의 전체 내용을 `src/lib/db/schema.ts`에 **절대 그대로 복사/붙여넣기 하지 마세요.** `$type` 등의 커스텀 타입 정보가 전부 유실될 수 있습니다.
- **주의사항 2:** 새롭게 추가된 Enum이 있다면 코드 상단에 `pgEnum`으로 명시적으로 추가 등록합니다.
- **주의사항 3:** 컬럼을 추가하거나 수정할 때, 기존에 설정된 애플리케이션 레벨 기본값들 (예: `.default(sql\`CURRENT_TIMESTAMP\`)` 나 `.defaultRandom()`)이 실수로 지워지지 않게 유의합니다. 삭제된 컬럼은 삭제하고, 추가된 컬럼은 새로 작성합니다.

### 4. Relations 확인 (필요한 경우)

릴레이션 구조도 변경되었다면 `drizzle/relations.ts` 파일과 `src/lib/db/relations.ts` 파일을 `diff` 명령어로 비교하여 업데이트합니다.

```bash
diff -u src/lib/db/relations.ts drizzle/relations.ts
```

### 5. 프로젝트 검증 (Validate)

모든 수정이 완료되었다면, 올바른 타입이 적용되었는지 빌드 및 린트를 통해 꼼꼼하게 최종 확인합니다.

```bash
npm run validate
```
