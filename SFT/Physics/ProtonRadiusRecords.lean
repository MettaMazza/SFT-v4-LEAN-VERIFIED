import SFT.Physics.SymmetricRecords
namespace SFT.Physics.ProtonRadiusRecords
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open PostNewtonianRecords (getDefault fileBytes)
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def sourcePath : String := "experiments/external_sources/physics/snapshots/proton-radius-terminal-source-record.json"
def sourceHash : String := "sha256:6bdbbef14cd8fc40d408028ba06911692f7b7c871b7214c038d51e33ed2118a1"
def sourceIds : List String := ["NATURE-2026-ELECTRONIC-HYDROGEN-PROTON-RADIUS", "NATURE-2019-PRAD-PROTON-RADIUS", "NIST-CODATA-2022", "NIST-CODATA-2014-HISTORICAL"]
def sourceHashes : List (String × String) := [("experiments/external_sources/physics/snapshots/proton-radius-terminal-source-record.json","sha256:6bdbbef14cd8fc40d408028ba06911692f7b7c871b7214c038d51e33ed2118a1"),("experiments/external_sources/physics/snapshots/nature-2026-proton-radius-electronic.pdf","sha256:834ddf04fdb3064d07307cc743544990e086601948903fb73390144d2a3ae253"),("experiments/external_sources/physics/snapshots/arxiv-1902.08185-prad-proton-radius.pdf","sha256:66925b870f8391be1a940b741ff60322877df7551cfa1db58b59add002e15ad5"),("experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt","sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"),("experiments/external_sources/physics/snapshots/nist-codata-2014-all.pdf","sha256:48c31408c79d3a9aa7c16efdbf5ef729d8ad162f2b9dbb8029d4d8cdcbef3568")]
def requiredBindings : Value := .array [.array [.text "NATURE-2026-ELECTRONIC-HYDROGEN-PROTON-RADIUS",.text "experiments/external_sources/physics/snapshots/nature-2026-proton-radius-electronic.pdf",.text "sha256:834ddf04fdb3064d07307cc743544990e086601948903fb73390144d2a3ae253"],.array [.text "NATURE-2019-PRAD-PROTON-RADIUS",.text "experiments/external_sources/physics/snapshots/arxiv-1902.08185-prad-proton-radius.pdf",.text "sha256:66925b870f8391be1a940b741ff60322877df7551cfa1db58b59add002e15ad5"],.array [.text "NIST-CODATA-2022",.text "experiments/external_sources/physics/snapshots/nist-codata-2022-allascii.txt",.text "sha256:77fb90e66c40db3e6eb16630bc9c88e4c7c8beddbe5e71be406f2f26e3f67e67"],.array [.text "NIST-CODATA-2014-HISTORICAL",.text "experiments/external_sources/physics/snapshots/nist-codata-2014-all.pdf",.text "sha256:48c31408c79d3a9aa7c16efdbf5ef729d8ad162f2b9dbb8029d4d8cdcbef3568"]]
def requiredScale : Value := .object [("quantity",.text "reduced proton Compton wavelength"),("value_fm",.text "0.210308910051"),("standard_uncertainty_fm",.text "0.000000000066"),("source_id",.text "NIST-CODATA-2022")]
def requiredCurrentIds : List String := ["electronic-hydrogen-2S-6P-2026","muonic-hydrogen-current-reference","codata-2022-global-adjustment","PRad-electron-proton-scattering-2019"]
def requiredCustody : List String := ["complete_current_electronic_and_muonic_rows_retained","complete_current_CODATA_row_retained","PRad_statistical_and_systematic_uncertainties_retained_separately","historical_unfavorable_CODATA_row_retained","current_discrepancy_and_scattering_analysis_limits_retained","reduced_Compton_scale_and_uncertainty_retained","target_inaccessible_to_prediction_program"]
def payloadBoundary (record : Value) : Except String Value := do
 if !sameValue (getDefault record "schema") (.text "sft-v3-proton-radius-terminal-source-record/1") then throw "proton-radius source record schema changed"
 let sources ← array (getDefault record "sources" (.array []))
 let received := sources.map (fun row => Value.array (["source_id","snapshot_path","snapshot_hash"].map (getDefault row)))
 if !sameValue (.array received) requiredBindings then throw "proton-radius source bindings changed"
 let target := getDefault record "registered_target" (.object [])
 if !sameValue (getDefault target "dimension_scale") requiredScale then throw "proton-radius scale row changed"
 let current ← array (getDefault target "current_radius_rows" (.array []))
 let historical ← array (getDefault target "historical_adverse_rows" (.array []))
 if current.length != 4 || historical.length != 1 then throw "proton-radius target row count changed"
 if !sameValue (.array (current.map (fun row => getDefault row "row_id"))) (.array (requiredCurrentIds.map Value.text)) then throw "proton-radius current target identities changed"
 if !sameValue (getDefault (← rowAt historical 0) "row_id") (.text "codata-2014-global-adjustment") then throw "proton-radius historical target identity changed"
 let scope ← match getDefault target "scope_rows" (.object []) with
  | .object fields => pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _ => throw "TypeError"
 if scope.length != 6 || !scope.all (fun x => sameValue x.2 (.boolean true)) then throw "proton-radius scope rows changed"
 let custody := getDefault record "row_custody" (.object [])
 if !requiredCustody.all (fun key => sameValue (getDefault custody key) (.boolean true)) then throw "proton-radius custody rows changed"
 if !sameValue (getDefault custody "measurement_selects_formula") (.boolean false) || !sameValue (getDefault custody "precision_widening_permitted") (.boolean false) then throw "proton-radius adverse custody rows changed"
 pure record
def authoritativeRecord (files : List (String × ByteArray)) (payload : Value) : Except String Value := do
 let _ ← sourceHashes.mapM (fun (relative,expected) => do
  let bytes ← fileBytes files relative
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then throw (Text.append "proton-radius source identity changed: " relative)
  pure ())
 payloadBoundary payload
end SFT.Physics.ProtonRadiusRecords
