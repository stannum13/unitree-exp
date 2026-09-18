# Unitree R1 Experiment Program

A safety-first research plan and operations prototype for testing hierarchical robot control on the Unitree R1—starting in simulation, with hard limits on cloud cost and no autonomous physical-robot access.

The central question is whether capabilities such as action refresh, local recovery, semantic memory, replanning, and specialist skills improve a measurable manipulation task enough to justify their complexity. The repository turns that question into a sequence of gated experiments and records the first remote Isaac Sim infrastructure result.

## What I built

- A detailed, experiment-first campaign specification for moving from local checks to Isaac Sim/Isaac Lab and, when justified, an official Unitree MuJoCo fallback.
- Explicit safety rules for joint mapping, loopback-only deployment-path tests, cloud ownership, cost ceilings, and cleanup.
- A bounded Google Cloud Workflows watchdog that can delete only the exact VM and disk identified by name, numeric ID, and run nonce.
- A retained evidence pack from a headless Isaac Sim 6.0.1 run on an NVIDIA L4.

## Current result

The first infrastructure gate reached a real simulator milestone:

- Isaac Sim 6.0.1 started headlessly in its official container on a GCP `g2-standard-8` Spot VM with one NVIDIA L4.
- Vulkan and Warp initialized on the GPU, and the stock finite simulation example completed its update loop.
- The run exposed a teardown problem: fast shutdown aborted on a busy task group, while orderly shutdown exceeded the two-minute bound.
- The test cost stayed well below the campaign's USD 30 ceiling, and all temporary cloud resources were removed.

This proves the base GPU/container path. It **does not** yet prove Isaac Lab, a Unitree R1 environment, trained policy performance, or physical deployment. See the full [G1 result](artifacts/g1-20260824/RESULTS.md) and retained logs for the exact environment and commands.

## Repository map

| Path | Purpose |
| --- | --- |
| [Unitree R1 Codex Prompt.md](Unitree%20R1%20Codex%20Prompt.md) | End-to-end experimental protocol, safety contract, metrics, and stopping rules |
| [`ops/reflect-r1-g1-watchdog.yaml`](ops/reflect-r1-g1-watchdog.yaml) | Ownership-checked cleanup workflow for the bounded G1 worker |
| [`ops/test_g1_watchdog.sh`](ops/test_g1_watchdog.sh) | Static checks for watchdog scope and fail-closed behavior |
| [`artifacts/g1-20260824/`](artifacts/g1-20260824/) | Compact result report and retained Isaac Sim logs |
| [`docs/superpowers/`](docs/superpowers/) | Design history and implementation plan |

## Verify the watchdog

The repository's executable check requires Bash and [`ripgrep`](https://github.com/BurntSushi/ripgrep):

```bash
bash ops/test_g1_watchdog.sh
```

The check confirms that the workflow:

- validates the fixed project, allowed zones, resource names, numeric IDs, and deletion request IDs;
- checks VM and disk ownership again before deletion;
- contains no create, start, or stop capability; and
- waits for the supplied deadline before cleanup.

## Safety and research boundaries

- `PHYSICAL_DEPLOYMENT_ALLOWED=false` throughout the campaign.
- No DDS motor commands or non-loopback robot-controller traffic.
- Exact source, image, asset, configuration, and checkpoint revisions are required for scientific claims.
- Tests and successful imports count as engineering checks, not rollout evidence.
- Cloud work is bounded by ownership proofs, independent cleanup, and a USD 30 incremental cost ceiling.

This repository is best read as a rigorous experimental and operational design with one completed infrastructure gate—not as a finished Unitree control stack.
