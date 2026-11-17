import SFT.Chemistry.RadiotracerCustodyAnalysis
namespace SFT.Chemistry.RadiolysisNetworkAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
def claimId : String := "SFT-CHEM-RADIATION-CHEMISTRY-REACTION-NETWORK-012"
def targetIds : List String := ["SFT-CHEM-NUCHEM-012-RESOURCE-HANDOFF","SFT-CHEM-NUCHEM-012-SPECIES","SFT-CHEM-NUCHEM-012-NETWORK","SFT-CHEM-NUCHEM-012-YIELDS","SFT-CHEM-NUCHEM-012-CONDITIONS","SFT-CHEM-NUCHEM-012-PARTITION-CLOSURE","SFT-CHEM-NUCHEM-012-ADVERSE-UNCERTAINTY","SFT-CHEM-NUCHEM-012-COMPLETE-SOURCE"]
def authorities := RadiotracerCustodyAnalysis.authorities
def validateAuthorities := RadiotracerCustodyAnalysis.validateAuthorities
def verifySurfaces := RadiotracerCustodyAnalysis.verifySurfaces
def radiolysisChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let definition ← field row "yield_definition" >>= text
 let products ← field row "complete_product_vector" >>= array
 let reactions ← field row "reaction_vector" >>= array
 let yields ← field row "preferred_yield_vector" >>= array
 let values ← yields.mapM fun x => do return (← field x "G" >>= text,← field x "uncertainty" >>= text)
 let expected := [("10.0","0.2"),("2.0","0.2"),("4.0","0.4"),("4.0","0.4")]
 let yieldMatch := values.length==expected.length && (values.zip expected).all (fun ((a,b),(c,d)) => Text.equal a c && Text.equal b d)
 let high ← field row "very_high_dose_vector" >>= array
 let highMatch ← if high.length==2 then do
  let first ← ConjugatedSupportAnalysis.valueAt high 0
  pure (Text.equal (← field first "G_N2" >>= text) "12.4 ± 0.4")
  else pure false
 let gas ← field row "complete_rare_gas_sensitized_table" >>= array
 let gasMatch ← if gas.length==5 then do
  let last ← ConjugatedSupportAnalysis.valueAt gas (gas.length-1)
  pure (Text.equal (← field last "G_minus_N2O" >>= text) "4.1")
  else pure false
 let adverse ← field row "adverse_and_limit_vector" >>= array
 let retained ← if adverse.length==12 then
  field row "all_methods_conditions_dosimetry_corrections_tentative_unreliable_questionable_nonlinear_adverse_absent_unavailable_and_unresolved_rows_retained" >>= bool
  else pure false
 let sourceCount ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-NUCHEM-012-RESOURCE-HANDOFF",Text.contains definition "absorbed-energy resource"),
  ("SFT-CHEM-NUCHEM-012-SPECIES",products.length==6),("SFT-CHEM-NUCHEM-012-NETWORK",reactions.length==4),
  ("SFT-CHEM-NUCHEM-012-YIELDS",yieldMatch),("SFT-CHEM-NUCHEM-012-CONDITIONS",highMatch),
  ("SFT-CHEM-NUCHEM-012-PARTITION-CLOSURE",gasMatch),("SFT-CHEM-NUCHEM-012-ADVERSE-UNCERTAINTY",retained),
  ("SFT-CHEM-NUCHEM-012-COMPLETE-SOURCE",sourceCount==4)]
def resolvedAnalysis (analysis : Value) (recorded : String) (total : Nat × Nat)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 let row ← field analysis "nuchem_012"
 let fullChecks ← radiolysisChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : Value := .object [("preferred_yield_rows",.integer 4),("preferred_G_vector",.array (["N2 10.0 ± 0.2","O2 measured 2.0 ± 0.2","O2 calculated 4.0 ± 0.4","NO 4.0 ± 0.4"].map Value.text)),
 ("rare_gas_rows",.integer 5),("very_high_dose_rows",.integer 2),
 ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_characters",.integer (.ofNat total.2)),
  ("complete_result_vector_sha256",.text recorded),
  ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_fit_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
def exactRadiolysisAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "NUCHEM-009–012 result vector changed"
 let total ← verifySurfaces analysis inputs
 resolvedAnalysis analysis recorded total omitLast
end SFT.Chemistry.RadiolysisNetworkAnalysis
