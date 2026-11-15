import SFT.Physics.SymmetricRecords
namespace SFT.Physics.ParkerRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourcePath : String := "experiments/external_sources/physics/snapshots/parker-proton-energy-source-record.json"
def sourceHash : String := "sha256:bd644fb01e46ae9ee3cdb096776e4d68fcfecc4ecb9bba078f3ac185edaecae1"
def parkerPath : String := "experiments/external_sources/physics/snapshots/desai-2025-parker-400kev.pdf"
def parkerHash : String := "sha256:6c950a6e142edf57df600d06e1ce40445fc18c84d42c3d2b916d63679a100fb5"
def codataPath : String := "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt"
def codataHash : String := "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"
def sourceIds : List String := ["DESAI-ET-AL-2025-PARKER-HCS-PROTONS", "NIST-CODATA-2022"]
def sourceHashes : List (String × String) := [(sourcePath,sourceHash),(parkerPath,parkerHash),(codataPath,codataHash)]
def requiredEvent : Value := .object [("event_date",.text "2022-12-12"),("heliocentric_distance_solar_radii",.text "16.25"),("spectral_analysis_lower_keV",.text "67"),("spectral_analysis_upper_keV",.text "527"),("pitch_angle_analysis_lower_keV",.text "67"),("pitch_angle_analysis_upper_keV",.text "570"),("reported_power_law_index_magnitude",.text "5.1"),("available_magnetic_energy_per_particle_keV",.text "0.56"),("approximately_400_is_exact_cutoff_measurement",.boolean false),("approximately_400_has_reported_standard_uncertainty",.boolean false),("paper_calls_399_714_keV_a_prediction",.boolean false)]
def requiredProton : Value := .object [("quantity",.text "proton mass energy equivalent in MeV"),("value_MeV",.text "938.27208943"),("standard_uncertainty_MeV",.text "0.00000029")]
def requiredCustody : List String := ["abstract_and_event_rows_retained", "complete_spectral_range_retained", "complete_pitch_angle_range_retained", "power_law_and_magnetic_energy_context_retained", "approximation_and_missing_uncertainty_retained", "proton_mass_and_uncertainty_retained", "target_inaccessible_to_prediction_program"]
def eventEqual (actual expected : Value) : Bool := match expected with
 | .boolean false => sameValue actual (.boolean false) || sameValue actual (.integer 0)
 | .null | .boolean true | .integer _ | .text _ | .array _ | .object _ => sameValue actual expected
def sourceLength : Value → Except String Nat
 | .text s => .ok (Text.chars s).length
 | .array xs => .ok xs.length
 | .object xs => .ok xs.length
 | .null | .boolean _ | .integer _ => .error "TypeError"
def payloadBoundary (record : Value) : Except String Value := do
 if !sameValue (getDefault record "schema") (.text "sft-v3-parker-proton-energy-source-record/1") ||
  !sameValue (getDefault record "source_id") (.text "DESAI-2025-PARKER-NIST-CODATA-PROTON-ENERGY") then throw "Parker source record identity changed"
 let sources ← array (getDefault record "sources" (.array []))
 let received := sources.map (fun row => Value.array (["source_id","snapshot_path","snapshot_hash"].map (getDefault row)))
 let expected := [Value.array [.text "DESAI-ET-AL-2025-PARKER-HCS-PROTONS",.text parkerPath,.text parkerHash],Value.array [.text "NIST-CODATA-2022",.text codataPath,.text codataHash]]
 if !sameValue (.array received) (.array expected) then throw "Parker source bindings changed"
 let target := getDefault record "registered_target" (.object [])
 let event := getDefault target "parker_event" (.object [])
 let eventPass := match requiredEvent with
  | .object fields => fields.all (fun (k,v) => eventEqual (getDefault event k) v)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => false
 if !eventPass then throw "Parker event rows changed"
 if (← sourceLength (getDefault event "reported_energy_wording" (.array []))) != 3 then throw "Parker event rows changed"
 if !sameValue (getDefault target "proton_rest_energy" (.object [])) requiredProton then throw "CODATA proton row changed"
 let custody := getDefault record "row_custody" (.object [])
 if !requiredCustody.all (fun k => sameValue (getDefault custody k) (.boolean true)) ||
  !sameValue (getDefault custody "measurement_selects_formula") (.boolean false) ||
  !sameValue (getDefault custody "precision_cutoff_claim_permitted") (.boolean false) then throw "Parker custody rows changed"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "Parker source identity changed: " relative)
  pure ())
 payloadBoundary payload
end SFT.Physics.ParkerRecords
