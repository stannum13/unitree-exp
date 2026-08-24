# Isaac Sim 6.0.1 headless G1 result

Date: 2026-08-24 UTC

## Outcome

Isaac Sim ran headlessly on a GCP `g2-standard-8` Spot VM with one NVIDIA L4. The live official compatibility-checker output reported `System checking result: PASSED`, recognized the L4 as supported, and initialized Vulkan; that raw checker log was lost when the first Spot VM was preempted and is not part of this committed evidence pack. The retained stock standalone-example logs show Vulkan on the L4, Warp on `cuda:0`, completion of the example's finite update loop, and `Hello World!`.

This proves the base Isaac Sim container path. It does not yet prove Isaac Lab or the Unitree environment.

## Reproducible environment

- Image: `nvcr.io/nvidia/isaac-sim:6.0.1`
- Digest: `sha256:783444c706538aa76cf5126e911ddc5e618779e6105305ad4af4260362a30aa9`
- VM: `g2-standard-8`, 8 vCPU, 32 GiB RAM, NVIDIA L4
- GPU: NVIDIA L4, 23,034 MiB
- Driver: `580.173.02`
- OS image: `ubuntu-accelerator-2404-amd64-with-nvidia-580-v20260820`
- Docker: `29.1.3`
- NVIDIA Container Toolkit: `1.20.0`
- Boot disk: 50 GiB `pd-balanced`

The accelerated OS image contained compute-side NVIDIA packages but omitted `libnvidia-gl-580-server`. Installing the exact matching `580.173.02-0ubuntu0.24.04.1` package exposed `libGLX_nvidia.so.0` and fixed `VK_ERROR_INCOMPATIBLE_DRIVER` in the container.

## Commands that mattered

Compatibility:

```bash
docker run --rm --gpus all --network=host --entrypoint bash \
  -e ACCEPT_EULA=Y \
  nvcr.io/nvidia/isaac-sim:6.0.1 \
  ./isaac-sim.compatibility_check.sh --/app/quitAfter=10 --no-window
```

Finite headless example:

```bash
docker run --rm --gpus all --network=host --entrypoint bash \
  -e ACCEPT_EULA=Y \
  nvcr.io/nvidia/isaac-sim:6.0.1 \
  -lc './python.sh standalone_examples/api/isaacsim.simulation_app/hello_world.py --no-window'
```

## Remaining issue

The stock example completed its simulation work but Isaac Sim 6.0.1 aborted during fast teardown with `Destroying busy TaskGroup!`. Disabling fast shutdown avoided the assertion but hit Isaac's two-minute orderly-shutdown timeout. A writable `/var/cache/hub` mount did not resolve the embedded Hub launch failure. The raw logs preserve all three outcomes.

The teardown defect is downstream of successful GPU, renderer, Warp, and simulation execution. Before long Unitree jobs, use NVIDIA's full Hub container deployment or a smaller Isaac Lab app configuration and require clean exit zero.

## Capacity and cost

Standard L4 capacity was unavailable in all three `us-central1` G2 zones. Two short Spot allocations ran for about 28 minutes total; the first was preempted and auto-deleted. At the on-demand `g2-standard-8` rate, compute would be under $0.40, so actual Spot compute was lower. Disk and Workflow use were pennies. This remained far below the $30 ceiling.

## Cleanup

Both VMs and auto-delete disks are gone. The isolated VPC, subnet, firewall, Workflow, watchdog service account, custom roles, temporary OS Login binding, and newly enabled Workflow APIs were removed. The watchdog implementation remains in the repository for review and reuse.
