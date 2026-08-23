# Unitree R1 Prompt Redesign Implementation Plan

> **For agentic workers:** REQUIRED SUB-SKILL: Use superpowers:subagent-driven-development (recommended) or superpowers:executing-plans to implement this plan task-by-task. Steps use checkbox (`- [ ]`) syntax for tracking.

**Goal:** Replace `Unitree R1 Codex Prompt.md` with one internally coherent, experiment-first autonomous research prompt that provisions one cost-fused headless Isaac Sim worker on GCP, validates or rejects an R1 port, falls back to official R1 MuJoCo, and executes E1–E6 under decision-grade stopping rules.

**Architecture:** First commit the current prompt byte-for-byte as its immutable baseline. Then rewrite the complete prompt in one atomic commit so no intermediate commit contains contradictory simulator priorities, cost rules, or inference semantics. Finish with independent critical reviews and evidence-backed correction commits. The final whole-branch audit amends this plan and the approved specification together with the prompt so all three remain one source-of-truth contract.

**Tech Stack:** Markdown, Git, `shasum`, `rg`, Zsh assertions, GCP `g2-standard-8`, Isaac Sim 6.0.1, Isaac Lab `v3.0.0-beta2.patch1`, Unitree `unitree_rl_mjlab`.

## Global Constraints

- Modify only `Unitree R1 Codex Prompt.md` during initial prompt implementation. An audit-driven coherence commit may update that prompt, this plan, and the approved specification together, and no other tracked file.
- Use `docs/superpowers/specs/2026-08-22-unitree-r1-experiment-first-redesign.md` as the approved source of truth.
- Physical R1 control remains forbidden; `PHYSICAL_DEPLOYMENT_ALLOWED=false` has no override.
- Incremental program-attributable GCP list-price spend must remain below USD 30 before tax, credits, discounts, and currency conversion.
- Do not modify existing GCP resources or unrelated workspace files.
- Use at most one successfully provisioned paid `g2-standard-8` worker, an absolute `terminationTime` and independent watchdog hard deadline no later than create plus `23h45m`, and productive soft stop at `22h30m`.
- Pin Isaac Sim 6.0.1 and Isaac Lab tag `v3.0.0-beta2.patch1`, commit `ffff603eafc6b74264a5261cc0183d6a65390d78`.
- Pin Unitree `unitree_rl_mjlab` commit `1425b15f73bd4095f0df53709d7c389c3eb9e790` as authoritative for this campaign. Record newer upstream heads without silently replacing the pin.
- Official R1 MuJoCo is the planned fallback whenever G1 or G2 does not pass its bounded gate.
- Imports, tests, synthetic fixtures, schemas, runners, converted USD files, and unevaluated checkpoints are not experimental evidence.
- `SCREEN` uses 11 paired blocks only for selection/futility. `CONFIRM` uses 12 untouched paired blocks as the sole efficacy dataset.
- Before each commit, require an empty staged index, stage only the task-owned file set, and assert the cached name set before committing.

### Audit-driven ratification

The following contract replaces any conflicting historical wording in this plan:

- Ordinary campaign autonomy cannot create/enable the persistent watchdog workflow, role definitions, execution service account, project IAM binding, or ownership tag. Missing prerequisites yield `BLOCKED_GCP_WATCHDOG` before spend plus an exact separately authorized one-time operator-bootstrap manifest/command sequence (immutable names, definitions/permission hashes, owner, cost, verification, and teardown responsibility). Only separate operator execution and attestation permits a rerun; prerequisite work is not experiment progress.
- For each of at most two capacity attempts, create the unique bucket in `BASE`; start one Workflows execution with concurrency overflow/backlogging disabled and `LOG_NONE`; capture exact execution name/revision; poll to `ACTIVE` and reject `QUEUED`; then install/verify the execution-ID-derived `ACTIVE` policy. The already-active workflow waits a bounded arming interval before `ARMED_PRECREATE`. Wrong revision/state/timeout means cleanup and no Compute insert.
- Voluntary deletion requires stopping all experiment writers, finalizing recoverable partial state, draining the uploader, generation-specific acknowledgement of every manifest-referenced non-recomputable artifact plus final `INDEX.json` and ownership/cost ledgers, local retrieval/hash verification, proof no producer remains, and `ACTIVE` to `SEALED`; only then delete VM/disk/network, objects/bucket, and worker service account. The immutable hard deadline remains cost-first.
- The exact REST body contains metadata items `enable-oslogin=TRUE` and `block-project-ssh-keys=TRUE`; post-create verification checks effective values, exact controller OS Login/IAP/`iam.serviceAccounts.actAs` authority, and no unexpected login/admin principal.
- An alternate-zone attempt is permitted only after an enumerated terminal nonbillable capacity error, proof no VM/disk/billable state existed, and cleanup/cancellation of every first-attempt resource. It uses a fresh nonce, requestId, bucket, execution, deadlines, body, and preflight. Any ambiguity, survivor, or billable state forbids it. Aggregate bounds are one live attempt, one worker ever billable, one successful worker, 1,000 object generations, 20,000 workflow internal steps, and USD 0.50 watchdog/API.
- Cost authorization uses `operational_envelope=26.100147488`, `remaining_envelope=operational_envelope-cumulative_realized_campaign_cost`, `remaining_nonruntime_reserve=max(0,5.000000000-cumulative_realized_nonruntime_cost)`, and `authorized_compute_hours=min(23.75,floor_to_0.1h(max(0,(remaining_envelope-remaining_nonruntime_reserve)/conservative_all_in_hourly_rate-0.25)))`. All prior attempt/API/storage costs enter realized totals; the 0.25-hour allowance is subtracted once; contingency is never runtime. Initially this yields 23.7 hours while the 24-hour rate product remains conservative.
- Screening uses `SCREEN_FUTILE_NO_CONFIRM` or `SCREEN_DIAGNOSTIC_REJECT_NO_CONFIRM` as applicable. Predictive probability refers explicitly to the posterior component of `PILOT_SUCCESS`: `P(Delta>0)>=0.95` and `P(Delta>=MES)>=0.50`; safety/mechanism gates remain separate.

---

### Task 1: Commit a byte-exact baseline of the original prompt

**Files:**
- Add unchanged: `Unitree R1 Codex Prompt.md`

**Interfaces:**
- Consumes: the current untracked prompt with SHA-256 `0478e1ef995680e047315c14d095e08ead3215b63b6d71ead1e74bd55bf1554d`.
- Produces: a Git-tracked, byte-exact baseline for the redesign diff.

- [ ] **Step 1: Require an empty staged index and untracked target**

Run:

```bash
test -z "$(git diff --cached --name-only)"
test -f 'Unitree R1 Codex Prompt.md'
test -z "$(git ls-files -- 'Unitree R1 Codex Prompt.md')"
```

Expected: both commands exit zero.

- [ ] **Step 2: Verify the exact source bytes**

Run:

```bash
test "$(shasum -a 256 'Unitree R1 Codex Prompt.md' | awk '{print $1}')" = '0478e1ef995680e047315c14d095e08ead3215b63b6d71ead1e74bd55bf1554d'
test "$(tail -c 1 'Unitree R1 Codex Prompt.md' | od -An -tuC | tr -d ' ')" = '63'
test "$(wc -l < 'Unitree R1 Codex Prompt.md' | tr -d ' ')" = '1968'
```

Expected: the hash matches, the final byte is ASCII 63 (`?`) rather than a newline, and the physical newline count is 1,968.

- [ ] **Step 3: Stage and verify the staged bytes and boundary**

Run:

```bash
git add 'Unitree R1 Codex Prompt.md'
test "$(git diff --cached --name-only)" = 'Unitree R1 Codex Prompt.md'
test "$(git show :'Unitree R1 Codex Prompt.md' | shasum -a 256 | awk '{print $1}')" = '0478e1ef995680e047315c14d095e08ead3215b63b6d71ead1e74bd55bf1554d'
git diff --cached --check
```

Expected: the staged index contains only the prompt and its bytes match the working source.

- [ ] **Step 4: Commit the untouched baseline**

Run:

```bash
git commit -m 'docs: add baseline Unitree R1 research prompt'
```

Expected: one commit adding only `Unitree R1 Codex Prompt.md`.

---

### Task 2: Rewrite the complete prompt as one coherent experiment-first program

**Files:**
- Replace: `Unitree R1 Codex Prompt.md`

**Interfaces:**
- Consumes: the byte-exact baseline and the approved design specification.
- Produces: the complete autonomous program. No later task supplies missing operational semantics.

- [ ] **Step 1: Require a clean implementation boundary**

Run:

```bash
test -z "$(git diff --cached --name-only)"
test -z "$(git status --short -- 'Unitree R1 Codex Prompt.md')"
```

Expected: the baseline prompt is committed and has no staged or working-tree change.

- [ ] **Step 2: Replace the complete section structure**

Use this exact top-level order so earlier rules dominate later details:

```text
0. Authority, precedence, and evidence definitions
1. Operating mode and bounded autonomy
2. Pinned source repositories and environment inventory
3. Physical safety, mapping safety, and cloud cost ceiling
4. M2 Max to GCP compute, network, and artifact topology
5. Repository and Git preservation policy
6. Evidence-first file and dependency policy
7. Gate sequence, acceptance contract, and status vocabulary
G0. Local inventory, safety lock, and preflight
G1. Generic headless Isaac Sim/Isaac Lab baseline
G2. Bounded R1 Isaac port and quantitative parity
G2F. Official R1 MuJoCo fallback
G3. Minimal R1 manipulation vertical slice
Shared runtime contracts
Common experimental design and stopping rules
E1. Reactive action refresh
E2. Skill retriggering and escalation
E3. Semantic memory and replanning
E4. Specialist RL pushing skill
E5. Learned world-model ranking in shadow mode
E6. Full hierarchy and ablations
Sim-to-real and conditional cross-engine analysis
R2S2R continuation
Logging, artifacts, tests, and reproducibility
Adaptive execution priority
Final report and completion invariants
```

Do not retain the old numbered headings when their instructions conflict with this order.

- [ ] **Step 3: Transpose the governing contract from the approved spec**

Implement approved-spec sections `Objective` through `Hard cloud-cost envelope` without weakening them. The resulting prompt must explicitly contain all of the following:

**Authority and evidence**

```text
explicit user instruction
> physical safety
> USD 30 absolute incremental cloud-spend ceiling
> preservation of existing resources and changes
> measured evidence and accurate status
> experimental gate order and stopping rules
> experiment ambition
> documentation and polish
```

- Success requires nonzero simulator rollouts plus command, exit code, engine, config, seed, metrics, hashes, and cost provenance.
- A file, import, unit test, synthetic fixture, schema, runner, converted asset, or unevaluated checkpoint cannot pass a gate.
- No broad scaffold may be created in anticipation of a later gate.

**Exact cloud identity and software**

- Project: `project-1178f0de-10fb-4e7e-8e4`.
- Worker: one `g2-standard-8` in verified `us-central1`, Ubuntu 24.04 x86-64, L4 24 GiB, 8 vCPU, 32 GiB RAM, 150 GiB auto-delete `pd-balanced`.
- Driver design target `595.58.03`, replaced only when the current official compatibility matrix requires it.
- Docker Engine, Docker Compose, current production NVIDIA Container Toolkit, and Python 3.12; record discovered versions.
- Isaac Sim 6.0.1 official NGC container; record base RepoDigest, resulting image ID, driver, toolkit, and `pip freeze`.
- Isaac Lab exact tag/commit and documented `base` Docker workflow.

**Exact cost bound**

```text
g2-standard-8                  0.853624312 USD/hour
150 GiB pd-balanced            0.020548500 USD/hour
ephemeral external IPv4        0.005000000 USD/hour
combined runtime               0.879172812 USD/hour
maximum charged runtime       24.000 hours
maximum runtime cost          21.100147488 USD
bounded non-runtime reserve    5.000000000 USD
unallocated contingency       3.899852512 USD
```

- Use an absolute `terminationTime` no later than create plus `23h45m`, termination action `DELETE`, and the independently armed watchdog; do not use a restart-relative maximum-duration field.
- Use the greater of live applicable rate and design-time on-demand rate.
- Standard/on-demand is mandatory; Spot is forbidden.
- Allow at most a primary plus one alternate-zone attempt under the ratified nonbillable-capacity proof and cleanup protocol.
- Do not create a replacement worker after any billable state or user-code failure.
- Before create, require zero labeled instances in `RUNNING`, `PROVISIONING`, `STAGING`, or `STOPPING`.
- Verify termination timestamp and boot-disk auto-delete.
- Prohibit Local SSD, snapshots, reusable images, reserved addresses, load balancers, Cloud NAT, and additional disks.

**Pre-launch ledger fields**

- Resource name, labels, rate source/time, conservative hourly rate, fixed cost, maximum duration, worst-case incremental cost, cumulative cost, remaining authorized cost, and deletion allowance.

**Bounded non-runtime reserve**

- WebRTC: at most 10 GiB and USD 1.20 using Premium-tier India egress for the bound.
- Artifact retrieval: at most 10 GiB and USD 1.20.
- Seven-day storage and operations: USD 0.10.
- Logging/API/rounding: USD 1.00.
- Residual contingency: USD 1.50.
- Disable verbose logging export and stop WebRTC at the host-side byte quota.

- [ ] **Step 4: Transpose the complete network and artifact lifecycle**

Implement approved-spec `Compute topology`, `Network and access`, and deletion-safety requirements:

- M2 Max performs editing, Git, `gcloud`, SSH/IAP, analysis, checksum verification, and native macOS WebRTC only.
- Create a dedicated temporary custom-mode VPC/subnet; never use the default network.
- Use a dedicated service account with object permissions scoped only to the artifact prefix; never project editor/storage admin.
- Give the VM an ephemeral external IPv4 for outbound downloads and optional native WebRTC. Do not claim IAP supplies internet egress.
- SSH only through IAP from `35.235.240.0/20`, targeted only to the worker. Audit effective rules and treat broad inherited ingress as gate failure.
- Headless work exposes no application ports.
- During the visual gate only, allow TCP 49100 and UDP 47998 from the client's current `/32`, use host networking, then delete both rules.
- Never expose TCP 8210, noVNC, RDP, Jupyter, Docker, or streaming to `0.0.0.0/0`.
- Upload durable state every five minutes and after each checkpoint to a regional object prefix.
- Keep the latest two checkpoints, cap cumulative uncompressed artifacts at 10 GiB, disable versioning and soft delete, and apply a seven-day lifecycle.
- At `22h30m`, stop new work. Require the all-artifact acknowledgement, local hash verification, no-live-producer proof, and `ACTIVE` to `SEALED` transition before voluntary deletion. Treat the absolute `23h45m` watchdog/`terminationTime` deadline as the cost fuse, never as transfer logic.
- Retrieve artifacts locally, verify hashes, and only then delete temporary cloud copies.
- Never stop, delete, relabel, or otherwise modify an existing user resource.

- [ ] **Step 5: Transpose G0–G3 completely**

Implement approved-spec `Experimental decision tree` and `Gate definitions` with these exact operational requirements.

**G0**

- Verify auth, billing, exact live prices, quota, capacity, disk quota, effective firewall behavior, source SHAs, mapping safety, cost ledger, artifact prefix, and fully rendered create specification without paid mutation.
- Pin Unitree commit `1425b15f73bd4095f0df53709d7c389c3eb9e790`; record newer heads separately.

**G1**

1. Verify L4, driver, Docker, and NVIDIA runtime.
2. Require Isaac compatibility result `PASSED`.
3. Run a stock headless Isaac Lab example.
4. Run multi-environment Cartpole reset/step or short training.
5. Require finite state, stable VRAM, real exit status, and a retrieved hashed artifact.

G1 and G2 share a six-paid-hour cap, justified as twice NVIDIA's normal sub-three-hour quick-install expectation. G1 permits its primary attempt plus at most one materially different repair. If G1 passes, G2 separately permits one primary conversion attempt plus at most one materially different repair. Either gate falls back when its own attempts or the shared cap are exhausted.

**G2 ten-operation sequence**

1. Call Unitree `get_spec()`, compile, serialize resolved `MjSpec`, and materialize injected assets.
2. Recompile the self-contained bundle without importing Unitree Python and require exact reproduction.
3. Export bodies, joints, geoms, sites, topology, actuators, order, limits, mass, COM, inertia, home, gains, armature, collision enablement/dimensionality, friction, solver, and action transforms.
4. Import with the official MJCF importer and record every importer option.
5. Explicitly transfer loader-side actuator groups, stiffness, damping, effort, armature, soft-limit factor, home state, collision policy, and action scale.
6. Reopen the USD headlessly and mechanically compare its manifest.
7. Run fixed-base contact-free paired actuator probes.
8. Run floating-base plane reset and standing probes.
9. Run one-group-at-a-time and one-joint-at-a-time commands.
10. Scale through 1, 16, 64, and 256 environments, stopping before OOM.

Resolve from the pinned source and check five actuator groups, soft position factor 0.9, home base height 0.76 m, full source home-joint map, collision policy, and per-joint `0.25 * effort_limit / stiffness` action scaling.

**G2 tolerances**

- Exact names, counts, types, order, topology, actuator membership, action order, and collision enablement where specified.
- Canonical numeric properties: absolute or relative `1e-12`.
- Joint limits/home: `<=1e-6 rad`.
- Mass: `<=1e-5` relative or `1e-7 kg`.
- COM: `<=1e-6 m`.
- Inertia: `<=1e-5` relative or `1e-9 kg*m^2`.
- Actuator/control values: `<=1e-7` relative or `1e-9` absolute.
- FK at home and three deterministic poses within 10 percent of range: `<=0.5 mm`, `<=0.05 degrees`.
- Identical two-second bounded contact-free targets: joint RMSE `<=0.02 rad`, max error `<=0.05 rad`, effort overshoot `<=1%`.
- Five-second standing: finite, penetration `<=2 mm`, post-first-second base drift `<=5 mm`, no monotonically growing kinetic energy, hard-limit overshoot `<=1e-4 rad`.
- Zero action-order/sign failures.

State explicitly that passing establishes experimental usability, not cross-engine dynamic equivalence.

**G2F and G3**

- On fallback, reproduce official R1 MuJoCo reset/step/play on the same worker and preserve classified Isaac failure evidence. Do not require MuJoCo-versus-itself cross-engine replay.
- G3 uses a stable stance or explicitly supported upper body, one hand/wrist site, one large object, one planar goal, privileged poses, and controller-compatible position targets.
- Do not build a generic simulator abstraction. Require real reaching/pushing rollouts before G3 passes.
- Retain typed observation, action chunk, event, and monotonic-clock contracts because E1–E3 execute them.

- [ ] **Step 6: Transpose the coherent common inference model**

Implement approved-spec `Common experimental design` exactly:

- One paired seed block is one scene seed crossed with the applicable perturbation suite. Frames, candidates, and perturbations within a block are not independent.
- Freeze disjoint `DEV`, `SCREEN=11`, and `CONFIRM=12` lists.
- SCREEN contributes no observation to final efficacy. Combined 23-block results are `COMBINED_EXPLORATORY` only.
- Evaluate endpoints lexicographically: safety, primary binary endpoint, then continuous diagnostic. Prohibit arbitrary weighted scores.

Use only:

```text
theta ~ Dirichlet(1/2, 1/2, 1/2, 1/2)
counts ~ Multinomial(N, theta)
Delta = theta_01 - theta_10
```

`01` is challenger-only success and `10` incumbent-only success. Compute `P(Delta > 0)` and `P(Delta >= MES)` by deterministic integration. Do not mix posterior probabilities with p-values or bootstrap thresholds.

- Ordinary `MES=2/12=1/6`; E4 and full-stack E6 use `MES=3/12=1/4`.
- Compute SCREEN predictive futility using the Dirichlet-multinomial distribution and the original Jeffreys prior for simulated CONFIRM panels.
- Drop below 0.10 predictive chance of final success. Among remaining candidates select exactly one challenger per incumbent by expected `Delta`, subject to safety/mechanism diagnostics.
- `PILOT_SUCCESS` requires `P(Delta>0)>=0.95`, `P(Delta>=MES)>=0.50`, and all gates.
- `FUTILE` requires `P(Delta>=MES)<=0.10`; otherwise `INCONCLUSIVE`.
- Any non-finite/out-of-limit command, unbounded recovery loop, indefinite stale action, failed safe hold, or method-attributable catastrophic fall immediately disqualifies authority. Zero events never establish safety.

Budget each stage as cold start + initialization + data generation + training + checkpoint evaluation + final evaluation + synchronization + interruption allowance. Measure batched wall time until the one-sided 90-percent runtime upper bound is within 10 percent of the estimate or calibration consumes 5 percent of the provisional allowance. Use the upper bound.

- [ ] **Step 7: Preserve E1–E6 substance while replacing their decisions**

Retain the current prompt's concrete modes, perturbations, metrics, recovery semantics, memory relations/tools, reward terms, candidate construction, model variants, authority limits, and A–I ablation definitions. Replace only their success and stopping semantics as follows.

**E1**

- Screen A–D and confirm one mode versus the incumbent.
- Primary success: recover from the seeded perturbation within the fixed deadline; `MES=1/6`.
- Action age, discontinuity, and jerk are directional/Pareto diagnostics.
- If no mode passes, choose the simplest Pareto-safe mode and report `INCONCLUSIVE`.

**E2**

- All deterministic oracle cases must pass first.
- Stochastic success: correct decision followed by recovery within deadline; `MES=1/6`.
- Loops, missed unsafe escalation, retry breaches, or deterministic-case recurrence disqualify.

**E3**

- Screen M1/M2 against M0 and confirm one.
- Success: correct-object mission completion without a stale-memory action; `MES=1/6`.
- Wrong-object/stale actions, tool calls, and latency remain diagnostics; any wrong-object safety consequence disqualifies authority.

**E4**

- Use three training seeds as an engineering collapse gate, not a population claim.
- Checkpoint at geometric fractions. Before quarter budget, stop only for numerical/reset failure. At or after quarter budget, stop a seed after two successive checkpoints show no positive paired progress and the progress slope remains non-positive.
- Two collapsed or unsafe seeds make the specialist `FUTILE`.
- Select/freeze one checkpoint using DEV/SCREEN and confirm against scripted incumbent with `MES=1/4`.

**E5**

- Split by rollout seed and use three initialization seeds; freeze architecture/checkpoint before CONFIRM.
- Predeclare candidate success before SCREEN as: the selected action chunk is among the actual top two of K=8 candidates and produces strictly positive task-normalized progress over its evaluation horizon.
- Confirm one learned model versus WM0 with `MES=1/6`.
- Spearman, normalized regret, calibration, latency, and privileged-feature dependence are authority diagnostics.
- P95 latency must fit measured E1 refresh slack; claimed non-privileged benefit must survive removal of simulator-only features.
- If rendered-data infrastructure consumes over 20 percent of E5's allowance, defer WM2.
- All world models remain shadow/offline regardless of efficacy.

**E6**

- Screen runnable A–I variants, freeze one complete stack, and confirm against A/incumbent with `MES=1/4`.
- Adjacent effects and 23-block summaries are exploratory.
- Require perturbation-specific mechanism diagnostics; H/I remain shadow.

- [ ] **Step 8: Transpose adaptive selection, artifacts, reports, and completion**

Implement approved-spec `Adaptive experiment selection` through `Completion requirements`:

```text
decision_value_per_hour =
    posterior_predictive_probability_of_changing_the_current_decision
    / conservative_upper_bound_runtime_hours
```

- Safety/dependencies override the score; confirmation outranks code-only breadth.
- G3 and E1–E3 form the prerequisite chain. Afterward choose among feasible E4–E6 decisions by information per hour.
- Work that cannot fit before `22h30m` becomes `NOT_RUN_BUDGET_GATE`.

Define all statuses: `PASS`, `PILOT_SUCCESS`, `INCONCLUSIVE`, `FUTILE`, `SAFETY_DISQUALIFIED`, `CODE_ONLY`, `TEST_ONLY`, `SYNTHETIC_ONLY`, `RUN_FAILED`, `BLOCKED_GCP_AUTH`, `BLOCKED_GCP_QUOTA`, `BLOCKED_LOCAL_PLATFORM`, `BLOCKED_SIMULATOR`, `BLOCKED_DATA`, `NOT_RUN_BUDGET_GATE`, `COMBINED_EXPLORATORY`, and `ISAAC_GATE_FAILED_FALLBACK_SELECTED`.

Define immutable `run_id = UTC timestamp + gate/experiment + engine + seed + short SHA`, `.partial` atomic finalization, per-run manifests, SHA-256, and top-level `INDEX.json`. Prohibit committing containers, caches, secrets, videos, bulky logs, large datasets, and checkpoints; commit compact manifests/reports only.

Tests validate mechanics only and cannot satisfy G1–G3 or E1–E6.

Retain sim-to-real staging and future R2S2R documentation. Cross-engine paired probes apply only when Isaac G2 is viable; on G2F preserve failure evidence and official MuJoCo reproduction without MuJoCo-versus-itself comparison. Never generalize supported-upper-body results to whole-body success.

Final reporting must include gate/fallback table, pins, exact commands/run IDs, implementation versus scientific status, real metrics/posteriors, cost ledger, every created resource/final state, mapping/physical status, changed files, blockers, and one exact highest-information continuation command.

Completion requires no unintended billable resource, cost below USD 30, local/durable hash parity, no overwritten evidence or secret, physical deployment disabled, no non-loopback robot command, passing relevant checks, truthful diff, atomic commits, and no push without authorization.

- [ ] **Step 9: Run fail-fast full-contract assertions**

Run:

```bash
required=(
  '# 0. Authority'
  'project-1178f0de-10fb-4e7e-8e4'
  '595.58.03'
  'v3.0.0-beta2.patch1'
  '0.879172812'
  '23h45m'
  'terminationTime'
  'compute/v1/projects/{project}/zones/{zone}/instances?requestId='
  'BLOCKED_GCP_WATCHDOG'
  'SCREEN_FUTILE_NO_CONFIRM'
  'SCREEN_DIAGNOSTIC_REJECT_NO_CONFIRM'
  'enable-oslogin'
  'block-project-ssh-keys'
  'every manifest-referenced non-recomputable artifact'
  '22h30m'
  '35.235.240.0/20'
  'G2F'
  '1e-12'
  '0.5 mm'
  'SCREEN'
  'CONFIRM'
  'Dirichlet(1/2'
  'PILOT_SUCCESS'
  'SAFETY_DISQUALIFIED'
  'decision_value_per_hour'
  'NOT_RUN_BUDGET_GATE'
  'COMBINED_EXPLORATORY'
  'INDEX.json'
)
for marker in "${required[@]}"; do
  rg -Fq -- "$marker" 'Unitree R1 Codex Prompt.md' || {
    echo "missing required marker: $marker" >&2
    exit 1
  }
done

if rg -Fq -- '23h58m' 'Unitree R1 Codex Prompt.md'; then
  echo 'forbidden obsolete 23h58m contract' >&2
  exit 1
fi
if rg -q '"maxRunDuration"[[:space:]]*:' 'Unitree R1 Codex Prompt.md'; then
  echo 'forbidden executable maxRunDuration contract' >&2
  exit 1
fi
if rg -q 'final `GO`|final GO|chance of final `GO`' 'Unitree R1 Codex Prompt.md'; then
  echo 'forbidden undefined final GO terminology' >&2
  exit 1
fi

rg -q 'MES[[:space:]]*=[[:space:]]*1/6' 'Unitree R1 Codex Prompt.md' || {
  echo 'missing ordinary MES = 1/6' >&2
  exit 1
}
rg -q 'MES[[:space:]]*=[[:space:]]*1/4' 'Unitree R1 Codex Prompt.md' || {
  echo 'missing complexity-heavy MES = 1/4' >&2
  exit 1
}

for forbidden in \
  'Do not install or configure Isaac Sim tonight' \
  'R1_REMOTE_HOST' \
  'reasonable target layout' \
  '## Required minimum' \
  '3/23' \
  '13.04' \
  'Holm' \
  'exact paired test' \
  'MuJoCo/MJLab is the primary substrate for this run'; do
  if rg -Fiq -- "$forbidden" 'Unitree R1 Codex Prompt.md'; then
    echo "forbidden stale instruction: $forbidden" >&2
    exit 1
  fi
done

git diff --check
```

Expected: every marker is independently asserted, every stale instruction is absent case-insensitively, and whitespace checks pass.

- [ ] **Step 10: Verify requirement coverage against the spec**

Check each row and record pass/fail before staging:

| Approved spec section | Prompt destination |
|---|---|
| Objective, authority, evidence rule | Sections 0–1 and 6–7 |
| Compute/network/cost | Sections 3–4 |
| G0–G3 and R1 semantic parity | G0–G3 |
| Common inference and throughput | Common experimental design |
| E1–E6 rules | Corresponding experiment sections |
| Adaptive selection | Adaptive execution priority |
| Artifact/status policy | Logging and final report |
| Completion requirements | Final completion invariants |

Expected: every row passes with exact section references; no requirement is deferred to Task 3.

- [ ] **Step 11: Stage, assert boundary, and commit the coherent rewrite**

Run:

```bash
test -z "$(git diff --cached --name-only)"
git add 'Unitree R1 Codex Prompt.md'
test "$(git diff --cached --name-only)" = 'Unitree R1 Codex Prompt.md'
git diff --cached --check
git commit -m 'docs: redesign R1 campaign around measured experiments'
```

Expected: one commit changes only the prompt and leaves it internally coherent.

---

### Task 3: Independent critical review and final correction gate

**Files:**
- Modify only for accepted findings: `Unitree R1 Codex Prompt.md`

**Interfaces:**
- Consumes: the complete committed rewrite.
- Produces: an independently reviewed prompt with no uncommitted target diff.

- [ ] **Step 1: Spawn an independent reviewer**

Require `PASS` or severity-ranked findings for:

- contradictory simulator priorities;
- physical deployment authority;
- any attributable spend path above USD 30;
- missing project/network/container lifecycle detail;
- loss of artifacts before hard deletion;
- incomplete R1 loader semantic transfer or parity tolerance;
- SCREEN/CONFIRM leakage or undefined inference;
- scaffold counted as evidence;
- shallow breadth preferred over confirmation; and
- destructive treatment of existing user resources.

- [ ] **Step 2: Apply only evidence-backed corrections**

For each accepted finding, make the smallest complete correction. Re-run the full assertion script from Task 2 Step 9 and the coverage table from Step 10.

- [ ] **Step 3: Commit corrections only when the review changed the prompt**

Run:

```bash
if ! git diff --quiet -- 'Unitree R1 Codex Prompt.md'; then
  test -z "$(git diff --cached --name-only)"
  git add 'Unitree R1 Codex Prompt.md'
  test "$(git diff --cached --name-only)" = 'Unitree R1 Codex Prompt.md'
  git diff --cached --check
  git commit -m 'docs: resolve final R1 prompt review findings'
fi
```

- [ ] **Step 4: Verify repository and cloud boundaries**

Run:

```bash
git log --oneline --decorate -8
git status --short
git diff HEAD -- 'Unitree R1 Codex Prompt.md'
gcloud compute instances list --filter='labels.program=reflect-r1' --format='table(name,status,zone)'
```

Expected: no prompt diff remains, only intended documentation is present, and no GCP resource was created during the rewrite.
