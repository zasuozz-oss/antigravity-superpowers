---
name: Test
description: Chạy và phân tích unit tests
trigger: /test
---

# Test Workflow

> **Required Skill**: Read `skills/my-skills/test/SKILL.md` for testing patterns and tools.

## Purpose
Run, analyze, or generate unit tests for the project.

## Next Steps
After completing the test action:
1. Output the test results, analysis, or generated code.
2. If tests failed, suggest debugging. If generated, suggest verification.
3. Wait for user input.

---

rules:
- do not modify production code during test runs
- do not modify test code unless explicitly requested
- test generation follows existing project test patterns
- prefer Unity Test Framework (NUnit-based)
- isolate tests from runtime dependencies where possible

======================TEST RUN WORKFLOW======================

## test run

steps:
1. identify test assemblies in project
   - look for *.Tests.asmdef or *.EditMode.asmdef or *.PlayMode.asmdef
2. run tests via Unity Test Runner CLI or Editor
3. collect results:
   - passed count
   - failed count
   - skipped count
   - duration
4. report failures with:
   - test name
   - failure message
   - stack trace (condensed)
   - location (if available)
5. suggest next actions:
   - /debug for failing tests
   - /fix if clear bug identified

output:
- test summary
- failure details (if any)
- recommendations

======================TEST ANALYZE WORKFLOW======================

## test analyze

purpose:
- analyze test coverage and quality
- identify missing test scenarios

steps:
1. scan test files in project
2. map tests to production scripts (naming convention or explicit)
3. identify:
   - untested public methods
   - untested edge cases (null, empty, boundary)
   - missing integration tests
4. report coverage gaps
5. recommend priority tests to add

output:
- coverage summary
- gap analysis
- recommended test cases

======================TEST GENERATE WORKFLOW======================

## test generate

purpose:
- generate unit test scaffolding for a target script

input:
- target script path
- test type: EditMode | PlayMode

steps:
1. analyze target script:
   - public methods
   - dependencies (serialized fields, injected services)
2. identify testable scenarios:
   - happy path
   - edge cases (null, empty, boundary)
   - error conditions
3. generate test class with:
   - setup/teardown
   - test method stubs
   - arrange/act/assert structure
4. place in appropriate test folder

rules:
- follow existing project test patterns
- use NUnit attributes ([Test], [SetUp], [TearDown])
- mock dependencies using project-standard mocking approach
- do not access real network, file system, or Unity lifecycle in EditMode tests

output:
- generated test file (proposed)
- test scenarios covered
- validation steps

---

### 📋 Next Steps (MANDATORY OUTPUT)
After completing the test action, ALWAYS output this section:

```
## Next Steps
Bạn có thể:
- `/debug` - debug failing tests
- `/fix <id>` - fix identified bugs
- Chạy lại tests sau khi fix

Vui lòng cho biết bạn muốn thực hiện gì tiếp theo.
```
