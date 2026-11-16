import SFT.Physics.PostNewtonianRecords
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.ReggeMeasuredRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement PostNewtonianRecords
set_option maxRecDepth 20000
def sourcePath : String := "experiments/external_sources/physics/snapshots/hadron-regge-measured-value-successor-source-record.json"
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/hadron-regge-measured-value-successor-source-record.json","sha256:6877a2e12365b035d3391a1a28af2f49693d8a749df276be3c772491a50ca356"),("experiments/external_sources/physics/snapshots/hadron-regge-successor-source-record.json","sha256:c6e671212984fa6b6956a3d748c12c81879686b9198ca5a0818670fe63301358"),("claims/SFT-PHYS-HADRON-REGGE-TERMINAL-005/certificate.json","sha256:04c8e3bd170de61199bf13e4ead70e3082a0e2cfc68c6213787ab4bfd1becaf1"),("claims/SFT-PHYS-HADRON-REGGE-DIMENSIONAL-TERMINAL-059/certificate.json","sha256:b5b3d9ec546d74a68080efba6d8249ea590c37aaba4618847ea6daabc6306489")]
def sourceIds : List String := ["PDG-2025-RHO-770", "PDG-2025-A2-1320", "PDG-2025-RHO3-1690", "PDG-2025-A4-1970", "PDG-2025-RHO5-2350"]
def requiredTrue : List String := ["development_targets_already_known", "formal_law_sealed_before_this_record_is_opened_in_execution", "all_five_registered_rows_retained", "mass_and_width_uncertainties_retained", "rho5_summary_omission_retained", "pole_mass_uncertainty_not_mislabelled_as_resonance_support", "no_slope_intercept_or_residual_fit", "no_uncertainty_or_width_widening"]
def expectedKeys : List String := ["pdg_2025_rho_770", "pdg_2025_a2_1320", "pdg_2025_rho3_1690", "pdg_2025_a4_1970", "pdg_2025_rho5_2350"]
def authoritativeRecord (files : List (String × ByteArray)) (record : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "Regge successor source changed: " relative)
  pure ())
 if !sameValue (getDefault record "schema") (.text "sft-v3-hadron-regge-measured-value-successor-source-record/1") then throw "Regge successor schema changed"
 let custody := getDefault record "custody" (.object [])
 if !requiredTrue.all (fun key=>ThermometryMeasurement.literalBoolean (getDefault custody key) true) then throw "Regge custody disclosure changed"
 if !ThermometryMeasurement.literalBoolean (getDefault custody "formal_law_contains_particle_names_masses_widths_or_units") false then throw "Regge formal target isolation changed"
 if !ThermometryMeasurement.literalBoolean (getDefault custody "measurements_select_formal_survivors") false then throw "Regge measurement-selection boundary changed"
 let sources := getDefault record "sources" (.object [])
 let keys := match sources with
  | .object fs => fs.map Prod.fst
  | .null | .boolean _ | .integer _ | .text _ | .array _ => []
 if !(keys==expectedKeys) then throw "complete five-row Regge source vector required"
 .ok record
end SFT.Physics.ReggeMeasuredRecords
