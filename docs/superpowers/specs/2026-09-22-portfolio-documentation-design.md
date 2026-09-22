# Unitree R1 portfolio documentation design

## Objective

Present the repository as a rigorous simulator and cloud-operations program with
one completed infrastructure gate and a precise next gate. The README should look
substantial without implying that an R1 policy, Isaac Lab environment, or physical
deployment has been validated.

## Narrative

Lead with the operational achievement: an official Isaac Sim 6.0.1 container
started headlessly on an NVIDIA L4, completed the finite update loop, stayed
inside the campaign cost ceiling, and left no temporary cloud resources.

The shutdown defect remains part of the result. It is a concrete systems finding,
not the ending. The current frontier is G2: validating the complete R1 asset,
articulation, action mapping, and cross-engine kinematics before policy work.

## README structure

1. Project thesis and explicit safety boundary.
2. A compact G1 result card with passed and unresolved checks.
3. A visual cloud-run lifecycle from bounded launch through retained artifacts
   and ownership-checked cleanup.
4. A plain-language explanation of why asset and actuator parity precede policy
   training.
5. A guided repository map.
6. Exact watchdog verification instructions.
7. A "next gate: R1 simulator parity" section with acceptance stages.
8. Scope, cost, and physical-deployment limitations.

## Visual design

Add one accessible explanatory SVG:

- docs/media/g1-bounded-cloud-lifecycle.svg

It will show the actual bounded workflow: approved worker identity, Spot VM,
official Isaac Sim container, retained logs, deadline, and cleanup watchdog.
The diagram will be captioned as an operational flow, not a simulator screenshot.

The README will quote a small, text-based evidence card from the retained G1
report. No generated robot render will be used because the completed run did not
validate an R1 scene.

## Current frontier and next gate

G2 proceeds in bounded stages:

1. construct a canonical R1 manifest from pinned Unitree source;
2. verify joints, actuators, limits, dynamics, collision policy, home state, and
   action transforms;
3. import the self-contained asset into Isaac Sim with recorded options;
4. compare forward kinematics against the canonical MuJoCo model;
5. run reset, standing, group, and single-joint direction probes;
6. scale through 1, 16, 64, and 256 environments with a pre-OOM stop;
7. retain hashes, logs, cost, and cleanup evidence.

If Isaac parity does not pass inside the attempt and cost budget, the documented
official MuJoCo fallback becomes the next executable path. Physical deployment
remains disabled.

## Scope

Documentation and explanatory media only:

- README.md
- docs/media/g1-bounded-cloud-lifecycle.svg
- no cloud launches, asset conversion, policy training, or physical commands

## Verification

- Cross-check every G1 statement against artifacts/g1-20260824/RESULTS.md.
- Confirm the G2 wording matches the ratified experiment specification.
- Render and visually inspect the SVG.
- Run ops/test_g1_watchdog.sh.
- Verify that no copy implies Isaac Lab, R1 articulation, policy performance, or
  physical deployment has already passed.

