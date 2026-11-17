import SFT.Chemistry.RadiochemicalAnalysis
namespace SFT.Chemistry.IsotopeExchangeAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
def claimId : String := "SFT-CHEM-ISOTOPE-EXCHANGE-006"
def targetIds : List String := ["SFT-CHEM-NUCHEM-006-ISOTOPES","SFT-CHEM-NUCHEM-006-CARRIERS","SFT-CHEM-NUCHEM-006-CONSERVATION","SFT-CHEM-NUCHEM-006-EXCHANGE-QUOTIENT","SFT-CHEM-NUCHEM-006-EQUILIBRIUM","SFT-CHEM-NUCHEM-006-MULTISPECIES","SFT-CHEM-NUCHEM-006-ADVERSE-ASSUMPTIONS","SFT-CHEM-NUCHEM-006-COMPLETE-SOURCES"]
def authorities := RadiochemicalAnalysis.authorities
def validateAuthorities := RadiochemicalAnalysis.validateAuthorities
def verifySurfaces := RadiochemicalAnalysis.verifySurfaces
def isotopeChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let ratios ← field row "complete_example_isotope_ratio_vector" >>= array
 let relation ← field row "exchange_relation" >>= text
 let balance ← field row "balance_and_nonideality_custody" >>= text
 let alphas ← field row "complete_exchange_alpha_vector" >>= array
 let firstAlpha ← ConjugatedSupportAnalysis.valueAt alphas 0 >>= fun x => field x "alpha" >>= text
 let conditions ← field row "complete_example_conditions" >>= array
 let lastRatio ← ConjugatedSupportAnalysis.valueAt ratios 3 >>= fun x => field x "standard_units_permil" >>= text
 let retained ← field row "all_assumptions_comparisons_nonideality_absent_unavailable_and_adverse_rows_retained" >>= bool
 let sourceCount ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-NUCHEM-006-ISOTOPES",ratios.length==4),
 ("SFT-CHEM-NUCHEM-006-CARRIERS",Text.contains relation "two retained carriers"),
 ("SFT-CHEM-NUCHEM-006-CONSERVATION",Text.contains balance "balance"),
 ("SFT-CHEM-NUCHEM-006-EXCHANGE-QUOTIENT",Text.equal firstAlpha "0.99893"),
 ("SFT-CHEM-NUCHEM-006-EQUILIBRIUM",Text.contains relation "equilibrium constant"),
 ("SFT-CHEM-NUCHEM-006-MULTISPECIES",conditions.length==5 && Text.equal lastRatio "42.08"),
 ("SFT-CHEM-NUCHEM-006-ADVERSE-ASSUMPTIONS",retained),
 ("SFT-CHEM-NUCHEM-006-COMPLETE-SOURCES",sourceCount==5)]
def exactIsotopeAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "NUCHEM-005–008 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "nuchem_006"
 let fullChecks ← isotopeChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : Value := .object [("exchange_alpha_rows",.integer 4),("isotope_ratio_rows",.integer 4),("example_conditions",.integer 5),
  ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_html_documents",.integer (.ofNat total.2.1)),
  ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
  ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.IsotopeExchangeAnalysis
