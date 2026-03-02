---
description: Run lint, type-check, tests, and build, and fix any occurring errors
---

# Verify and Fix Workflow

This workflow is designed to ensure code quality by running linting, type-checking, tests, and building the project. Follow these steps to verify your code and fix any errors.

## 1. Formatting & Linting

Run the auto-fix command to automatically solve formatting and fixable linting errors.

```bash
// turbo
npm run lint:fix
```

If there are remaining lint errors that cannot be auto-fixed, review and fix them manually, then run `npm run lint` to verify.

## 2. Type Checking

Run TypeScript type checking to identify any type errors before testing or building.

```bash
// turbo
npm run type-check
```

If type errors are found, fix the code accordingly and re-run the command until no errors remain.

## 3. Unit Tests

Run the project's test suite to ensure everything is working correctly.

```bash
// turbo
npm run test
```

If tests fail, inspect the failed cases, fix the source code or update tests as appropriate, and re-run.

## 4. Production Build

Finally, run the build command to ensure the application compiles successfully without build-time errors.

```bash
// turbo
npm run build
```

If the build process fails, analyze the output, address the problem, and retry the build.
