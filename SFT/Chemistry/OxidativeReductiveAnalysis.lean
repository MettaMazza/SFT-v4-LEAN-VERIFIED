import SFT.Chemistry.OxidativeReductiveSource
import SFT.Chemistry.OxidativeReductiveDerivation
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.OxidativeReductiveAnalysis
open SFT.Host OxidativeReductive
open JointCorrelationTargets (field text)
open OxidativeReductivePrediction (get equal)
abbrev J := Canonical.Value
def rejected {α : Type} : Except String α → Bool
 | .error _ => true | .ok _ => false
def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 5 then throw "INORG-012 requires five surfaces"
 let single ← one
 let split ← two
 let rev ← reductive single
 let third := rejected (oxidative ["M1","M2","M3"] "X" "Y")
 let post ← field primary "exact_postseal_analysis"
 let sourceIds ← rows.mapM (fun row => field row "source_id" >>= text)
 let uniqueSources := sourceIds.foldl (fun out id => if out.any (Text.equal id) then out else out++[id]) []
 let surfaces ← rows.mapM (fun row => do field (← field row "source_outcome") "registered_surface_present")
 return .object [
  ("single_distribution",.array (single.distribution.map fun n => .integer (.ofNat n.value))),
  ("split_distribution",.array (split.distribution.map fun n => .integer (.ofNat n.value))),
  ("carrier_count",.integer (.ofNat single.carriers.length)),
  ("product_incidence_count",.integer (.ofNat single.products.length)),
  ("reverse_restores_source",.boolean (sameLabels rev.restoredBond single.sourceBond)),
  ("third_metal_rejected",.boolean third),
  ("complete_target_count",.integer (.ofNat rows.length)),
  ("complete_source_count",.integer (.ofNat uniqueSources.length)),
  ("all_registered_surfaces_present",.boolean (surfaces.all CoordinationAnalysis.truthy)),
  ("scope_distinction_count",← field post "scope_distinction_count"),
  ("complete_target_vector_hash",← field post "complete_target_vector_hash"),
  ("source_recapture_count",← field post "source_recapture_count"),
  ("all_rows_preserved",← field post "all_rows_preserved")]
end SFT.Chemistry.OxidativeReductiveAnalysis
