import SFT.Chemistry.RadiotracerCustodyAnalysis
namespace SFT.Chemistry.RadiochemicalSeparationAnalysis
open SFT.Host SFT.Host.Canonical
open NuclideCarrierAnalysis hiding targetIds claimId authorities validateAuthorities verifySurfaces
def claimId : String := "SFT-CHEM-RADIOCHEMICAL-SEPARATION-DECONTAMINATION-010"
def targetIds : List String := ["SFT-CHEM-NUCHEM-010-SPECIES","SFT-CHEM-NUCHEM-010-STREAMS","SFT-CHEM-NUCHEM-010-BALANCE","SFT-CHEM-NUCHEM-010-RECOVERY","SFT-CHEM-NUCHEM-010-DECONTAMINATION","SFT-CHEM-NUCHEM-010-STAGES","SFT-CHEM-NUCHEM-010-ADVERSE-UNCERTAINTY","SFT-CHEM-NUCHEM-010-COMPLETE-SOURCE"]
def authorities := RadiotracerCustodyAnalysis.authorities
def validateAuthorities := RadiotracerCustodyAnalysis.validateAuthorities
def verifySurfaces := RadiotracerCustodyAnalysis.verifySurfaces
def separationChecks (analysis row : Value) : Except String (List (String × Bool)) := do
 let species ← field row "complete_species_vector" >>= array
 let processes ← field row "complete_process_vector" >>= array
 let resin ← field row "resin_vector"
 let pre ← field resin "pre_column_48V_uCi" >>= text
 let post ← field resin "post_column_48V_uCi" >>= text
 let recovery ← field resin "48V_recovery_percent" >>= text
 let postSc ← field resin "post_column_Sc" >>= text
 let titanium ← field row "post_titanium_removal_vector"
 let titaniumExtraction ← field titanium "extraction_percent" >>= text
 let titaniumTime ← field titanium "time_minutes" >>= text
 let competitive ← field row "competitive_species_vector"
 let competitiveExtraction ← field competitive "extraction_percent" >>= text
 let competitiveTime ← field competitive "time_minutes" >>= text
 let adverse ← field row "adverse_initial_radiotracer_vector"
 let adverseExtraction ← field adverse "extraction_percent" >>= text
 let retained ← field row "all_detection_limits_uncertainties_single_replicates_losses_interference_unexpected_adverse_estimates_and_future_work_retained" >>= bool
 let sourceCount ← field analysis "complete_source_count" >>= nat
 return [("SFT-CHEM-NUCHEM-010-SPECIES",species.length == 14),
 ("SFT-CHEM-NUCHEM-010-STREAMS",processes.length == 9),
 ("SFT-CHEM-NUCHEM-010-BALANCE",Text.equal pre "2562" && Text.equal post "1626"),
 ("SFT-CHEM-NUCHEM-010-RECOVERY",Text.equal recovery "92" && Text.equal titaniumExtraction "71"),
 ("SFT-CHEM-NUCHEM-010-DECONTAMINATION",Text.equal postSc "not detectable" && Text.equal competitiveExtraction "71"),
 ("SFT-CHEM-NUCHEM-010-STAGES",Text.equal titaniumTime "180" && Text.equal competitiveTime "60"),
 ("SFT-CHEM-NUCHEM-010-ADVERSE-UNCERTAINTY",Text.equal adverseExtraction "1" && retained),
 ("SFT-CHEM-NUCHEM-010-COMPLETE-SOURCE",sourceCount == 4)]
def exactSeparationAnalysis (analysis : Value) (files : List Snapshot) (inputs : List SurfaceInput)
 (omitLast : Bool := false) : Except String (Value × List (String × Bool)) := do
 validateAuthorities files
 let fs ← fields analysis
 let recorded ← field analysis "complete_result_vector_sha256" >>= text
 let vector := Value.object (fs.filter (fun row => !Text.equal row.1 "complete_result_vector_sha256"))
 if !Text.equal recorded (identity vector) then throw "NUCHEM-009–012 result vector changed"
 let total ← verifySurfaces analysis inputs
 let row ← field analysis "nuchem_010"
 let fullChecks ← separationChecks analysis row
 let checks := if omitLast then fullChecks.take (fullChecks.length-1) else fullChecks
 if !equal (.array ((checks.map Prod.fst).map Value.text)) (.array (targetIds.map Value.text)) || !(checks.all Prod.snd) then
  throw (Text.append claimId " comparison changed")
 let summary : Value := .object [("species_rows",.integer 14),("post_column_recovery_percent",.text "92"),
  ("post_titanium_extraction_percent",.text "71"),("competitive_extraction_percent",.text "71"),
  ("adverse_initial_extraction_percent",.text "1"),
  ("complete_family_pdf_pages",.integer (.ofNat total.1)),("complete_family_characters",.integer (.ofNat total.2)),
  ("complete_result_vector_sha256",.text recorded),
  ("all_favorable_adverse_absent_unavailable_unresolved_uncertainty_assumption_correction_fit_estimate_loss_signed_zero_decimal_continuum_and_historical_inscriptions_retained_as_external_provenance_only",.boolean true)]
 return (summary,checks)
end SFT.Chemistry.RadiochemicalSeparationAnalysis
