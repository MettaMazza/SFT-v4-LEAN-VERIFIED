import SFT.Chemistry.OrganometallicElectronAccountSource
import SFT.Chemistry.OrganometallicElectronAccount
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.OrganometallicElectronAccountAnalysis
open SFT.Host OrganometallicElectronAccount
open JointCorrelationTargets (field text)
open OrganometallicElectronAccountPrediction (get equal)
abbrev J := Canonical.Value
def rejected {α : Type} : Except String α → Bool
 | .error _ => true | .ok _ => false
def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 4 then throw "INORG-011 requires all four source surfaces"
 let full ← complete
 let part ← partialAccount
 let next ← appendPair part "bond"
 let overflow := rejected (appendPair full "bond")
 let post ← field primary "exact_postseal_analysis"
 let surfaces ← rows.mapM (fun row => do field (← field row "source_outcome") "registered_surface_present")
 return .object [
  ("s_width",.integer 2),("p_width",.integer 6),("d_width",.integer 10),
  ("capacity",.integer (.ofNat forcedCapacity.value)),
  ("complete_count",.integer (.ofNat full.electronCount.value)),
  ("complete_relation",.text full.relation.label),
  ("partial_count",.integer (.ofNat part.electronCount.value)),
  ("successor_count",.integer (.ofNat next.electronCount.value)),
  ("overflow_rejected",.boolean overflow),
  ("complete_target_count",.integer (.ofNat rows.length)),
  ("all_registered_surfaces_present",.boolean (surfaces.all CoordinationAnalysis.truthy)),
  ("complete_target_vector_hash",← field post "complete_target_vector_hash"),
  ("source_recapture_count",← field post "source_recapture_count"),
  ("all_rows_preserved",← field post "all_rows_preserved")]
end SFT.Chemistry.OrganometallicElectronAccountAnalysis
