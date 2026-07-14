#!/usr/bin/env bash
# Render FreeMarker login templates → html/login/*.html for local UI preview.
set -euo pipefail

ROOT="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
cd "$ROOT"

run_mvn() {
  if command -v mvn >/dev/null 2>&1; then
    echo "→ Generating mocks with local Maven..."
    mvn -q test
    return
  fi

  if command -v docker >/dev/null 2>&1; then
    echo "→ Maven not found; generating mocks with Docker (maven:3.9-eclipse-temurin-21)..."
    docker run --rm \
      -v "$ROOT":/work \
      -v keywind-m2-cache:/root/.m2 \
      -w /work \
      maven:3.9-eclipse-temurin-21 \
      mvn -q test
    return
  fi

  echo "error: need either 'mvn' or 'docker' to generate FreeMarker mocks" >&2
  exit 1
}

run_mvn

if [[ ! -f html/index.html ]]; then
  echo "error: mock generation finished but html/index.html is missing" >&2
  exit 1
fi

LOGIN_COUNT="$(find html/login -name '*.html' 2>/dev/null | wc -l | tr -d ' ')"
ACCOUNT_COUNT="$(find html/account -name '*.html' 2>/dev/null | wc -l | tr -d ' ')"
echo "✓ Generated login=${LOGIN_COUNT} account=${ACCOUNT_COUNT} mock pages + html/index.html"
echo "  Preview with: npm run dev"
echo "  Open:         http://localhost:5173/"