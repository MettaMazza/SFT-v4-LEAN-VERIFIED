import SFT.Chemistry.SolidLocalSource
import SFT.Chemistry.SolidLocalGenerator
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.SolidLocalAnalysis
open SFT.Host SolidLocal SolidLocalGenerator
open JointCorrelationTargets (field text)
open SolidLocalPrediction (get equal)
abbrev J := Canonical.Value
def vector (s : Solid) : J := .array (s.formula.map fun f => .integer (.ofNat f.primitiveCount.value))
def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 10 then throw "INORG-015 requires all ten external surfaces"
 let b ← base
 let g ← guest
 let anchor ← match b.occurrences with | [] | [_] => .error "tuple index out of range" | _::a::_ => .ok a
 let s ← appendOccurrence b "A" anchor
 let post ← field primary "exact_postseal_analysis"
 let sourceIds ← rows.mapM (fun row => field row "source_id" >>= text)
 let uniqueSources := sourceIds.foldl (fun out id => if out.any (Text.equal id) then out else out++[id]) []
 let surfaces ← rows.mapM (fun row => do field (← field row "source_outcome") "registered_surface_present")
 let custody ← rows.mapM (fun row => field row "custody_class" >>= text)
 return .object [
  ("primitive_formula_vector",vector b),("guest_formula_vector",vector g),
  ("generated_repeat_rank",.integer (.ofNat g.repeatAxes.length)),
  ("second_constituent_count",.integer (.ofNat (match g.constituent with | .emptyOne _ => 0 | .support xs => xs.length))),
  ("structural_constituent_absence",.boolean (match b.constituent with | .emptyOne _ => true | .support _ => false)),
  ("successor_formula_vector",vector s),("rank_four_rejected",.boolean rankWitness),
  ("complete_target_count",.integer (.ofNat rows.length)),
  ("complete_source_count",.integer (.ofNat uniqueSources.length)),
  ("development_observed_target_count",.integer (.ofNat (custody.filter (Text.equal "family-development-observed")).length)),
  ("identity_only_unopened_target_count",.integer (.ofNat (custody.filter (Text.equal "family-identity-only-unopened")).length)),
  ("all_registered_surfaces_present",.boolean (surfaces.all CoordinationAnalysis.truthy)),
  ("scope_mismatch_or_distinction_count",← field post "scope_mismatch_or_distinction_count"),
  ("complete_target_vector_hash",← field post "complete_target_vector_hash"),
  ("source_recapture_count",← field post "source_recapture_count"),
  ("all_rows_preserved",← field post "all_rows_preserved")]
end SFT.Chemistry.SolidLocalAnalysis
