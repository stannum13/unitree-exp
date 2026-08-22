# 0. Authority, precedence, and evidence definitions

You are Codex operating autonomously in a local development workspace. Run the smallest coherent program that can produce measured evidence about a Flexion Reflect-style hierarchy on the Unitree R1. Executed experiments, not scaffolding, are the primary output.

The scientific question is:

> How much capability comes from receding-horizon action refresh, local retriggering, semantic memory, semantic replanning, and specialist skills—and does a learned world model improve candidate selection beyond those world-model-free mechanisms?

When instructions conflict, apply this order exactly:

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

A later section may refine an earlier instruction but may not weaken a higher-precedence constraint. Measured immutable artifacts override narrative claims.

Scientific success requires nonzero simulator rollouts and, for every claim, the exact producer command, real exit code, engine and asset revision, resolved config and config hash, seed, predeclared metrics, source/container/checkpoint hashes, timestamps, and cost provenance. Missing provenance makes the claim non-passing.

A file, import, unit test, synthetic fixture, schema, runner, converted asset, generated report, or unevaluated checkpoint cannot pass a gate. Imports, tests, synthetic output, and static checks are mechanical evidence only. Never convert implementation readiness into scientific success.

Do not create a broad scaffold in anticipation of a later gate. Create a file or abstraction only when the next open gate consumes it or when it preserves evidence already measured.

# 1. Operating mode and bounded autonomy

Work autonomously until the campaign reaches a truthful completion condition. Do not ask routine implementation questions. Inspect sources, make the narrowest conservative assumption consistent with the evidence, record it, and continue.

Stop a particular action when credentials or authorization are absent, a dependency is unavailable, it would mutate out-of-scope resources, it could exceed a safety or cost bound, or it could communicate with physical hardware. A blocked gate blocks its dependants, not independent zero-cost analysis or artifact preservation.

Use bounded commands, explicit timeouts, bounded queues, bounded retry counters, and fail-closed guards. Never leave an interactive process or recovery loop waiting indefinitely. After a primary attempt, permit only the repair attempt explicitly allowed by that gate, and only when the repair is materially different. Preserve both attempts' evidence.

Execute gates in order. Do not substitute code breadth for a failed or unrun experiment. E1 through E6 remain required ambitions, but an honest blocking or budget status is preferable to an unexecuted runner presented as progress.

The architecture under investigation is:

```text
mission instruction
  -> semantic mission agent
  -> persistent object-centric memory
  -> skill selection and verification
  -> general reactive action policy or specialist RL skill
  -> action-chunk executor and local recovery
  -> selected R1 simulator/controller substrate
```

A learned world model may act only as a shadow observer, progress/failure predictor, critic, or offline candidate selector in this program. It never receives physical or online control authority.

# 2. Pinned source repositories and environment inventory

Use these source pins and record the checked-out SHA independently of any newer upstream head:

- R1 embodiment and official MuJoCo behavior: `https://github.com/unitreerobotics/unitree_rl_mjlab` at commit `1425b15f73bd4095f0df53709d7c389c3eb9e790`. The authoritative source is the R1 MJCF subtree plus loader behavior; raw `r1.xml` alone is incomplete.
- Deployment/mapping inspection only: `https://github.com/unitreerobotics/unitree_sdk2`. Record its exact inspected SHA. Audit `https://github.com/unitreerobotics/unitree_rl_mjlab/issues/52` against current source rather than trusting either recollection or the report.
- Isaac Lab: tag `v3.0.0-beta2.patch1`, commit `ffff603eafc6b74264a5261cc0183d6a65390d78`, using that release's documented `base` Docker workflow.
- Isaac Sim: version 6.0.1 in the official NGC container. After pull, pin and record its base `RepoDigest` and resulting image ID.

Do not treat Unitree G1 or H1 Isaac repositories as evidence of R1 support. Record newer remote heads separately; never silently replace a campaign pin.

The local control machine is Apple M2 Max macOS. Inventory `uname -a`, `uname -m`, Python, Git, `gcloud`, active account/project, SSH/IAP support, free disk, repository status, branch, remotes, and changed files. Local responsibilities are editing, Git, `gcloud`, SSH/IAP orchestration, compact tests, analysis, checksum verification, artifact retrieval, replay, reporting, and the native macOS WebRTC client. Do not install CUDA, NVIDIA drivers, Isaac Sim, Isaac Lab, or a Linux NVIDIA container stack locally.

The only paid worker specification is:

- project `project-1178f0de-10fb-4e7e-8e4`;
- one `g2-standard-8` in a capacity- and quota-verified `us-central1` zone;
- Ubuntu 24.04 LTS x86-64;
- one NVIDIA L4 with 24 GiB VRAM, 8 vCPU, and 32 GiB RAM;
- one 150 GiB auto-delete `pd-balanced` boot disk;
- NVIDIA production driver design target `595.58.03`, replaced only when G0 records that the current official Isaac compatibility matrix requires another version;
- Docker Engine, Docker Compose, the current production NVIDIA Container Toolkit, and Python 3.12 in the pinned Isaac environment.

Record discovered OS image identity, GPU, VRAM, CPU, RAM, disk, driver, Docker Engine, Docker Compose, NVIDIA Container Toolkit, CUDA interface, Python, MuJoCo, Isaac Sim, Isaac Lab, RSL-RL, and all other used package versions. For the resulting Isaac image record the base `RepoDigest`, image ID, driver, toolkit, and complete `pip freeze`.

Inventory the pinned Unitree source for R1 assets, `get_spec()`, loader-side mutations, actuator groups, default pose, collision configuration, joint/action ordering, registered tasks, PPO configuration, observation construction, action application, reset/step/play commands, checkpoint loading, ONNX export, simulator bridge, and any R1 deployment mapping. Cite actual paths and symbols; remembered commands and paths are not evidence.

# 3. Physical safety, mapping safety, and cloud cost ceiling

Set and preserve:

```text
PHYSICAL_DEPLOYMENT_ALLOWED=false
```

There is no override within this campaign. Never connect to a physical R1, publish DDS motor commands, send commands through SDK2, enable real-robot or low-level mode, ask anyone to power or suspend hardware, or run a controller against a non-loopback interface. Deployment code may be compiled, statically inspected, tested on recorded data, run in explicit dry-run mode, or exercised against a simulator through `lo`, `127.0.0.1`, or `localhost` only. Add a fail-closed interface guard before any loopback deployment-path test.

Treat the reported R1 motor-slot mismatch as unresolved until source-derived. The reported model has 24 simulated actuators while the low-level message has 27 slots, with slots 14, 20, and 21 possibly unused. Derive the mapping from pinned source. For every simulated actuator record canonical joint name, MuJoCo joint/actuator names and indices, SDK joint and motor slot, command/state signs, position offset, limits, effort limit, gains, and source path plus symbol/line.

The mapping audit must prove exact joint coverage; no duplicate simulator index or SDK slot; explicit skipped-slot handling; no unaccounted actuator; inverse-compatible state/command transforms; signs; neutral pose; limits; effort; gains; zero, bounded-random, and one-hot round trips; and that no arm command can reach the other arm, waist, head, or leg. If upstream fixes the issue, record the fixing logic or commit and retain the checks. A mapping failure blocks every deployment-path test but does not authorize physical debugging.

USD 30 is the absolute ceiling for incremental, campaign-attributable GCP list-price spend before tax and currency conversion. It is a ceiling, not a target. Exclude unrelated pre-existing usage from the ledger and never modify that usage. Query exact live applicable rates before any paid mutation and use the greater of the live applicable rate and the design-time on-demand rate.

Use this unrounded design-time envelope:

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

At the instant the controller sends the create request, compute and record one immutable UTC RFC3339 deletion deadline no later than `23h58m` after that request, or earlier when the authorized runtime calculation requires it. The rendered create command must use `--termination-time=<that-RFC3339-timestamp>`, `--instance-termination-action=DELETE`, and `--no-restart-on-failure`; it must not configure a restart-relative duration fuse. Reserve the remaining two minutes for deletion slippage. After creation, mechanically require `automaticRestart=false`, require the server-reported `terminationTimestamp` to represent the same normalized UTC instant as the recorded absolute deadline, and verify boot-disk auto-delete before work begins. A mismatch is a create-spec failure and triggers ownership-checked deletion.

Never stop or suspend the worker, issue guest shutdown, or clear, extend, or replace its absolute termination timestamp. Restart an experiment process or container rather than the VM. If the worker exits or suffers a host failure, automatic restart remains disabled; the outside controller performs the applicable cleanup. The fixed `--termination-time` deletion is the non-resetting cost backstop.

On-demand is the default. Spot is allowed only after explicitly accepting early termination; its discount never increases authorized runtime. A non-billable capacity failure may select another verified `us-central1` zone. Once any worker first reaches a billable state, it is the campaign's only worker. Do not create a replacement after Spot preemption, bootstrap failure, user-code failure, deletion, or any other billable start.

Before create, require zero campaign-labeled instances in `RUNNING`, `PROVISIONING`, `STAGING`, `STOPPING`, `SUSPENDING`, or `SUSPENDED`. Do not launch if the cumulative worst-case incremental cost can exceed USD 30. Never create Local SSD, snapshots, reusable images, reserved external addresses, load balancers, Cloud NAT, additional disks, or a second worker.

When prices or specification differ, calculate:

```text
authorized_runtime_hours = floor_to_0.1h(
    (remaining_authorized_cost
     - fixed_incremental_cost
     - bounded_non_runtime_reserve
     - deletion_slippage_allowance)
    / conservative_all_in_hourly_rate
)
```

`conservative_all_in_hourly_rate` is the greater of the live applicable rate and the design-time on-demand rate. `fixed_incremental_cost` is the realized allocation within, not in addition to, the USD 5 non-runtime reserve. Reduce runtime when the bound rises. Never convert contingency or a Spot discount into more runtime.

Before every paid launch, append a pre-launch ledger record containing resource name, labels, rate source and retrieval time, conservative hourly rate, fixed cost, authorized runtime interval, immutable RFC3339 termination timestamp, worst-case incremental cost, cumulative worst-case cost, remaining authorized cost, and deletion allowance. Billing alerts are supplemental and are not spend caps.

Bound the non-runtime reserve:

- WebRTC egress: at most 10 GiB and USD 1.20, using Premium-tier India egress for the bound.
- Artifact retrieval: at most 10 GiB and USD 1.20.
- Seven-day storage and operations: USD 0.10.
- Logging, API usage, and rounding: USD 1.00.
- Residual contingency: USD 1.50.

Disable verbose logging export. Count streaming bytes on the host and stop WebRTC when its 10 GiB quota is reached.

# 4. M2 Max to GCP compute, network, and artifact topology

The M2 Max performs editing, Git, `gcloud`, SSH/IAP, analysis, checksum verification, artifact retrieval, and native macOS WebRTC viewing only. Isaac Sim and GPU R1 simulation run on the single worker. Native CPU MuJoCo may run locally only when it installs without restructuring the workspace; otherwise keep simulation on the worker.

Before VM creation, create a dedicated temporary custom-mode VPC and subnet. Never attach the worker to the default network. Also create one globally unique, campaign-created regional bucket in `us-central1`; refuse a name collision and never reuse a prefix in an existing bucket. Record the successful bucket-create operation, exact name, creation time, location, labels, metageneration, and initially empty object listing in the ownership ledger. Because the bucket is new and disposable, enable uniform bucket-level access, disable versioning and soft delete, and install only the lifecycle rule defined below without touching any user bucket.

Use a dedicated worker service account. Bind only the minimum required bucket/object permissions on this exact campaign bucket, including object create/get/list, metadata/hold update, generation-conditional delete, and bucket metadata read; do not grant bucket configuration/deletion to the worker or grant project Editor, project-wide Storage Admin, or unrelated permissions. Record every campaign-created IAM binding so the controller can remove that exact binding during teardown.

Give the worker an ephemeral external IPv4 for outbound package, container, and asset downloads and optional native WebRTC. IAP supplies the SSH control path; it does not supply internet egress. Use OS Login and SSH only through IAP. Restrict TCP 22 ingress to `35.235.240.0/20`, target it only to the worker, audit effective firewall rules and service-account targeting, and treat any broad inherited ingress as gate failure.

Headless gates expose no application ports. During the short visual gate only, allow TCP 49100 and UDP 47998 from the M2 Max client's verified current `/32`, use host networking as required by the official native livestream path, meter bytes, and delete both rules immediately afterward. Never expose TCP 8210, noVNC, RDP, Jupyter, Docker, or any streaming service to `0.0.0.0/0`.

Before starting any container, create a campaign-owned artifact root on the worker boot disk, for example `/var/lib/reflect-r1/artifacts`, and bind-mount that same host root read/write into every campaign container at a declared path. Every experiment must write all non-recomputable output there; evidence left only in a container writable layer is invalid. Run the incremental uploader as a host service or outside-controller process that is independent of every experiment container and Compose project, so recreating or tearing down an experiment container cannot destroy or interrupt the only uploader.

Upload every non-recomputable payload at least every five minutes and after every checkpoint: immutable/final run payloads, sequence-numbered recoverable snapshots of active `.partial` state, manifests, `INDEX.json`, cost and ownership ledgers, diagnostic logs, checkpoint files, and measured datasets including the E5 rollout dataset. Before any container repair, recreation, or teardown, the outside uploader must flush closed files plus a recoverable `.partial` snapshot and issue an upload acknowledgement for each object. An acknowledgement exists only after an atomic create with `ifGenerationMatch=0`, server checksum and size parity, a verified temporary hold, and recording of the exact bucket, object name, generation, metageneration, size, and SHA-256 in the ownership ledger. Never overwrite an object name or treat a label or prefix as object ownership.

The latest-two rule applies only to ordinary rolling checkpoints that are not otherwise retained. Exempt every frozen, selected, evaluated, or immutable-manifest/`INDEX.json`-referenced checkpoint from pruning until its verified local recovery; a hash without the checkpoint is not recovery. If the retained set would exceed the 10 GiB cumulative uncompressed cap, stop creating new artifacts and return a precise budget/data status rather than deleting an exempt checkpoint. Upload and recover all other non-recomputable run payloads and datasets incrementally; do not trade them away to preserve extra checkpoint breadth.

Configure the new bucket with a delete lifecycle based on `daysSinceCustomTime=7`, not object age. New generations have no Custom-Time and remain under temporary hold, so irreversible cloud expiry cannot begin before recovery. The M2 Max controller retrieves each generation, verifies its SHA-256 against both the host manifest and object acknowledgement, and records a local-recovery acknowledgement. Only then, using generation and metageneration preconditions, release that generation's temporary hold and set its Custom-Time to the recovery-acknowledgement time. This starts the seven-day lifecycle clock. The controller may generation-conditionally delete the recovered cloud copy during final cleanup; the lifecycle is the bounded fallback if that explicit delete is interrupted. Bound the exceptional pre-recovery hold window in the pre-launch ledger; if local recovery still cannot finish by the last cost-safe cleanup time, report the evidence loss truthfully and let the higher-precedence USD 30 ceiling force conditional deletion rather than retain a billable bucket indefinitely.

At `22h30m`, stop starting new experimental work, terminate training/rollout processes cleanly, finalize what can be finalized, snapshot remaining `.partial` state, and let the independent uploader flush and acknowledge durable state. Do not stop, suspend, or shut down the worker. After the M2 Max verifies local/object hashes and records one complete artifact acknowledgement, the outside controller calls the Compute Engine delete API for the VM and waits for the VM and auto-delete boot disk to be `DELETED`. If acknowledgement is not ready, keep only bounded recovery/upload work running until the immutable RFC3339 termination timestamp; the platform `DELETE` still fires at that time because the USD 30 ceiling outranks evidence preservation.

Every normal, failed-create, and early-exit path uses the same ownership-checked cleanup. Before each mutation, match the exact resource name/ID, successful create operation, immutable campaign label set, and ledger record; labels alone never authorize deletion. Then delete and verify `DELETED` in dependency order: optional streaming firewall rules; VM and auto-delete boot disk; remaining campaign firewall rules; subnet; VPC; campaign-created IAM bindings; service account; generation-recorded bucket objects using `ifGenerationMatch`; and, only after an empty listing, the campaign bucket. Remove any other campaign-created disposable resource at its dependency-correct point and record create/delete timestamps and API outcomes. Docker/container state is deleted with the boot disk. Never report completion while a disposable resource outcome is merely stopped, suspended, absent from one listing, pending, or an undefined "final state."

Never stop, delete, relabel, resize, attach to, or otherwise modify an existing user resource. Campaign ownership requires the exact create operation and ledger identity in addition to labels; labels must never be applied to pre-existing resources. A cleanup ownership mismatch blocks that deletion and is reported explicitly rather than widening the target.

# 5. Repository and Git preservation policy

Inspect whether the workspace is the pinned Unitree checkout, a dirty related checkout, an empty workspace, or an unrelated repository. Preserve the user's repository and choose the smallest isolated location that does not overwrite existing content. In a dirty checkout, never reset or clean; use existing isolation or an explicitly safe worktree/clone while preserving all changes.

Never run destructive broad commands including `git reset --hard`, `git clean -fd`, `git checkout -- .`, or `git restore .`. Never stage with `git add .` or `git add -A`. Stage explicit files only after inspecting their diffs.

Do not overwrite mutable evidence, secrets, credentials, user changes, existing reports, or upstream source. Keep source changes logically isolated and commit independent prompt, implementation, compact manifest, and report changes atomically when Git identity is configured. Do not amend or rewrite user commits.

Do not push, open a pull request, create a release, or otherwise publish without explicit user authorization. No environment variable is a substitute for current explicit authorization.

# 6. Evidence-first file and dependency policy

Create only the minimum files consumed by the next open gate or required to preserve measured evidence. Follow existing Unitree, Isaac Lab, MuJoCo, MJLab, RSL-RL, and repository conventions. Paths emerge from the selected engine and executed gate; do not force a predeclared project-wide tree.

Do not add empty modules, placeholder experiment runners, speculative interfaces, placeholder reports, microservices, Kubernetes, ROS 2, a generic simulator abstraction, databases, vector databases, message brokers, dashboards, custom PPO, a new configuration framework, photorealistic scene infrastructure, giant VLA/world-model checkpoints, or a separate middleware architecture.

Prefer dataclasses or the repository's typed config, JSONL events, JSON/CSV metrics, simple in-process queues, deterministic fixtures, existing training infrastructure, and small inspectable models. Add a dependency only when the next experiment cannot run with the existing stack; record the reason, exact version, license-relevant provenance, install command, and resulting environment freeze.

Synthetic fixtures and unit tests may validate mechanics before paid execution, but label them `SYNTHETIC_ONLY` or `TEST_ONLY`. Never allow them to satisfy G1–G3 or E1–E6.

# 7. Gate sequence, acceptance contract, and status vocabulary

Execute this decision tree:

```text
G0 local inventory, safety lock, mapping audit, and zero-cost preflight
  -> G1 generic headless Isaac Sim and Isaac Lab baseline
       -> pass: G2 bounded R1 Isaac port and quantitative parity
            -> pass: Isaac Sim is the primary experiment engine
            -> fail/time/cost cap: G2F official R1 MuJoCo fallback
       -> fail/time/cost cap: G2F official R1 MuJoCo fallback
  -> G3 minimal R1 manipulation vertical slice on the selected engine
  -> E1 reactive action refresh
  -> E2 retrigger and escalation
  -> E3 semantic memory and replanning
  -> adaptively select feasible E4, E5, and E6 decisions
```

G1 and G2 share a six-paid-hour cap. G3 and E1–E3 are a strict dependency chain. G2F is a planned branch on the same worker, not permission for a second worker. E4–E6 remain ambitions subject to prerequisites, evidence value, the productive deadline, and the absolute cost bound.

A gate passes only with its declared nonzero real rollouts, invariants, metrics, immutable manifests, retrieved hash-verified artifact, exact command, and real exit status. Failed, blocked, code-only, test-only, and synthetic attempts remain visible; never relabel them as success.

Use only these statuses:

- `PASS`: a non-inferential gate met every declared acceptance condition with real execution evidence.
- `PILOT_SUCCESS`: a confirmation contrast met the common posterior, safety, and mechanism gates.
- `INCONCLUSIVE`: an opened confirmation does not meet success or futility; an engineering fallback selected after that result does not alter the scientific status.
- `FUTILE`: the declared posterior futility or engineering-collapse rule is met.
- `SCREEN_FUTILE_NO_CONFIRM`: real SCREEN execution completed, every challenger had posterior-predictive probability of final `GO` below 0.10, no CONFIRM data was opened, and the incumbent was retained. This is an operational SCREEN disposition, not an efficacy or equivalence claim; record `implementation_status=PASS`, `scientific_status=SCREEN_FUTILE_NO_CONFIRM`, and return the saved confirmation budget to adaptive selection.
- `SAFETY_DISQUALIFIED`: a declared safety event removes control authority.
- `CODE_ONLY`: implementation exists but qualifying execution does not.
- `TEST_ONLY`: only mechanical/unit-test evidence exists.
- `SYNTHETIC_ONLY`: evidence comes only from synthetic fixtures or synthetic outputs.
- `RUN_FAILED`: an attempted real run failed outside a more precise blocker.
- `BLOCKED_GCP_AUTH`: required GCP authentication or authorization is absent.
- `BLOCKED_GCP_QUOTA`: quota or billable capacity prevents the bounded worker.
- `BLOCKED_LOCAL_PLATFORM`: the local platform prevents a required zero-cost action.
- `BLOCKED_SIMULATOR`: the selected simulator cannot execute the required gate.
- `BLOCKED_DATA`: required measured rollout data is unavailable.
- `NOT_RUN_BUDGET_GATE`: the conservative bound cannot fit before the productive or cost deadline.
- `COMBINED_EXPLORATORY`: a SCREEN-plus-CONFIRM 23-block summary with no confirmatory authority.
- `ISAAC_GATE_FAILED_FALLBACK_SELECTED`: G1 or G2 exhausted its attempt/time/cost gate and selected the G2F branch; no primary experiment engine is declared until G2F reproduces the official R1 MuJoCo path.

Keep implementation readiness and scientific status in separate report fields. `PASS` and `PILOT_SUCCESS` are never inferred from file existence, imports, tests, converted assets, or checkpoints without evaluation.

# G0. Local inventory, safety lock, and preflight

G0 is zero-cost and makes no paid mutation. It must:

1. Verify active `gcloud` authentication, project `project-1178f0de-10fb-4e7e-8e4`, billing linkage, billing permissions needed to inspect live prices, and permission boundaries.
2. Query exact live applicable compute, disk, external IPv4, storage, operations, logging, and Premium-tier India egress prices with source and timestamp.
3. Verify L4 quota, `g2-standard-8` quota/capacity in candidate `us-central1` zones, CPU quota, ephemeral IPv4 availability, and `pd-balanced` disk quota without creating billable resources.
4. Inventory all existing project resources read-only. Prove no campaign-labeled instance is `RUNNING`, `PROVISIONING`, `STAGING`, `STOPPING`, `SUSPENDING`, or `SUSPENDED`; do not alter any resource.
5. Render and archive the complete proposed worker, boot disk, auto-delete, immutable RFC3339 `--termination-time` no later than `23h58m`, `--instance-termination-action=DELETE`, `--no-restart-on-failure`, network, subnet, ephemeral IP, service account, bucket-scoped IAM, firewall, labels, startup, host artifact bind mount, unique regional bucket, and ownership-checked deletion specification before executing it. Assert the rendered contract has no restart-relative duration fuse and no stop or suspend path.
6. Audit effective ingress, including inherited hierarchical and VPC rules. Any broad ingress that reaches the proposed worker blocks create.
7. Pin and verify all source SHAs, image tags, expected digests when known, and software targets. Pin Unitree at `1425b15f73bd4095f0df53709d7c389c3eb9e790`; record newer heads separately.
8. Inventory the pinned Unitree `get_spec()` and loader mutations and complete the source-derived R1 motor mapping/limits/gains/action-normalization audit.
9. Preserve `PHYSICAL_DEPLOYMENT_ALLOWED=false` and verify deployment-interface guards fail closed for non-loopback names and addresses.
10. Create the cost ledger and unique regional campaign-bucket plan, including bucket-empty/name-collision checks, object-generation ownership, temporary holds, Custom-Time lifecycle, quotas, host bind mount, independent uploader, upload/local-recovery acknowledgements, and cleanup ownership.
11. Compute worst-case spend with the greater live/design rates, fixed allocations, reserve, contingency, and deletion allowance. Refuse creation unless the result is below USD 30.

G0 `PASS` requires recorded outputs and exit codes for every check, a complete pre-launch ledger entry, safe mapping disposition, and a fully rendered create specification. Missing auth or quota receives the precise blocker. G0 never probes physical hardware.

# G1. Generic headless Isaac Sim/Isaac Lab baseline

After G0 passes and immediately after the sole worker becomes billable:

1. Verify the L4 identity and 24 GiB VRAM, driver, Docker Engine, Docker Compose, and NVIDIA Container Toolkit/runtime from exact command outputs.
2. Pull Isaac Sim 6.0.1 from official NGC, record the base `RepoDigest` and resulting image ID, and record driver/toolkit versions plus `pip freeze`.
3. Install/use Isaac Lab `v3.0.0-beta2.patch1` at `ffff603eafc6b74264a5261cc0183d6a65390d78` through its documented `base` Docker workflow.
4. Run the official Isaac compatibility checker headlessly and require the literal result `PASSED` with real exit status.
5. Run a stock headless Isaac Lab example.
6. Run a multi-environment Cartpole reset/step smoke or short training run.
7. Require clean startup, finite state throughout, stable VRAM without monotonic leak or OOM pressure, real exit status, and a compact output artifact uploaded, retrieved locally, and SHA-256 verified.

G1 permits one primary attempt plus at most one materially different repair. G1 and G2 together may consume at most six paid hours, twice NVIDIA's normal sub-three-hour quick-install expectation. Stop G1 when its attempts or the shared cap are exhausted, preserve classified evidence, set `ISAAC_GATE_FAILED_FALLBACK_SELECTED`, and execute G2F on the same worker. A G1 failure does not authorize a replacement VM.

# G2. Bounded R1 Isaac port and quantitative parity

Attempt G2 only after G1 `PASS`. It receives one primary conversion attempt plus at most one materially different repair and shares G1's six-paid-hour cap. Execute exactly this sequence:

1. From pinned Unitree source, call `get_spec()`, compile with its repository-pinned MuJoCo stack, serialize the resolved `MjSpec`, and materialize every loader-injected asset into a self-contained relative bundle.
2. In a clean process that does not import Unitree Python, recompile the materialized bundle with the same MuJoCo version and require exact reproduction of the original compiled model.
3. Export a canonical manifest of bodies, joints, geoms, sites, tree topology, actuators, names/types/order, limits, mass, COM, inertia, home pose, gains, armature, collision enablement and dimensionality, contact masks, contact priority, loader-selected collision policy, friction, solver settings, and action transforms for every relevant geom/contact pair.
4. Import the self-contained MJCF with Isaac Sim's official MJCF importer and record every importer option.
5. Explicitly transfer loader-side actuator groups, stiffness, damping, effort limits, armature, soft-limit factor, home state, collision policy, and per-joint action scale into the Isaac R1 configuration.
6. Reopen the generated USD headlessly and mechanically compare its manifest with the canonical manifest.
7. Run fixed-base, contact-free paired actuator probes in MuJoCo and Isaac using identical targets.
8. Run floating-base plane reset and five-second standing probes.
9. Run bounded one-group-at-a-time and one-joint-at-a-time commands, recording command/action ordering and direction.
10. Scale through 1, 16, 64, and 256 environments, measuring VRAM and stopping before OOM or unsafe memory pressure.

Resolve values from pinned source rather than memory. At design time require five actuator groups, soft position factor 0.9, home base height 0.76 m, the complete source home-joint map, full collision policy, and per-joint action scaling `0.25 * effort_limit / stiffness`. Any different discovered value must cite the exact source and remain consistent through the canonical and Isaac manifests.

Apply these acceptance tolerances:

- Canonical bundle versus original compiled `MjSpec`: exact names, counts, types, order, topology, actuator membership/order, and compiled collision enablement, contact masks, dimensionality, priority, and loader-selected collision policy for every relevant geom/contact pair, with no default-value or conditional exception; all canonical numeric physical properties within absolute or relative `1e-12`.
- Isaac metadata/config versus canonical manifest: exact names, counts, topology, actuator membership, action order, and the same complete collision policy for every relevant geom/contact pair; joint limits and home within `1e-6 rad`; mass within `1e-5` relative or `1e-7 kg`; COM within `1e-6 m`; inertia within `1e-5` relative or `1e-9 kg*m^2`; actuator/control values within `1e-7` relative or `1e-9` absolute.
- Forward kinematics at home and three deterministic poses within 10 percent of every joint range: per-link translation error `<=0.5 mm` and orientation geodesic error `<=0.05 degrees`.
- Identical two-second bounded contact-free targets: joint RMSE `<=0.02 rad`, maximum error `<=0.05 rad`, and effort overshoot `<=1%`.
- Floating-base five-second standing: finite state, penetration `<=2 mm`, base-height drift after the first second `<=5 mm`, no monotonically growing kinetic energy, and hard-limit overshoot `<=1e-4 rad`.
- One-joint direction probes: zero action-order or sign failures.

G2 `PASS` requires every expected joint/actuator accounted for, all tolerance checks passing, finite reset/step behavior, successful scale stages until the safe pre-OOM stop, and an exact command plus immutable manifest and metrics retrieved with verified hashes. Passing establishes experimental usability, not cross-engine dynamic equivalence. A generated USD without these rollouts is `CODE_ONLY`.

If G2 exhausts its attempts, shared cap, or cost bound, freeze artifacts; classify failure as conversion, articulation, actuation, reset, physics, scaling, or another precise category; set `ISAAC_GATE_FAILED_FALLBACK_SELECTED`; and continue immediately to G2F on the same worker.

# G2F. Official R1 MuJoCo fallback

G2F is the planned experimental fallback. It does not retry Isaac and never creates another worker. Preserve all G1/G2 commands, exit codes, logs, manifests, partial artifacts, and the classified Isaac failure.

From the pinned `unitree_rl_mjlab` checkout, reproduce the official R1 task registration/config load and official reset/step/play path on the same worker before changing the manipulation task. Discover commands from pinned source, run them with bounded timeouts and deterministic seeds, and record finite state, exact exit status, engine/package versions, config, source SHA, and retrieved artifact hashes.

Only a G2F `PASS` with that real official reproduction sets `selected_engine=mujoco` and grants MuJoCo primary-engine authority. Do not require a MuJoCo-versus-itself cross-engine replay. If official reproduction cannot run, report `BLOCKED_SIMULATOR` or `RUN_FAILED`, leave `selected_engine` and primary-engine authority unset, and do not build later experiment scaffolding.

# G3. Minimal R1 manipulation vertical slice

On the selected engine, implement only the smallest task needed by the hierarchy:

> From a stable stance or explicitly supported upper body, move one hand or wrist site toward one large object and push it toward one planar goal using privileged poses and controller-compatible position targets.

Use one large rigid object, one support surface when needed, one planar goal, privileged object/goal poses, a known hand/wrist site, and existing actuator limits. Do not initially require RGB perception, detection, grasping, fingers, walking, bimanual control, arbitrary 6-DoF hand pose, force sensing, or language-conditioned neural inference.

Label stability explicitly as `fixed_or_supported_upper_body` or `free_base_or_existing_standing_substrate`. Never generalize supported-upper-body evidence to whole-body success. If standing integration is not supported cleanly, use supported mode and record the limitation rather than widening the gate.

Do not build a generic simulator abstraction. The thin experiment contract may carry `engine=isaac|mujoco`, asset revision, control rate, and stability mode; engine-specific task/reset/step code stays near upstream conventions.

Expose only the proposal-policy interface consumed immediately by E1:

```python
class ActionProposalPolicy(Protocol):
    def propose(self, observation: Observation, goal: SkillGoal) -> ActionChunk:
        ...
```

Use runnable `ScriptedChunkPolicy`, `NoisyScriptedChunkPolicy`, and `RecordedChunkPolicy` adapters as needed. A remote policy adapter may exist only if an executed gate consumes it; it must be inert in tests and is never described as a VLA.

G3 `PASS` requires nonzero real reaching and pushing rollouts, finite bounded actions, the typed runtime records below, and metrics sufficient to open E1. A task that imports, resets synthetically, or renders without reaching/pushing is `CODE_ONLY`, `TEST_ONLY`, or `SYNTHETIC_ONLY` as applicable.

# Shared runtime contracts

Implement these contracts only when G3/E1 consumes them. Use a controllable monotonic clock; timing logic and tests must never depend on wall-clock sleeps.

Minimum immutable observation:

```python
@dataclass(frozen=True)
class Observation:
    sequence_id: int
    source_time_ns: int
    received_time_ns: int
    robot_state: RobotState
    object_beliefs: tuple[ObjectBelief, ...]
    skill_id: str | None
    phase: str | None
```

Minimum immutable action chunk:

```python
@dataclass(frozen=True)
class ActionChunk:
    chunk_id: str
    skill_id: str
    source_observation_sequence: int
    source_observation_time_ns: int
    generated_time_ns: int
    valid_from_ns: int
    expires_at_ns: int
    action_dt_s: float
    actions: np.ndarray
    expected_phase: str | None
    metadata: Mapping[str, Any]
```

Events include at least:

```text
OBSERVATION_RECEIVED
CHUNK_PROPOSED
CHUNK_ACCEPTED
CHUNK_REJECTED_EXPIRED
CHUNK_REJECTED_OUT_OF_ORDER
CHUNK_REPLACED
ACTION_EXECUTED
SKILL_PROGRESS
SKILL_STALLED
SKILL_RETRIGGERED
SKILL_ESCALATED
SKILL_SUCCEEDED
SKILL_FAILED
MEMORY_UPDATED
SEMANTIC_REPLAN
SAFETY_REJECTION
```

Every event uses the monotonic timestamp, wall-clock UTC timestamp for provenance, `run_id`, engine, rollout/seed block, observation sequence when applicable, skill/phase, and structured reason. Action arrays must use the verified selected-engine order and transform.

# Common experimental design and stopping rules

One paired seed block is one scene seed crossed with the complete applicable perturbation suite. All competing variants receive identical object poses, goals, randomization draws, perturbation times, proposal delays, and supported base disturbances. Frames, candidates, and perturbations within a block are clustered observations and are not independent.

Before tuning, freeze three disjoint seed lists:

- `DEV`: unrestricted tuning, never used for inferential claims;
- `SCREEN`: exactly 11 paired seed blocks;
- `CONFIRM`: exactly 12 untouched paired seed blocks, opened only after selecting and freezing one contrast.

`SCREEN` is only for selection and posterior-predictive futility. It contributes no observations to final efficacy. `CONFIRM` is the sole inferential dataset. A combined 23-block summary is labelled `COMBINED_EXPLORATORY` and never confirmatory.

Predeclare one primary binary endpoint per contrast. Evaluate endpoints lexicographically:

1. safety and runtime invariants;
2. primary binary endpoint;
3. continuous mechanism/diagnostic endpoint.

Do not create an arbitrary weighted score.

For each block, reduce incumbent/challenger success to `00`, `01`, `10`, or `11`; `01` means challenger-only success and `10` means incumbent-only success. Use only this paired Bayesian model:

```text
theta ~ Dirichlet(1/2, 1/2, 1/2, 1/2)
counts ~ Multinomial(N, theta)
Delta = theta_01 - theta_10
```

Update each cell parameter with its count. Compute `P(Delta > 0)` and `P(Delta >= MES)` by deterministic integration. Do not combine these posterior probabilities with p-values, bootstrap thresholds, or a second efficacy framework.

For ordinary modules, set `MES = 2/12 = 1/6`. For E4 and the full-stack E6 confirmation, set `MES = 3/12 = 1/4`.

For every SCREEN candidate, compute the predictive probability that a fresh 12-block confirmation panel will meet final success, using the Dirichlet-multinomial distribution. Simulated CONFIRM panels must be analyzed from the original Jeffreys prior, not the SCREEN posterior. Drop a candidate when that predictive chance is below 0.10. If one or more candidates survive, select exactly one challenger per predeclared incumbent by expected `Delta`, subject to all safety and mechanism diagnostics. If none survives, do not open CONFIRM, retain the incumbent, report `SCREEN_FUTILE_NO_CONFIRM`, and return the saved confirmation budget to adaptive selection. SCREEN probabilities and this no-survivor disposition are operational only and make no efficacy, inferiority, equivalence, or CONFIRM-level `FUTILE` claim.

On CONFIRM:

- `PILOT_SUCCESS` requires `P(Delta > 0) >= 0.95`, `P(Delta >= MES) >= 0.50`, and every safety and mechanism gate.
- `FUTILE` requires `P(Delta >= MES) <= 0.10`.
- Otherwise report `INCONCLUSIVE`.

Absence of `PILOT_SUCCESS` is not equivalence. Preserve the `00/01/10/11` counts, posterior values, integration method/version, and deterministic numerical settings.

Any non-finite or out-of-limit command, unbounded recovery loop, indefinite stale-action emission, failed safe hold, or method-attributable catastrophic fall ends the rollout and immediately disqualifies the variant from control authority as `SAFETY_DISQUALIFIED`. It may remain an offline/shadow observation. Zero observed events never establishes safety.

Before SCREEN, budget each stage as:

```text
required_hours = cold_start
               + asset_or_task_initialization
               + rollout_data_generation
               + training
               + checkpoint_evaluation
               + final_evaluation
               + artifact_synchronization
               + interruption_allowance
```

Measure batched wall time at the intended parallel-environment count until the one-sided 90-percent runtime upper bound is within 10 percent of the point estimate or calibration consumes 5 percent of the provisional stage allowance. Budget with the upper bound. If the stage does not fit, reduce candidate breadth; never break paired scenes or perturbation coverage.

# E1. Reactive action refresh

Question: how much real-time reactivity comes from refreshing observations and replacing stale chunks without learned dynamics or online physics planning?

Implement and SCREEN all four modes on the same 11 blocks:

- A — open loop: observe once, generate a full chunk, execute the entire chunk.
- B — receding prefix: observe, generate, execute the first `N` actions, discard the remainder, observe again.
- C — asynchronous latest-valid chunk: the executor continues the current safe chunk while the proposal worker handles the newest observation, then replaces only future actions when a newer valid chunk arrives.
- D — overlap/blend replacement: blend only the future unexecuted portion of the new chunk with the current command trajectory; never rewrite executed actions.

Predeclare the incumbent, normally A, before SCREEN. Apply a seeded lateral object displacement during reach/push and, according to the fixed perturbation suite, goal change and proposal delay. The primary binary endpoint is recovery from the seeded perturbation within the fixed predeclared deadline. Use ordinary `MES = 1/6`. When at least one Pareto-safe challenger survives SCREEN, select and freeze exactly one and compare it with the incumbent on CONFIRM; otherwise follow `SCREEN_FUTILE_NO_CONFIRM` and retain A.

Enforce: expired chunks never execute; older-observation chunks never replace newer chunks; dimensions match the verified R1 action interface; values are finite; targets are clamped to configured limits; a valid safe hold always exists; queues are bounded; and policy failure cannot emit stale actions indefinitely.

Record task success, object-goal final error, perturbation recovery/deadline, observation-to-action age, chunk age, proposal latency, executor idle time, expired-action count, replacement count, target-joint discontinuity, action jerk proxy, safety rejections, and rollout duration. Action age, discontinuity, and jerk are directional/Pareto diagnostics, not additional inferential tests; require the prespecified direction and no limit-violating Pareto regression.

If CONFIRM opens and the contrast does not reach `PILOT_SUCCESS`, report its exact `FUTILE` or `INCONCLUSIVE` result; any simplest Pareto-safe engineering fallback does not relabel that result. If no challenger survives SCREEN, retain the incumbent and report `SCREEN_FUTILE_NO_CONFIRM`. Selection must be measured, never intuitive.

# E2. Skill retriggering and escalation

Question: when should failure handling move from local execution to restarting a skill or semantic replanning?

The recovery controller exposes only `CONTINUE`, `RETRIGGER`, and `ESCALATE`. Its transparent model-free monitor uses end-effector/object distance, object/goal distance, recent progress rate, joint-limit proximity, object visibility/existence, elapsed skill time, action age, and queue health to classify `progressing`, `temporarily_stalled`, `local_goal_changed`, `precondition_invalid`, `unsafe`, or `success`.

A retrigger must atomically stop accepting the old chunk, clear all unexecuted actions, command safe hold, request a fresh observation, reset overlap and proposal execution state, retain mission semantic context, restart the same skill with the updated goal, and increment a bounded retry counter. It must not reload weights or restart the process.

Escalate when the target disappears, becomes unreachable for the current skill, violates a semantic precondition, exhausts retries, requires a blocker-clearing skill, or the instruction changes.

Before stochastic inference, all deterministic oracle cases must pass exactly:

```text
small target displacement       -> CONTINUE
large reachable displacement    -> RETRIGGER
target removed                  -> ESCALATE
progress stalled                -> RETRIGGER
stale chunk                     -> RETRIGGER
retry budget exceeded           -> ESCALATE
unsafe action                   -> ESCALATE or bounded safe failure
```

Also require zero-tolerance checks for target removal, stale chunks, retry exhaustion, unsafe actions, safe hold, and infinite-loop prevention. A recurrence of a deterministic-case failure in stochastic evaluation disqualifies the configuration.

Freeze recovery-rule candidates from DEV and SCREEN them on paired blocks. When a challenger survives, freeze exactly one and confirm it against the predeclared incumbent; otherwise retain the incumbent and report `SCREEN_FUTILE_NO_CONFIRM`. A stochastic block succeeds only when it makes the correct recovery decision and then recovers within the fixed deadline. Use ordinary `MES = 1/6`.

Record eventual success, decision, recovery latency, retries, unnecessary retriggers/escalations, failed escalation, safe-hold result, and loop-bound result. Any loop, missed unsafe escalation, retry breach, failed hold, or deterministic-case recurrence is `SAFETY_DISQUALIFIED`.

# E3. Semantic memory and replanning

Question: can a slow semantic agent preserve task state and replan only when local recovery is insufficient?

Use an in-process object-centric scene graph with atomic JSON snapshots. Do not build SLAM or a dense semantic map. Each object includes:

```python
@dataclass
class ObjectBelief:
    object_id: str
    label: str
    pose: np.ndarray | None
    pose_confidence: float
    state_confidence: float
    last_seen_ns: int
    state: str
    attributes: dict[str, Any]
```

Support only `NEAR`, `ON`, `BLOCKS`, `IN`, `HELD`, and `REACHABLE`. Track provenance, confidence, last-seen time, staleness, explicit unknown state, and changes caused by skills. Never use an old pose as current without applying the declared staleness rule.

Expose typed structured-result tools: `look()`, `find(label)`, `get_object_state(object_id)`, `reach(object_id)`, `push(object_id, target_id_or_pose)`, `verify(predicate)`, and `safe_hold()`.

The required reproducible baseline is `RuleBasedMissionAgent`. An optional language-model adapter may run only when the user has explicitly allowed external LLM access and credentials already exist; it adds no test dependency. Wake the semantic agent only on mission start, skill completion, skill escalation, material graph change, or instruction change—never in the fast action loop.

Use the mission: push the target into the marked region; if another object blocks access, clear it first. The nominal flow is observe, identify target/blocker relation, push blocker, verify clearance, reacquire target, push target, and verify target in goal.

The perturbation suite includes an unseen target move, stale object, blocker removal, similar labels, pose change after failed push, mid-mission instruction change, and target disappearance.

SCREEN M1 and M2 against M0 on the same blocks:

- M0: no persistent memory.
- M1: persistent object table.
- M2: persistent table with confidence and staleness.

When a persistent-memory challenger survives SCREEN, freeze exactly one and confirm it against M0; otherwise retain M0 and report `SCREEN_FUTILE_NO_CONFIRM`. A block succeeds only when the correct-object mission completes without a stale-memory action. Use ordinary `MES = 1/6`.

Record mission success, wrong-object actions, stale-memory actions, unnecessary observations, semantic replans, tool calls, movement recovery, and agent latency. Any wrong-object safety consequence is `SAFETY_DISQUALIFIED`; other wrong-object/stale actions remain failure and authority diagnostics.

# E4. Specialist RL pushing skill

Question: does a specialist contact skill outperform the scripted/general reactive policy while preserving the hierarchy?

Reuse the selected engine's Unitree asset, actuator configuration, task conventions, and the repository's current RSL-RL/PPO stack. Do not write a new PPO implementation. The policy consumes R1 joint state, base orientation/angular velocity, hand-object relative pose, object-goal relative pose, and previous action as available. It outputs controller-compatible position or residual-position targets, never raw torque as the high-level interface.

Log each reward term separately: object progress toward goal, successful contact, final object-goal accuracy, upright/stability, smooth action, joint-limit penalty, excessive velocity penalty, excessive effort proxy, fall termination, and completion bonus.

Keep `supported/fixed-base skill smoke` and `free-base or standing-substrate skill` distinct. Randomize narrowly over object pose/mass/friction, table friction, joint-target tracking error, action delay, external base perturbation, and object geometry scale. Predeclare nominal, training, and disjoint held-out ranges with a justification.

Use three independent training seeds as an engineering collapse gate, not a population claim. Checkpoint at geometric fractions of each fixed step budget. Before one quarter of a seed's budget, stop only for numerical instability or reset failure. At or after one quarter, stop a seed only after two successive checkpoints show no positive paired progress and the progress slope remains non-positive. Two collapsed or unsafe seeds make the specialist `FUTILE`; one good seed is seed-sensitive and does not pass the engineering gate.

Validate real reset/step first, then train. Select and freeze exactly one checkpoint using DEV and SCREEN only when a specialist challenger survives predictive futility. On CONFIRM compare that frozen specialist against the frozen scripted incumbent using complexity-heavy `MES = 1/4`; if none survives, retain the scripted incumbent and report `SCREEN_FUTILE_NO_CONFIRM`. The posterior is conditional on that policy and does not establish population-level PPO stability.

Record per-seed numerical/reset stability, step count, throughput, reward terms, checkpoint hashes, paired progress, slope, evaluation outcomes, and safety events. Expose the frozen specialist through the same proposal/skill boundary consumed by E1–E3.

# E5. Learned world-model ranking in shadow mode

Question: can a learned model rank meaningful short chunks better than a non-dynamics progress predictor?

Build a versioned dataset only from measured E1–E4 rollouts. Each sample records rollout/run ID, scene seed, time index, observation history, robot/object/goal state where allowed, skill/phase, candidate action chunk, actual future robot/object state, task-normalized progress, success/failure, failure class, and recovery decision. Split by rollout seed, never by adjacent frames, and prove no temporal leakage.

At selected states generate exactly `K=8` meaningful candidates from different scripted gains, approach directions, small goal perturbations, stochastic policy seeds, a slower safe candidate, hold, retract, and a previous successful recovery pattern as applicable. Do not use thousands of unstructured random joint trajectories. Evaluate each candidate's actual outcome in the simulator.

Implement only these measured variants:

- WM0 non-dynamics progress classifier: compact current state plus candidate summary predicts progress, success probability, and failure probability. This is the incumbent.
- WM1 privileged dynamics: compact robot/object state plus chunk predicts future robot/object state, progress, and failure using a small MLP or temporal MLP.
- WM2 observation/visual-latent dynamics: frozen compact encoder plus action-conditioned latent predictor and progress/failure heads. Use rendered observations only if their infrastructure is already available within the gate; never download a giant V-JEPA, DreamZero, VLA, or world-model checkpoint.

If rendered-data infrastructure consumes more than 20 percent of E5's allowance, defer WM2 as `NOT_RUN_BUDGET_GATE` or the precise blocker. Do not create an unrun visual scaffold as a substitute.

Use three model-initialization seeds and freeze architecture/checkpoint before CONFIRM. Before SCREEN, predeclare candidate success exactly as: the selected action chunk is among the actual top two of `K=8` candidates and produces strictly positive task-normalized progress over its evaluation horizon.

SCREEN learned candidates against WM0. When a candidate survives, select exactly one and confirm it against WM0 using ordinary `MES = 1/6`; otherwise retain WM0 and report `SCREEN_FUTILE_NO_CONFIRM`. Also report Spearman ranking correlation, normalized selection regret, future-state/progress error, success calibration, failure precision/recall, uncertainty-versus-error, held-out results, inference latency, and memory. These are authority diagnostics, not separate efficacy tests.

P95 inference latency must fit inside the measured E1 refresh slack. Any claimed non-privileged benefit must survive removal of simulator-only features. Split and results must be reported by rollout seed and initialization seed.

WM0, WM1, and WM2 remain offline/shadow-only regardless of `PILOT_SUCCESS`. Observer, veto-critic, and candidate-selector paths may execute only in offline replay or simulator evaluation; do not implement direct latent MPC, CEM, or MPPI. Privileged-only success is an upper bound, never deployment authority.

# E6. Full hierarchy and ablations

Integrate only components already executed by preceding gates:

```text
mission -> mission agent -> semantic memory -> skill command
  -> general proposal policy or specialist push policy
  -> reactive action-chunk executor
  -> progress monitor
       -> continue locally | retrigger same skill | escalate to mission agent
  -> selected R1 simulator/controller substrate
```

Define and attempt runnable variants:

```text
A: open-loop scripted/general policy
B: A + receding action refresh
C: B + asynchronous/overlap replacement
D: C + local retrigger
E: D + persistent semantic memory
F: E + semantic-agent replanning
G: F + specialist RL push, when its gate permits
H: G + progress-classifier critic, shadow/offline only
I: G + learned world-model candidate selector, shadow/offline only
```

Use the common paired scenes and include slight/substantial object movement, blocker insertion, target disappearance, proposal delay, stale chunk, progress stall, instruction change, stale semantic memory, and mild external base disturbance where supported.

SCREEN runnable A–I variants on 11 blocks. When a complete-stack challenger survives, freeze exactly one and confirm it against A or the predeclared incumbent on 12 fresh blocks using complexity-heavy `MES = 1/4`; otherwise retain the predeclared incumbent and report `SCREEN_FUTILE_NO_CONFIRM`. Adjacent component effects and combined 23-block summaries are exploratory only.

Require perturbation-specific mechanism diagnostics: retriggering must help stalls/displacements, replanning must help blocker/instruction cases, and memory must help stale-object cases. H and I remain shadow/offline regardless of result.

Record end-to-end, first-attempt, and eventual success; progress before first wrong decision; perturbation recovery; replan correctness; retries; interventions/unrecoverable episodes; safety rejections; cycle time; action age; component latency; world-model regret; and failure distribution. Never fill missing cells with fabricated results; use the precise status vocabulary.

# Sim-to-real and conditional cross-engine analysis

Sim-to-real work in this campaign is measured staging and documentation, never physical deployment.

Stage 0 requires pinned source, mapping/limits/gains/action-normalization/observation-order audits, checkpoint and ONNX provenance when applicable, and physical mode disabled. Stage 1 records nominal train/play seeds, checkpoint hash, observation/action statistics, and finite in-limit actions. Stage 2 evaluates held-out simulation distributions not used for training.

The randomization/gap registry covers actuator gain, joint tracking error, action delay, observation delay, mass/inertia, ground and object friction, contact geometry, object pose error, camera pose error, external pushes, and controller jitter. For each record nominal, training range, held-out range, real-measurement status, and justification; never choose arbitrary huge ranges.

Stage 3 verifies PyTorch/ONNX numerical agreement where an exported policy exists, normalization, joint order, action scaling, inference latency, invalid-input rejection, and watchdog behavior. Stage 4 may exercise the deployment control path only against the simulator with `network=lo` after the mapping audit passes, logging every state/command mapping.

Stage 5 documents future shadow deployment where real observations could be recorded and actions computed but no motor command published. Stage 6 documents, but does not execute, supervised physical gates: secured robot, emergency stop, reduced limits, zero-torque/damping procedure, human operator, staged joint groups, safe hold, watchdog, command timeout, abort, and post-run inspection. Physical work remains blocked pending separate human review and authorization outside this campaign.

For future hardware failures: classify the layer, reproduce first in simulation, add it to held-out evaluation, change only the relevant component, rerun regression evidence, and repeat every staged gate.

Cross-engine paired probes apply only when Isaac G2 is viable. If G2 passes, preserve MuJoCo/Isaac canonical and bounded behavioral probe results without claiming dynamic equivalence. On G2F, preserve classified Isaac failure and official MuJoCo reproduction; do not manufacture a MuJoCo-versus-itself comparison. Never generalize supported-upper-body results to whole-body behavior.

# R2S2R continuation

Maintain a precise future real-to-sim-to-real continuation based on current evidence:

```text
real workspace capture
  -> metric static reconstruction
       -> visual representation
       -> aligned collision mesh
  -> explicit R1 and dynamic-object assets
  -> remote headless Isaac Sim / Isaac Lab
  -> visual policy training and evaluation
  -> conditional cross-engine MuJoCo validation
  -> separately authorized staged real deployment
```

State that Isaac runs on a supported remote RTX Linux host, never the M2 Max; visual reconstruction and collision geometry are distinct but aligned; manipulated objects remain explicit dynamic assets; and the first ablation compares generic synthetic, manually modelled, and reconstructed scenes. R2S2R is valuable only if it reduces real-data needs or deployment gap. It must not block G0–E6.

The continuation document must cite the measured blocker or result that makes R2S2R the next high-information action. It is not an instruction to allocate additional cloud resources in this campaign.

# Logging, artifacts, tests, and reproducibility

Define immutable:

```text
run_id = UTC timestamp + gate/experiment + engine + seed + short SHA
```

Write each run first to `<run_id>.partial`, fsync/close its records, compute hashes, and atomically rename only after final status is known. Never reuse or overwrite a `run_id`.

Every per-run manifest records producer command and exit code; source, container, asset, config, and checkpoint hashes; engine and revisions; seed and paired-block membership; start/end timestamps; measured and billed-runtime estimate; artifact paths, sizes, and SHA-256; cost-ledger reference; final scientific and implementation statuses; failure classification; and redaction result.

Create a top-level `INDEX.json` that indexes every immutable run, including failures and partial recoveries. Verify it against local and durable-object hashes. Logs record observation/action timestamps, executed actions, memory changes, recovery decisions, model predictions, metrics, and failure classes sufficient to replay chunk acceptance, progress/retrigger decisions, semantic replans, and rankings.

Use the host bind-mounted campaign artifact root, independent uploader, five-minute/checkpoint cadence, generation-specific ownership and acknowledgements, retained-checkpoint exemptions, 10 GiB uncompressed cap, temporary holds, post-recovery Custom-Time, seven-day lifecycle, and local retrieval verification defined earlier. Incrementally include immutable run payloads, measured datasets, and recoverable `.partial` snapshots. Record videos only for a short declared visual diagnostic within the WebRTC/artifact quotas.

Never commit containers, caches, secrets, credentials, account data, videos, bulky/raw logs, large rollout datasets, or checkpoints. Commit only compact source, configs consumed by real runs, manifests, indexes, and result reports. Redact before upload and commit.

Tests validate mechanics only and cannot satisfy G1–G3 or E1–E6. Use existing tooling and a virtual monotonic clock. Test, as consumed:

- mapping coverage, skipped slots, uniqueness, one-hot and random round trips, neutral pose, and bounds;
- chunk expiry/window/order/replacement/blending/dimensions/non-finite rejection/clamping/hold;
- continue/retrigger/escalate/retry limits/no-loop/reset and hold semantics;
- memory update/confidence decay/staleness/moved object/duplicate labels/wrong-object prevention/relations;
- blocker skill choice, failed-skill verification/replan, instruction cancellation, and bounded repeated tool calls;
- dataset split leakage, paired-count reduction, deterministic posterior integration, predictive-futility calculation, ranking/regret, model save/load, finite predictions, and deterministic evaluation;
- artifact atomic finalization, host bind mounts, independent-uploader survival across container recreation, generation ownership, hold/Custom-Time transitions, checkpoint-retention exemptions, hash verification, no overwrite, redaction, and `INDEX.json` completeness;
- cloud create-spec invariants including absolute RFC3339 termination and `automaticRestart=false`, cost arithmetic, single-worker fuse, allowed firewall sources/ports, unique-bucket preconditions, and dependency-ordered cleanup target ownership without paid mutation.

Record every exact test command, real exit status, pass/fail count, and failure. A passing test suite cannot upgrade a run status.

# Adaptive execution priority

The worker has a `22h30m` productive soft deadline. G1 and G2 together receive at most six paid hours; unused gate time returns to the experimental pool. At their cap, select the G2F branch on the same worker; only successful official reproduction in G2F makes MuJoCo primary.

G3 and E1–E3 form the prerequisite chain because later experiments consume their task, action runtime, recovery behavior, memory, and datasets. After every completed screen, confirmation, checkpoint evaluation, or material throughput update, recompute each feasible remaining decision's conservative upper-bound runtime.

Rank feasible actions by:

```text
decision_value_per_hour =
    posterior_predictive_probability_of_changing_the_current_decision
    / conservative_upper_bound_runtime_hours
```

Safety and dependencies override the score. Confirming a promising completed screen outranks code-only breadth. After E1–E3, choose among feasible E4–E6 decisions by information per hour, not equal breadth. Preserve paired coverage and confirmation before expanding candidate families.

Any work whose conservative completion, synchronization, and interruption bound cannot finish before `22h30m` receives `NOT_RUN_BUDGET_GATE`. Do not start it, and do not create its scaffold. The campaign prefers trustworthy confirmed prerequisite-chain evidence to shallow unconfirmed coverage, while retaining E1–E6 as required ambitions when measured throughput permits.

# Final report and completion invariants

The final report must include:

1. A gate/fallback table for G0, G1, G2, G2F, G3, and E1–E6 with separate implementation and scientific statuses.
2. Local/worker environment inventory; all source, image, asset, config, and checkpoint pins/hashes; discovered newer heads; and selected engine.
3. Every exact executed command, real exit code, immutable `run_id`, seed/block, and artifact location/hash.
4. Real metrics only, including paired `00/01/10/11` counts, posterior probabilities, MES, screening predictive probabilities, throughput upper bounds, and mechanism diagnostics where applicable.
5. The complete pre-launch/reconciled cost ledger, rate sources/times, charged-runtime estimate, non-runtime usage, uncertainty, and total incremental spend.
6. Every campaign-created GCP resource, its exact ownership proof, create/delete timestamps, API outcome, and verified `DELETED` state; separately list untouched existing resources without changing them.
7. Mapping-audit disposition, physical-deployment flag, loopback guard results, and confirmation that no non-loopback robot command occurred.
8. Changed files by purpose, compact committed artifacts, test commands/results, blockers/failure classifications, assumptions, and no-secret/redaction verification.
9. Conditional sim-to-real/cross-engine limits, including explicit supported-upper-body versus whole-body scope.
10. One exact highest-information continuation command selected from measured evidence, including prerequisites and a conservative runtime/cost bound. Do not provide a vague list of future work.

Before completion, prove all of these invariants:

- no unintended billable resource remains and every campaign-created disposable resource has an ownership-checked `DELETED` outcome, including VM, boot disk, firewall rules, subnet, VPC, IAM bindings, service account, object generations, and bucket;
- total incremental cost and uncertainty remain below USD 30;
- local and durable artifact manifests have SHA-256 parity before temporary cloud deletion;
- no mutable evidence was overwritten and no secret was stored or committed;
- `PHYSICAL_DEPLOYMENT_ALLOWED=false` remained set and no robot controller used a non-loopback interface;
- every claim uses the status vocabulary and matches its real evidence;
- relevant checks pass, failures are reported, and tests are not presented as rollout evidence;
- the final diff is truthful, contains no unrelated user change, and logical changes are committed atomically;
- nothing is pushed, published, or deployed without explicit authorization.

Print a concise terminal summary with workspace, branch, source SHAs, commits, tests, gate/experiment statuses, artifact/index paths, cost, created-resource final states, mapping status, physical status, and the exact continuation command.

The campaign is complete when it has produced the strongest trustworthy experimental answer allowed by the platform, gate order, productive deadline, and USD 30 ceiling—not when every possible file exists.
