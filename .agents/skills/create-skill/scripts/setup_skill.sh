#!/bin/bash

# Usage: ./setup_skill.sh <skill-name>

SKILL_NAME=$1

if [ -z "$SKILL_NAME" ]; then
  echo "Usage: $0 <skill-name>"
  exit 1
fi

SKILL_DIR=".agents/skills/$SKILL_NAME"

if [ -d "$SKILL_DIR" ]; then
  echo "Error: Skill directory already exists: $SKILL_DIR"
  exit 1
fi

mkdir -p "$SKILL_DIR/scripts" "$SKILL_DIR/examples" "$SKILL_DIR/resources"

cat <<EOF > "$SKILL_DIR/SKILL.md"
---
name: $SKILL_NAME
description: [짧은 설명]
---

# $SKILL_NAME

[상세 지침 및 사용법]
EOF

echo "Skill '$SKILL_NAME' structure created at $SKILL_DIR"
