# Autonomous Overnight Codex Prompt  
## Unitree R1 Reflect-Lite Experimental Program

You are Codex operating autonomously in a local development workspace.

Your objective is to produce the **smallest working experimental substrate** for studying a Flexion Reflect-style hierarchical autonomy architecture on a Unitree R1.

Do not spend this run building a general robotics framework. Reuse the current official Unitree R1 MuJoCo/RL stack, add a thin experimental layer, execute the highest-information experiments that fit the available compute, and leave a precise report and continuation path.

The architecture under investigation is:

```text
mission instruction
        ↓
semantic mission agent
        ↓
persistent object-centric memory
        ↓
skill selection and verification
        ↓
general reactive action policy OR specialist RL skill
        ↓
action-chunk executor and local recovery
        ↓
existing R1 policy/controller substrate
        ↓
simulated Unitree R1
```

An optional learned world model may later act as:

```text
shadow observer
→ progress/failure predictor
→ action-chunk critic
→ candidate selector
→ latent subgoal generator
→ only eventually a direct planner
```

The world-model branch must be evaluated against a strong world-model-free baseline. Do not assume the world model is useful.

---

# 1. Operating mode

Work autonomously until the run is complete.

Do not ask the user routine implementation questions. Inspect the repository, make conservative assumptions, document those assumptions, and continue.

Only stop a particular phase when:

- credentials are missing;
- a required external machine is unavailable;
- continuing would risk destructive changes;
- continuing would communicate with a physical robot;
- the requested operation requires explicit user authorization.

A blocked phase must not stop independent phases. Record the blocker and continue.

Use bounded commands and explicit timeouts. Do not leave a process waiting indefinitely. Do not repeatedly retry the same failed installation or build strategy.

Prefer a functional, measured, narrow experiment over a broad scaffold.

---

# 2. Source-of-truth repositories

Use the current default branch of:

```text
https://github.com/unitreerobotics/unitree_rl_mjlab
```

Use the current official SDK only for source inspection and static deployment auditing:

```text
https://github.com/unitreerobotics/unitree_sdk2
```

Audit this upstream safety issue before touching the R1 deployment path:

```text
https://github.com/unitreerobotics/unitree_rl_mjlab/issues/52
```

Do not rely on remembered file paths or commands. Inspect the current repository and adapt to its present structure.

Record:

- upstream repository;
- upstream commit SHA;
- current branch;
- repository status;
- Python version;
- operating system and architecture;
- installed MuJoCo/mjlab/RSL-RL versions;
- available R1 tasks;
- exact current training command;
- exact current play command;
- exact current ONNX export behavior;
- exact current simulation-deployment path;
- existence and maturity of any R1 deployment code.

Write this to:

```text
artifacts/reflect_r1/baseline_inventory.json
docs/reflect_r1/BASELINE_INVENTORY.md
```

Do not claim that a component works merely because a file exists.

---

# 3. Hard safety constraints

## 3.1 Physical robot control is forbidden during this run

Set and preserve:

```text
PHYSICAL_DEPLOYMENT_ALLOWED=false
```

There is no override during this run.

Do not:

- connect to a physical R1;
- publish DDS motor commands;
- execute an R1 controller against a non-loopback interface;
- send commands through Unitree SDK2;
- enable a real-robot debug or low-level mode;
- ask the user to suspend or power on the robot;
- infer that a connected Ethernet interface is safe to use.

Any deployment executable may only be:

- compiled;
- statically inspected;
- tested against recorded data;
- run in explicit dry-run mode;
- run against a simulator through loopback.

Add a guard so that experimental deployment scripts reject every network interface except:

```text
lo
127.0.0.1
localhost
```

The guard must fail closed.

## 3.2 Audit the reported R1 motor-index mismatch

Upstream issue #52 alleges that:

- the R1 MuJoCo model exposes 24 actuators;
- the physical low-level motor message exposes 27 slots;
- slots 14, 20 and 21 may be unused;
- a continuous `0..23` mapping may therefore shift upper-body state and command indices.

Treat this as an unresolved safety concern until verified against the current checkout.

Do not blindly assume either the issue or current source is correct. Derive the mapping from source.

Create:

```text
docs/reflect_r1/R1_JOINT_MAPPING_AUDIT.md
artifacts/reflect_r1/r1_joint_mapping_manifest.yaml
scripts/reflect_r1/audit_r1_joint_mapping.py
tests/reflect_r1/test_r1_joint_mapping.py
```

The manifest should contain one row per simulated actuator:

```yaml
- canonical_joint_name:
  mujoco_joint_name:
  mujoco_actuator_name:
  mujoco_joint_index:
  mujoco_actuator_index:
  sdk_joint_name:
  sdk_motor_slot:
  command_sign:
  state_sign:
  position_offset:
  lower_limit:
  upper_limit:
  effort_limit:
  kp:
  kd:
  source_files:
    - path:
      line_or_symbol:
```

Verify:

- exact joint-name coverage;
- no duplicate simulator indices;
- no duplicate SDK motor slots;
- no unaccounted simulator actuator;
- explicit treatment of every skipped SDK slot;
- state and command mappings are inverse-compatible;
- sign conventions;
- neutral/default pose;
- position limits;
- effort limits;
- gains;
- random bounded vector round trips;
- zero-vector round trip;
- one-hot command mapping for every joint;
- no arm command can arrive at another arm, waist, head or leg joint.

If current upstream already fixes the issue, document the fixing commit or source logic and retain the tests.

If it does not, create a minimal local fix behind a clearly named mapping layer. Do not activate physical control.

---

# 4. Compute topology

The primary development machine is an Apple M2 Max MacBook.

Detect the actual platform before running anything:

```bash
uname -a
uname -m
python --version
git status
```

## Local M2 Max responsibilities

Use the Mac for:

- editing;
- Git operations;
- repository inspection;
- type checking and unit tests;
- pure-Python runtime tests;
- semantic-memory tests;
- recovery-state-machine tests;
- world-model tests that fit locally;
- result analysis;
- rollout replay;
- documentation;
- SSH orchestration.

Do not attempt to install:

- CUDA;
- NVIDIA drivers;
- Isaac Sim;
- Isaac Lab;
- a Linux-only NVIDIA container stack.

Do not spend the run forcing `mujoco_warp` or another CUDA-specific dependency to work on Apple Silicon.

Native CPU MuJoCo tests are acceptable when they install cleanly without restructuring the project. Otherwise use synthetic state fixtures locally and reserve full simulation for the remote worker.

## Optional remote worker

Use a remote worker only when `R1_REMOTE_HOST` is explicitly present in the environment.

Supported optional variables:

```text
R1_REMOTE_HOST
R1_REMOTE_USER
R1_REMOTE_WORKDIR
R1_REMOTE_SSH_OPTS
R1_REMOTE_CONDA_ENV
R1_REMOTE_PYTHON
```

Do not probe arbitrary SSH hosts from the user’s config.

When a remote host is configured:

1. verify connectivity;
2. verify Linux x86-64;
3. run `nvidia-smi`;
4. record GPU, driver, VRAM and disk availability;
5. create an isolated remote work directory;
6. sync only required source and configs;
7. use bounded training/smoke runs;
8. retrieve logs, checkpoints and metrics.

Do not overwrite an existing remote checkout or environment.

When no remote worker is configured:

- complete all local-independent work;
- create tested remote scripts;
- syntax-check them;
- document the exact command to launch later;
- mark GPU-dependent results as `BLOCKED_REMOTE_GPU`;
- do not treat this as failure of the entire run.

## Isaac Sim

Do not install or configure Isaac Sim tonight.

Create only:

```text
docs/reflect_r1/ISAAC_R2S2R_LATER.md
```

This document should describe how remote headless Isaac Sim may later be used for:

- richer camera rendering;
- synthetic visual data;
- reconstructed deployment scenes;
- site-specific visual evaluation;
- cross-engine validation;
- real-to-sim-to-real experiments.

MuJoCo/MJLab is the primary substrate for this run.

---

# 5. Repository strategy

First determine whether the current directory is:

1. already a clone/fork of `unitreerobotics/unitree_rl_mjlab`;
2. an empty workspace;
3. an unrelated non-empty repository.

Proceed as follows.

## Existing clean Unitree checkout

Create a branch:

```text
codex/reflect-r1-overnight
```

Preserve upstream code wherever possible.

## Existing dirty Unitree checkout

Do not reset, clean or overwrite the user’s changes.

Prefer a separate Git worktree from the current HEAD. If that is unsuitable, create a sibling clone.

## Empty workspace

Clone the official repository:

```bash
git clone https://github.com/unitreerobotics/unitree_rl_mjlab.git
```

## Unrelated non-empty repository

Do not modify unrelated files. Clone the Unitree repository into a clearly named subdirectory or sibling workspace.

## Git restrictions

Never run:

```text
git reset --hard
git clean -fd
git checkout -- .
git restore .
git add .
git add -A
```

Do not push or open a pull request unless:

```text
ALLOW_PUSH=1
```

Commit logically separated phases when Git identity is already configured. Otherwise leave a clean, reviewable diff and document it.

---

# 6. Minimize new scaffolding

Use existing repository conventions and dependencies.

Add no more abstraction than the experiments require.

A reasonable target layout is:

```text
reflect_r1/
├── __init__.py
├── types.py
├── clock.py
├── action_chunks.py
├── executor.py
├── progress.py
├── recovery.py
├── memory.py
├── tools.py
├── agent.py
├── logging.py
├── proposals.py
└── world_models/
    ├── __init__.py
    ├── dataset.py
    ├── progress_classifier.py
    ├── privileged_dynamics.py
    ├── latent_dynamics.py
    └── ranking.py

experiments/reflect_r1/
├── configs/
├── e0_official_r1_baseline.py
├── e1_reactive_execution.py
├── e2_skill_retrigger.py
├── e3_semantic_replanning.py
├── e4_specialist_push.py
├── e5_world_model_ranking.py
└── e6_full_ablation.py

scripts/reflect_r1/
├── overnight.sh
├── local_checks.sh
├── remote_bootstrap.sh
├── remote_official_r1_smoke.sh
├── remote_specialist_push.sh
├── sync_remote_artifacts.sh
├── audit_r1_joint_mapping.py
└── dry_run_deployment.sh

tests/reflect_r1/
docs/reflect_r1/
artifacts/reflect_r1/
```

Adapt these paths to the existing repository rather than forcing them mechanically.

Do not add:

- microservices;
- Kubernetes;
- ROS 2;
- a generic middleware framework;
- a general simulator abstraction;
- a database server;
- a vector database;
- a web dashboard;
- a custom reinforcement-learning implementation;
- a new message broker;
- a new configuration framework when the repository already has one;
- a photorealistic scene pipeline;
- a large VLA checkpoint;
- a multi-billion-parameter world model.

Use:

- Python dataclasses or the project’s existing typed config mechanism;
- JSONL for events;
- JSON/CSV for metrics;
- existing RSL-RL and MJLab components;
- simple in-process queues;
- deterministic test fixtures.

---

# 7. Overnight success definition

## Required minimum

The run is successful when it leaves all of the following:

1. a verified baseline inventory;
2. an R1 joint/motor mapping audit;
3. physical output hard-disabled;
4. a local test suite for the action executor, recovery logic and memory;
5. one runnable minimal R1 simulation task or a clearly isolated simulator blocker;
6. a working reactive action-chunk experiment;
7. a working retrigger/escalation experiment;
8. a working semantic-memory and semantic-replanning experiment;
9. a rollout dataset format;
10. at least a progress-classifier and privileged-dynamics world-model baseline;
11. a candidate-ranking evaluation;
12. a full hierarchy ablation runner or configuration matrix;
13. sim-to-real documentation;
14. a complete overnight report with exact commands and artifacts.

## Stretch outcomes

Attempt these only after the required minimum is secure:

- run the official R1 environment on a remote NVIDIA worker;
- run a bounded official R1 training smoke test;
- play an existing or newly produced checkpoint;
- verify ONNX export;
- run ONNX inference parity checks;
- create and smoke-test a specialist pushing RL environment;
- train a small visual-latent predictor;
- run the complete ablation matrix in simulation.

Do not sacrifice the required minimum to chase a long training run.

---

# 8. Phase A — Inspect and reproduce the official R1 baseline

## A1. Repository inspection

Locate:

- R1 MJCF/XML assets;
- actuator definitions;
- default pose;
- joint-order definitions;
- R1 velocity task registration;
- PPO configuration;
- observation construction;
- action application;
- ONNX export;
- simulator bridge;
- R1 deployment controller, if present;
- Unitree SDK2 message mapping.

Create a source map in:

```text
docs/reflect_r1/R1_SOURCE_MAP.md
```

For every important behavior, identify the actual symbol and path.

## A2. Local checks

Run only checks that are appropriate for the local platform:

- import checks;
- config parsing;
- task registration discovery;
- XML parsing;
- MJCF actuator/joint extraction;
- mapping audit;
- pure-Python tests;
- native CPU MuJoCo smoke test when available.

Do not install a GPU stack locally.

## A3. Remote official smoke

When a remote GPU worker is configured, reproduce the official R1 task before modifying the environment.

Discover the exact current command. It is likely based on the registered R1 flat/velocity task, but do not hard-code a remembered command without verifying it.

Run, in order:

1. task listing or config load;
2. one-environment reset/step smoke;
3. small headless play or rollout;
4. bounded training smoke;
5. checkpoint save;
6. policy load;
7. ONNX export;
8. ONNX inference on recorded observations.

Do not launch full-scale training merely to prove the pipeline works.

Record exact commands, return codes and artifact paths.

## A4. ONNX parity

For a saved policy:

- collect deterministic observations;
- run PyTorch inference;
- run ONNX inference;
- compare shape, finite values and numerical difference;
- document normalization and action scaling;
- test malformed observation rejection;
- test joint-order consistency.

Do not connect the ONNX output to physical commands.

---

# 9. Phase B — Build one minimal manipulation vertical slice

The first custom task should test the hierarchy, not solve general humanoid manipulation.

Implement the simplest viable R1 task:

> From a stable stance, move one hand or wrist contact point toward a large tabletop object and push it toward a marked planar goal.

Use:

- one large rigid object;
- one table or support surface;
- one planar target;
- privileged object pose;
- privileged target pose;
- a known hand/wrist site;
- joint-position or joint-position-delta targets;
- existing actuator limits.

Do not initially require:

- RGB perception;
- object detection;
- grasping;
- finger manipulation;
- walking;
- bimanual coordination;
- arbitrary 6-DoF hand pose;
- contact-force sensing;
- language-conditioned neural inference.

## Stability modes

Provide two clearly labelled modes when feasible:

```text
fixed_or_supported_upper_body
free_base_or_existing_standing_substrate
```

The supported/fixed mode exists to validate the hierarchy rapidly.

Do not describe supported-base success as full humanoid whole-body success.

If the existing R1 substrate cannot safely combine standing and upper-body targets without larger architectural changes, implement the supported mode, document the limitation, and leave a clean interface for the standing policy.

## Proposal-policy interface

Create a small interface such as:

```python
class ActionProposalPolicy(Protocol):
    def propose(
        self,
        observation: Observation,
        goal: SkillGoal,
    ) -> ActionChunk:
        ...
```

Implement runnable adapters:

```text
ScriptedChunkPolicy
NoisyScriptedChunkPolicy
RecordedChunkPolicy
RemotePolicyClient
```

`RemotePolicyClient` is only an adapter for a future VLA/action policy. It should not require a server during tests.

Do not claim that the scripted policy is a VLA.

---

# 10. Shared runtime types

Implement only the types needed by the experiments.

## Observation

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

## Action chunk

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

## Execution events

At minimum:

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

Use a controllable monotonic clock abstraction so timing tests do not depend on wall-clock sleeps.

---

# 11. Experiment E1 — Reactive execution without a world model

## Question

How much real-time reactivity comes from refreshing observations and replacing stale action chunks, without learned dynamics or online physics planning?

## Implement four execution modes

### E1-A — Open loop

```text
observe once
→ generate full chunk
→ execute entire chunk
```

### E1-B — Receding prefix

```text
observe
→ generate chunk
→ execute first N actions
→ discard remaining actions
→ observe again
```

### E1-C — Asynchronous latest-valid chunk

```text
executor continues current safe chunk
while proposal worker processes newest observation
→ replace remaining future actions when a newer valid chunk arrives
```

### E1-D — Overlap/blend replacement

Blend only the future, unexecuted portion of a new chunk with the current command trajectory.

Do not rewrite actions already executed.

## Runtime invariants

Enforce:

- expired chunks are never executed;
- chunks based on older observations cannot replace newer chunks;
- action dimensions match the R1 control interface;
- values are finite;
- joint targets are clamped to configured limits;
- executor has a valid hold action;
- no queue is unbounded;
- policy failure cannot leave the executor emitting stale actions indefinitely.

## Perturbation

At a seeded time during reaching or pushing:

- move the object laterally;
- optionally change the goal;
- optionally delay proposal generation.

Evaluate whether each mode reacts.

## Metrics

Record:

- task success;
- object-goal final error;
- recovery after perturbation;
- observation-to-action age;
- action-chunk age;
- proposal latency;
- executor idle time;
- number of expired actions;
- number of chunk replacements;
- target-joint discontinuity;
- action jerk proxy;
- safety rejections;
- rollout duration.

Run multiple deterministic seeds when simulation is available.

Generate:

```text
artifacts/reflect_r1/e1/metrics.csv
artifacts/reflect_r1/e1/summary.json
artifacts/reflect_r1/e1/events/*.jsonl
docs/reflect_r1/E1_REACTIVE_EXECUTION.md
```

Select a default world-model-free execution mode based on measured results, not intuition.

---

# 12. Experiment E2 — Skill retriggering and escalation

## Question

Where should failure handling transition from continued local execution to skill restart to semantic replanning?

## Implement only three decisions

```text
CONTINUE
RETRIGGER
ESCALATE
```

## Progress monitor

Begin with a transparent model-free monitor using:

- end-effector-to-object distance;
- object-to-goal distance;
- recent rate of progress;
- joint-limit proximity;
- object visibility/existence;
- elapsed skill time;
- action age;
- queue health.

Classify:

```text
progressing
temporarily_stalled
local_goal_changed
precondition_invalid
unsafe
success
```

Map these to the three recovery decisions.

## Retrigger semantics

A retrigger must:

1. stop accepting the old chunk;
2. clear all unexecuted actions;
3. command safe hold in simulation;
4. request a fresh observation;
5. reset action-overlap state;
6. reset proposal-policy execution state;
7. retain mission-level semantic context;
8. start the same skill with the updated goal;
9. increment a bounded retry counter.

Do not reload model weights or restart the whole process.

## Escalation semantics

Escalate when:

- the target disappeared;
- the target became unreachable under the current skill;
- the semantic precondition is false;
- retry budget is exceeded;
- a blocker requires another skill;
- the instruction changed.

## Test cases

Create deterministic tests and simulated scenarios for:

```text
small target displacement       → CONTINUE
large reachable displacement    → RETRIGGER
target removed                  → ESCALATE
progress stalled                → RETRIGGER
stale chunk                     → RETRIGGER
retry budget exceeded           → ESCALATE
unsafe action                   → ESCALATE or safe failure
```

Metrics:

- eventual success;
- recovery decision;
- recovery latency;
- retry count;
- unnecessary retriggers;
- unnecessary escalations;
- failed-to-escalate cases;
- infinite-loop prevention.

Generate:

```text
artifacts/reflect_r1/e2/
docs/reflect_r1/E2_RECOVERY.md
```

---

# 13. Experiment E3 — Semantic memory and semantic replanning

## Question

Can a slow semantic agent maintain persistent task state and replan only when local execution can no longer recover?

Do not build SLAM or a dense semantic map tonight.

## Object-centric memory

Use an in-process scene graph with JSON snapshot persistence.

Each object should contain:

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

Support only the relations needed by the task:

```text
NEAR
ON
BLOCKS
IN
HELD
REACHABLE
```

Track:

- provenance;
- confidence;
- last-seen time;
- stale state;
- explicit unknown state;
- changes caused by a skill.

Never treat an old pose as current without considering staleness.

## Tools

Expose typed tools:

```text
look()
find(label)
get_object_state(object_id)
reach(object_id)
push(object_id, target_id_or_pose)
verify(predicate)
safe_hold()
```

Tool results must be structured objects.

## Agents

Implement:

```text
RuleBasedMissionAgent
OptionalLLMMissionAgent
```

The rule-based agent is the required reproducible baseline.

The optional language-model adapter may only run when:

```text
ALLOW_EXTERNAL_LLM=1
```

and credentials are already present.

Do not add an API dependency to tests.

## Agent wake-up conditions

Run the semantic agent only on:

- mission start;
- skill completion;
- skill escalation;
- material scene-graph change;
- instruction change.

Do not place the semantic agent in the fast action loop.

## Mission

Use a minimal multi-step task such as:

> Push the target object into the marked region. If another object blocks access, clear the blocker first.

Flow:

```text
observe scene
→ identify target
→ identify blocking relation
→ push blocker
→ verify blocker cleared
→ reacquire target
→ push target
→ verify target in goal
```

## Memory perturbations

Test:

- target moves while not observed;
- object becomes stale;
- blocker is removed;
- two objects have similar labels;
- failed push changes object pose;
- instruction changes midway;
- target disappears.

Compare:

```text
M0: no persistent memory
M1: persistent object table
M2: persistent table with confidence and staleness
```

Metrics:

- mission success;
- wrong-object action rate;
- stale-memory action rate;
- unnecessary repeated observations;
- semantic replans;
- tool calls;
- recovery after object movement;
- agent decision latency.

Generate:

```text
artifacts/reflect_r1/e3/
docs/reflect_r1/E3_SEMANTIC_MEMORY.md
```

---

# 14. Experiment E4 — Specialist RL pushing skill

This is the first GPU-dependent custom learning experiment.

## Question

Does a specialist contact skill improve robustness beyond the general/scripted reactive action policy while preserving the same hierarchy?

Reuse the repository’s current:

- MJLab environment conventions;
- RSL-RL implementation;
- R1 asset;
- actuator configuration;
- training scripts;
- logging.

Do not write another PPO implementation.

## Specialist skill

Create a planar push skill with privileged simulator observations.

Inputs may include:

- R1 joint state;
- base orientation and angular velocity;
- hand/object relative position;
- object/goal relative position;
- previous action.

Outputs must be controller-compatible joint targets or residual targets.

Do not make raw torque the high-level action interface.

## Reward terms

Use a small interpretable set:

- object progress toward goal;
- successful contact;
- final object-goal accuracy;
- upright/stability;
- smooth action;
- joint-limit penalty;
- excessive velocity penalty;
- excessive effort proxy;
- fall termination;
- task completion bonus.

Keep reward terms separately logged.

## Training modes

Implement:

```text
supported/fixed-base skill smoke
free-base or standing-substrate skill, only if supported cleanly
```

Do not hide the distinction.

## Domain randomization

Start narrowly with:

- object pose;
- object mass;
- object friction;
- table friction;
- joint target tracking error;
- action delay;
- external base perturbation;
- object geometry scale.

Separate:

```text
training range
held-out range
```

## Overnight behavior

When a remote GPU exists:

1. validate environment reset and step;
2. train a tiny smoke configuration;
3. confirm reward changes and checkpoint saves;
4. run a bounded evaluation;
5. export the exact continuation command.

Do not run an unbounded full training job.

When no remote GPU exists:

- finish the task/config;
- run config/import/static tests;
- prepare the exact remote command;
- mark results `BLOCKED_REMOTE_GPU`.

Expose the resulting policy through the same `ActionProposalPolicy` or specialist-skill interface used by E1–E3.

Generate:

```text
artifacts/reflect_r1/e4/
docs/reflect_r1/E4_SPECIALIST_PUSH.md
```

---

# 15. Experiment E5 — Learned world models in shadow mode

## Question

Can a learned model rank meaningful short action chunks better than a non-dynamics progress predictor?

Do not implement direct latent MPC, CEM or MPPI tonight.

A world model must first demonstrate useful candidate ranking.

## Dataset

Create a versioned dataset from E1–E4 rollouts.

Each sample should contain:

```text
rollout_id
episode_seed
time index
observation history
robot state
object state, when privileged
goal state
skill and phase
candidate action chunk
actual future robot state
actual future object state
progress
success/failure
failure class
recovery decision
```

Split by rollout/scene seed, not random adjacent frames.

Prevent train/test temporal leakage.

## Candidate generation

At selected states, create `K=8` meaningful candidate chunks from:

- different scripted-policy gains;
- different approach directions;
- small goal perturbations;
- stochastic policy seeds;
- slower safe candidate;
- hold;
- retract;
- previous successful recovery pattern.

Do not use thousands of unstructured random joint trajectories.

Evaluate candidate outcomes in simulation.

## WM0 — Non-dynamics progress classifier

Input:

```text
current compact state
+ candidate action summary
```

Predict:

```text
progress
success probability
failure probability
```

This is the baseline to beat.

Use a small model that trains quickly and is easy to inspect.

## WM1 — Privileged dynamics model

Input:

```text
current robot/object state
+ action chunk
```

Predict:

```text
future robot/object state
+ progress
+ failure
```

This establishes an upper bound when perception is not the bottleneck.

Use a compact MLP or temporal MLP.

## WM2 — Visual or observation-latent dynamics model

Only implement this fully when rendered observations are available without a large infrastructure detour.

Use:

```text
frozen compact encoder
+ action-conditioned latent predictor
+ progress/failure heads
```

Prefer an already installed compact torchvision encoder or a tiny project-local encoder.

Do not download a giant V-JEPA, DreamZero or VLA checkpoint tonight.

Keep the interface compatible with replacing the encoder later with:

- DINO features;
- V-JEPA features;
- a VLA backbone;
- a learned task-specific encoder.

If visual data is unavailable, implement and test the interface using compact observation features, and mark the visual experiment partial.

## Evaluation

Primary metrics:

### Rank correlation

```text
Spearman correlation:
predicted candidate ranking
vs
actual simulated candidate ranking
```

### Selection regret

```text
best actual candidate outcome
minus
actual outcome of model-selected candidate
```

Also report:

- future-state error;
- progress error;
- success calibration;
- failure precision/recall;
- uncertainty proxy versus error;
- in-distribution results;
- held-out results;
- inference latency;
- memory use.

## Authority gate

All world models remain in shadow mode during this run.

Create configuration paths for:

```text
observer
veto critic
candidate selector
```

but enable critic/selector behavior only in offline replay or simulation evaluation.

A world model may advance conceptually only if it:

- outperforms WM0 on held-out candidate ranking;
- reduces selection regret;
- fits within the action-refresh latency budget;
- does not depend entirely on information unavailable outside simulation.

Do not implement direct latent MPC unless later evidence justifies it.

Generate:

```text
artifacts/reflect_r1/e5/
docs/reflect_r1/E5_WORLD_MODEL.md
docs/reflect_r1/WORLD_MODEL_DECISION.md
```

`WORLD_MODEL_DECISION.md` must choose one current status:

```text
INSUFFICIENT_EVIDENCE
RETAIN_AS_SHADOW_OBSERVER
PROMISING_AS_CRITIC
PROMISING_AS_CANDIDATE_SELECTOR
NOT_CURRENTLY_USEFUL
```

---

# 16. Experiment E6 — Full Reflect-style hierarchy and ablations

Integrate the implemented components into one runner.

## Full hierarchy

```text
mission
   ↓
mission agent
   ↓
semantic memory
   ↓
skill command
   ↓
general proposal policy OR specialist push policy
   ↓
reactive action-chunk executor
   ↓
progress monitor
   ├── continue locally
   ├── retrigger same skill
   └── escalate to mission agent
   ↓
R1 simulation/control substrate
```

The world model may observe or rank candidates in offline/simulation mode, but it does not command a physical robot.

## Ablations

Create configuration variants:

```text
A: open-loop scripted/general policy
B: A + receding action refresh
C: B + asynchronous/overlap replacement
D: C + local retrigger
E: D + persistent semantic memory
F: E + semantic-agent replanning
G: F + specialist RL push, when available
H: G + progress-classifier critic
I: G + learned world-model candidate selector, offline/sim only
```

Use shared evaluation seeds and perturbations.

## Perturbation suite

Include:

- object moves slightly;
- object moves substantially;
- blocker introduced;
- target disappears;
- action generation delayed;
- stale chunk;
- progress stall;
- instruction changes;
- semantic memory becomes stale;
- mild external base disturbance where supported.

## Metrics

Report:

- end-to-end mission success;
- first-attempt success;
- eventual success;
- progress before first wrong decision;
- perturbation recovery;
- semantic-replan correctness;
- retries;
- interventions or unrecoverable episodes;
- unsafe-action rejections;
- cycle time;
- action age;
- runtime component latency;
- world-model selection regret;
- failure distribution.

Generate:

```text
artifacts/reflect_r1/e6/ablation_results.csv
artifacts/reflect_r1/e6/summary.json
docs/reflect_r1/E6_FULL_HIERARCHY.md
```

Do not fabricate missing results. Use explicit values such as:

```text
NOT_RUN
BLOCKED_REMOTE_GPU
BLOCKED_SIMULATOR
INSUFFICIENT_DATA
```

---

# 17. Sim-to-real methodology

Create:

```text
docs/reflect_r1/SIM2REAL.md
artifacts/reflect_r1/sim2real_gap_registry.yaml
```

The methodology must be specific to the actual current R1 stack.

## Stage 0 — Source and mapping verification

Require:

- pinned repository commits;
- R1 mapping audit;
- limits/gains audit;
- action normalization audit;
- observation ordering audit;
- ONNX parity;
- physical mode disabled until human review.

## Stage 1 — Train and play

Require:

- nominal training;
- deterministic play evaluation;
- fixed seeds;
- policy checkpoint hash;
- observation/action statistics;
- no NaN or out-of-limit actions.

## Stage 2 — Held-out simulation

Evaluate on distributions not used for training.

Randomization registry should cover:

```text
actuator gain
joint tracking error
action delay
observation delay
mass and inertia
ground friction
object friction
contact geometry
object pose error
camera pose error
external pushes
controller update jitter
```

For every variable record:

```text
nominal
training range
held-out range
real measurement status
reason for range
```

Do not choose huge arbitrary ranges without justification.

## Stage 3 — ONNX and runtime parity

Verify:

- PyTorch/ONNX numerical agreement;
- observation normalization agreement;
- joint ordering;
- action scaling;
- inference latency;
- invalid-input rejection;
- watchdog behavior.

## Stage 4 — Simulation deployment through loopback

Use only:

```text
network=lo
```

Run the deployment control path against the simulator, if supported.

The mapping audit must pass before this stage.

Log every state and command mapping.

## Stage 5 — Shadow deployment

Document a future mode in which:

- real observations may be recorded;
- policy actions are computed;
- commands are logged;
- no motor command is published.

Do not perform it tonight.

## Stage 6 — Supervised physical deployment

Document but do not execute:

- suspended/secured robot;
- physical emergency stop;
- reduced command limits;
- zero-torque and damping procedure;
- supervised operator;
- staged joint groups;
- safe standing/hold;
- watchdog;
- automatic command timeout;
- abort path;
- post-run hardware inspection.

Physical deployment remains blocked pending human review of the mapping audit.

## Failure-driven update loop

For every future hardware failure:

1. classify the layer;
2. reproduce it in simulation;
3. add it first to held-out evaluation;
4. modify only the relevant model/randomization/runtime component;
5. rerun regression tests;
6. pass staged deployment gates again.

---

# 18. Deferred Isaac Sim and R2S2R methodology

Create `docs/reflect_r1/ISAAC_R2S2R_LATER.md`.

Do not implement it tonight.

Document this future branch:

```text
real workspace capture
        ↓
metric static reconstruction
        ├── visual representation
        └── aligned collision mesh
        ↓
explicit R1 and dynamic-object assets
        ↓
remote headless Isaac Sim / Isaac Lab
        ↓
visual policy training and evaluation
        ↓
cross-engine MuJoCo validation
        ↓
staged real deployment
```

State clearly:

- Isaac runs on a supported remote RTX Linux host, not the M2 Max;
- static visual reconstruction and physical collision geometry are distinct but aligned;
- manipulated objects remain explicit dynamic assets;
- the first ablation compares generic synthetic, manually modelled and reconstructed scenes;
- R2S2R is valuable only if it reduces real-data needs or deployment gap;
- it must not block the core Reflect-style architecture experiments.

---

# 19. Logging and reproducibility

Every rollout should record:

```text
rollout metadata
Git SHA
config
seed
platform
model/checkpoint hash
events
observation timestamps
action-chunk timestamps
executed actions
semantic-memory changes
recovery decisions
world-model predictions
metrics
failure classification
```

Use a simple structure:

```text
artifacts/reflect_r1/<experiment>/<run_id>/
├── metadata.json
├── config.json
├── events.jsonl
├── actions.csv
├── metrics.json
└── summary.md
```

Record videos only when the simulator supports them cheaply.

Provide a replay command that can reconstruct:

- action-chunk acceptance/rejection;
- progress decisions;
- retrigger events;
- semantic replans;
- world-model rankings.

Determinism is not the main research track tonight, but complete replayable logs are mandatory.

---

# 20. Tests

Use the repository’s existing test tooling where practical.

At minimum test:

## Mapping

- joint-name coverage;
- skipped motor slots;
- no duplicates;
- one-hot mapping;
- round-trip mapping;
- neutral pose;
- bounded random commands.

## Action chunks

- expiry;
- validity window;
- out-of-order rejection;
- replacement;
- blending;
- dimensionality;
- non-finite rejection;
- clamping.

## Recovery

- continue;
- retrigger;
- escalation;
- retry budget;
- no infinite loop;
- reset semantics.

## Memory

- update;
- confidence decay;
- staleness;
- moved object;
- duplicate labels;
- wrong-object prevention;
- relation update.

## Agent

- blocker causes alternate skill;
- failed skill causes verification/replan;
- instruction change cancels current mission;
- repeated failed tool call is bounded.

## World model

- dataset split has no rollout leakage;
- ranking metric correctness;
- selection-regret correctness;
- model save/load;
- finite predictions;
- deterministic evaluation.

Use a virtual clock rather than wall-clock sleeps.

Run the local test suite at the end and record exact results.

---

# 21. Autonomous execution policy

Follow this priority order:

```text
P0 safety lock and mapping audit
P1 repository inventory
P2 local unit tests
P3 official R1 smoke path
P4 minimal push task
P5 reactive execution
P6 retrigger and escalation
P7 semantic memory and replanning
P8 rollout dataset
P9 WM0 and privileged world model
P10 full ablation runner
P11 specialist RL smoke
P12 visual latent world model
```

When blocked:

1. record the exact command;
2. record stdout/stderr;
3. explain the likely cause;
4. try at most one materially different resolution;
5. continue to the next independent phase.

Do not repeatedly reinstall the same environment.

Do not download very large model checkpoints.

Do not introduce a new major dependency without documenting why the existing stack was insufficient.

Prefer a small deterministic baseline over an unverified sophisticated model.

Do not alter upstream R1 physical deployment behavior except to add safety guards, mapping tests or explicit dry-run support.

---

# 22. Final artifacts

Create:

```text
docs/reflect_r1/OVERNIGHT_REPORT.md
docs/reflect_r1/NEXT_RUN.md
docs/reflect_r1/ASSUMPTIONS.md
docs/reflect_r1/PRODUCTION_GAPS.md
docs/reflect_r1/EXPERIMENT_TREE.md
```

## OVERNIGHT_REPORT.md

Include:

### Executive summary

Explain what now works and what does not.

### Environment

- local machine;
- remote machine, if used;
- repository SHA;
- dependency versions.

### Status table

Use:

```text
PASS
PARTIAL
BLOCKED_LOCAL_PLATFORM
BLOCKED_REMOTE_GPU
BLOCKED_SIMULATOR
BLOCKED_DATA
NOT_ATTEMPTED_AFTER_GATE
```

Report status for:

```text
R1 mapping audit
official R1 baseline
ONNX export/parity
minimal manipulation task
E1 reactive execution
E2 recovery
E3 semantic memory
E4 specialist RL
E5 world-model ranking
E6 full hierarchy
sim-to-real documentation
```

### Commands executed

Include exact reproducible commands.

### Tests

Include pass/fail counts and failures.

### Experimental results

Include real metrics only.

### Safety findings

Summarize the R1 mapping audit and confirm physical output remained disabled.

### Changed files

List all modified/added files by purpose.

### Blockers

Be precise.

### Highest-value next action

Choose one, based on the results.

## NEXT_RUN.md

Provide exact next commands for:

- local tests;
- remote official R1 smoke;
- remote specialist-skill training;
- experiment evaluation;
- report generation.

Do not write vague instructions such as “train the model later.”

## PRODUCTION_GAPS.md

Separate:

```text
research demonstration gap
runtime reliability gap
perception gap
whole-body control gap
safety gap
sim-to-real gap
physical hardware validation gap
```

---

# 23. Completion behavior

Before finishing:

1. run formatting only on files changed by this work;
2. run relevant tests;
3. inspect `git diff`;
4. ensure no secrets were written;
5. ensure physical deployment remains disabled;
6. ensure no non-loopback robot command was executed;
7. ensure documentation matches actual results;
8. make atomic commits when safe;
9. do not push unless explicitly authorized.

Print a concise final terminal summary containing:

```text
workspace path
branch
upstream SHA
commits created
tests passed/failed
experiments passed/partial/blocked
main artifact paths
mapping-audit status
physical-deployment status
highest-value next command
```

The result should be a **thin, working Reflect-style R1 experimental layer**, not a new robotics platform.

The core scientific output should answer as much as the available environment permits:

> How much capability comes from receding-horizon action refresh, local retriggering, semantic memory, semantic replanning and specialist skills—and does a learned world model improve candidate selection beyond those world-model-free mechanisms?