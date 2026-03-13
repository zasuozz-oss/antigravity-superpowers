# Test Cases — Antigravity Superpowers

Paste mỗi prompt vào Antigravity trên bất kỳ project nào, kiểm tra kết quả theo expected behavior.

---

## 🔵 Skill Auto-Trigger (Implicit)

Agent phải **tự nhận ra** context và kích hoạt skill đúng — user không nhắc tên skill.

---

### TC-01: Systematic Debugging

**Prompt:**
```
I'm getting an error when running the app. It was working yesterday but now it crashes on startup.
Can you figure out what's going wrong and fix it?
```

**Expected:**
- [ ] Kích hoạt `systematic-debugging` skill
- [ ] Gọi `view_file` đến SKILL.md trước khi hành động
- [ ] Điều tra root cause trước (Phase 1)
- [ ] KHÔNG fix ngay mà không tìm nguyên nhân

---

### TC-02: Test-Driven Development

**Prompt:**
```
I need to add a new feature to validate email addresses. It should:
- Check that there's an @ symbol
- Check that there's at least one character before the @
- Check that there's a dot in the domain part
- Return true/false

Can you implement this?
```

**Expected:**
- [ ] Kích hoạt `brainstorming` skill (yêu cầu thiết kế trước)
- [ ] KHÔNG viết code ngay
- [ ] Đề xuất design trước, hỏi approval
- [ ] Khi implement: viết test trước, rồi mới viết code

---

### TC-03: Writing Plans

**Prompt:**
```
Here's the spec for our new authentication system:

Requirements:
- Users can register with email/password
- Users can log in and receive a JWT token
- Protected routes require valid JWT
- Tokens expire after 24 hours
- Support password reset via email

We need to implement this. There are multiple steps involved.
```

**Expected:**
- [ ] Kích hoạt `brainstorming` skill (thiết kế trước)
- [ ] Không nhảy vào code ngay
- [ ] Hỏi clarifying questions
- [ ] Đề xuất 2-3 approaches
- [ ] Sau khi approve → chuyển sang `writing-plans`

---

### TC-04: Dispatching Parallel Agents

**Prompt:**
```
I have several unrelated issues in this project:

1. There's a broken link in the README
2. One of the config files has a typo causing errors
3. The documentation is outdated in some sections
4. A helper function is returning wrong output

These are independent problems. Can you investigate all of them?
```

**Expected:**
- [ ] Nhận ra 4 tasks độc lập
- [ ] Kích hoạt `dispatching-parallel-agents` hoặc `systematic-debugging`
- [ ] Xử lý song song hoặc theo thứ tự hợp lý
- [ ] KHÔNG fix bừa mà không điều tra từng cái

---

### TC-05: Code Review

**Prompt:**
```
I just finished a big refactor. All the code is committed.
Can you review my changes and check if anything looks wrong before I push?
```

**Expected:**
- [ ] Kích hoạt `requesting-code-review` skill
- [ ] Kiểm tra code quality, architecture, tests
- [ ] Phân loại issues (Critical / Important / Suggestion)
- [ ] Mention điểm tốt trước khi nêu issues

---

## 🟢 Explicit Skill Request

Agent phải **nghe lời** khi user chỉ đích danh skill.

---

### TC-06: Explicit Brainstorming

**Prompt:**
```
please use the brainstorming skill to help me think through this feature
```

**Expected:**
- [ ] Kích hoạt `brainstorming` ngay lập tức
- [ ] Gọi `view_file` SKILL.md đầu tiên
- [ ] Hỏi clarifying questions 1 cái 1

---

### TC-07: Explicit Debugging

**Prompt:**
```
use the systematic debugging skill to investigate why my API returns 500
```

**Expected:**
- [ ] Kích hoạt `systematic-debugging` ngay
- [ ] Bắt đầu Phase 1: Root cause investigation
- [ ] KHÔNG đề xuất fix khi chưa tìm nguyên nhân

---

### TC-08: Casual Request (Skip Formalities)

**Prompt:**
```
hey just brainstorm with me real quick about adding dark mode to the app
```

**Expected:**
- [ ] Vẫn kích hoạt `brainstorming` dù giọng casual
- [ ] Không bỏ qua skill vì user nói "real quick"
- [ ] Vẫn theo đúng quy trình: hỏi → thiết kế → approve

---

### TC-09: Abbreviation Understanding

**Prompt:**
```
let's use SDD for implementing the dashboard feature
```

**Expected:**
- [ ] Hiểu SDD = Subagent-Driven Development
- [ ] Kích hoạt `subagent-driven-development` skill

---

## 🟠 Workflow Tests

Test các workflow `/brainstorm`, `/write-plan`, `/execute-plan`, `/code-review`.

---

### TC-10: Brainstorm Workflow

**Prompt:**
```
/brainstorm

I want to add a notification system to my app. Users should receive notifications for:
- New messages
- System alerts
- Friend requests
```

**Expected:**
- [ ] Chạy workflow brainstorm
- [ ] Hỏi clarifying questions (1 cái 1)
- [ ] Đề xuất 2-3 approaches
- [ ] Trình bày design
- [ ] Chờ approve trước khi code

---

### TC-11: Write Plan Workflow

**Prompt:**
```
/write-plan

Based on our approved notification system design, create an implementation plan.
```

**Expected:**
- [ ] Tạo `implementation_plan.md`
- [ ] Chia thành tasks cụ thể với file paths
- [ ] Đánh giá complexity (S/M/L)
- [ ] Có verification plan
- [ ] Hỏi user approve trước khi tiếp

---

### TC-12: Execute Plan Workflow

**Prompt:**
```
/execute-plan

Execute the approved implementation plan.
```

**Expected:**
- [ ] Đọc `implementation_plan.md`
- [ ] Tạo/cập nhật `task.md`
- [ ] Thực hiện TDD cycle: test trước → code → verify
- [ ] Cập nhật `[ ] → [/] → [x]` trong task.md
- [ ] Tạo `walkthrough.md` khi hoàn thành

---

### TC-13: Code Review Workflow

**Prompt:**
```
/code-review

Review the code I just implemented for the notification feature.
```

**Expected:**
- [ ] So sánh implementation vs plan
- [ ] Kiểm tra code quality + tests
- [ ] Phân loại: 🔴 Critical / 🟡 Important / 🟢 Suggestion
- [ ] Mention điểm tốt trước
- [ ] Output đúng format structured

---

## 🔴 Iron Laws Tests

Test 3 Luật Sắt có được enforce không.

---

### TC-14: Iron Law 1 — No Code Without Design

**Prompt:**
```
Add a dark mode toggle to the app. Just code it up quickly.
```

**Expected:**
- [ ] KHÔNG viết code ngay dù user nói "quickly"
- [ ] Bắt đầu brainstorming trước
- [ ] Hỏi về requirements trước khi code

---

### TC-15: Iron Law 2 — No Code Without Test

**Prompt:**
```
Add a function that calculates shipping cost based on weight and distance. Here's the formula: cost = weight * 0.5 + distance * 0.1. Just write the function.
```

**Expected:**
- [ ] Viết test trước (`calculateShippingCost.test.ts`)
- [ ] Verify test fails
- [ ] Rồi mới viết implementation
- [ ] KHÔNG viết function trước rồi mới viết test

---

### TC-16: Iron Law 3 — No Fix Without Root Cause

**Prompt:**
```
The app crashes when users submit empty forms. Just add an if-check for empty input and show an error message.
```

**Expected:**
- [ ] KHÔNG thêm if-check ngay
- [ ] Điều tra root cause trước (tại sao crash?)
- [ ] Sau khi tìm ra nguyên nhân mới đề xuất fix
- [ ] Fix phải giải quyết root cause, không phải chỉ mask lỗi

---

## Verification Checklist

Sau khi chạy tất cả test cases:

- [ ] **Skills auto-trigger** (TC-01 → TC-05): Skills tự kích hoạt đúng context
- [ ] **Explicit requests** (TC-06 → TC-09): Agent nghe lời khi user chỉ định
- [ ] **Workflows** (TC-10 → TC-13): 4 workflows chạy đúng quy trình
- [ ] **Iron Laws** (TC-14 → TC-16): 3 Luật Sắt được enforce nghiêm túc
