import SFT.Chemistry.NuclideCarrierAnalysis
namespace SFT.Chemistry.RadioactiveTransformationAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId

def claimId : String := "SFT-CHEM-RADIOACTIVE-CHEMICAL-TRANSFORMATION-002"
def targetIds : List String := ["SFT-CHEM-NUCHEM-002-PARENT","SFT-CHEM-NUCHEM-002-DAUGHTER",
 "SFT-CHEM-NUCHEM-002-CHEMICAL-STATES","SFT-CHEM-NUCHEM-002-CHANNELS","SFT-CHEM-NUCHEM-002-NETWORK",
 "SFT-CHEM-NUCHEM-002-EQUILIBRIUM","SFT-CHEM-NUCHEM-002-ADVERSE-METHODS","SFT-CHEM-NUCHEM-002-COMPLETE-SOURCES"]
def transformationChecks (row : Value) : Except String (List (String × Bool)) := do
 let edges ← field row "parent_daughter_vector" >>= array
 let first ← match edges with
  | [] => .error "list index out of range"
  | e::_ => .ok e
 let parent ← field first "parent"
 let daughter ← field first "daughter"
 let states ← field row "parent_daughter_chemical_states" >>= array
 let channels ← field row "channel_identity_vector" >>= array
 let retained ← field row "complete_directed_network_retained" >>= bool
 let equilibrium ← field row "equilibrium_records" >>= array
 let methods ← field row "method_assumption_vector" >>= array
 let comparisons ← field row "complete_confirmatory_comparison_vector" >>= array
 let complete ← field row "complete_registered_source_surface_retained" >>= bool
 return [("SFT-CHEM-NUCHEM-002-PARENT",ConjugatedSupportAnalysis.isText parent "90Sr"),
  ("SFT-CHEM-NUCHEM-002-DAUGHTER",ConjugatedSupportAnalysis.isText daughter "90Y"),
  ("SFT-CHEM-NUCHEM-002-CHEMICAL-STATES",states.length==3),
  ("SFT-CHEM-NUCHEM-002-CHANNELS",channels.length==5),
  ("SFT-CHEM-NUCHEM-002-NETWORK",retained && edges.length==4),
  ("SFT-CHEM-NUCHEM-002-EQUILIBRIUM",equilibrium.length==2),
  ("SFT-CHEM-NUCHEM-002-ADVERSE-METHODS",methods.length==3 && comparisons.length==3),
  ("SFT-CHEM-NUCHEM-002-COMPLETE-SOURCES",complete)]
def exactTransformationAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "NUCHEM-001–004 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "nuchem_002"
 let fullChecks ← transformationChecks row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : Value := .object [("directed_network_rows",.integer 4),("channel_rows",.integer 5),
  ("equilibrium_records",.integer 2),("confirmatory_rows",.integer 3),
  ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_html_documents",.integer (.ofNat total.2.1)),
  ("complete_family_characters",.integer (.ofNat total.2.2)),("complete_result_vector_sha256",.text recorded),
  ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.RadioactiveTransformationAnalysis
