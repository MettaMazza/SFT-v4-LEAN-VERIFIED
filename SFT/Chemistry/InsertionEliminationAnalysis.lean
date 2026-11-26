import SFT.Chemistry.InsertionEliminationSource
import SFT.Chemistry.InsertionEliminationDerivation
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.InsertionEliminationAnalysis
open SFT.Host InsertionElimination
open JointCorrelationTargets (field text)
open InsertionEliminationPrediction (get equal)
abbrev J := Canonical.Value
def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 10 then throw "INORG-013 requires ten surfaces"
 let ins ← insertion "X" "Z" "Y"
 let rev ← extrusion ins
 let mig ← migratory "M" "X" "Y"
 let distinct ← elimination "A" "B" "X" "Y"
 let same ← elimination "A" "A" "X" "Y"
 let post ← field primary "exact_postseal_analysis"
 let sourceIds ← rows.mapM (fun row => field row "source_id" >>= text)
 let uniqueSources := sourceIds.foldl (fun out id => if out.any (Text.equal id) then out else out++[id]) []
 let surfaces ← rows.mapM (fun row => do field (← field row "source_outcome") "registered_surface_present")
 return .object [
  ("insertion_before_count",.integer (.ofNat ins.before.length)),
  ("insertion_after_count",.integer (.ofNat ins.after.length)),
  ("insertion_removed_count",.integer (.ofNat ins.removed.length)),
  ("insertion_added_count",.integer (.ofNat ins.added.length)),
  ("extrusion_restores_source",.boolean (OxidativeReductive.sameIncidences rev.after ins.before)),
  ("migratory_composition",.array (mig.composition.map fun c => .text c.label)),
  ("migratory_common_edge_count",.integer (.ofNat ((uniqueEdges mig.before).filter (containsEdge mig.after)).length)),
  ("distinct_eliminand_removed_count",.integer (.ofNat distinct.removed.length)),
  ("single_centre_carrier_count",.integer (.ofNat same.carriers.length)),
  ("complete_target_count",.integer (.ofNat rows.length)),
  ("complete_source_count",.integer (.ofNat uniqueSources.length)),
  ("all_registered_surfaces_present",.boolean (surfaces.all CoordinationAnalysis.truthy)),
  ("scope_distinction_count",← field post "scope_distinction_count"),
  ("rendered_structure_absence_count",← field post "rendered_structure_absence_count"),
  ("complete_target_vector_hash",← field post "complete_target_vector_hash"),
  ("source_recapture_count",← field post "source_recapture_count"),
  ("all_rows_preserved",← field post "all_rows_preserved")]
end SFT.Chemistry.InsertionEliminationAnalysis
