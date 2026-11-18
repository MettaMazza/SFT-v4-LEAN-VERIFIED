import SFT.Chemistry.NuclideCarrierAnalysis
namespace SFT.Chemistry.ActivityAmountAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId

def claimId : String := "SFT-CHEM-ACTIVITY-AMOUNT-TIME-003"
def targetIds : List String := ["SFT-CHEM-NUCHEM-003-IDENTITY","SFT-CHEM-NUCHEM-003-AMOUNT-FORMS",
 "SFT-CHEM-NUCHEM-003-ACTIVITY-UNIT","SFT-CHEM-NUCHEM-003-REFERENCE-TIME","SFT-CHEM-NUCHEM-003-MASSIC-ACTIVITY",
 "SFT-CHEM-NUCHEM-003-UNCERTAINTY","SFT-CHEM-NUCHEM-003-TIME-RELATION","SFT-CHEM-NUCHEM-003-COMPLETE-SOURCES"]
def massicActivityVector : Value := .array [
 .object [("coverage_factor",.text "2"),("expanded_uncertainty",.text "0.088"),("nuclide",.text "90Sr"),("unit",.text "kBq·g-1"),("value",.text "29.492")],
 .object [("coverage_factor",.text "2"),("expanded_uncertainty",.text "0.23"),("nuclide",.text "232U"),("unit",.text "Bq·g-1"),("value",.text "26.30")]]
def activityChecks (row : Value) : Except String (List (String × Bool)) := do
 let identityRetained ← field row "identity_and_chemical_form_retained" >>= bool
 let amounts ← field row "amount_forms" >>= array
 let becquerel ← field row "becquerel_definition"
 let times ← field row "reference_time_vector" >>= array
 let massic ← field row "complete_massic_activity_vector"
 let uncertainties ← field row "complete_uncertainty_vector" >>= array
 let correction ← field row "decay_correction_and_reference_time_retained" >>= bool
 let halfLives ← field row "complete_half_life_vector" >>= array
 let complete ← field row "complete_registered_source_surface_retained" >>= bool
 return [("SFT-CHEM-NUCHEM-003-IDENTITY",identityRetained),
  ("SFT-CHEM-NUCHEM-003-AMOUNT-FORMS",amounts.length==5),
  ("SFT-CHEM-NUCHEM-003-ACTIVITY-UNIT",ConjugatedSupportAnalysis.isText becquerel "one nuclear transformation per second"),
  ("SFT-CHEM-NUCHEM-003-REFERENCE-TIME",times.length==2),
  ("SFT-CHEM-NUCHEM-003-MASSIC-ACTIVITY",equal massic massicActivityVector),
  ("SFT-CHEM-NUCHEM-003-UNCERTAINTY",uncertainties.length==12),
  ("SFT-CHEM-NUCHEM-003-TIME-RELATION",correction && halfLives.length==3),
  ("SFT-CHEM-NUCHEM-003-COMPLETE-SOURCES",complete)]
def exactActivityAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "NUCHEM-001–004 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "nuchem_003"
 let fullChecks ← activityChecks row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : Value := .object [("massic_activity_rows",.integer 2),("half_life_rows",.integer 3),
  ("sr90_massic_activity_kBq_per_g",.text "29.492 ± 0.088"),("u232_massic_activity_Bq_per_g",.text "26.30 ± 0.23"),
  ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_html_documents",.integer (.ofNat total.2.1)),
  ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
  ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.ActivityAmountAnalysis
