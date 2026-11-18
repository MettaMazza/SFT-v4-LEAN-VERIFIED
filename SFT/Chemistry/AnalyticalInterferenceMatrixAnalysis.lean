import SFT.Chemistry.AnalyticalAccuracyAnalysis
namespace SFT.Chemistry.AnalyticalInterferenceMatrixAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
open AnalyticalAccuracyAnalysis (validateAuthorities verifySurfaces)
def claimId : String := "SFT-CHEM-ANALYTICAL-SELECTIVITY-INTERFERENCE-005"
def targetIds : List String := ["SFT-CHEM-ANAL-005-IDENTITY","SFT-CHEM-ANAL-005-INTERFERENT-MATRIX","SFT-CHEM-ANAL-005-BASELINES","SFT-CHEM-ANAL-005-MIXTURES","SFT-CHEM-ANAL-005-DISTINGUISHABILITY","SFT-CHEM-ANAL-005-PERFORMANCE","SFT-CHEM-ANAL-005-ADVERSE-LIMITS","SFT-CHEM-ANAL-005-COMPLETE-SOURCE"]
def item (rows : List Value) (n : Nat) : Except String Value :=
 match (rows.drop n).head? with
 | none => .error "list index out of range"
 | some row => .ok row
def interferenceChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let t2 ← field row "complete_table_2_analyte_mobility_background_vector" >>= array
 let t3 ← field row "complete_table_3_mass_tpr_fpr_vector" >>= array
 let analytes ← field row "target_analyte_count" >>= nat
 let identityCheck ← if analytes==16 then do
  pure ((← field row "instrument_configurations" >>= nat)==2) else pure false
 let matrix ← if t2.length==16 then do
  pure (equal (← field row "background_sample_counts") (.object [("AE",.text "9359"),("N/E",.text "1996")])) else pure false
 let first ← item t2 0
 let firstValue ← field first "AE_K0" >>= text
 let baselines ← if Text.equal firstValue "0.9762 ± 0.0003" then do
  let last ← item t2 (t2.length-1)
  pure (Text.equal (← field last "NE_K0" >>= text) "1.3638 ± 0.0010") else pure false
 let boundary ← field row "iupac_boundary" >>= text
 let window ← field row "alarm_window_cm2_V_minus1_s_minus1" >>= text
 let screen ← field row "registered_screening_target" >>= text
 let performance ← if Text.equal screen "TPR >=90%; FPR <=2%" then do
  let selected ← item t3 9
  pure (Text.equal (← field selected "AE_TPR_percent" >>= text) "90") else pure false
 let adverse ← field row "adverse_vector" >>= array
 let held ← if adverse.length==7 then do
  let selected ← item t2 7
  let background ← field selected "NE_background_peak_percent" >>= text
  if Text.equal background "79.0" then
   field row "all_instrument_mass_mobility_uncertainty_background_threshold_false_positive_false_negative_overlap_assumption_and_scope_rows_retained" >>= bool
  else pure false
 else pure false
 let sources ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-ANAL-005-IDENTITY",identityCheck),("SFT-CHEM-ANAL-005-INTERFERENT-MATRIX",matrix),
 ("SFT-CHEM-ANAL-005-BASELINES",baselines),("SFT-CHEM-ANAL-005-MIXTURES",Text.contains boundary "mixtures or matrices"),
 ("SFT-CHEM-ANAL-005-DISTINGUISHABILITY",Text.equal window "±0.003" && t3.length==16),
 ("SFT-CHEM-ANAL-005-PERFORMANCE",performance),("SFT-CHEM-ANAL-005-ADVERSE-LIMITS",held),
 ("SFT-CHEM-ANAL-005-COMPLETE-SOURCE",sources==6)]
def exactInterferenceMatrixAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "ANAL-001–005 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "anal_005"
 let fullChecks ← interferenceChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : List (String × Value) := [("analytes",.integer 16),("table_2_rows",.integer 16),("table_3_rows",.integer 16),("background_samples",.object [("AE",.text "9359"),("N/E",.text "1996")]),("screening_target",.text "TPR >=90%; FPR <=2%")]
 return (.object (summary++[("complete_family_pdf_pages",.integer (.ofNat total.1)),
 ("complete_family_html_documents",.integer (.ofNat total.2.1)),
 ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
 ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_fit_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]),checks)
end SFT.Chemistry.AnalyticalInterferenceMatrixAnalysis
