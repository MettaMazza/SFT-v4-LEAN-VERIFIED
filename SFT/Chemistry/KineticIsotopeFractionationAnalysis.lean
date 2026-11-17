import SFT.Chemistry.RadiochemicalAnalysis
namespace SFT.Chemistry.KineticIsotopeFractionationAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
def claimId : String := "SFT-CHEM-KINETIC-ISOTOPE-FRACTIONATION-008"
def targetIds : List String := ["SFT-CHEM-NUCHEM-008-REACTION-PATH","SFT-CHEM-NUCHEM-008-TIME-RESOURCE","SFT-CHEM-NUCHEM-008-PRODUCTS","SFT-CHEM-NUCHEM-008-RATES","SFT-CHEM-NUCHEM-008-FACTOR","SFT-CHEM-NUCHEM-008-STEADY-STATE","SFT-CHEM-NUCHEM-008-ADVERSE-CORRECTIONS","SFT-CHEM-NUCHEM-008-COMPLETE-SOURCES"]
def authorities := RadiochemicalAnalysis.authorities
def validateAuthorities := RadiochemicalAnalysis.validateAuthorities
def verifySurfaces := RadiochemicalAnalysis.verifySurfaces
def kineticChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let reaction ← field row "reaction_path" >>= text
 let table ← field row "complete_table_1_vector" >>= array
 let lastRow ← ConjugatedSupportAnalysis.valueAt table (table.length-1)
 let litres ← field lastRow "litres_collected" >>= text
 let residual ← field lastRow "residual_H2_in_cell_ppm" >>= text
 let response ← field row "kinetic_response_vector"
 let density ← field response "initial_recombined_gas_density_change_ppm" >>= text
 let factor ← field response "fractionation_factor" >>= text
 let steady ← field row "steady_state_record" >>= text
 let retained ← field row "all_corrections_uncertainties_replicate_discrepancies_flow_reversals_estimates_losses_and_limits_retained" >>= bool
 let correction ← field row "correction_vector"
 let measurements ← field correction "measurement_rows_ppm" >>= array
 let adverse ← field row "adverse_and_limit_vector" >>= array
 let sourceCount ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-NUCHEM-008-REACTION-PATH",(Text.chars "electrolysis").isPrefixOf (Text.chars reaction)),
 ("SFT-CHEM-NUCHEM-008-TIME-RESOURCE",table.length == 10 && Text.equal litres "150"),
 ("SFT-CHEM-NUCHEM-008-PRODUCTS",Text.equal residual "+57.8"),
 ("SFT-CHEM-NUCHEM-008-RATES",Text.equal density "-20.5"),
 ("SFT-CHEM-NUCHEM-008-FACTOR",Text.equal factor "2.4"),
 ("SFT-CHEM-NUCHEM-008-STEADY-STATE",(Text.chars "at 150 litres").isPrefixOf (Text.chars steady)),
 ("SFT-CHEM-NUCHEM-008-ADVERSE-CORRECTIONS",retained && measurements.length == 3 && adverse.length == 6),
 ("SFT-CHEM-NUCHEM-008-COMPLETE-SOURCES",sourceCount == 5)]
def exactKineticAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "NUCHEM-005–008 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "nuchem_008"
 let fullChecks ← kineticChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : Value := .object [("kinetic_series_rows",.integer 10),("fractionation_factor",.text "2.4"),("correction_ppm",.text "2.2 ± 0.5"),("replicate_rows",.integer 3),
  ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_html_documents",.integer (.ofNat total.2.1)),
  ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
  ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.KineticIsotopeFractionationAnalysis
