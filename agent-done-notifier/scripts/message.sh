#!/usr/bin/env bash
set -euo pipefail

NTFY_TOPIC="${NTFY_TOPIC:-agent-done-unique}"
NTFY_URL="https://ntfy.sh/${NTFY_TOPIC}"

TITLE="${NTFY_TITLE:-Agent Update}"
PRIORITY="${NTFY_PRIORITY:-high}"
TAGS="${NTFY_TAGS:-white_check_mark,robot}"

MESSAGE="${*:-Agent task completed.}"

curl -sf \
  -H "Title: ${TITLE}" \
  -H "Priority: ${PRIORITY}" \
  -H "Tags: ${TAGS}" \
  -d "${MESSAGE}" \
  "${NTFY_URL}" > /dev/null 2>&1 || true

echo "[ntfy] Notification sent: ${MESSAGE}"
