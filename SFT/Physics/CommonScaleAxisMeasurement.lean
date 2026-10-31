import SFT.Physics.CommonScaleAxisCertificate
import SFT.Host.SHA256Chunks
import SFT.Physics.RunningConvergenceValidation
namespace SFT.Physics.CommonScaleAxisMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
def sourceBindings : List (String × String × String) := [("PDG-2026-ELECTROWEAK-SCALE-VECTOR","experiments/external_sources/physics/snapshots/pdg-2026-electroweak-model.pdf","sha256:a102f6252b7190dc423200271dffa7c805cd15a50391b1c578853d2f777611cb"),("PDG-2025-2026-STRONG-EM-COMPLETE-RUNNING-VECTOR","experiments/external_sources/physics/snapshots/coupling-running-convergence-source-record.json","sha256:b83331089d96c073fbd5101753ba5c4716ae1a8b1b891e068684b6f7246d9953")]
def inheritedBindings : List (String × String × String) := [("SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006","claims/SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006/certificate.json","sha256:f598cd663a76f8137cf2e40c5e8154083b8196ec399751da8577ce9769f688d6"),("SFT-PHYS-VALIDATION-ELECTROWEAK-TERMINAL-003","claims/SFT-PHYS-VALIDATION-ELECTROWEAK-TERMINAL-003/certificate.json","sha256:3d93670205eb78e5f45da65574c011beb64a142bdf07cd36a2f09f97f8c93980"),("SFT-PHYS-VALIDATION-PROTON-PLANCK-TERMINAL-003","claims/SFT-PHYS-VALIDATION-PROTON-PLANCK-TERMINAL-003/certificate.json","sha256:41ac74e37c135774d5c8b384c5fcf5aae5415c21c2a63b3d77c5a5d2981ed651")]
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/common-scale-axis-source-record.json","sha256:157f5a0e4c74b26065747d354c1f942740831524618ab21b6b44bdc672d6325f"),("experiments/external_sources/physics/snapshots/pdg-2026-electroweak-model.pdf","sha256:a102f6252b7190dc423200271dffa7c805cd15a50391b1c578853d2f777611cb"),("experiments/external_sources/physics/snapshots/coupling-running-convergence-source-record.json","sha256:b83331089d96c073fbd5101753ba5c4716ae1a8b1b891e068684b6f7246d9953"),("claims/SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006/certificate.json","sha256:f598cd663a76f8137cf2e40c5e8154083b8196ec399751da8577ce9769f688d6"),("claims/SFT-PHYS-VALIDATION-ELECTROWEAK-TERMINAL-003/certificate.json","sha256:3d93670205eb78e5f45da65574c011beb64a142bdf07cd36a2f09f97f8c93980"),("claims/SFT-PHYS-VALIDATION-PROTON-PLANCK-TERMINAL-003/certificate.json","sha256:41ac74e37c135774d5c8b384c5fcf5aae5415c21c2a63b3d77c5a5d2981ed651")]
def sourceIds : List String := ["PDG-2026-ELECTROWEAK-SCALE-VECTOR","PDG-2025-2026-STRONG-EM-COMPLETE-RUNNING-VECTOR"]
def targetIds : List String := ["WITHHELD-COMMON-SCALE-AND-COUPLING-COMPLETE-VECTOR"]
def falsification : String := "Reject if any source or inherited receipt identity changes; if the terminal on-shell prediction leaves the registered on-shell interval; if the registered sub-W low-transfer direction is reversed; if the NuTeV adverse row, scheme distinctions, W-threshold sign change, strong/EM complete vectors or proton-Planck scale receipt are omitted; if a measured value selects a rung or law; or if target access precedes the seal."

def get (v : Value) (key : String) (fallback : Value := .null) : Value :=
 match v with
 | .object fs => (CapabilityDocuments.field key fs).getD fallback
 | .text _ | .integer _ | .boolean _ | .null | .array _ => fallback

def isTrue (v : Value) : Bool := sameValue v (.boolean true)
def isFalse (v : Value) : Bool := sameValue v (.boolean false)
def objectFields (v : Value) : Except String (List (String × Value)) :=
 match v with
 | .object fs => .ok fs
 | .text _ | .integer _ | .boolean _ | .null | .array _ => .error "TypeError: expected source object"

def bindingRows (rows : List Value) (a b c : String) : Except String (List (String × String × String)) :=
 rows.mapM fun row => do pure (← text (← field row a),← text (← field row b),← text (← field row c))

def checkHashRows (files : List (String × ByteArray)) : List (String × String) → Except String Unit
 | [] => .ok ()
 | (path,expected)::rest =>
  match files.find? (fun pair => Text.equal pair.1 path) with
  | none => .error (Text.append "common-scale source identity changed: " path)
  | some (_,bytes) => if Text.equal (Text.append "sha256:" (SFT.Host.SHA256Chunks.digest bytes)) expected then
    checkHashRows files rest
   else .error (Text.append "common-scale source identity changed: " path)
def checkHashes (files : List (String × ByteArray)) : Except String Unit := checkHashRows files sourceHashes

def authoritativeRecord (files : List (String × ByteArray)) (record running : Value)
 (certificates : List (String × Value)) : Except String Value := do
 checkHashes files
 if !sameValue (get record "schema") (.text "sft-v3-common-scale-axis-source-record/1") then throw "common-scale source schema changed"
 let sources ← array (get record "sources" (.array []))
 if (← bindingRows sources "source_id" "snapshot_path" "snapshot_hash") != sourceBindings then throw "common-scale external source binding changed"
 let weak ← rowAt sources 0
 let schemes ← array (get weak "complete_scheme_rows_printed_page_23" (.array []))
 let low ← array (get weak "complete_explicit_low_transfer_rows_printed_page_25" (.array []))
 if (← schemes.mapM (fun r => do text (← field r "scheme"))) != ["on-shell","effective lepton angle","MS at Z","MS non-decoupled"] then throw "weak scheme vector changed"
 if (← low.mapM (fun r => do text (← field r "row_id"))) != ["NuTeV-DIS-on-shell","Jefferson-Lab-Hall-A-eDIS","SLAC-E158","Cesium-atomic-parity-violation"] then throw "weak low-transfer vector changed"
 let figure := get weak "figure_10_1_printed_page_26" (.object [])
 if (← array (get figure "displayed_measurement_classes" (.array []))).length != 8 then throw "complete weak-running figure classes changed"
 if !(isTrue (get figure "complete_figure_retained_by_snapshot_hash") && isFalse (get figure "numeric_reverse_digitization_permitted")) then throw "weak-running figure custody changed"
 if !(← objectFields (get weak "scope_rows" (.object []))).all (fun p => isTrue p.2) then throw "weak-running scope rows changed"
 let inherited ← array (get record "inherited_admitted_evidence" (.array []))
 if (← bindingRows inherited "claim_id" "certificate_path" "certificate_hash") != inheritedBindings then throw "inherited scale evidence binding changed"
 let custody := get record "row_custody" (.object [])
 let required := ["all_printed_weak_scheme_rows_retained","all_printed_low_transfer_numeric_rows_retained","complete_weak_running_figure_retained","complete_inherited_strong_and_electromagnetic_vectors_retained","terminal_on_shell_and_proton_Planck_receipts_retained","unfavorable_and_scheme_boundaries_retained","target_inaccessible_to_prediction_program"]
 if !required.all (fun key => isTrue (get custody key)) then throw "common-scale row custody changed"
 if !isFalse (get custody "measurement_selects_scale_law") then throw "measurement-selection boundary changed"
 if !sameValue (get running "record_id") (.text "PDG-COUPLING-RUNNING-CONVERGENCE-2025-2026") then throw "inherited running record identity changed"
 let runningSources ← array (get running "sources" (.array []))
 if runningSources.length != 3 then throw "inherited running source vector changed"
 if (← array (← field (← field (← rowAt runningSources 0) "table_9_1") "complete_rows")).length != 7 then throw "complete QCD table changed"
 if (← array (← field (← field (← rowAt runningSources 1) "table_10_1") "complete_rows")).length != 11 then throw "complete electromagnetic table changed"
 let admitted ← inheritedBindings.mapM fun (claim,_,_) => do
  let payload ← field (.object certificates) claim
  if !sameValue (get payload "claim_id") (.text claim) || !sameValue (get payload "status") (.text "empirically_tested_and_independently_replicated") then
   throw (Text.append "inherited certificate changed: " claim)
  pure (claim,payload)
 pure (.object [("weak_source",weak),("inherited_running_source",running),("inherited_certificates",.object admitted),("row_custody",custody)])

def exactInterval (centre width : Rat) : Except String (Rat × Rat) :=
 if !((LeptonIntervals.normalize 0 1 (by decide)).blt width) || !width.blt centre then
  .error "scale-vector intervals must remain positive"
 else .ok (LeptonIntervals.subtract centre width,LeptonIntervals.add centre width)

-- Decimal decoding is the representation used by every row in the hash-bound
-- source record and by its original disjoint-interval control. The interval
-- operation above retains the complete rational guard independently of spelling.
def registeredRowInterval (row : Value) : Except String (Rat × Rat) := do
 let centre ← decimalField row "central"
 let width ← decimalField row "standard_uncertainty"
 exactInterval centre width

def intervalRows (rows : List Value) (key : String) : Except String Value := do
 let fields ← rows.foldlM (fun fields row => do
  let name ← text (← field row key)
  let bounds ← registeredRowInterval row
  pure (fields.filter (fun p => !Text.equal p.1 name) ++ [(name,intervalValue bounds)])) []
 pure (.object fields)

def intervalAt (rows : Value) (key : String) : Except String (Rat × Rat) := do
 RunningConvergenceValidation.intervalFromValue (← field rows key)

def contains (bounds : Rat × Rat) (q : Rat) : Bool := !q.blt bounds.1 && !bounds.2.blt q

def exactMeasurementAnalysis (target : Value) : Except String Value := do
 let weak ← field target "weak_source"
 let schemes ← intervalRows (← array (← field weak "complete_scheme_rows_printed_page_23")) "scheme"
 let low ← intervalRows (← array (← field weak "complete_explicit_low_transfer_rows_printed_page_25")) "row_id"
 let terminal := (← CommonScaleAxis.terminalElectroweakChain).terminalShare
 let leading ← CommonScaleAxis.leadingElectroweakShare (.integer 4)
 let ms ← intervalAt schemes "MS at Z"
 let onShell ← intervalAt schemes "on-shell"
 let e158 ← intervalAt low "SLAC-E158"
 let apv ← intervalAt low "Cesium-atomic-parity-violation"
 let nutev ← intervalAt low "NuTeV-DIS-on-shell"
 let edis ← intervalAt low "Jefferson-Lab-Hall-A-eDIS"
 let inherited ← field target "inherited_certificates"
 let receiptPassed := fun key => do
  let receipt ← field inherited key
  pure (isTrue (get receipt "controls_passed") && isTrue (get receipt "all_measurement_rows_preserved"))
 pure (.object [
 ("scheme_intervals",schemes),("low_transfer_intervals",low),("terminal_on_shell_prediction",ratValue terminal),
 ("terminal_inside_on_shell_interval",.boolean (contains onShell terminal)),
 ("leading_support_eight_prediction",ratValue leading),("leading_support_eight_inside_APV_interval",.boolean (contains apv leading)),
 ("E158_interval_strictly_above_MS_Z",.boolean (ms.2.blt e158.1)),("APV_interval_strictly_above_MS_Z",.boolean (ms.2.blt apv.1)),
 ("eDIS_interval_overlaps_MS_Z",.boolean (!(edis.2.blt ms.1 || ms.2.blt edis.1))),
 ("NuTeV_adverse_interval_above_terminal_on_shell",.boolean (onShell.2.blt nutev.1)),
 ("scheme_rows_complete",.boolean ((← objectFields schemes).length==4)),("low_transfer_rows_complete",.boolean ((← objectFields low).length==4)),
 ("figure_classes_complete",.boolean ((← array (← field (← field weak "figure_10_1_printed_page_26") "displayed_measurement_classes")).length==8)),
 ("threshold_boundary_retained",.boolean (isTrue (← field (← field weak "scope_rows") "above_W_sign_change_prevents_universal_monotone_claim"))),
 ("running_certificate_passed",.boolean (← receiptPassed "SFT-PHYS-COUPLING-RUNNING-CONVERGENCE-TERMINAL-006")),
 ("terminal_electroweak_certificate_passed",.boolean (← receiptPassed "SFT-PHYS-VALIDATION-ELECTROWEAK-TERMINAL-003")),
 ("proton_Planck_certificate_passed",.boolean (← receiptPassed "SFT-PHYS-VALIDATION-PROTON-PLANCK-TERMINAL-003"))])

def setField (value : Value) (key : String) (replacement : Value) : Except String Value := do
 let fs ← objectFields value
 pure (.object (fs.filter (fun p => !Text.equal p.1 key) ++ [(key,replacement)]))

def tamperedTarget (target : Value) : Except String Value := do
 let weak ← field target "weak_source"
 let rows ← array (← field weak "complete_scheme_rows_printed_page_23")
 let row ← rowAt rows 0
 let changed ← setField (← setField row "central" (.text "0.24000")) "standard_uncertainty" (.text "0.00001")
 setField target "weak_source" (← setField weak "complete_scheme_rows_printed_page_23" (.array (changed::rows.drop 1)))

end SFT.Physics.CommonScaleAxisMeasurement
