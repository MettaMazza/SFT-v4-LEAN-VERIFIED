import SFT.Chemistry.CoordinationNumberSource
import SFT.Chemistry.CoordinationNumber
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.CoordinationNumberAnalysis
open SFT.Host
open JointCorrelationTargets (field text)
open CoordinationNumberPrediction (equal)
open CoordinationNumber
abbrev J := Canonical.Value

def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 23 || !CoordinationNumberPrediction.completeOrdinals 1 rows then
  throw "INORG-002 requires all 23 source records"
 let authorities ← rows.mapM fun row => field row "authority" >>= text
 let iupac := (authorities.filter (Text.equal · "IUPAC")).length
 let nist := (authorities.filter (Text.equal · "NIST-CCCBDB")).length
 let vector ← field primary "exact_direct_link_vector"
 let adverse ← field primary "adverse_and_boundary_surface"
 let adverseValues ← match adverse with
  | .object fields => pure (fields.map Prod.snd)
  | .null | .text _ | .integer _ | .boolean _ | .array _ => throw "boundary surface requires an object"
 let counts ← [3,4,5].mapM fun width => do return (← forcedNumber (← generatedEntity width)).positiveDirectIncidenceCount.value
 let prior ← generatedEntity 3
 let next ← generatedAttachment 4
 let successor ← appendIncrements prior next
 let general ← CoordinationAnalysis.inscription rows "general-direct-link-definition"
 let inorganic ← CoordinationAnalysis.inscription rows "inorganic-sigma-link-definition"
 let scandium ← CoordinationAnalysis.inscription rows "ScF3-direct-link-count"
 let titanium ← CoordinationAnalysis.inscription rows "TiCl4-direct-link-count"
 let iron ← CoordinationAnalysis.inscription rows "FeCO5-direct-link-count"
 return .object [
 ("complete_registered_target_count",.integer (.ofNat rows.length)),
 ("source_class_census",.object [("IUPAC",.integer (.ofNat iupac)),("NIST-CCCBDB",.integer (.ofNat nist))]),
 ("source_class_census_matches",.boolean (iupac==5 && nist==18)),
 ("exact_generated_counts_three_four_five_reconstructed",.boolean (counts==[3,4,5])),
 ("successor_preserves_prior_and_increments_one",.boolean successor),
 ("iupac_general_direct_link_definition_retained",.boolean (Text.contains general "directly linked")),
 ("iupac_inorganic_sigma_definition_retained",.boolean (Text.contains inorganic "number of" && Text.contains inorganic "bonds")),
 ("nist_three_four_five_vector_retained",.boolean (equal vector (.object [("ScF3",.text "3"),("TiCl4",.text "4"),("FeCO5",.text "5")]) && Text.equal scandium "3" && Text.equal titanium "4" && Text.equal iron "5")),
 ("all_boundaries_absences_and_disclaimers_retained",.boolean (adverseValues.all CoordinationAnalysis.truthy)),
 ("source_counts_remain_postseal_evidence_only",.boolean (equal (← field primary "no_source_count_used_as_fold_proof_parameter") (.boolean true)))]
end SFT.Chemistry.CoordinationNumberAnalysis
