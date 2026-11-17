import SFT.Chemistry.RadiotracerCustodyAnalysis
namespace SFT.Chemistry.FissionProductDistributionAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
def claimId : String := "SFT-CHEM-FISSION-PRODUCT-CHEMICAL-DISTRIBUTION-011"
def targetIds : List String := ["SFT-CHEM-NUCHEM-011-PHYSICS-HANDOFF","SFT-CHEM-NUCHEM-011-CHEMICAL-IDENTITY","SFT-CHEM-NUCHEM-011-PHASE-LOCATION","SFT-CHEM-NUCHEM-011-DISTRIBUTION","SFT-CHEM-NUCHEM-011-REDISTRIBUTION","SFT-CHEM-NUCHEM-011-TIME-SAMPLE","SFT-CHEM-NUCHEM-011-ADVERSE-DISCREPANCY","SFT-CHEM-NUCHEM-011-COMPLETE-SOURCE"]
def authorities := RadiotracerCustodyAnalysis.authorities
def validateAuthorities := RadiotracerCustodyAnalysis.validateAuthorities
def verifySurfaces := RadiotracerCustodyAnalysis.verifySurfaces
def fissionChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let groups ← field row "complete_chemical_groups"
 let gases ← field groups "noble_gases" >>= array
 let salts ← field groups "stable_salt_soluble_fluorides" >>= array
 let metals ← field groups "noble_metals_or_nonstable_fluorides" >>= array
 let behavior ← field row "phase_location_behavior" >>= array
 let support ← field row "sample_support" >>= array
 let iodine ← field row "iodine_balance_vector"
 let iodineRange ← field iodine "salt_inventory_range_percent" >>= text
 let surface ← field row "surface_vector"
 let metalArea ← field surface "metal_area_percent" >>= text
 let graphiteArea ← field surface "graphite_area_percent" >>= text
 let deposition ← ConjugatedSupportAnalysis.valueAt behavior 4 >>= text
 let operating ← field row "operating_support"
 let hours235 ← field operating "235U_effective_full_power_hours" >>= text
 let hours233 ← field operating "233U_effective_full_power_hours" >>= text
 let adverse ← field row "adverse_and_unresolved_vector" >>= array
 let retained ← field row "all_inventory_bases_samples_conditions_variances_losses_conjectures_adverse_absent_unavailable_and_unresolved_rows_retained" >>= bool
 let sourceCount ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-NUCHEM-011-PHYSICS-HANDOFF",gases.length == 2),
 ("SFT-CHEM-NUCHEM-011-CHEMICAL-IDENTITY",salts.length == 7 && metals.length == 7),
 ("SFT-CHEM-NUCHEM-011-PHASE-LOCATION",behavior.length == 5 && support.length == 5),
 ("SFT-CHEM-NUCHEM-011-DISTRIBUTION",Text.equal iodineRange "45-71" && Text.equal metalArea "26"),
 ("SFT-CHEM-NUCHEM-011-REDISTRIBUTION",Text.equal graphiteArea "74" && Text.contains deposition "deposit"),
 ("SFT-CHEM-NUCHEM-011-TIME-SAMPLE",Text.equal hours235 ">9000" && Text.equal hours233 ">5100"),
 ("SFT-CHEM-NUCHEM-011-ADVERSE-DISCREPANCY",adverse.length == 6 && retained),
 ("SFT-CHEM-NUCHEM-011-COMPLETE-SOURCE",sourceCount == 4)]
def exactFissionAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "NUCHEM-009–012 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "nuchem_011"
 let fullChecks ← fissionChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : Value := .object [("chemical_groups",.integer 4),("salt_fluoride_rows",.integer 7),("noble_metal_rows",.integer 7),
  ("iodine_salt_inventory_percent",.text "45-71 (median 62)"),("unaccounted_iodine",.text "about one-quarter to one-third"),
  ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_characters",.integer (.ofNat total.2)),
  ("complete_result_vector_sha256",.text recorded),
  ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_fit_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.FissionProductDistributionAnalysis
