import SFT.Physics.SymmetricRecords
namespace SFT.Physics.FizeauRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourcePath : String := "experiments/external_sources/physics/snapshots/velocity-composition-fizeau-source-record.json"
def sourceHash : String := "sha256:2d8f4c921c10e4d3917cce4c5cdeb83269c6f135d3d98c99d824ff3cc1fca1b7"
def pdfPath : String := "experiments/external_sources/physics/snapshots/arxiv-1201.0501-fizeau.pdf"
def pdfHash : String := "sha256:8c19ceeccda50a3c297aa13c6006a6cf032d41a3c714f128b2be663bd3c5b5b3"
def sourceId : String := "ARXIV-1201.0501-FIZEAU-WATER-AIR"
def sourceHashes : List (String × String) := [(sourcePath,sourceHash),(pdfPath,pdfHash)]
-- Original Python len on JSON strings, arrays and objects; non-containers fail.
def recordLength : Value → Except String Nat
 | .text s => .ok (Text.chars s).length
 | .array xs => .ok xs.length
 | .object xs => .ok xs.length
 | .boolean _ => .error "TypeError: object of type 'bool' has no len()"
 | .integer _ => .error "TypeError: object of type 'int' has no len()"
 | .null => .error "TypeError: object of type 'NoneType' has no len()"
def payloadBoundary (record : Value) : Except String Value := do
 if !sameValue (getDefault record "schema") (.text "sft-v3-velocity-composition-fizeau-source-record/1") ||
  !sameValue (getDefault record "source_id") (.text sourceId) then throw "Fizeau source record identity changed"
 let source := getDefault record "source" (.object [])
 if !sameValue (getDefault source "snapshot_hash") (.text pdfHash) || !sameValue (getDefault source "snapshot_path") (.text pdfPath) then throw "Fizeau PDF binding changed"
 let target := getDefault record "registered_target" (.object [])
 let expected := [("water_measured_slope_rad_s_per_m","274/1000"),
  ("water_measured_standard_uncertainty_rad_s_per_m","3/1000"),
  ("relativistic_raw_prediction_rad_s_per_m","248/1000"),
  ("relativistic_profile_and_dispersion_corrected_prediction_rad_s_per_m","299/1000"),
  ("ordinary_addition_prediction_rad_s_per_m","563/1000"),
  ("reported_corrected_agreement_fraction","8/100")]
 if !expected.all (fun (key,value) => sameValue (getDefault target key) (.text value)) then throw "Fizeau exact target row changed"
 if !sameValue (getDefault target "air_nonrelativistic_prediction_ruled_out") (.boolean true) ||
  !sameValue (getDefault target "air_measurements_compatible_with_relativistic_calculation") (.boolean true) then throw "Fizeau air control changed"
 let n ← recordLength (getDefault target "systematic_limitations_retained" (.array []))
 if n != 4 then throw "Fizeau limitation ledger changed"
 let custody := getDefault record "row_custody" (.object [])
 let required := ["formal_sft_claim_sealed_before_source_retrieval","measured_slope_retained", "measured_uncertainty_retained", "raw_relativistic_prediction_retained", "corrected_relativistic_prediction_retained", "ordinary_addition_unfavorable_control_retained", "air_result_retained", "systematic_limitations_retained", "target_inaccessible_to_formal_derivation"]
 if !required.all (fun key => sameValue (getDefault custody key) (.boolean true)) ||
  !sameValue (getDefault custody "measurement_selected_formal_survivor") (.boolean false) then throw "Fizeau custody row changed"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "Fizeau source identity changed: " relative)
  pure ())
 payloadBoundary payload
end SFT.Physics.FizeauRecords
