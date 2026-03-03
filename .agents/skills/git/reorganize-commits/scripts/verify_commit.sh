#!/bin/bash

# ./.agents/skills/reorganize-commits/scripts/verify_commit.sh

echo "--- Running Type Check ---"
npm run type-check
if [ $? -ne 0 ]; then
  echo "Error: Type check failed."
  exit 1
fi

echo "--- Running Tests ---"
npm run test
if [ $? -ne 0 ]; then
  echo "Error: Tests failed."
  exit 1
fi

echo "--- Running Build ---"
npm run build
if [ $? -ne 0 ]; then
  echo "Error: Build failed."
  exit 1
fi

echo "--- Verification Successful ---"
exit 0
