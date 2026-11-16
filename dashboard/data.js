// 대시보드 이미지 데이터 — "대시보드 갱신해줘" 때 Claude가 통째로 다시 쓴다. 손으로 고치지 않는다.
// 날짜는 YYYY-MM-DD. D-day는 today 기준으로 화면에서 계산된다.
window.DASH = {
  today: "2026-11-16",
  team: "롯데경영 20A",
  term: "2026-2학기",
  week: 11,
  totalWeeks: 15,
  classInfo: "매주 월 08:40 – 18:30 · 무용학부관 404호",

  // period: 교시, color: 카드 색(파스텔), next: 가장 가까운 일정
  subjects: [
    { period: 1, name: "증권분석", prof: "장환", time: "08:40 – 10:40", color: "#FFC9B5",
      summary: "감상문 A4 4장 이내 · 기말 형식 추후 공지",
      next: { label: "수시시험", date: "2026-11-30" } },
    { period: 2, name: "생산계획 및 재고통제", prof: "김남희", time: "11:00 – 13:00", color: "#C9E4FF",
      summary: "AI 활용 기업 전략 분석 과제 15점",
      next: { label: "수시시험 5점", date: "2026-11-30" } },
    { period: 3, name: "심리학개론", prof: "이선영", time: "14:20 – 16:20", color: "#D9F2C4",
      summary: "자아탐색 보고서 4~5매 · AI 사용 금지",
      next: { label: "보고서 제출", date: "2026-12-07" } },
    { period: 4, name: "무역학개론", prof: "배경원", time: "16:30 – 18:30", color: "#E6D9FF",
      summary: "한국 수출입 10년 + 경쟁력 산업 2개",
      next: { label: "레포트 제출", date: "2026-12-07" } }
  ],

  // 타임라인 — period가 없으면 학사일정
  events: [
    { date: "2026-11-30", label: "증권분석 수시시험", period: 1 },
    { date: "2026-11-30", label: "생산계획 수시시험", period: 2 },
    { date: "2026-12-07", label: "증권분석 감상문", period: 1 },
    { date: "2026-12-07", label: "자아탐색 보고서", period: 3 },
    { date: "2026-12-07", label: "무역학 레포트", period: 4 },
    { date: "2026-12-14", label: "기말고사" },
    { date: "2026-12-14", label: "AI 기업전략 과제", period: 2 },
    { date: "2026-12-21", label: "한 주 방학" },
    { date: "2026-12-28", label: "계절학기 개강" }
  ],

  todos: [
    { text: "증권분석 · 생산계획 수시시험 준비", due: "2026-11-30" },
    { text: "증권분석 감상문 (A4 4장 이내)", due: "2026-12-07" },
    { text: "자아탐색 보고서 직접 작성", due: "2026-12-07" },
    { text: "무역학 레포트 (표지 + 5매 이상)", due: "2026-12-07" },
    { text: "AI 활용 기업 전략 분석 과제", due: "2026-12-14" }
  ],

  unknowns: [
    "수시시험 형식·범위 (1·2교시)",
    "1·2·4교시 기말고사 형식",
    "감상문 · 보고서 제출 방법",
    "무역학 레포트 제출일 12.07 맞는지"
  ],

  meetings: []
};
