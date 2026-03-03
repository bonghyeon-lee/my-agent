---
name: apply-drizzle-schema
description: 코드 스키마(src/lib/db/schema.ts) 변경 사항을 DB에 실제 테이블/컬럼으로 반영(Push)하는 가이드라인 및 도구입니다.
---

# Apply Drizzle Schema

코드 레벨(`src/lib/db/schema.ts`)에서 변경된 스키마를 실제 데이터베이스로 반영(Push)하기 위한 로컬 개발 스킬입니다.
주로 개발 과정에서 새 컬럼이나 테이블을 만들었을 때, 번거로운 Migration 파일 생성 없이 빠르게 로컬 또는 원격 개발 DB에 변경 사항을 동기화하기 위해 사용됩니다.

> **주의:** 이 명령어는 Drizzle Kit의 `push` 기능을 사용합니다. Production DB의 경우 데이터 손실(Drop Column 등)이 발생할 수 있으므로, 반드시 Push 전 변경점이 맞는지 확인해야 하며 프로덕션에서는 `drizzle-kit generate`와 `drizzle-kit migrate` 조합을 권장합니다.

## 실행 절차

### 1. 변경된 스키마 검증

스키마 변경이 TypeScript 문법이나 참조 무결성에 문제가 없는지 먼저 타입 체크를 통해 확인합니다.

```bash
npm run type-check
```

### 2. Drizzle Push로 DB 적용

작성한 schema를 기반으로 DB에 변경사항을 강제로 적용(Push)합니다. 이 작업은 테이블 생성, 컬럼 추가/삭제 등을 자동으로 수행합니다.
추가적인 확인 없이 강제 적용되므로 유의하세요.

```bash
npx drizzle-kit push
```

*(패키지 매니저(npm/yarn/pnpm)에 설정된 명령어 확인 후 적절히 사용하세요.)*

### 3. (확인용) Drizzle Studio 실행 (선택 사항)

DB에 정상적으로 반영되었는지 브라우저 GUI를 통해 데이터를 확인하고 싶다면 아래 명령어를 사용합니다.

```bash
npx drizzle-kit studio
```

이후 `https://local.drizzle.studio` 등 안내된 주소에서 스키마와 데이터를 점검할 수 있습니다.
