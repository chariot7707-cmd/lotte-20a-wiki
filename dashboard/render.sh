#!/usr/bin/env bash
# dashboard/index.html + data.js → dashboard/dashboard.png
# 사용: bash dashboard/render.sh   (Windows Git Bash · macOS · Linux)
set -euo pipefail

DIR="$(cd "$(dirname "$0")" && pwd)"
HEIGHT="${DASH_HEIGHT:-1400}"   # 내용이 잘리거나 아래가 비면 이 값을 조정

# 크롬 계열 브라우저 찾기 (Edge / Chrome / Chromium)
BROWSER=""
for b in \
  "/c/Program Files (x86)/Microsoft/Edge/Application/msedge.exe" \
  "/c/Program Files/Microsoft/Edge/Application/msedge.exe" \
  "/c/Program Files/Google/Chrome/Application/chrome.exe" \
  "/Applications/Google Chrome.app/Contents/MacOS/Google Chrome" \
  "/Applications/Microsoft Edge.app/Contents/MacOS/Microsoft Edge" \
  "$(command -v google-chrome 2>/dev/null || true)" \
  "$(command -v chromium 2>/dev/null || true)" \
  "$(command -v chromium-browser 2>/dev/null || true)"; do
  if [ -n "$b" ] && [ -x "$b" ]; then BROWSER="$b"; break; fi
done
[ -z "$BROWSER" ] && { echo "크롬/엣지 브라우저를 찾지 못했습니다" >&2; exit 1; }

# Windows 브라우저에는 Windows 경로를 넘긴다
if command -v cygpath >/dev/null 2>&1; then
  URL="file:///$(cygpath -m "$DIR/index.html")"; OUT="$(cygpath -w "$DIR/dashboard.png")"
else
  URL="file://$DIR/index.html"; OUT="$DIR/dashboard.png"
fi

TMP_PROFILE="$(mktemp -d)"
"$BROWSER" --headless=new --disable-gpu --hide-scrollbars --no-first-run \
  --user-data-dir="$(command -v cygpath >/dev/null 2>&1 && cygpath -w "$TMP_PROFILE" || echo "$TMP_PROFILE")" \
  --force-device-scale-factor=2 --window-size=1200,"$HEIGHT" \
  --virtual-time-budget=8000 --screenshot="$OUT" "$URL" >/dev/null 2>&1 || true
rm -rf "$TMP_PROFILE"

[ -s "$DIR/dashboard.png" ] && echo "생성됨: dashboard/dashboard.png" || { echo "렌더 실패" >&2; exit 1; }
