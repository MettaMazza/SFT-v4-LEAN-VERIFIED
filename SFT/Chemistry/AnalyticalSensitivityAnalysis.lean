import SFT.Chemistry.AnalyticalAccuracyAnalysis
namespace SFT.Chemistry.AnalyticalSensitivityAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
open AnalyticalAccuracyAnalysis (validateAuthorities verifySurfaces)
def claimId : String := "SFT-CHEM-ANALYTICAL-SENSITIVITY-003"
def targetIds : List String := ["SFT-CHEM-ANAL-003-IDENTITY","SFT-CHEM-ANAL-003-INPUT-SUPPORT","SFT-CHEM-ANAL-003-RESPONSE-SUPPORT","SFT-CHEM-ANAL-003-SENSITIVITY","SFT-CHEM-ANAL-003-NONLINEARITY","SFT-CHEM-ANAL-003-DOMAIN","SFT-CHEM-ANAL-003-DRIFT-NOISE","SFT-CHEM-ANAL-003-COMPLETE-SOURCE"]
def sensitivityChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let boundary ← field row "calibration_boundary" >>= text
 let mixtures ← field row "minimum_calibration_mixtures" >>= text
 let standards ← field row "minimum_nonlinear_calibration_standards" >>= text
 let sensitivity ← field row "required_relative_concentration_difference_sensitivity_percent" >>= text
 let exact ← if Text.equal sensitivity "0.2" then do
  pure (Text.equal (← field row "duplicate_agreement_acceptance_percent_relative" >>= text) "0.2") else pure false
 let nonlinear ← field row "straight_quadratic_prediction_difference_trigger_percent" >>= text
 let drift ← field row "drift_vector" >>= array
 let held ← if drift.length==4 then field row "all_nonlinearity_extrapolation_drift_noise_and_case_by_case_limits_retained" >>= bool else pure false
 let sources ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-ANAL-003-IDENTITY",Text.contains boundary "NTRM concentration"),
 ("SFT-CHEM-ANAL-003-INPUT-SUPPORT",Text.equal mixtures "3"),
 ("SFT-CHEM-ANAL-003-RESPONSE-SUPPORT",Text.equal standards "4"),
 ("SFT-CHEM-ANAL-003-SENSITIVITY",exact),
 ("SFT-CHEM-ANAL-003-NONLINEARITY",Text.equal nonlinear "0.5"),
 ("SFT-CHEM-ANAL-003-DOMAIN",Text.contains boundary "extrapolation not recommended"),
 ("SFT-CHEM-ANAL-003-DRIFT-NOISE",held),("SFT-CHEM-ANAL-003-COMPLETE-SOURCE",sources==6)]
def exactSensitivityAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "ANAL-001–005 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "anal_003"
 let fullChecks ← sensitivityChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : List (String × Value) := [("minimum_calibration_mixtures",.text "3"),("minimum_nonlinear_standards",.text "4"),("relative_sensitivity_percent",.text "0.2"),("nonlinearity_trigger_percent",.text "0.5")]
 return (.object (summary++[("complete_family_pdf_pages",.integer (.ofNat total.1)),
 ("complete_family_html_documents",.integer (.ofNat total.2.1)),
 ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
 ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_fit_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]),checks)
end SFT.Chemistry.AnalyticalSensitivityAnalysis
