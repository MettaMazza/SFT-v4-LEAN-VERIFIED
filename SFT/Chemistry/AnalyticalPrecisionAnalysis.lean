import SFT.Chemistry.AnalyticalAccuracyAnalysis
namespace SFT.Chemistry.AnalyticalPrecisionAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
open AnalyticalAccuracyAnalysis (validateAuthorities verifySurfaces)
def claimId : String := "SFT-CHEM-ANALYTICAL-PRECISION-REPEATABILITY-002"
def targetIds : List String := ["SFT-CHEM-ANAL-002-IDENTITY","SFT-CHEM-ANAL-002-REPLICATES","SFT-CHEM-ANAL-002-WITHIN-SET","SFT-CHEM-ANAL-002-BETWEEN-SET","SFT-CHEM-ANAL-002-METHOD-AGREEMENT","SFT-CHEM-ANAL-002-DRIFT","SFT-CHEM-ANAL-002-ADVERSE-LIMITS","SFT-CHEM-ANAL-002-COMPLETE-SOURCE"]
def precisionChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let accuracy ← field analysis "anal_001"
 let certified ← field accuracy "certified_row_count" >>= nat
 let reference ← field accuracy "reference_noncertified_row_count" >>= nat
 let minimum ← field row "ntrm_batch_standard_minimum_analyses" >>= text
 let replicates ← if Text.equal minimum "6" then do
  pure (Text.equal (← field row "remaining_samples_analysis" >>= text) "duplicate") else pure false
 let gc ← field row "gc_ms_within_set_cv_percent" >>= text
 let withinSet ← if Text.equal gc "0.5 to 4.3" then do
  pure (Text.equal (← field row "lc_ms_within_set_cv_percent" >>= text) "0.2 to 1.2") else pure false
 let betweenSet ← field row "between_set_cv_percent" >>= text
 let agreement ← field row "between_method_agreement_percent" >>= text
 let duplicate ← field row "duplicate_and_interval_agreement_percent_relative" >>= text
 let drift ← if Text.equal duplicate "0.2" then do
  pure (Text.equal (← field row "stability_reanalysis_interval_days" >>= text) "30") else pure false
 let adverse ← field row "all_noise_drift_inhomogeneity_instability_and_discard_conditions_retained" >>= bool
 let sourceCount ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-ANAL-002-IDENTITY",certified+reference==7),
 ("SFT-CHEM-ANAL-002-REPLICATES",replicates),
 ("SFT-CHEM-ANAL-002-WITHIN-SET",withinSet),
 ("SFT-CHEM-ANAL-002-BETWEEN-SET",Text.equal betweenSet "0.1 to 1.1"),
 ("SFT-CHEM-ANAL-002-METHOD-AGREEMENT",Text.equal agreement "0.8 to 8.8"),
 ("SFT-CHEM-ANAL-002-DRIFT",drift),("SFT-CHEM-ANAL-002-ADVERSE-LIMITS",adverse),
 ("SFT-CHEM-ANAL-002-COMPLETE-SOURCE",sourceCount==6)]
def exactPrecisionAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "ANAL-001–005 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "anal_002"
 let fullChecks ← precisionChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary ← ["gc_ms_within_set_cv_percent","lc_ms_within_set_cv_percent","between_set_cv_percent","between_method_agreement_percent"].mapM fun key => do
  pure (key,← field row key)
 return (.object (summary++[("complete_family_pdf_pages",.integer (.ofNat total.1)),
 ("complete_family_html_documents",.integer (.ofNat total.2.1)),
 ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
 ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_fit_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]),checks)
end SFT.Chemistry.AnalyticalPrecisionAnalysis
