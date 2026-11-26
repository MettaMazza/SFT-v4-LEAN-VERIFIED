import SFT.Chemistry.OrganometallicBondSource
import SFT.Chemistry.OrganometallicBondDerivation
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.OrganometallicBondAnalysis
open SFT.Host OrganometallicBond
open JointCorrelationTargets (field text)
open OrganometallicBondPrediction (get equal)
abbrev J := Canonical.Value
def absent : BondSupport → Bool
 | .empty _ => true | .positive _ => false
def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 12 then throw "INORG-010 requires all twelve source surfaces"
 let noBond ← forced "absent" (.empty "empty-One")
 let first ← forceRows "first" [← direct "M1" "C1" ⟨2,by decide⟩]
 let next ← appendDirect first (← direct "M1" "C2" ⟨2,by decide⟩)
 let post ← field primary "exact_postseal_analysis"
 let sourceIds ← rows.mapM (fun row => field row "source_id" >>= text)
 let uniqueSources := sourceIds.foldl (fun out id => if out.any (Text.equal id) then out else out++[id]) []
 let surfaces ← rows.mapM (fun row => do field (← field row "source_outcome") "registered_surface_present")
 let roles ← rows.mapM (fun row => field row "source_record_role" >>= text)
 return .object [
  ("absence_is_EmptyOne",.boolean (absent noBond)),
  ("first_count",.integer (.ofNat first.directCount.value)),
  ("first_class",.text first.classification.label),
  ("successor_count",.integer (.ofNat next.directCount.value)),
  ("complete_target_count",.integer (.ofNat rows.length)),
  ("complete_source_count",.integer (.ofNat uniqueSources.length)),
  ("all_registered_surfaces_present",.boolean (surfaces.all CoordinationAnalysis.truthy)),
  ("example_count",.integer (.ofNat (roles.filter (fun role => Text.contains role "example")).length)),
  ("explicit_exclusion_count",← field post "explicit_exclusion_count"),
  ("scope_distinction_count",← field post "scope_distinction_count"),
  ("complete_target_vector_hash",← field post "complete_target_vector_hash"),
  ("source_recapture_count",← field post "source_recapture_count"),
  ("all_rows_preserved",← field post "all_rows_preserved")]
end SFT.Chemistry.OrganometallicBondAnalysis
