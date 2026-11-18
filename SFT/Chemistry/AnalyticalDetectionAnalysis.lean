import SFT.Chemistry.AnalyticalAccuracyAnalysis
namespace SFT.Chemistry.AnalyticalDetectionAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
open AnalyticalAccuracyAnalysis (validateAuthorities verifySurfaces)
def claimId : String := "SFT-CHEM-ANALYTICAL-DETECTION-QUANTIFICATION-004"
def targetIds : List String := ["SFT-CHEM-ANAL-004-IDENTITY","SFT-CHEM-ANAL-004-BLANK-LOW-LEVEL","SFT-CHEM-ANAL-004-BOUNDARIES","SFT-CHEM-ANAL-004-ERRORS","SFT-CHEM-ANAL-004-DETECTION-VALUES","SFT-CHEM-ANAL-004-QUANTIFICATION","SFT-CHEM-ANAL-004-ADVERSE-LIMITS","SFT-CHEM-ANAL-004-COMPLETE-SOURCE"]
def detectionChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let classes ← field row "boundary_classes" >>= array
 let worked ← field row "worked_measurement"
 let assumptions ← field row "assumptions"
 let firstKind ← field assumptions "first_kind_error_percent" >>= text
 let errors ← if Text.equal firstKind "5" then do
  pure (Text.equal (← field assumptions "second_kind_error_percent" >>= text) "5") else pure false
 let workedExample ← field row "conventional_zero_background_example"
 let normal ← field workedExample "LD_poisson_normal_counts" >>= text
 let detection ← if Text.equal normal "2.71" then do
  pure (Text.equal (← field workedExample "exact_poisson_LD_counts" >>= text) "3.00") else pure false
 let quantitation ← field workedExample "LQ_counts" >>= text
 let quantified ← if Text.equal quantitation "100" then do
  pure (Text.equal (← field assumptions "quantitation_relative_uncertainty_percent" >>= text) "10") else pure false
 let span ← field row "literature_detection_limit_span_factor" >>= text
 let retained ← if Text.equal span "nearly 1000" then
  field row "all_conventional_zero_normal_poisson_rule_of_thumb_disagreement_and_model_assumptions_retained_as_external_provenance" >>= bool else pure false
 let sources ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-ANAL-004-IDENTITY",classes.length==3),
 ("SFT-CHEM-ANAL-004-BLANK-LOW-LEVEL",equal worked (.object [("counting_time_minutes",.text "10"),("detector_efficiency_percent",.text "10"),("background_counts_per_minute",.text "20")])),
 ("SFT-CHEM-ANAL-004-BOUNDARIES",equal (.array classes) (.array [.text "critical level LC",.text "detection limit LD",.text "determination limit LQ"])),
 ("SFT-CHEM-ANAL-004-ERRORS",errors),("SFT-CHEM-ANAL-004-DETECTION-VALUES",detection),
 ("SFT-CHEM-ANAL-004-QUANTIFICATION",quantified),("SFT-CHEM-ANAL-004-ADVERSE-LIMITS",retained),
 ("SFT-CHEM-ANAL-004-COMPLETE-SOURCE",sources==6)]
def exactDetectionAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "ANAL-001–005 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "anal_004"
 let fullChecks ← detectionChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : List (String × Value) := [("recipe_count",.text "8"),("span_factor",.text "nearly 1000"),("LC_LD_LQ_counts",.array [.text "0",.text "2.71",.text "100"]),("exact_poisson_LD_counts",.text "3.00")]
 return (.object (summary++[("complete_family_pdf_pages",.integer (.ofNat total.1)),
 ("complete_family_html_documents",.integer (.ofNat total.2.1)),
 ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
 ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_fit_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]),checks)
end SFT.Chemistry.AnalyticalDetectionAnalysis
