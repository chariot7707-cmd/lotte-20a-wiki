#!/bin/bash
# 응답 종료 시 자동 커밋·푸시. 변경 없으면 아무것도 안 함.
cd "$CLAUDE_PROJECT_DIR" || exit 0
# git이 정말 쓸 수 있는지 — 없으면 혼자 쓰기 모드(아무것도 안 함)
# macOS에서 개발자 도구가 없으면 /usr/bin/git 은 실행할 때마다 "설치하시겠습니까" 창만 띄우므로 실행 전에 거른다
has_git() {
  command -v git >/dev/null 2>&1 || return 1
  if [ "$(uname)" = "Darwin" ] && [ "$(command -v git)" = "/usr/bin/git" ]; then
    xcode-select -p >/dev/null 2>&1 || return 1
  fi
  return 0
}
has_git || exit 0                                              # 혼자 쓰기 모드
git rev-parse --is-inside-work-tree >/dev/null 2>&1 || exit 0  # 아직 git 저장소가 아님
[ -z "$(git status --porcelain)" ] && exit 0

git add -A
# 커밋 메시지에 변경 파일을 남긴다 — log.md 없이 git log가 작업 기록 역할을 하도록
# core.quotepath=false — 없으면 한글 파일명이 "\354\213..."처럼 깨져 찍힌다
FILES=$(git -c core.quotepath=false diff --cached --name-only | head -5 | paste -sd' ' -)
git commit --quiet -m "docs: ${FILES} ($(git config user.name 2>/dev/null || whoami))" || exit 0

# push — 원격이 없으면 조용히 끝. 그 사이 남이 푸시했으면 rebase 후 1회 재시도
git remote | grep -q . || exit 0
if ! git push --quiet 2>/dev/null; then
  if git pull --rebase --autostash --quiet >/dev/null 2>&1 && git push --quiet 2>/dev/null; then
    echo "lotte-20a-wiki: 동기화 완료 (rebase 후 푸시)"
  else
    echo "lotte-20a-wiki: ⚠️ 푸시 실패 (원격에 닿지 못했거나 충돌) — 로컬 커밋은 안전하게 저장됨. 다음 턴에 자동 재시도되며, 계속 실패하면 '위키 커밋해줘'라고 말하면 Claude가 풉니다."
  fi
fi
exit 0
