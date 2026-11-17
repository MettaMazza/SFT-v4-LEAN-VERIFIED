import SFT.Chemistry.RadiochemicalAnalysis
namespace SFT.Chemistry.EquilibriumIsotopeFractionationAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
def claimId : String := "SFT-CHEM-EQUILIBRIUM-ISOTOPE-FRACTIONATION-007"
def targetIds : List String := ["SFT-CHEM-NUCHEM-007-ISOTOPE-RATIOS","SFT-CHEM-NUCHEM-007-PHASES","SFT-CHEM-NUCHEM-007-FACTORS","SFT-CHEM-NUCHEM-007-ORIENTATION","SFT-CHEM-NUCHEM-007-TEMPERATURE","SFT-CHEM-NUCHEM-007-EQUILIBRIUM","SFT-CHEM-NUCHEM-007-ADVERSE-UNAVAILABLE","SFT-CHEM-NUCHEM-007-COMPLETE-SOURCES"]
def authorities := RadiochemicalAnalysis.authorities
def validateAuthorities := RadiochemicalAnalysis.validateAuthorities
def verifySurfaces := RadiochemicalAnalysis.verifySurfaces
def fractionationChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let definition ← field row "factor_definition" >>= text
 let table ← field row "complete_table_1_vector" >>= array
 let lastAlpha ← ConjugatedSupportAnalysis.valueAt table (table.length-1) >>= fun x => field x "alpha" >>= text
 let firstAlpha ← ConjugatedSupportAnalysis.valueAt table 0 >>= fun x => field x "alpha" >>= text
 let temperature ← field row "temperature_support" >>= array
 let temperatureText ← ConjugatedSupportAnalysis.valueAt temperature 1 >>= text
 let exchange ← field row "one_atom_exchange_correspondence" >>= text
 let alphas ← field row "complete_exchange_alpha_vector" >>= array
 let retained ← field row "all_fits_assumptions_estimated_curves_adverse_absent_unavailable_and_unresolved_rows_retained" >>= bool
 let adverse ← field row "adverse_record" >>= text
 let sourceCount ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-NUCHEM-007-ISOTOPE-RATIOS",(Text.chars "alpha_A-B").isPrefixOf (Text.chars definition)),
 ("SFT-CHEM-NUCHEM-007-PHASES",Text.contains definition "R_A/R_B"),
 ("SFT-CHEM-NUCHEM-007-FACTORS",table.length==12 && Text.equal lastAlpha "1.01980"),
 ("SFT-CHEM-NUCHEM-007-ORIENTATION",Text.equal firstAlpha "1.00000"),
 ("SFT-CHEM-NUCHEM-007-TEMPERATURE",temperature.length==2 && Text.contains temperatureText "figures 1 through 49"),
 ("SFT-CHEM-NUCHEM-007-EQUILIBRIUM",Text.equal exchange "for a one-atom exchange reaction K equals alpha" && alphas.length==4),
 ("SFT-CHEM-NUCHEM-007-ADVERSE-UNAVAILABLE",retained && Text.contains adverse "uncritically compiled"),
 ("SFT-CHEM-NUCHEM-007-COMPLETE-SOURCES",sourceCount==5)]
def exactFractionationAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "NUCHEM-005–008 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "nuchem_007"
 let fullChecks ← fractionationChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : Value := .object [("comparison_table_rows",.integer 12),("exchange_alpha_rows",.integer 4),("registered_curve_figures",.integer 49),
  ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_html_documents",.integer (.ofNat total.2.1)),
  ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
  ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.EquilibriumIsotopeFractionationAnalysis
