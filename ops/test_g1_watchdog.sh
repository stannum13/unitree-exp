#!/usr/bin/env bash
set -euo pipefail

workflow="ops/reflect-r1-g1-watchdog.yaml"

test -f "$workflow"
rg -Fq 'call: sys.sleep_until' "$workflow"
rg -Fq 'time: ${args.deadline_rfc3339}' "$workflow"
rg -Fq 'call: googleapis.compute.v1.instances.get' "$workflow"
rg -Fq 'call: googleapis.compute.v1.instances.delete' "$workflow"
rg -Fq 'call: googleapis.compute.v1.disks.get' "$workflow"
rg -Fq 'call: googleapis.compute.v1.disks.delete' "$workflow"
rg -Fq 'instance.id != args.vm_id' "$workflow"
rg -Fq 'disk.id != args.disk_id' "$workflow"
rg -Fq 'map.get(instance.labels, "run_nonce") != args.nonce' "$workflow"
rg -Fq 'reflect-r1-g1-' "$workflow"
rg -Fq 'args.vm_name != "reflect-r1-g1-" + args.nonce' "$workflow"
rg -Fq 'args.disk_name != "reflect-r1-g1-" + args.nonce' "$workflow"
rg -Fq 'text.match_regex(args.vm_id, "^[1-9][0-9]{0,19}$")' "$workflow"
rg -Fq 'text.match_regex(args.disk_id, "^[1-9][0-9]{0,19}$")' "$workflow"
rg -Fq 'text.match_regex(args.vm_delete_request_id, "^[a-f0-9]{8}-[a-f0-9]{4}-[1-5][a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$")' "$workflow"
rg -Fq 'text.match_regex(args.disk_delete_request_id, "^[a-f0-9]{8}-[a-f0-9]{4}-[1-5][a-f0-9]{3}-[89ab][a-f0-9]{3}-[a-f0-9]{12}$")' "$workflow"

if rg -q 'instances\.(insert|start|stop)|disks\.insert' "$workflow"; then
  echo 'watchdog contains forbidden create/start/stop capability' >&2
  exit 1
fi
