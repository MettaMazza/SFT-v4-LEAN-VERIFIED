import SFT.Physics.SymmetricRecords
namespace SFT.Physics.YangMillsSpectrumRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourcePath : String := "experiments/external_sources/physics/snapshots/yang-mills-singlet-gap-source-record.json"
def sourceHash : String := "sha256:cf0ccdbcb6d2fe3c69a5b64f07da0b9e5aef93c7d32654b341ec2eb1397ae75c"
def pdgPath : String := "experiments/external_sources/physics/snapshots/pdg-2026-quark-model.pdf"
def pdgHash : String := "sha256:6aa98fa53857122f27b638c59081af1a2857d787c4205370d8fa38fcb6b70ff0"
def sourceId : String := "PDG-2026-QUARK-MODEL-GLUEBALL-BOUNDARY"
def sourceHashes : List (String × String) := [(sourcePath,sourceHash),(pdgPath,pdgHash)]
def payloadBoundary (record : Value) : Except String Value := do
 if !sameValue (getDefault record "schema") (.text "sft-v3-yang-mills-singlet-gap-source-record/1") ||
  !sameValue (getDefault record "source_id") (.text sourceId) then throw "Yang-Mills spectrum source record identity changed"
 let source := getDefault record "source" (.object [])
 if !sameValue (getDefault source "snapshot_hash") (.text pdgHash) || !sameValue (getDefault source "snapshot_path") (.text pdgPath) then throw "PDG snapshot binding changed"
 let target := getDefault record "registered_target" (.object [])
 if !sameValue (getDefault target "theory_scope") (.text "pure SU(3) gauge lattice spectrum with separate full-QCD and experimental-identification caveats") then throw "glueball theory scope changed"
 let rows ← array (getDefault target "precise_lattice_rows" (.array []))
 let received := rows.map (fun row => Value.array (["quantum_numbers","mass_mev","standard_uncertainty_mev","role"].map (getDefault row)))
 let expected := [
  Value.array [.text "0++",.text "1653",.text "26",.text "lightest registered pure-gauge glueball"],
  Value.array [.text "2++",.text "2376",.text "32",.text "first registered excitation"],
  Value.array [.text "0-+",.text "2561",.text "40",.text "registered pseudoscalar excitation"]]
 if !sameValue (.array received) (.array expected) then throw "complete glueball spectrum rows changed"
 let required := ["all_central_masses_positive","all_lower_uncertainty_edges_positive","intervals_strictly_ordered_and_disjoint","quenched_approximation_neglects_quark_loops","glue_and_quark_antiquark_states_can_mix","full_qcd_requires_dynamical_light_quarks_mixing_control_and_high_statistics","pdg_reports_no_scalar_below_2_gev_as_predominantly_glueball"]
 if !required.all (fun key => sameValue (getDefault target key) (.boolean true)) then throw "glueball spectrum or limitation row changed"
 if !sameValue (getDefault target "unambiguous_experimental_glueball_identification") (.boolean false) ||
  !sameValue (getDefault target "dimensionful_mass_selected_formal_fold_gap") (.boolean false) then throw "glueball identification or derivation boundary changed"
 let custody := getDefault record "row_custody" (.object [])
 let retained := ["all_three_precise_mass_rows_retained","ground_and_first_excitation_order_retained","quenched_scope_retained","mixing_scope_retained","full_qcd_limitation_retained","experimental_nonidentification_retained","target_inaccessible_to_prediction_program"]
 if !sameValue (getDefault custody "pages_retained") (.array [.text "11",.text "12",.text "32"]) ||
  !retained.all (fun key => sameValue (getDefault custody key) (.boolean true)) ||
  !sameValue (getDefault custody "measurement_or_lattice_value_selects_survivor") (.boolean false) then throw "glueball row custody changed"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "Yang-Mills spectrum source identity changed: " relative)
  pure ())
 payloadBoundary payload
end SFT.Physics.YangMillsSpectrumRecords
