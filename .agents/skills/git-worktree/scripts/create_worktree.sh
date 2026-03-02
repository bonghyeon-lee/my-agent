#!/bin/bash

# git-worktree 생성 스크립트

# 파라미터 체크
BRANCH=$1
TARGET_PATH=$2

if [ -z "$BRANCH" ]; then
  echo "사용법: $0 <branch-name> [target-path]"
  exit 1
fi

# 레포지토리 이름 추출
REPO_NAME=$(basename $(pwd))

# 경로가 지정되지 않은 경우 기본값 설정
if [ -z "$TARGET_PATH" ]; then
  # 브랜치 이름에서 슬래시를 언더바로 변경
  SAFE_BRANCH=$(echo $BRANCH | sed 's/\//_/g')
  TARGET_PATH="../${REPO_NAME}_${SAFE_BRANCH}"
fi

echo "Worktree 생성 시도: 브랜치 '$BRANCH', 경로 '$TARGET_PATH'"

# 디렉토리 존재 여부 확인
if [ -d "$TARGET_PATH" ]; then
  echo "오류: 대상 경로가 이미 존재합니다: $TARGET_PATH"
  exit 1
fi

# git worktree add 실행
git worktree add "$TARGET_PATH" "$BRANCH"

if [ $? -eq 0 ]; then
  echo "성공: Worktree가 $TARGET_PATH 에 생성되었습니다."
  echo "다음 명령어로 이동할 수 있습니다: cd $TARGET_PATH"
else
  echo "오류: git worktree add 명령이 실패했습니다."
  exit 1
fi
