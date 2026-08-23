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

The maximum runtime plus bounded non-runtime envelope remains exactly `26.100147488 USD`; the watchdog allocation is internal to that envelope, not additive. The remaining `3.899852512 USD` stays unallocated contingency, so the absolute ceiling and adaptive runtime policy remain unchanged.

Before any campaign resource is created, require a pre-provisioned shared GCP Workflows watchdog, its execution service account, the disposable Resource Manager tag, and the five immutable custom-role definitions specified below. They are operator-owned prerequisites, not campaign-created resources. Verify each exact full resource name, immutable revision or described-permission hash, launch stage, and audit receipt. The execution service account has no user-managed key and no impersonator other than the Workflows service agent. Its pre-provisioned Compute permissions allow only bounded GET/list/delete for resources satisfying the supplied scope and tag; it has no VM/disk create, start, stop, suspend, IAM-write, general administration, or `logging.logEntries.create` permission. Its campaign Storage authority comes only from the exact bucket bindings in `ACTIVE` and `SEALED`. Audit the identities allowed to invoke the shared workflow and to cancel an execution: only the outside controller principal may start or safely cancel this campaign's exact execution, and the watchdog service account cannot cancel itself. Do not create, update, or delete the shared workflow, either operator-owned service account or principal, the tag, or any custom-role definition during this campaign. If any prerequisite is absent, mutable, hash- or stage-mismatched, over-privileged, unauthorized, or cannot be armed, return `BLOCKED_GCP_WATCHDOG` and create no worker.

Generate a cryptographically random 128-bit campaign nonce before deriving any campaign identity. Encode it as 32 lowercase hexadecimal characters and derive unique intended VM and boot-disk names from it. Precompute one UUID Compute insert `requestId`, exact standard labels including `program=reflect-r1` and the nonce, an exact nonce-bearing description, and the exact pre-provisioned disposable Resource Manager tag binding. Immediately before starting the watchdog, the outside controller independently requires exact GETs of both intended names to return `404`; any object returned is a name collision, is never adopted, and blocks the execution and worker create.

Compute and record two immutable UTC RFC3339 deadlines before launch. The hard compute deadline is no later than the VM-create request plus `23h45m`, or earlier when the authorized runtime calculation requires it. The artifact emergency deadline is no later than seven days after that create request, fitting the declared storage/operations reserve. Start exactly one watchdog execution before sending the VM-create request. Its immutable input contains the nonce; requestId; exact project, zone, intended VM and boot-disk names; required labels, description, and tag; exact bucket containment and permitted IAM-state schema; all other intended campaign resource identities; both deadlines; and workflow revision. As its first action, before acknowledging or accepting any compute identity, the workflow independently requires exact GETs of both intended VM and disk names to return `404`. Any present resource or inability to prove both absences produces `BLOCKED_GCP_WATCHDOG`; the workflow never adopts or mutates it and never widens or guesses a target.

Do not use custom Cloud Logging as an acknowledgement channel. The actual execution resource name supplies `<execution-id>`; the controller uses it to install the pre-rendered exact namespace conditions, and the workflow derives the same expected normalized policy from its own execution ID plus the immutable schema. The workflow may wait only for the short predeclared arming interval for that exact `ACTIVE` state; it accepts no transient or approximate policy and blocks without a worker if the state never matches. It then atomically creates an immutable, temporarily held GCS marker with `ifGenerationMatch=0` under the sole namespace `control/watchdog/<execution-id>/ARMED_PRECREATE.json`. It records the exact execution resource name, revision, nonce, requestId, scope, both name-absence receipts, IAM-state hash, and deadlines. The controller verifies its exact object name, generation, checksum, size, metadata, temporary hold, and payload before issuing the sole `instances.insert`. That insert uses the precomputed requestId and creates the VM with the exact nonce labels, description, tag, absolute deadline, named boot disk, and boot-disk auto-delete contract. No retry may use a different requestId and no second insert is allowed.

The workflow may atomically create `control/watchdog/<execution-id>/ARMED_COMPUTE.json` only after observing a creation later than `ARMED_PRECREATE` whose exact labels, description, and tag match and whose sole insert operation is `DONE`, has `clientOperationId=requestId`, has matching `targetId` and `targetLink`, and resolves to the same server-assigned VM and boot-disk numeric IDs, creation times, intended names, boot attachment, and `autoDelete=true`. The marker carries all those capture fields plus execution, revision, nonce, scope, deadlines, checksum, and immutable metadata. A missing or nonmatching field is `BLOCKED_GCP_WATCHDOG`, never an ownership proof. Apart from the minimum interval needed to create and identify the worker, bootstrap must wait; no package install, container start, or experiment may proceed until the controller has generation/checksum/metadata-verified this marker and copied it into the outside ledger. Failure triggers immediate controller cleanup only for identities already proved campaign-owned; the watchdog never mutates an unmatched compute resource.

The worker has exactly one executable create path: an authenticated Compute v1 REST mutation `POST https://compute.googleapis.com/compute/v1/projects/{project}/zones/{zone}/instances?requestId={nonzero-UUID}`. Put `requestId` only in the query string, never in the JSON body, and never use `gcloud compute instances create`. Render the following template to an exact JSON file by replacing every angle-bracket token before G0 passes; archive that byte-exact body and its SHA-256. Resolve the Ubuntu family to a specific Ubuntu 24.04 LTS amd64 image self-link before rendering. Do not add fields or disks at execution time.

```json
{
  "name": "<nonce-derived-vm-name>",
  "machineType": "zones/<zone>/machineTypes/g2-standard-8",
  "labels": {"program": "reflect-r1", "run_nonce": "<32-lowercase-hex-nonce>"},
  "description": "reflect-r1 campaign <32-lowercase-hex-nonce>",
  "params": {"resourceManagerTags": {"<tag-key-namespaced-name>": "<tag-value-short-name>"}},
  "tags": {"items": ["<nonce-derived-network-tag>"]},
  "networkInterfaces": [{
    "subnetwork": "projects/<project>/regions/us-central1/subnetworks/<exact-subnet-name>",
    "accessConfigs": [{"name": "External NAT", "type": "ONE_TO_ONE_NAT", "networkTier": "PREMIUM"}]
  }],
  "serviceAccounts": [{"email": "<worker-service-account-email>", "scopes": ["https://www.googleapis.com/auth/cloud-platform"]}],
  "metadata": {"items": [{"key": "startup-script", "value": "<exact-startup-script-content>"}]},
  "disks": [{
    "boot": true,
    "autoDelete": true,
    "type": "PERSISTENT",
    "initializeParams": {
      "diskName": "<nonce-derived-boot-disk-name>",
      "diskSizeGb": "150",
      "diskType": "zones/<zone>/diskTypes/pd-balanced",
      "sourceImage": "<resolved-specific-ubuntu-2404-lts-amd64-image-self-link>",
      "resourceManagerTags": {"<tag-key-namespaced-name>": "<tag-value-short-name>"}
    }
  }],
  "scheduling": {
    "terminationTime": "<hard-compute-deadline-RFC3339>",
    "instanceTerminationAction": "DELETE",
    "automaticRestart": false,
    "onHostMaintenance": "TERMINATE",
    "provisioningModel": "STANDARD"
  }
}
```

Use a short-lived OAuth 2 bearer token only in the in-memory `Authorization: Bearer <token>` header and `Content-Type: application/json`; never print or archive the token or an authorization header. Capture the sanitized HTTP status, response body, request body hash, and returned zonal operation name, numeric ID, `operationType=insert`, `clientOperationId`, `targetId`, and `targetLink`. Persist the operation receipt before polling that exact operation with Compute v1 `zoneOperations.get` until `status=DONE`; any HTTP error, operation error entry, missing identity field, or mismatch blocks bootstrap. If and only if the insert response is lost, retry the identical URL, byte-identical body, and same requestId; then recover the unique matching zonal insert operation and reject zero or multiple matches. This idempotent response recovery is not a second create attempt; never change the requestId, body, or target and never adopt an instance by name alone. Standard/on-demand is the only permitted provisioning model: Spot, `maxRunDuration`, and legacy `preemptible` are forbidden, and no discount expands runtime. After creation, mechanically require the server-reported `automaticRestart=false`, `onHostMaintenance=TERMINATE`, `provisioningModel=STANDARD`, `instanceTerminationAction=DELETE`, and `terminationTimestamp` equal the rendered deadline, verify the sole boot disk and `autoDelete=true`, and verify both input-only Resource Manager tag maps persisted through the tag-binding and effective-tag APIs. This is only a secondary `RUNNING`-state fuse: it does not cover `STOPPED` or `SUSPENDED`, where Compute Engine may remove the termination timestamp. Compatibility statement: the earlier design's `23h58m` running-state fuse is superseded and forbidden as an executable deadline; the only hard compute deadline remains the absolute time no later than create plus `23h45m`.

Never stop or suspend the worker, issue guest shutdown, or clear, extend, or replace either deadline or its termination timestamp. Restart an experiment process or container rather than the VM. If the worker exits, is stopped, or suffers a host failure, automatic restart remains disabled and the watchdog still reaches the absolute deadline independently of the M2 Max, guest, VM lifecycle state, or experiment containers.

At the hard compute deadline, the watchdog wakes and GET-validates the exact project/zone/name, numeric IDs, creation times, nonce labels, description, tag, and captured DONE insert-operation `clientOperationId`, `targetId`, and `targetLink` against its immutable input and `ARMED_COMPUTE` capture. A matching `404` after that complete capture is an idempotent already-deleted result; an extant same-name resource with a different identity is an ownership mismatch. Otherwise it deletes the VM even when it is `STOPPED`, using a deterministic idempotent delete request ID, and waits for the Compute Engine long-running operation to finish. It then GET-validates the captured boot-disk identity, requires that the disk has no unexpected users, deletes any survivor with a separate deterministic request ID, and waits for that operation. It may write a held, create-only control marker for the outcome before later artifact cleanup. It fails closed on any identity mismatch and never widens or guesses a target. The outside controller remains responsible for earlier orderly cleanup and reconciliation; the watchdog is the controller-independent hard stop.

Standard on-demand is mandatory. A non-billable capacity failure may select another verified `us-central1` zone only by rerendering the complete preflight before starting any watchdog execution; once an execution is started, its zone and body are immutable. Once any worker first reaches a billable state, it is the campaign's only worker. Do not create a replacement after bootstrap failure, user-code failure, deletion, or any other billable start.

Before create, require zero campaign-labeled instances in `RUNNING`, `PROVISIONING`, `STAGING`, `STOPPING`, `SUSPENDING`, or `SUSPENDED`, and repeat the exact intended-name `404` checks immediately before the sole insert. Do not launch if the cumulative worst-case incremental cost can exceed USD 30. Never create Local SSD, snapshots, reusable images, reserved external addresses, load balancers, Cloud NAT, additional disks, or a second worker.

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

`conservative_all_in_hourly_rate` is the greater of the live applicable rate and the design-time on-demand rate. `fixed_incremental_cost` is the realized allocation within, not in addition to, the USD 5 non-runtime reserve. Reduce runtime when the bound rises. Never convert contingency or any incidental discount into more runtime.

Before every paid launch, append a pre-launch ledger record containing the 128-bit nonce, nonce-derived VM/disk names, intended-name absence receipts, sole insert requestId and expected operation identity, exact labels/description/tag, every other intended resource identity and resource-specific ownership proof, rate source and retrieval time, conservative hourly rate, fixed cost, authorized runtime interval, hard compute and artifact emergency deadlines, watchdog execution identity/revision/control-marker acknowledgements, worst-case incremental cost, cumulative worst-case cost, remaining authorized cost, and deletion allowance. Billing alerts are supplemental and are not spend caps.

Bound the non-runtime reserve:

- WebRTC egress: at most 10 GiB and USD 1.20, using Premium-tier India egress for the bound.
- Artifact retrieval: at most 10 GiB and USD 1.20.
- Seven-day storage and operations: USD 0.10.
- Logging, API usage, Workflows watchdog execution, and rounding: USD 1.00, of which at most USD 0.50 is allocated to the watchdog inside this line rather than added to it. Refuse launch when the live worst-case watchdog bound exceeds USD 0.50.
- Residual contingency: USD 1.50.

Disable verbose logging export. Count streaming bytes on the host and stop WebRTC when its 10 GiB quota is reached.

# 4. M2 Max to GCP compute, network, and artifact topology

The M2 Max performs editing, Git, `gcloud`, SSH/IAP, analysis, checksum verification, artifact retrieval, and native macOS WebRTC viewing only. Isaac Sim and GPU R1 simulation run on the single worker. Native CPU MuJoCo may run locally only when it installs without restructuring the workspace; otherwise keep simulation on the worker.

Before VM creation, create a dedicated temporary custom-mode VPC and subnet. Never attach the worker to the default network. Also create one globally unique, campaign-created regional bucket in `us-central1`; refuse a name collision and never reuse a prefix in an existing bucket. Establish its immutable containment identity from the unique successful create receipt, exact name, owning project number, `timeCreated`, location, campaign labels, verified initially empty all-versions listing, and create-ledger identity. Bucket metageneration and IAM etag are concurrency tokens, not immutable ownership identity: GET their current values immediately before a guarded mutation, but do not reject an otherwise valid bucket merely because authorized setup advanced either token. Because the bucket is new and disposable, enable uniform bucket-level access, disable versioning and soft delete, and install only the lifecycle rule defined below without touching any user bucket.

The following custom-role definitions are immutable operator-owned prerequisites. G0 must fetch each definition by its exact full resource name, require `stage=GA`, require the described permission set to match exactly with no additional permission, and record the normalized definition SHA-256 and audit receipt:

- `projects/project-1178f0de-10fb-4e7e-8e4/roles/reflectR1ArtifactCreator`: exactly `storage.objects.create` and `storage.objects.get`, with `get` used only to verify upload acknowledgement;
- `projects/project-1178f0de-10fb-4e7e-8e4/roles/reflectR1WatchdogMarkerCreator`: only `storage.objects.create`;
- `projects/project-1178f0de-10fb-4e7e-8e4/roles/reflectR1WatchdogCleanup`: exactly `storage.buckets.get`, `storage.buckets.getIamPolicy`, `storage.buckets.delete`, `storage.objects.get`, `storage.objects.list`, `storage.objects.update`, and `storage.objects.delete`;
- `projects/project-1178f0de-10fb-4e7e-8e4/roles/reflectR1BucketController`: exactly `storage.buckets.get`, `storage.buckets.getIamPolicy`, `storage.buckets.setIamPolicy`, `storage.buckets.update`, `storage.buckets.delete`, `storage.objects.get`, `storage.objects.list`, `storage.objects.update`, and `storage.objects.delete`.
- `projects/project-1178f0de-10fb-4e7e-8e4/roles/reflectR1BucketCreator`: only `storage.buckets.create`, pre-bound to the exact outside-controller principal at project scope as an audited operator prerequisite.

Conditions belong only to bucket policy bindings, never to role definitions. Use a dedicated worker service account. Bind `reflectR1ArtifactCreator` to it on the exact bucket with a unique condition title and the exact expression `resource.name.startsWith("projects/_/buckets/<bucket>/objects/run/<nonce>/artifacts/")`. Bind `reflectR1WatchdogMarkerCreator` to the watchdog service account with a unique title and `resource.name.startsWith("projects/_/buckets/<bucket>/objects/control/watchdog/<execution-id>/")`. Bind `reflectR1WatchdogCleanup` to that watchdog service account on the exact bucket without a prefix condition so its bucket and all-version cleanup permissions function. Bind `reflectR1BucketController` to the exact outside-controller principal on the exact bucket without a prefix condition. The controller's verified pre-existing project authority supplies bucket creation and the bootstrap ability to install its exact bucket-controller tuple. If that bootstrap would require a new project-wide binding, a broad Storage Admin grant, or authority outside the audited controller, return `BLOCKED_GCP_WATCHDOG` or use a separately authorized isolated operator project; never create such a grant during the campaign. The controller is the only campaign actor with `storage.buckets.setIamPolicy`; the watchdog never has it. The worker and marker creator always use `ifGenerationMatch=0`; neither can create in the other's namespace, and the worker's object `get` is restricted to acknowledgement checks inside its conditioned prefix while it cannot update, delete, configure, or administer the bucket.

Cloud Storage bucket `getIamPolicy` returns the direct bucket policy, not project, folder, or organization inheritance. Always request policy version 3. After the new bucket's create receipt, the controller uses a fresh etag to remove any unsafe automatically inserted direct convenience tuple, add its exact bucket-controller tuple, and freeze the resulting normalized direct policy as `BASE`. `ACTIVE=BASE` plus the exact worker-artifact, watchdog-marker, and watchdog-cleanup tuples. `SEALED=ACTIVE` minus the complete worker tuple and nothing else. Record the normalized direct-tuple hash for `BASE`, `ACTIVE`, and `SEALED`; use a fresh etag only as the `setIamPolicy` concurrency guard. Never claim to modify or preserve inherited entries through the direct bucket policy.

Separately, before installing `ACTIVE` and again before every accepted `ACTIVE`/`SEALED` read, inventory effective access inherited from project, folder, and organization, including groups, domains, service agents, basic roles, custom roles, IAM Conditions, deny policies, and principal access boundaries. Apart from the exact worker, watchdog, and outside-controller capabilities predeclared here, any direct or inherited principal able on this bucket to create/update/delete objects, delete/update the bucket, or get/set its IAM policy blocks launch or cleanup acceptance. Read-only access is reported but does not expand these mutation states. Inherited policy is preserved because the campaign cannot edit it through bucket IAM. If the controller's pre-existing bootstrap authority is inherited, it is the one explicitly permitted controller capability and must resolve to the same audited principal and no broader campaign actor. Use policy troubleshooting/effective-access evidence rather than treating a bucket `getIamPolicy` response as an inheritance audit.

After worker uploads stop and their acknowledgements are captured, the controller may transition `ACTIVE` to `SEALED` by a fresh policy-v3 GET, exact normalized direct-policy match, and removal of only the worker tuple with the fresh etag. The watchdog accepts only the exact direct-policy hash for `ACTIVE` or `SEALED` plus a passing fresh inherited-effective-access audit; no third direct state or extra mutating principal is accepted. The watchdog bindings have no expiry before verified bucket `404`; if the platform requires an expiry, it must be strictly later than the artifact emergency deadline plus the predeclared retry allowance. Never remove or expire marker creation, `storage.buckets.getIamPolicy`, hold clearing, object deletion, or bucket deletion before verified bucket `404`; deleting the bucket destroys all four campaign-created bucket binding tuples. The custom-role definitions, watchdog service account, and outside-controller identity remain operator-owned prerequisites and are never campaign cleanup targets.

Give the worker an ephemeral external IPv4 for outbound package, container, and asset downloads and optional native WebRTC. IAP supplies the SSH control path; it does not supply internet egress. Use OS Login and SSH only through IAP. Restrict TCP 22 ingress to `35.235.240.0/20`, target it only to the worker, audit effective firewall rules and service-account targeting, and treat any broad inherited ingress as gate failure.

Headless gates expose no application ports. During the short visual gate only, allow TCP 49100 and UDP 47998 from the M2 Max client's verified current `/32`, use host networking as required by the official native livestream path, meter bytes, and delete both rules immediately afterward. Never expose TCP 8210, noVNC, RDP, Jupyter, Docker, or any streaming service to `0.0.0.0/0`.

Before starting any container, create a campaign-owned artifact root on the worker boot disk, for example `/var/lib/reflect-r1/artifacts`, and bind-mount that same host root read/write into every campaign container at a declared path. Every experiment must write all non-recomputable output there; evidence left only in a container writable layer is invalid. Run the incremental uploader as a host service or outside-controller process that is independent of every experiment container and Compose project, so recreating or tearing down an experiment container cannot destroy or interrupt the only uploader.

Upload every non-recomputable payload at least every five minutes and after every checkpoint: immutable/final run payloads, sequence-numbered recoverable snapshots of active `.partial` state, manifests, `INDEX.json`, cost and ownership ledgers, diagnostic logs, checkpoint files, and measured datasets including the E5 rollout dataset. Before any container repair, recreation, or teardown, the outside uploader must flush closed files plus a recoverable `.partial` snapshot and issue an upload acknowledgement for each object. An acknowledgement exists only after an atomic create in the worker's exact artifact namespace with `ifGenerationMatch=0`, server checksum and size parity, a verified temporary hold, and recording of the exact bucket, object name, generation, metageneration, size, SHA-256, run nonce metadata, and creation-ledger identity in the ownership ledger. Never overwrite an object name or treat a label or prefix as object ownership. The held watchdog control markers are included in the same all-versions inventory, 10 GiB bound, and 1,000-generation ceiling. Stop artifact production before exceeding that bound.

The latest-two rule applies only to ordinary rolling checkpoints that are not otherwise retained. Exempt every frozen, selected, evaluated, or immutable-manifest/`INDEX.json`-referenced checkpoint from pruning until its verified local recovery; a hash without the checkpoint is not recovery. If the retained set would exceed the 10 GiB cumulative uncompressed cap, stop creating new artifacts and return a precise budget/data status rather than deleting an exempt checkpoint. Upload and recover all other non-recomputable run payloads and datasets incrementally; do not trade them away to preserve extra checkpoint breadth.

Configure the new bucket with a delete lifecycle based on `daysSinceCustomTime=7`, not object age. New generations have no Custom-Time and remain under temporary hold, so irreversible cloud expiry cannot begin before recovery. The M2 Max controller retrieves each generation, verifies its SHA-256 against both the host manifest and object acknowledgement, and records a local-recovery acknowledgement. Only then, using generation and metageneration preconditions, release that generation's temporary hold and set its Custom-Time to the recovery-acknowledgement time. This starts the seven-day lifecycle clock. The controller may generation-conditionally delete the recovered cloud copy during final cleanup; lifecycle is only a secondary fallback.

At the artifact emergency deadline, the watchdog independently validates the bucket's immutable containment identity, requires the freshly normalized direct policy-v3 hash to match exactly `ACTIVE` or `SEALED`, and repeats the inherited effective-access admission audit; a matching `404` after the captured create receipt is an already-deleted result. An extant same-name bucket with a different project number, `timeCreated`, location, labels, accepted direct policy, or permitted effective mutator set is an ownership mismatch. The current metageneration and policy-v3 etag are captured only as guarded-mutation concurrency tokens. Refuse to widen cleanup if the all-versions listing exceeds the enforced 1,000-generation bound. For each listed post-start generation, including every control marker, capture exact bucket/name/generation/metageneration, CRC32C, and custom run metadata in workflow state. The containment proof authorizes emergency handling of a post-start generation even when an interrupted uploader omitted it from its outside ledger. Release any temporary hold with generation and metageneration preconditions, then delete with a generation-match precondition. Verify an empty all-versions listing, freshly GET the bucket, revalidate its immutable identity, direct policy, and effective-access audit, and delete the exact bucket with the current metageneration precondition. Bucket deletion removes its still-live bucket-scoped campaign bindings. At this deadline the USD 30 ceiling and bounded-resource rule outrank artifact retention: if local recovery is incomplete, write the final pre-deletion control marker when possible, then conditionally delete rather than retain held objects or a bucket indefinitely. The workflow is capped at 20,000 internal steps and the bucket at 1,000 generations; any live worst-case bound that violates either cap blocks launch. The single watchdog execution then completes naturally. Execution-history expiry is provider-owned; it does not authorize a campaign Scheduler, Cloud Task, workflow definition, workflow service account, or other persistent watchdog resource.

At `22h30m`, stop starting new experimental work, terminate training/rollout processes cleanly, finalize what can be finalized, snapshot remaining `.partial` state, and let the independent uploader flush and acknowledge durable state. Do not stop, suspend, or shut down the worker. After the M2 Max verifies local/object hashes and records one complete artifact acknowledgement, the outside controller calls the Compute Engine delete API for the VM and waits for the VM and auto-delete boot disk to be `DELETED`. If acknowledgement is not ready, keep only bounded recovery/upload work running until the hard compute deadline; the armed watchdog still deletes at that time because the USD 30 ceiling outranks evidence preservation.

Every normal, failed-create, and early-exit path uses the same ownership-checked cleanup. Use the ownership proof that the resource API actually supports; never require a label where that API has none:

- VM and disk: exact project, zone, nonce-derived name, server-assigned numeric ID, creation time, required nonce labels/description/tag where supported, and the sole DONE insert operation's requestId/clientOperationId/targetId/targetLink plus ledger identity;
- VPC, subnet, and firewall rule: exact project/location/selfLink/name and server-assigned numeric ID where exposed, create-operation/ledger identity, dependency links, run nonce in the description, and exact binding to a pre-provisioned operator-owned Resource Manager tag rather than an unsupported standard label; do not create or delete the tag key/value;
- service account: exact email and server-assigned `uniqueId`;
- IAM binding: exact normalized direct-policy role/member/condition-title/expression tuple against a freshly read policy-v3 etag; permit only the declared `BASE` to `ACTIVE` to `SEALED` transitions, preserve every unaffected direct tuple, audit inherited effective access separately, and never claim that direct-policy writes preserve inherited entries; etag is a concurrency token, not identity;
- bucket: exact globally unique name, owning project number, create receipt, campaign labels, `timeCreated`, location, initially empty all-versions listing, exact direct-policy `BASE`/`ACTIVE`/`SEALED` normalized hash, passing inherited-effective-access audit, and create-ledger identity; current metageneration is only a mutation/delete precondition;
- object: exact bucket, name, generation, metageneration, CRC32C, custom run metadata, and creation-ledger identity when available, with generation and metageneration preconditions for metadata mutation and deletion; at the artifact emergency deadline only, the exact bucket containment proof plus a captured post-start generation identity replaces a missing uploader-ledger entry;
- watchdog execution: exact execution name, workflow revision, nonce, immutable input including insert requestId and expected IAM states, both deadlines, and generation/checksum/metadata-verified control markers.

Before each mutation, GET and match every immutable identity field, exact accepted direct-policy state, and required inherited-effective-access result, then use the freshly returned concurrency token. A mismatch fails closed, records the precise blocker, and never authorizes a broader search or target; the controller and watchdog can still clean independently owned resources whose proofs match. The normal controller performs this sequence as early as possible: delete optional streaming firewall rules; delete the VM and auto-delete boot disk; delete remaining campaign firewall rules, subnet, and VPC; stop uploads and make the guarded `ACTIVE` to `SEALED` transition; clear holds and generation-conditionally delete every artifact and control-marker generation; verify an empty all-versions listing; delete the exact bucket with its fresh metageneration and verify bucket `404`; only then delete the worker service account. Do not remove individual bucket tuples during cleanup: verified bucket deletion destroys the worker, watchdog-marker, watchdog-cleanup, and controller bindings together. A controller interrupted while the bucket is `ACTIVE` or `SEALED` leaves the watchdog fully authorized to finish emergency cleanup. The armed watchdog independently guarantees VM/disk deletion at the compute deadline and object/bucket deletion at the artifact emergency deadline; a resumed controller reconciles any non-billable survivors using the same proofs. Remove any other campaign-created disposable resource at its dependency-correct point and record create/delete timestamps and API outcomes. Operator-owned custom-role definitions and their pre-existing BucketCreator binding are not campaign cleanup targets. Docker/container state is deleted with the boot disk. Never report completion while a disposable resource outcome is merely stopped, suspended, absent from one incomplete listing, pending, or an undefined "final state."

Normal early cleanup may request cancellation of the exact watchdog execution only after independent GETs and complete listings prove the captured VM, boot disk, every bucket generation, and bucket are all `404` or absent. If that absence proof is incomplete, never cancel or weaken the execution; let it reach both immutable deadlines. A terminal `SUCCEEDED`, or `CANCELLED` only when paired with the recorded pre-cancel all-four absence proof, is valid. This permits overnight completion after fully successful early cleanup without waiting for the seven-day artifact deadline.

Never stop, delete, relabel, resize, attach to, or otherwise modify an existing user resource. Labels may supplement ownership only on supported resource types and must never be applied to pre-existing resources. The operator-owned workflow definition and execution service account are prerequisites, not campaign cleanup targets; no campaign-created Scheduler, Task, workflow definition, workflow service account, or equivalent watchdog resource may remain.

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
- `SCREEN_DIAGNOSTIC_REJECT_NO_CONFIRM`: real SCREEN execution completed; at least one challenger had posterior-predictive probability of final `GO` at or above 0.10, but every predictive survivor failed at least one predeclared non-safety mechanism or Pareto diagnostic; no CONFIRM data was opened; and the incumbent was retained. Record `implementation_status=PASS` and `scientific_status=SCREEN_DIAGNOSTIC_REJECT_NO_CONFIRM`. This is an operational/diagnostic disposition only and supports no efficacy, inferiority, equivalence, or CONFIRM-level `FUTILE` or `INCONCLUSIVE` claim.
- `SAFETY_DISQUALIFIED`: a declared safety event removes control authority.
- `CODE_ONLY`: implementation exists but qualifying execution does not.
- `TEST_ONLY`: only mechanical/unit-test evidence exists.
- `SYNTHETIC_ONLY`: evidence comes only from synthetic fixtures or synthetic outputs.
- `RUN_FAILED`: an attempted real run failed outside a more precise blocker.
- `BLOCKED_GCP_AUTH`: required GCP authentication or authorization is absent.
- `BLOCKED_GCP_WATCHDOG`: the pre-provisioned shared watchdog or execution service account is absent, unauthorized, over-privileged, revision-mismatched, or failed to produce the required ready/armed acknowledgement; no experimental paid work may proceed.
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
4. Inventory all existing project resources read-only. Prove no campaign-labeled instance is `RUNNING`, `PROVISIONING`, `STAGING`, `STOPPING`, `SUSPENDING`, or `SUSPENDED`; do not alter any resource. Verify the pre-provisioned shared watchdog definition, immutable revision/source hash, operator-owned execution service account, absence of user-managed keys or non-Workflows impersonators, bounded compute GET/list/delete permissions, absence of custom-log permission, exact five role-definition names/stages/permission hashes, existing controller BucketCreator and safe bootstrap authority, exact Storage permissions to be bucket-bound, pre-provisioned ownership tag, authorized invoke/cancel principals, 20,000-step limit, and ability to accept the exact intended resource scope. Verify that no new project-wide binding or broad Storage Admin grant is needed. If any prerequisite is unavailable, return `BLOCKED_GCP_WATCHDOG` without starting its execution or creating campaign resources.
5. Generate the 128-bit nonce first; derive unique VM/disk names; precompute the sole UUID insert requestId and exact labels/description/tag; and require read-only exact-name VM and disk GETs to return `404`. Render and archive the exact Compute v1 REST URL, byte-exact JSON request body and hash, specific resolved Ubuntu 24.04 image, Standard scheduling fields, authorization-header handling, expected insert-operation identity/polling contract, immutable RFC3339 hard compute deadline no later than VM create plus `23h45m`, later artifact emergency deadline, watchdog execution/control-marker contract, network, subnet, ephemeral IP, service account, exact direct-policy `BASE`/`ACTIVE`/`SEALED` hashes and separate inherited-effective-access audit, firewall, resource-specific ownership proofs, startup, host artifact bind mount, unique regional bucket, and ownership-checked deletion specification before executing it. Assert requestId occurs only in the URL query, the body has exactly one 150 GiB `pd-balanced` auto-delete boot disk, and the rendered contract has no Spot, `maxRunDuration`, legacy `preemptible`, restart-relative fuse, stop, or suspend path.
6. Audit effective ingress, including inherited hierarchical and VPC rules. Any broad ingress that reaches the proposed worker blocks create.
7. Pin and verify all source SHAs, image tags, expected digests when known, and software targets. Pin Unitree at `1425b15f73bd4095f0df53709d7c389c3eb9e790`; record newer heads separately.
8. Inventory the pinned Unitree `get_spec()` and loader mutations and complete the source-derived R1 motor mapping/limits/gains/action-normalization audit.
9. Preserve `PHYSICAL_DEPLOYMENT_ALLOWED=false` and verify deployment-interface guards fail closed for non-loopback names and addresses.
10. Create the cost ledger and unique regional campaign-bucket plan, including bucket-empty/name-collision checks, immutable bucket identity versus fresh concurrency tokens, exact direct-policy `BASE`/`ACTIVE`/`SEALED` hashes, fresh inherited-effective-access evidence, the controller-only `setIamPolicy` bootstrap, disjoint conditioned artifact/control-marker namespaces, the 1,000-generation ceiling, object-generation ownership, temporary holds, Custom-Time lifecycle, quotas, host bind mount, independent uploader, upload/local-recovery acknowledgements, both watchdog deadlines, and resource-specific cleanup ownership.
11. Compute worst-case spend with the greater live/design rates, fixed allocations, reserve, contingency, and deletion allowance. Refuse creation unless the result is below USD 30.

G0 `PASS` requires recorded outputs and exit codes for every check, a complete pre-launch ledger entry, safe mapping disposition, a verified watchdog prerequisite, and a fully rendered create specification. Missing auth, watchdog, or quota receives the precise blocker. G0 never starts the watchdog execution, creates a campaign resource, or probes physical hardware.

# G1. Generic headless Isaac Sim/Isaac Lab baseline

After G0 passes, create only the rendered non-worker prerequisites and record their ownership proofs. Bootstrap the new bucket from its exact fresh direct policy to `BASE`, then `ACTIVE`, using policy-v3 etags and prove the separate inherited-effective-access admission check. Immediately before starting the watchdog, repeat the outside-controller exact-name VM/disk `404` checks. Start the one exact execution with immutable input; verify its exact `ACTIVE` direct-policy hash and effective-access audit; require the workflow's independent absence checks and generation/checksum/metadata-verified `ARMED_PRECREATE` control marker; repeat exact-name `404` checks; and only then issue the sole requestId-bound Compute v1 REST insert. After the sole worker becomes billable, keep bootstrap paused until the verified `ARMED_COMPUTE` marker; then:

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

For every SCREEN candidate, compute the predictive probability that a fresh 12-block confirmation panel will meet final success, using the Dirichlet-multinomial distribution. Simulated CONFIRM panels must be analyzed from the original Jeffreys prior, not the SCREEN posterior. Drop a candidate when that predictive chance is below 0.10. Apply declared safety eliminations separately as `SAFETY_DISQUALIFIED`. Among candidates with predictive chance at or above 0.10 and no safety elimination, apply every predeclared non-safety mechanism and Pareto diagnostic, then select exactly one eligible challenger per predeclared incumbent by expected `Delta`.

If every challenger has predictive chance below 0.10, do not open CONFIRM, retain the incumbent, report `SCREEN_FUTILE_NO_CONFIRM`, and return the saved confirmation budget to adaptive selection. If at least one challenger has predictive chance at or above 0.10 but every predictive survivor fails at least one predeclared non-safety mechanism/Pareto diagnostic, do not open CONFIRM, retain the incumbent, and report `SCREEN_DIAGNOSTIC_REJECT_NO_CONFIRM`. If safety elimination leaves no eligible challenger, do not open CONFIRM, retain the incumbent, and preserve each eliminated challenger's `SAFETY_DISQUALIFIED` status rather than relabelling it as either SCREEN no-confirm status. SCREEN probabilities and every no-confirm disposition are operational only and make no efficacy, inferiority, equivalence, or CONFIRM-level `FUTILE` or `INCONCLUSIVE` claim.

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

Predeclare the incumbent, normally A, before SCREEN. Apply a seeded lateral object displacement during reach/push and, according to the fixed perturbation suite, goal change and proposal delay. The primary binary endpoint is recovery from the seeded perturbation within the fixed predeclared deadline. Use ordinary `MES = 1/6`. When at least one eligible challenger survives the common predictive, safety, mechanism, and Pareto routing, select and freeze exactly one and compare it with the incumbent on CONFIRM; otherwise retain A and use the exact applicable `SCREEN_FUTILE_NO_CONFIRM`, `SCREEN_DIAGNOSTIC_REJECT_NO_CONFIRM`, or `SAFETY_DISQUALIFIED` disposition defined above.

Enforce: expired chunks never execute; older-observation chunks never replace newer chunks; dimensions match the verified R1 action interface; values are finite; targets are clamped to configured limits; a valid safe hold always exists; queues are bounded; and policy failure cannot emit stale actions indefinitely.

Record task success, object-goal final error, perturbation recovery/deadline, observation-to-action age, chunk age, proposal latency, executor idle time, expired-action count, replacement count, target-joint discontinuity, action jerk proxy, safety rejections, and rollout duration. Action age, discontinuity, and jerk are directional/Pareto diagnostics, not additional inferential tests; require the prespecified direction and no limit-violating Pareto regression.

If CONFIRM opens and the contrast does not reach `PILOT_SUCCESS`, report its exact `FUTILE` or `INCONCLUSIVE` result; any simplest Pareto-safe engineering fallback does not relabel that result. If no challenger is eligible after SCREEN, retain the incumbent and report the exact applicable no-confirm or safety disposition from the common routing. Selection must be measured, never intuitive.

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

Freeze recovery-rule candidates from DEV and SCREEN them on paired blocks. When a challenger is eligible under the common predictive, safety, mechanism, and Pareto routing, freeze exactly one and confirm it against the predeclared incumbent; otherwise retain the incumbent and report the exact applicable no-confirm or safety disposition. A stochastic block succeeds only when it makes the correct recovery decision and then recovers within the fixed deadline. Use ordinary `MES = 1/6`.

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

When a persistent-memory challenger is eligible under the common predictive, safety, mechanism, and Pareto routing, freeze exactly one and confirm it against M0; otherwise retain M0 and report the exact applicable no-confirm or safety disposition. A block succeeds only when the correct-object mission completes without a stale-memory action. Use ordinary `MES = 1/6`.

Record mission success, wrong-object actions, stale-memory actions, unnecessary observations, semantic replans, tool calls, movement recovery, and agent latency. Any wrong-object safety consequence is `SAFETY_DISQUALIFIED`; other wrong-object/stale actions remain failure and authority diagnostics.

# E4. Specialist RL pushing skill

Question: does a specialist contact skill outperform the scripted/general reactive policy while preserving the hierarchy?

Reuse the selected engine's Unitree asset, actuator configuration, task conventions, and the repository's current RSL-RL/PPO stack. Do not write a new PPO implementation. The policy consumes R1 joint state, base orientation/angular velocity, hand-object relative pose, object-goal relative pose, and previous action as available. It outputs controller-compatible position or residual-position targets, never raw torque as the high-level interface.

Log each reward term separately: object progress toward goal, successful contact, final object-goal accuracy, upright/stability, smooth action, joint-limit penalty, excessive velocity penalty, excessive effort proxy, fall termination, and completion bonus.

Keep `supported/fixed-base skill smoke` and `free-base or standing-substrate skill` distinct. Randomize narrowly over object pose/mass/friction, table friction, joint-target tracking error, action delay, external base perturbation, and object geometry scale. Predeclare nominal, training, and disjoint held-out ranges with a justification.

Use three independent training seeds as an engineering collapse gate, not a population claim. Checkpoint at geometric fractions of each fixed step budget. Before one quarter of a seed's budget, stop only for numerical instability or reset failure. At or after one quarter, stop a seed only after two successive checkpoints show no positive paired progress and the progress slope remains non-positive. Two collapsed or unsafe seeds make the specialist `FUTILE`; one good seed is seed-sensitive and does not pass the engineering gate.

Validate real reset/step first, then train. Select and freeze exactly one checkpoint using DEV and SCREEN only when a specialist challenger is eligible under the common predictive, safety, mechanism, and Pareto routing. On CONFIRM compare that frozen specialist against the frozen scripted incumbent using complexity-heavy `MES = 1/4`; if none is eligible, retain the scripted incumbent and report the exact applicable no-confirm or safety disposition. The posterior is conditional on that policy and does not establish population-level PPO stability.

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

SCREEN learned candidates against WM0. When a candidate is eligible under the common predictive, safety, mechanism, and Pareto routing, select exactly one and confirm it against WM0 using ordinary `MES = 1/6`; otherwise retain WM0 and report the exact applicable no-confirm or safety disposition. Also report Spearman ranking correlation, normalized selection regret, future-state/progress error, success calibration, failure precision/recall, uncertainty-versus-error, held-out results, inference latency, and memory. These are authority diagnostics, not separate efficacy tests.

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

SCREEN runnable A–I variants on 11 blocks. When a complete-stack challenger is eligible under the common predictive, safety, mechanism, and Pareto routing, freeze exactly one and confirm it against A or the predeclared incumbent on 12 fresh blocks using complexity-heavy `MES = 1/4`; otherwise retain the predeclared incumbent and report the exact applicable no-confirm or safety disposition. Adjacent component effects and combined 23-block summaries are exploratory only.

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
- cloud create-spec invariants including the 128-bit nonce, nonce-derived unique names, dual pre-create `404` checks, one Compute v1 REST insert URL with query-only requestId, exact rendered JSON/hash, Standard scheduling, one tagged 150 GiB `pd-balanced` auto-delete Ubuntu 24.04 boot disk, exact network/service-account/metadata/tag fields, identical response-loss retry, `operationType=insert`, operation identity and `DONE` without error, persisted tag bindings, hard compute and artifact emergency deadlines, forbidden Spot/`maxRunDuration`/legacy `preemptible`, held create-only GCS control markers, exact five operator-owned role hashes, object creator/get acknowledgement scope, explicit watchdog `storage.buckets.getIamPolicy`, controller-only `setIamPolicy`, direct-policy-v3 `BASE`/`ACTIVE`/`SEALED` transitions and inherited-effective-access admission, immutable bucket identity versus fresh concurrency tokens, disjoint writer namespaces, identity-sensitive post-capture `404`, stopped-VM deletion, idempotent delete request IDs, LRO waits, disk-user check, 1,000-generation/20,000-step/USD-0.50 bounds, cost arithmetic, single-worker fuse, allowed firewall sources/ports, resource-specific ownership proofs, fail-closed precondition mismatches, dependency-ordered cleanup, and safe execution cancellation without paid mutation.

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

- no unintended billable resource remains and every campaign-created disposable resource has an ownership-checked `DELETED` outcome, including VM, boot disk, firewall rules, subnet, VPC, bucket-scoped IAM bindings through bucket deletion, worker service account, object generations, and bucket; operator-owned custom-role definitions, BucketCreator binding, watchdog service account, controller identity, tag, and workflow are verified prerequisites rather than campaign-created resources;
- the single watchdog execution is terminal `SUCCEEDED`, or is terminal `CANCELLED` only after a recorded independent proof that the captured VM, boot disk, every bucket generation, and bucket were already `404` or absent; no campaign-created Scheduler, Cloud Task, workflow definition, workflow service account, tag key/value, or equivalent persistent watchdog component exists, while provider-owned execution history is reported rather than treated as a campaign resource;
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
