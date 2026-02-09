---
name: Create
description: Tạo prefab/UI/scene/VFX tự động qua editor script
trigger: /create
---

## create request

goal:
- Create new Unity assets automatically (prefab / UI prefab / scene / VFX prefab / other assets)
- Asset-first workflow with run-once automation
- If relevant scripts already exist (explicitly provided/approved), integrate by adding scripts and applying only related parts

input:
- create target:
  (ui | prefab | scene | vfx | other-asset)
- reference (required):
  - UI: UI Tree Layout (preferred) OR screenshot/image
  - Prefab: purpose + components + hierarchy spec
  - Scene: scene flow + key objects + transitions
  - VFX: effect description + reference image/video + constraints
- constraints (optional):
  (mobile, TMP-only, DOTween usage, performance rules)
- output folder (optional):
  default: Assets/Created/<Target>/
- naming (optional):
  prefab/asset base name
- existing scripts in scope (optional):
  - provide file(s) OR explicitly name script(s) to be edited
  - recommended: include CREATE markers for safe patching

rules:
- Create = create NEW assets/prefabs/scenes/VFX only
- By default:
  - do NOT modify existing assets
  - do NOT modify existing scripts
- Allowed existing modifications ONLY when explicitly in scope:
  - user provides the script file(s), OR
  - user explicitly names the script(s) and confirms they are in scope
- Do NOT invent project-specific paths, packages, settings; if unknown → "cannot verify"
- Avoid Awake unless strictly required; Awake is for caching references only
- DOTween timing/feel must not be changed unless explicitly requested

output:
- Always return:
  1) Create specification (normalized)
  2) Final layout/spec (UI Tree Layout or normalized asset spec)
  3) Temp Editor Script code (run-once, self-delete)
  4) Build/Run instructions
  5) Validation checklist
  6) Assumptions / Cannot verify (if any)


======================AUTO EDITOR SCRIPT (MANDATORY)======================

## Auto Editor Script rule (run once + self delete)

- When `/create` is invoked, generate a TEMP Unity Editor Script.
- The temp Editor Script MUST:
  - Auto-run exactly once (run-once guard)
  - Create the requested asset(s)
  - Save to the output folder
  - Self-delete after completion

run-once guarantee:
- Use EditorPrefs (or marker file) with a unique key per request
- Use EditorApplication.delayCall to run after compilation/domain reload

failure safety:
- Must NOT loop re-running on failure
- On failure:
  - log ONE error
  - keep run-once guard set to prevent reruns
  - proceed to self-delete unless user explicitly requests to keep for debugging


======================EXISTING SCRIPTS INTEGRATION (OPTIONAL)======================

## Existing scripts integration rule (add scripts + apply related parts)

If relevant scripts already exist AND are explicitly in scope, `/create` MUST integrate by:
- Adding required scripts/components to the newly created prefab (AddComponent)
- Applying minimal, related changes ONLY to the specified script files

scope limits:
- Allowed to edit scripts ONLY when:
  1) The user provides the script file(s), OR
  2) The user explicitly names the script(s) and confirms they are in scope
- Never edit scripts outside that scope

allowed changes (related parts only):
- Add serialized fields/references needed by the created prefab
- Add minimal binding APIs (e.g., Init/Bind/SetData/Show/Hide) ONLY if required
- Add event subscribe/unsubscribe for the asset (prefer OnEnable/OnDisable)
- Add registration or instantiation hooks directly required for the new asset

not allowed by default:
- Refactor unrelated code
- Change gameplay/business logic
- Rename public APIs or serialized fields
- Move lifecycle responsibilities across Awake/Start/OnEnable unless explicitly requested
- Change DOTween timing/sequence/feel unless explicitly requested

apply mechanism:
- When script edits are required, the temp Editor Script MAY also patch scripts, but only if safe.

marker rule (recommended for safe auto-apply):
- Scripts SHOULD contain markers:
  - // CREATE:BEGIN <FeatureName>
  - // CREATE:END <FeatureName>
- If markers exist:
  - Replace content INSIDE markers only
- If markers do NOT exist:
  - Do NOT patch automatically
  - Output "Manual patch steps" instead

safety rules:
- Never guess file paths
- Never patch scripts not provided/approved
- If insertion point cannot be verified → "cannot verify" and provide manual steps


======================CREATE TARGETS======================

## Supported create targets

- UI
  - Create UI prefab/hierarchy from UI Tree Layout (or from screenshot)
- Prefab
  - Create prefab structure and components from spec
- Scene
  - Create a new scene structure from spec
- VFX
  - Create VFX prefab/asset structure from spec
- Other-asset
  - Any asset that can be generated in Editor via script


======================WORKFLOW: CREATE (GENERAL)======================

## Step 1 – Validate target & reference
- Validate create target exists
- Validate reference matches target requirements
- If reference is invalid or incomplete → request minimum missing input

UI special case:
- If input is NOT a valid UI Tree Layout → request screenshot/image
- Do not proceed to asset creation until a valid layout exists

UI Tree Layout validation:
- must include a root node
- must be hierarchical (indent tree)
- each node must include at least: name + type
- if missing → invalid layout


## Step 2 – Create specification (source of truth)
Output a normalized spec that will drive asset creation:

- Target:
- Asset name(s):
- Output folder:
- Constraints:
- Existing scripts in scope (if any):
- Assumptions / Cannot verify:

UI:
- Final UI Tree Layout (normalized or generated from image)

Prefab/Scene/VFX:
- Final hierarchy/graph spec (normalized)

### Create-after-add rule (plan-driven prefab creation)

- The `/create` workflow MAY be invoked after `/add` to materialize assets that were already defined in the plan/spec.
- If the plan already includes a prefab (name + purpose) AND a UI Tree Layout was previously presented for it:
  - `/create` MUST automatically create that prefab using the previously presented UI Tree Layout as the source of truth
  - Do NOT request the UI Tree Layout again unless it is missing or invalid
  - If the layout is not available in the current context → request it (or request an image)

Rules:
- Do NOT change the previously agreed layout structure unless explicitly requested
- If any part of the plan is ambiguous → state "cannot verify" and request minimum missing info


### UI Raycast Target auto-disable rule

- When creating UI prefabs from UI Tree Layout, automatically disable Raycast Target
  for UI elements that are not intended to receive clicks.

Applies to:
- UnityEngine.UI.Image.raycastTarget = false
- TextMeshProUGUI.raycastTarget = false
- RawImage.raycastTarget = false
- Other purely visual Graphics (if present)

Exceptions (keep raycastTarget = true):
- Buttons (and their target Graphic, if used)
- Toggles, Sliders, Scrollbars, InputFields, Dropdowns
- Any element explicitly marked as clickable in the UI Tree Layout notes:
  - notes contains: "click", "tap", "button", "interactive", "draggable", "scroll"
- Elements that must block clicks behind them (explicitly marked):
  - notes contains: "block raycast", "modal blocker"

Default behavior:
- If node role is unknown and not marked interactive → set raycastTarget = false

Validation:
- Ensure interactive controls still receive clicks
- Ensure non-interactive visuals do not consume pointer events


## Step 3 – Generate (or normalize) UI Tree Layout (UI only)
If user provided a valid layout:
- normalize naming and node structure
- keep minimal and scannable

If user provided an image:
- reconstruct a new UI Tree Layout from screenshot
- include hierarchy + key components + layout groups + notes
- include "Assumptions / Cannot verify" for inferred parts

Then:
- Suggest user to build/create using the newly generated layout as source of truth


## Step 4 – Generate temporary Editor Script (mandatory)
- Folder: Assets/Editor/__CreateTemp__/
- Script name: Create_<Target>_<UniqueId>.cs
- Script contains:
  - run-once guard (EditorPrefs key = "CREATE_RUN_ONCE__<UniqueId>")
  - creation logic for the target asset(s)
  - save assets (PrefabUtility / AssetDatabase / scene save)
  - optional: add components/scripts to the created prefab
  - optional: patch specified scripts ONLY if safe (markers required)
  - self-delete (AssetDatabase.DeleteAsset)
  - AssetDatabase.Refresh()


## Step 5 – Auto-run once
- After compilation/domain reload, script runs once:
  - creates assets
  - logs success once
- On failure:
  - logs one error
  - does not re-run again (guard is already set)


## Step 6 – Self-delete temp editor script
- After completion:
  - delete the temp script
  - refresh AssetDatabase
- Optional:
  - delete temp folder if empty (only if safe/implemented)


## Step 7 – Validation checklist (must include)
- Assets created in correct folder
- Prefab opens without missing required references
- UI anchors/layout groups behave correctly (UI)
- No temp editor script remains
- No repeated execution on editor reload
- Play mode smoke test (if applicable)


======================UI MODULE (INSIDE CREATE)======================

## UI Tree Layout format

minimal per node:
- name
- type: (RectTransform/Image/Button/TextMeshProUGUI/CanvasGroup/RawImage/...)
- anchors: (preset or min/max)
- layout: (Vertical/Horizontal/Grid/ContentSizeFitter/none)
- notes: intent/state

UI rules:
- Use TextMeshProUGUI for all UI text
- Do not introduce legacy UnityEngine.UI.Text
- DOTween allowed for UI transitions ONLY if explicitly requested
- Avoid Awake unless strictly required; Awake for caching only
- Subscribe in OnEnable, unsubscribe in OnDisable
- No runtime Find calls
- No allocations in Update, no LINQ in hot paths


======================TEMP EDITOR SCRIPT TEMPLATE======================

## Template: run once + self delete (skeleton)

- Must replace:
  - <UNIQUE_ID>
  - <SCRIPT_ASSET_PATH>
  - creation logic per target

```csharp
#if UNITY_EDITOR
using System.IO;
using UnityEditor;
using UnityEngine;

public static class __CreateTempRunner__
{
    private const string RunKey = "CREATE_RUN_ONCE__<UNIQUE_ID>";
    private const string ThisScriptPath = "<SCRIPT_ASSET_PATH>";

    [InitializeOnLoadMethod]
    private static void RunOnce()
    {
        if (EditorPrefs.GetBool(RunKey, false))
            return;

        EditorPrefs.SetBool(RunKey, true);

        EditorApplication.delayCall += () =>
        {
            try
            {
                // -------------------------
                // Create logic (prefab/scene/vfx/ui)
                // -------------------------
                // 1) Create GameObjects
                // 2) Add Components
                // 3) Save Asset(s)
                // 4) Optional: Patch approved scripts inside CREATE markers only
                // -------------------------

                Debug.Log("[Create] Done.");
            }
            catch (System.Exception ex)
            {
                Debug.LogError("[Create] Failed: " + ex.Message);
                // Guard prevents rerun; do not throw
            }
            finally
            {
                EditorApplication.delayCall += SelfDelete;
            }
        };
    }

    private static void SelfDelete()
    {
        AssetDatabase.DeleteAsset(ThisScriptPath);
        AssetDatabase.Refresh();
        Debug.Log("[Create] Temp editor script deleted.");
    }
}
#endif