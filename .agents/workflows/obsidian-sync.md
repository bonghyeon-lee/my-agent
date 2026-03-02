---
description: 이 프로젝트의 `.agents/vault` 기록들을 로컬 Obsidian 중앙 Vault 내부로 동기화(Symlink) 합니다.
---

# Obsidian Vault 동기화 (Symlink)

이 워크플로우(`/obsidian-sync`)는 현재 프로젝트의 AI 멘토링 기록 및 PKM 데이터를 중앙집중식 Obsidian Vault 환경에서도 함께 원활하게 볼 수 있도록 권한이나 링크 설정을 관리합니다.

## 🔗 연동 방식: Symbolic Link

프로젝트 내부의 `.agents/vault` 디렉토리 원본을 유지하면서, 동시에 지정된 Obsidian Vault 폴더 안에서도 파일을 읽고 쓸 수 있도록 **Symlink (바로 가기)**를 생성합니다.

### 기 연동된 대상 경로

- **원본 폴더 (Source)**: `[Project Root]/.agents/vault`
- **대상 폴더 (Target)**: `/Users/bonghyeon/Library/Mobile Documents/iCloud~md~obsidian/Documents/bonghyeon/vora_service_agent`

### 실행 지침 (AI Execution Steps)

1. **연결 상태 확인**: 현재 지정된 대상 경로(`Target`)에 심볼릭 링크가 정상적으로 생성되어 있고 깨지지 않았는지 점검(`ls -la`)합니다.
2. **권한 및 동기화 점검**: 대상 경로 내부의 파일을 읽을 수 있는지 점검하여 양 폴더가 정상적으로 동기화되고 있는지 확인합니다.
3. **복구 (필요시)**: 만약 심볼릭 링크가 유실되었거나 대상 Vault 경로가 변경되었다면, 이전 링크를 제거하고 아래 형태의 명령어로 새 링크를 재발급합니다.

   ```bash
   ln -s "$(pwd)/.agents/vault" "[New Target Obsidian Path]/vora_service_agent"
   ```

4. **결과 보고**: 옵시디언 연동이 정상이면 "🔗 Obsidian Vault에 정상적으로 연결되어 있습니다."라고 사용자에게 보고합니다.
