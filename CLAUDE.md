# lotte-20a-wiki — 롯데경영 20A LLM 위키 운영 스키마

이 레포는 **롯데경영 20A의 세컨 브레인**입니다. 프로젝트 현황·결정·일정·노하우를 마크다운으로 누적하고,
팀원 각자가 Claude Code로 읽고(질의) 씁니다(인제스트). 세부 산출물(코드·디자인·문서 원본)은 각자의 원래 도구에 있고,
여기는 **"왜 · 언제 · 무엇을 · 다음 액션"** 만 남깁니다.

> 출처 패턴: Karpathy LLM-Wiki (raw 원본 / 위키 / 스키마 3레이어).

## 0. 절대 규칙

- **모든 문서는 한글로.** 코드·파일명·고유명사는 원문 유지.
- **`raw/`는 불변** — 원본은 절대 수정하지 않는다. 읽기만.
- **회의 녹음 전사(STT) 원문은 이 레포에 넣지 않는다** — 정리된 회의록(요약 MD)만. 원문은 녹음자 개인 보관.
- **보안**: 넣으면 안 되는 것은 [rules/보안.md](rules/보안.md) — 문서 작성 전 반드시 확인.
- **`dashboard.md`는 손으로 고치지 않는다** — "대시보드 갱신해줘" 로 Claude가 통째로 재생성.
- **log 파일 없음** — 히스토리는 `git log`가 담당.
- **추측 금지** — 근거 없는 일정·결정을 지어내지 않는다. 모르면 `(확인 필요)`.

## 1. 폴더 구조

```
.claude/           # 훅 — 자동 pull/commit/push (수정 시 팀에 공유)
CLAUDE.md          # 본 문서 (링크만, 300줄 이하 유지)
rules/             # 보안.md 커밋.md
projects/          # 1프로젝트 1페이지 (templates/project.md)
members/           # 협업하는 사람 1인 1페이지 — 팀원 + 타 팀·외부 인물 (templates/member.md)
meetings/          # YYYY-MM-DD-제목.md — 작성자 1인
knowhow/           # 1인 1주제 1파일 (예: 신규입사자-계정-신청-절차.md)
raw/               # 공유 문서 원본 (기획서 사본·가이드 등, 불변)
templates/         # project.md, meeting.md, member.md
dashboard.md       # 팀 현황 대시보드 (자동 재생성 전용)
dashboard/         # 대시보드 이미지: index.html(디자인) · data.js(데이터) · render.sh → dashboard.png
```

## 2. 충돌 회피 3규칙 (여러 명 동시 편집 전제)

1. 전원이 같은 파일 맨 위에 줄을 넣는 구조(log)를 만들지 않는다.
2. 공용 파일은 `dashboard.md` 하나뿐이고 재생성으로만 갱신한다.
3. 한 파일을 여럿이 고칠 땐 **자기 역할 섹션만** (예: `## 과대` / `## 학우`). git은 다른 줄이면 자동 병합된다.

**커밋·푸시는 자동이다** — 세션 시작 시 pull, 응답 종료 시 커밋+푸시 (레포에 포함된 `.claude/settings.json` 훅). 사용자도 Claude도 따로 신경 쓰지 않는다. 꼬였을 때만 [rules/커밋.md](rules/커밋.md).
git이 없는 컴퓨터에서는 훅이 아무것도 하지 않는다(혼자 쓰기 모드). 사용자가 **"위키 동기화 켜줘"** 라고 하면 [rules/커밋.md](rules/커밋.md)의 「동기화 켜기」 절차를 따른다.

## 3. 워크플로

### 인제스트 (자료 넣기)
1. 원본이 파일이면 `raw/`에 둔다 (STT 원문 제외).
2. 요약 MD를 만든다 — 회의는 `meetings/`(templates/meeting.md), 프로젝트 관련이면 해당 `projects/*.md`의 자기 섹션 갱신.
3. 결정이 있으면 프로젝트 페이지 "의사결정 기록" 표에 한 줄 추가. 새 담당자·외부 접점이 등장하면 "담당·관계자" 표와 `members/`를 함께 갱신.
4. "대시보드 갱신해줘".
5. 커밋·푸시는 자동 (훅) — 따로 할 것 없음.

### 질의 (읽기만 — 편집법 몰라도 됨)
클론한 폴더에서 Claude Code를 열고 그냥 묻는다:
- "○○ 프로젝트 어디까지 됐지?" / "지난 회의에서 정한 액션 아이템 뭐였지?" / "○○ 업무는 누구한테 물어봐?"(→ members/)
- Claude는 `dashboard.md` → 관련 `projects/`·`meetings/` 순으로 읽고 답한다.

### 질의 결과의 파일링 (지식 복리의 핵심)
질의에 대한 답이 **여러 문서를 종합해 새로 만들어진 지식**이면, 답만 하고 버리지 말고
적절한 위치(`knowhow/` 또는 해당 프로젝트 페이지)에 저장할지 사용자에게 제안한다.
같은 질문에 두 번 조사하지 않는 것이 이 위키의 존재 이유다.

### 린트 (주기 점검 — "린트해줘")
- 모순 찾기 (두 문서가 다른 일정·결정을 말함)
- 낡은 정보 (last_updated 오래된 in-progress, 지난 마감)
- 고아 페이지 (어디서도 링크 안 됨)
- 결과는 보고만 — 수정은 사용자 확인 후.

### 대시보드 갱신 (Claude 전용 지침)
`projects/*.md`·`meetings/` 최근 5건을 읽어 다음 셋을 **통째로 다시 쓴다** (손편집 흔적 보존 X, 재생성이 정본):
1. `dashboard/data.js` — 이미지용 데이터 (today·week·subjects·events·todos·unknowns). 기존 파일의 구조를 그대로 따르고 값만 바꾼다. 근거 없는 값은 넣지 않는다.
2. `bash dashboard/render.sh` 실행 → `dashboard/dashboard.png` 생성. 생성된 PNG를 직접 열어 잘림·겹침이 없는지 확인한다 (내용이 늘면 `DASH_HEIGHT=1600 bash dashboard/render.sh`처럼 높이 조정).
3. `dashboard.md` — 맨 위에 이미지, 그 아래 `<details>` 안에 텍스트 버전(프로젝트별 현황 한 줄 + 임박 일정 D-day + 미해결 액션 아이템, 링크 포함).

디자인 변경("대시보드 디자인 바꿔줘")은 `dashboard/index.html`만 고친다 — 데이터와 디자인을 섞지 않는다.

## 4. 역할별 진입

| 역할 | 먼저 읽을 것 |
|---|---|
| 모든 역할 | dashboard.md → 질의부터 |
| 문서를 넣는 사람 | rules/보안.md |

## 5. frontmatter 최소 스키마

- 프로젝트: `title / status(planning·in-progress·paused·done) / last_updated / owner(역할별 이름)`
- 회의록: `title / date / participants / summary(한 줄)`
- knowhow: `title / owner / last_updated`
- 사람: `title(이름) / affiliation(소속) / role / function / projects / terms(학기별 참여·미참여)` — 팀 밖 인물은 소속 + **협업 맥락 한 줄** 필수. **담당·업무 정보만** — 평가·신상은 [rules/보안.md](rules/보안.md) 금지 영역. 팀 밖 인물일수록 엄격히
날짜는 `YYYY-MM-DD`. 그 외 필드는 자유 — 스키마를 늘리기 전에 팀에 공유.
