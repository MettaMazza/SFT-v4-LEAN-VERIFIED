import SFT.Physics.FizeauRecords
namespace SFT.Physics.ThermalObservationRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourcePath : String := "experiments/external_sources/physics/snapshots/thermal-history-postseal-source-record.json"
def sourceHash : String := "sha256:8ce41a6c68923395da2502fbb8e078dc770ac2c7648c966b241d8c671273a0d8"
def sourceIds : List String := ["NOTERDAEME-ET-AL-2011-CMB-TEMPERATURE","AVER-ET-AL-2026-PRIMORDIAL-HELIUM","COOKE-PETTINI-STEIDEL-2018-DEUTERIUM","PLANCK-2018-OVERVIEW-PEAKS","PLANCK-2018-COSMOLOGICAL-PARAMETERS","PDG-2025-BBN-REVIEW"]
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/thermal-history-postseal-source-record.json","sha256:8ce41a6c68923395da2502fbb8e078dc770ac2c7648c966b241d8c671273a0d8"),("experiments/external_sources/physics/snapshots/arxiv-1012.3164-cmb-temperature-redshift.pdf","sha256:aa79c65170e84d6a8dc71dbd0876538c19619a1c926453ce5a54bd96d3f1efb7"),("experiments/external_sources/physics/snapshots/arxiv-2601.22238-primordial-helium.pdf","sha256:72f646a345c36b77211e6035d3a78345498f0766cf9fc0a54932ebe0dd670c6a"),("experiments/external_sources/physics/snapshots/arxiv-1710.11129-primordial-deuterium.pdf","sha256:1a6ec19d6568b8854a40e9dd587906f99a8ea94ecd2d5c712ad86aa506b93f4a"),("experiments/external_sources/physics/snapshots/arxiv-1807.06205-planck-overview.pdf","sha256:dca932893b7d2724aa2b8d33170fc1b5682c425dd56fcd3c5d7b2098d377db5c"),("experiments/external_sources/physics/snapshots/arxiv-1807.06209-planck-cosmological-parameters.pdf","sha256:8e172730faf07c9f4ff3fdcc7043f76ed67df6f76066d47df30d693025b6ce77"),("experiments/external_sources/physics/snapshots/pdg-2025-bbang-nucleosynthesis.pdf","sha256:1843c1d9025aa33c059700708f1041c4462364cdb582325f0c685a6ba1b38484")]
def expectedTarget : List (String × Value) := [("cmb_temperature_exponent_central",.text "1.007"),("cmb_temperature_exponent_standard_uncertainty",.text "0.027"),("primordial_helium_mass_fraction_central",.text "0.2458"),("primordial_helium_mass_fraction_standard_uncertainty",.text "0.0013"),("primordial_deuterium_times_100000_central",.text "2.527"),("primordial_deuterium_times_100000_standard_uncertainty",.text "0.030"),("planck_recombination_redshift_central",.text "1089.92"),("planck_recombination_redshift_standard_uncertainty",.text "0.25"),("planck_detected_peak_count",.integer 18)]
def requiredCustody : List String := ["formal_receipt_precedes_new_source_retrieval","target_inaccessible_to_formal_executable","target_did_not_rewrite_formal_survivor","current_unfavourable_helium_interval_retained","old_exact_observed-quarter-equality_rejected","old_exact_angular-integer-multiple_claim_rejected","projection_and_visibility_types_retained","complete_uncertainty_and_peak_rows_retained"]
def payloadBoundary (record : Value) : Except String Value := do
 if !sameValue (getDefault record "schema") (.text "sft-v3-thermal-history-postseal-source-record/1") then throw "thermal-history source schema changed"
 if !sameValue (getDefault record "formal_receipt_hash") (.text "sha256:25dda78644ebc04ad43cd3e416950ad76dae6b124ed023f41364f0661eae9c00") then throw "thermal-history formal receipt binding changed"
 let count ← FizeauRecords.recordLength (getDefault record "sources" (.array []))
 if count != 6 then throw "complete six-source record is required"
 let target := getDefault record "registered_target" (.object [])
 if !expectedTarget.all (fun (k,v) => sameValue (getDefault target k) v) then throw "thermal-history target row changed"
 let peaks ← FizeauRecords.recordLength (getDefault target "planck_tt_peak_multipoles" (.array []))
 if peaks != 7 then throw "complete Planck TT peak rows are required"
 let amplitudes ← FizeauRecords.recordLength (getDefault target "planck_tt_peak_amplitudes" (.array []))
 if amplitudes != 7 then throw "complete Planck TT peak rows are required"
 let custody := getDefault record "row_custody" (.object [])
 if !requiredCustody.all (fun k => sameValue (getDefault custody k) (.boolean true)) then throw "thermal-history custody record changed"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "thermal-history source identity changed: " relative)
  pure ())
 payloadBoundary payload
end SFT.Physics.ThermalObservationRecords
