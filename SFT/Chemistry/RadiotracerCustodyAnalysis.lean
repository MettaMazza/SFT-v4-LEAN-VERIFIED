import SFT.Chemistry.NuclideCarrierAnalysis
namespace SFT.Chemistry.RadiotracerCustodyAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
def claimId : String := "SFT-CHEM-RADIOTRACER-CUSTODY-INFERENCE-009"
def targetIds : List String := ["SFT-CHEM-NUCHEM-009-TRACER-CHEMISTRY","SFT-CHEM-NUCHEM-009-OBSERVATION-SUPPORT","SFT-CHEM-NUCHEM-009-COUNTS","SFT-CHEM-NUCHEM-009-RECOVERY","SFT-CHEM-NUCHEM-009-LOCALIZATION","SFT-CHEM-NUCHEM-009-INFERENCE-BOUNDARY","SFT-CHEM-NUCHEM-009-ADVERSE-LIMITS","SFT-CHEM-NUCHEM-009-COMPLETE-SOURCE"]
def authorities : List (String × String) := [("audits/CHEMISTRY_NUCHEM_001_012_FAMILY_BOUNDARY_2026-07-28.json","sha256:77cefa7bb8a338c3b0e2de615ee7335c7c18c680423c58ecf336a5420bc4109f"),("experiments/external_sources/chemistry/nuchem_009_012_family_source_identity_registry_v1.json","sha256:ff9ae4d8616b9e5889028876f217e5d0c356d30fa146dd2b5ae90cb2bab06628"),("sft/chemistry/radiotracer_custody_law_v1.py","sha256:322bf04ce164fa418956198e076e3e18bd0146c4d924515e7fe738d09388df0e"),("sft/chemistry/radiochemical_separation_law_v1.py","sha256:a5cee923a57144eab81205f6d00eb46457f4f9668eee05566924486ba7951fc3"),("sft/chemistry/fission_product_distribution_law_v1.py","sha256:3ac7032706528d449b6d21e172febbb794a16eabe51b30428d6dac469e7f8eb6"),("sft/chemistry/radiolysis_network_law_v1.py","sha256:99962608fc2d6ddfb52dac69cf9a8cbbedc7f1e50749ce64e872745326177afb"),("experiments/external_sources/chemistry/nuchem_009_target_identities_v1.json","sha256:8133f5aabc7ec7cfbb5fc9fa38e6776153e5bc2e8f514fd4d1a6d8e1870c5a03"),("experiments/external_sources/chemistry/nuchem_010_target_identities_v1.json","sha256:77c00ab3050b60c58320a03c7823168d250bea4bdaee744b437c32fe300ad851"),("experiments/external_sources/chemistry/nuchem_011_target_identities_v1.json","sha256:9e20706647d7cc961875900fd5ec265cc891115a988bee6128b7ab6dd6c7bcca"),("experiments/external_sources/chemistry/nuchem_012_target_identities_v1.json","sha256:1603b88b918aac72522ae865c78ad10fdcd9b91146d57b9bee5a21ce257190b1"),("experiments/sealed_predictions/chemistry_nuchem_009_pre_source_v1.json","sha256:73cf904a4d34bbb7dfd0ffe7b52ed3e15c04cc32dac68d631f7c9ab4d3eade29"),("experiments/sealed_predictions/chemistry_nuchem_010_pre_source_v1.json","sha256:7b4467b104dc19d96d2ce5e56e7ce84ad4dfeec22b7d2f9cd19a18f8681e30cc"),("experiments/sealed_predictions/chemistry_nuchem_011_pre_source_v1.json","sha256:81482cf2d5aeb17080fdc5f69780838b7ac3910748ac27cf9bf21d0ae96ea204"),("experiments/sealed_predictions/chemistry_nuchem_012_pre_source_v1.json","sha256:b180a00808ac40571ea6f07b4d7f0a9d6e6d873ded4218431d5ac024fa0454c1"),("experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/source-inventory-v1.json","sha256:6e420b9e739c6899345641ea0091efad147d508f65fec5e956f82c8ec764b071"),("experiments/external_sources/chemistry/snapshots/nuchem-009-012-radiochemistry-v1/complete-postseal-analysis-v1.json","sha256:6c993195755f1ddf3c63e1f2404fc0d9a8762378c767c834d69b23b1430dae8c"),("tools/seal_chemistry_nuchem_009_012_predictions_v1.py","sha256:4cc3b4167b8eee8132f7ab8627d7d064227cf79698e2ed369d441a908200b6d8"),("tools/capture_chemistry_nuchem_009_012_sources_v1.py","sha256:6d08b87577ca4cc641080c4aa16d083547f0713a779245bd42e162fd6acc7a09"),("tools/build_chemistry_nuchem_009_012_external_v1.py","sha256:40edf4850c465e100c039cafbc107db66372ba776cca098a6c01405f86d397ec")]
def validateAuthorities (files : List Snapshot) : Except String Unit := do
 let _ ← authorities.mapM fun (path,expected) => do
  let bytes ← SFT.Materials.MaterialSource.readSnapshot files path
  if !Text.equal (SFT.Materials.MaterialSource.bytesHash bytes) expected then
   throw (Text.append "NUCHEM-009–012 authority changed: " path)
 return ()
def verifySurfaces (analysis : Value) (inputs : List SurfaceInput) : Except String (Nat × Nat) := do
 let sources ← field analysis "complete_source_reconstruction" >>= fields
 let total ← sources.foldlM (fun (total : Nat × Nat) (_,source) => do
  let path ← field source "snapshot_path" >>= text
  let input ← match inputs.find? (fun row => Text.equal row.path path) with
   | none => .error (Text.append "FileNotFoundError: " path)
   | some row => .ok row
  let reconstructed := NuclideCarrierSurface.surface "pdf" input.pages []
  let expected ← field source "complete_surface_vector"
  if !equal (.array reconstructed) expected then throw "complete NUCHEM-009–012 source reconstruction changed"
  let characters ← reconstructed.foldlM (fun sum row => do
   let n ← field row "character_count" >>= nat
   return sum+n) 0
  return (total.1+reconstructed.length,total.2+characters)) (0,0)
 let pages ← field analysis "complete_pdf_page_count" >>= nat
 let chars ← field analysis "complete_extracted_character_count" >>= nat
 if total.1 != 370 || total.2 != 837013 || total.1 != pages || total.2 != chars then
  throw "complete NUCHEM-009–012 source surface changed"
 return total

def tracerChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let chemistry ← field row "complete_tracer_chemical_vector" >>= array
 let support ← field row "detector_support"
 let detectors ← field support "simple_experiment_detector_count" >>= text
 let times ← field row "flotation_mean_residence_time_minutes" >>= array
 let gold ← field row "gold_leach_vector"
 let tank1 ← field gold "tank_1_injected_activity_mCi" >>= text
 let tank7 ← field gold "tank_7_injected_activity_mCi" >>= text
 let cobalt ← field row "cobalt_recovery_vector"
 let recovery ← field cobalt "recovery_in_copper_matte_percent" >>= text
 let shortCircuit ← field cobalt "short_circuit_percent" >>= text
 let blockedVolume ← field cobalt "blocked_settling_tank_volume_percent" >>= text
 let boundary ← field row "observation_model_boundary" >>= text
 let retained ← field row "all_background_decay_correction_normalization_loss_fit_assumption_adverse_absent_unavailable_and_unresolved_rows_retained" >>= bool
 let sourceCount ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-NUCHEM-009-TRACER-CHEMISTRY",chemistry.length == 8 && chemistry.any (fun x => equal x (.text "58CoO"))),
 ("SFT-CHEM-NUCHEM-009-OBSERVATION-SUPPORT",Text.equal detectors "2" && times.length == 3),
 ("SFT-CHEM-NUCHEM-009-COUNTS",Text.equal tank1 "100" && Text.equal tank7 "130"),
 ("SFT-CHEM-NUCHEM-009-RECOVERY",Text.equal recovery "70-75"),
 ("SFT-CHEM-NUCHEM-009-LOCALIZATION",Text.equal shortCircuit "about 5" && Text.equal blockedVolume "nearly 30"),
 ("SFT-CHEM-NUCHEM-009-INFERENCE-BOUNDARY",(Text.chars "measured curves").isPrefixOf (Text.chars boundary)),
 ("SFT-CHEM-NUCHEM-009-ADVERSE-LIMITS",retained),
 ("SFT-CHEM-NUCHEM-009-COMPLETE-SOURCE",sourceCount == 4)]

def exactTracerAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "NUCHEM-009–012 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "nuchem_009"
 let fullChecks ← tracerChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : Value := .object [("tracer_chemistry_rows",.integer 8),("flotation_rows",.integer 3),
  ("cobalt_recovery_percent",.text "70-75"),("short_circuit_percent",.text "about 5"),
  ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_characters",.integer (.ofNat total.2)),
  ("complete_result_vector_sha256",.text recorded),
  ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_fit_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.RadiotracerCustodyAnalysis
