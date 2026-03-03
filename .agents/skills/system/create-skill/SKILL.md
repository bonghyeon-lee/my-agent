---
name: create-skill
description: 이 스킬은 워크스페이스에 새로운 스킬을 생성하고 등록하는 데 도움을 줍니다.
---

# Create-Skill

이 스킬은 에이전트가 새로운 전문 분야(Skill)를 구조화된 방식으로 정의하고 등록할 수 있게 합니다.

## Skill 구조

모든 스킬은 `.agents/skills/[skill-name]` 디렉토리에 위치해야 하며 다음 구조를 가집니다:

- `SKILL.md` (필수): 스킬의 이름, 설명, 상세 지침이 포함된 마크다운 파일입니다. YAML frontmatter를 포함해야 합니다.
- `scripts/` (선택): 스킬 실행에 필요한 헬퍼 스크립트들을 포함합니다.
- `examples/` (선택): 스킬 사용 예시 또는 패턴을 포함합니다.
- `resources/` (선택): 스킬이 참조하는 추가 파일이나 템플릿을 포함합니다.

## 새로운 스킬 생성 단계

1. **디렉토리 생성**: `.agents/skills/[category]/[skill-name]` 디렉토리를 생성합니다. (예: `db`, `git`, `productivity`, `system` 등)
2. **SKILL.md 작성**: 아래 템플릿을 사용하여 `SKILL.md`를 작성합니다.

   ```markdown
   ---
   name: [skill-name]
   description: [짧은 설명]
   ---

   # [Skill Name]

   [상세 지침 및 사용법]
   ```

3. **추가 리소스**: 필요한 경우 `scripts/`, `examples/`, `resources/` 폴더를 만들고 내용을 채웁니다.

## Best Practices

- `SKILL.md`의 지침은 명확하고 실행 가능해야 합니다.
- 워크플로우나 반복적인 복잡한 작업을 스킬로 만들면 효율적입니다.
- 특정 도구나 라이브러리 사용법을 최적화할 때 활용하십시오.
