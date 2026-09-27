# Website handoff — Unitree R1 simulation

Updated September 27, 2026. This is copy and media guidance, not a website deployment.

## Suggested project card

**Unitree R1 Simulation and Operations**

I established a bounded cloud workflow for robotics simulation: an official Isaac
Sim 6.0.1 container completed its stock headless simulation loop on an NVIDIA L4,
with retained environment details, logs, and resource-cleanup records. The run
also exposed a shutdown defect. The next milestone is checking the R1 model's
joints, actuators, geometry, and action mapping before policy experiments.

## Media and interpretation

- Hero: [`media/g1-bounded-cloud-lifecycle.svg`](media/g1-bounded-cloud-lifecycle.svg).
- Caption: “Recorded cloud simulation lifecycle; simulator infrastructure, not robot task performance.”
- Link: [retained run and unresolved shutdown issue](../artifacts/g1-20260824/RESULTS.md).
- Spell out “gate 1” when using G1: it is not a Unitree G1 robot result.
- Keep `PHYSICAL_DEPLOYMENT_ALLOWED=false` visible in the expanded section.

The cleanup-watchdog static test passed again on September 27, 2026. This is not a
fresh cloud run or a new inspection of the historical cloud resources. Do not show
R1 motion videos or policy-success graphs as this project's completed work yet.
