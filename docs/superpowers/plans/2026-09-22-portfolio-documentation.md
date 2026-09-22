# Unitree R1 Portfolio Documentation Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Present the completed bounded Isaac Sim infrastructure gate and the active R1 parity gate with a clear visual lifecycle and precise safety boundaries.

**Architecture:** Add one accessible operational-flow SVG derived from the retained G1 report, then rewrite the README around the completed result, cleanup guarantees, and G2 acceptance sequence. No robot render is introduced because G1 did not validate an R1 scene.

**Tech Stack:** GitHub Markdown, SVG 1.1, Bash watchdog verification

## Global Constraints

- Modify only `README.md` and create `docs/media/g1-bounded-cloud-lifecycle.svg`.
- Cross-check every completed-result statement against `artifacts/g1-20260824/RESULTS.md`.
- Do not imply Isaac Lab, an R1 articulation, a trained policy, or physical deployment passed.
- Keep `PHYSICAL_DEPLOYMENT_ALLOWED=false` explicit.
- Preserve the USD 30 campaign ceiling and ownership-checked cleanup description.
- Present shutdown behavior as an unresolved systems result.

---

### Task 1: Create the G1 operational-flow diagram

**Files:**
- Create: `docs/media/g1-bounded-cloud-lifecycle.svg`
- Reference: `artifacts/g1-20260824/RESULTS.md`
- Reference: `ops/reflect-r1-g1-watchdog.yaml`

**Interfaces:**
- Produces: one 1200×420 accessible SVG linked from the README

- [ ] **Step 1: Verify source evidence and missing target**

```bash
test -f artifacts/g1-20260824/RESULTS.md
test -f ops/reflect-r1-g1-watchdog.yaml
test ! -e docs/media/g1-bounded-cloud-lifecycle.svg
```

Expected: evidence files exist and the SVG does not.

- [ ] **Step 2: Create the SVG**

Use five connected stages:

```text
Bounded launch
fixed project · zone · run nonce
        →
GCP Spot worker
g2-standard-8 · NVIDIA L4
        →
Official Isaac Sim 6.0.1
headless finite update loop
        →
Retained evidence
versions · commands · logs · cost
        →
Independent watchdog
identity re-check · deadline · VM/disk deletion
```

Add a green callout: “GPU/container path passed.” Add an amber callout:
“Shutdown remained unresolved: fast abort vs orderly timeout.” Add a footer:
“Operational flow from retained G1 artifacts — not an R1 policy result.”

Include `role="img"`, accessible title/description, and a 1200×420 viewBox.

- [ ] **Step 3: Validate and inspect**

```bash
xmllint --noout docs/media/g1-bounded-cloud-lifecycle.svg
```

Expected: exit zero. Render to PNG with an available SVG renderer and inspect at README width.

- [ ] **Step 4: Commit the visual**

```bash
git add docs/media/g1-bounded-cloud-lifecycle.svg
git commit -m "docs: visualize bounded Isaac Sim G1 lifecycle"
```

Expected: one commit containing only the SVG.

### Task 2: Rewrite the README around G1 and G2

**Files:**
- Modify: `README.md`
- Reference: `artifacts/g1-20260824/RESULTS.md`
- Reference: `Unitree R1 Codex Prompt.md`

**Interfaces:**
- Consumes: Task 1 SVG and retained experiment documents
- Produces: a public-facing project case study

- [ ] **Step 1: Record evidence anchors**

```bash
rg -n "Isaac Sim|L4|shutdown|cost|removed|G2|PHYSICAL_DEPLOYMENT_ALLOWED" artifacts/g1-20260824/RESULTS.md "Unitree R1 Codex Prompt.md"
```

Expected: anchors exist for every planned headline and boundary.

- [ ] **Step 2: Rewrite with this exact section order**

```markdown
# Unitree R1 Experiment Program

[thesis, completed gate, and active next gate]

## G1 result at a glance
![Bounded G1 cloud lifecycle](docs/media/g1-bounded-cloud-lifecycle.svg)
## What passed
## What remained unresolved
## Why parity comes before policy training
## Next gate: canonical R1 simulator parity
## Repository map
## Verify the cleanup watchdog
## Safety, cost, and research boundaries
```

The result card must list: Isaac Sim 6.0.1, official container, GCP
`g2-standard-8` Spot VM, NVIDIA L4, finite update loop, cost below USD 30,
resources removed, and shutdown unresolved.

- [ ] **Step 3: Add the G2 active sequence**

List canonical manifest, Isaac import options, joint/actuator/collision/action
parity, forward-kinematics comparison, reset/standing/direction probes, scale
stages 1/16/64/256, retained hashes/logs/cost, and official MuJoCo fallback if
the bounded Isaac gate fails.

- [ ] **Step 4: Commit the README**

```bash
git add README.md
git commit -m "docs: present G1 result and active R1 parity gate"
```

Expected: one commit containing only `README.md`.

### Task 3: Verify safety and presentation

- [ ] **Step 1: Run watchdog checks**

```bash
bash ops/test_g1_watchdog.sh
```

Expected: all watchdog static checks pass.

- [ ] **Step 2: Validate documentation**

Run relative-link validation, then:

```bash
xmllint --noout docs/media/g1-bounded-cloud-lifecycle.svg
git diff HEAD~2 --check
rg -n "physical deployment passed|trained R1 policy|Isaac Lab passed" README.md
```

Expected: links and XML pass; no whitespace errors; the final grep has no matches.

- [ ] **Step 3: Verify scope**

```bash
git status --short
git show --stat --oneline HEAD~1
git show --stat --oneline HEAD
```

Expected: only the SVG and README implementation commits are new beyond the plan.

