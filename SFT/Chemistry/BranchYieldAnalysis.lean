import SFT.Chemistry.NuclideCarrierAnalysis
namespace SFT.Chemistry.BranchYieldAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId

def claimId : String := "SFT-CHEM-RADIOACTIVE-BRANCHING-CHEMICAL-YIELD-004"
def targetIds : List String := ["SFT-CHEM-NUCHEM-004-CHANNELS","SFT-CHEM-NUCHEM-004-DAUGHTERS",
 "SFT-CHEM-NUCHEM-004-BRANCH-FRACTIONS","SFT-CHEM-NUCHEM-004-CHEMICAL-RECOVERY","SFT-CHEM-NUCHEM-004-PARTITION",
 "SFT-CHEM-NUCHEM-004-METHODS","SFT-CHEM-NUCHEM-004-ADVERSE-UNCERTAINTY","SFT-CHEM-NUCHEM-004-COMPLETE-SOURCES"]
def branchingChecks (row : Value) : Except String (List (String × Bool)) := do
 let channels ← field row "complete_channel_vector" >>= array
 let daughters ← field row "complete_daughter_vector" >>= array
 let probability ← field row "probability_per_decay_relation" >>= text
 let numeric ← field row "numeric_probability_per_decay_rows_in_registered_sources" >>= text
 let chemical ← field row "chemical_recovery_custody" >>= text
 let partition ← field row "partition_support" >>= text
 let primary ← field row "primary_method_vector" >>= array
 let confirmatory ← field row "complete_confirmatory_method_vector" >>= array
 let assumptions ← field row "complete_assumption_discrepancy_uncertainty_vector"
 let confirmations ← field assumptions "confirmations" >>= array
 let unavailable ← field row "unavailable_numeric_branch_fractions_preserved_as_unavailable_not_fabricated" >>= bool
 let complete ← field row "complete_registered_source_surface_retained" >>= bool
 return [("SFT-CHEM-NUCHEM-004-CHANNELS",channels.length==5),
  ("SFT-CHEM-NUCHEM-004-DAUGHTERS",daughters.length==4),
  ("SFT-CHEM-NUCHEM-004-BRANCH-FRACTIONS",Text.contains probability "fraction of decays" && (Text.chars "absent").isPrefixOf (Text.chars numeric)),
  ("SFT-CHEM-NUCHEM-004-CHEMICAL-RECOVERY",Text.contains chemical "monitoring radiochemical procedures"),
  ("SFT-CHEM-NUCHEM-004-PARTITION",Text.contains partition "without renormalizing after omission"),
  ("SFT-CHEM-NUCHEM-004-METHODS",primary.length==4 && confirmatory.length==5),
  ("SFT-CHEM-NUCHEM-004-ADVERSE-UNCERTAINTY",confirmations.length==3 && unavailable),
  ("SFT-CHEM-NUCHEM-004-COMPLETE-SOURCES",complete)]
def exactBranchingAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "NUCHEM-001–004 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "nuchem_004"
 let fullChecks ← branchingChecks row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : Value := .object [("channel_rows",.integer 5),("daughter_rows",.integer 4),
  ("numeric_branch_fraction_status",.text "unavailable_in_registered_sources__preserved_not_fabricated"),("method_rows",.integer 9),
  ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_html_documents",.integer (.ofNat total.2.1)),
  ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
  ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.BranchYieldAnalysis
