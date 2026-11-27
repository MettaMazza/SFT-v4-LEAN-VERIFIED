import SFT.Chemistry.MetalClusterSource
import SFT.Chemistry.MetalCluster
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.MetalClusterAnalysis
open SFT.Host MetalCluster
open JointCorrelationTargets (field text)
open MetalClusterPrediction (get equal)
abbrev J := Canonical.Value
def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 10 then throw "INORG-014 requires ten surfaces"
 let d ← direct
 let b ← bridged
 let g ← grouped
 let s ← appendCentre b "M3" "M2" "bridging-ligand-path"
 let post ← field primary "exact_postseal_analysis"
 let sourceIds ← rows.mapM (fun row => field row "source_id" >>= text)
 let uniqueSources := sourceIds.foldl (fun out id => if out.any (Text.equal id) then out else out++[id]) []
 let surfaces ← rows.mapM (fun row => do field (← field row "source_outcome") "registered_surface_present")
 let roles ← rows.mapM (fun row => field row "source_record_role" >>= text)
 return .object [
  ("direct_centre_count",.integer (.ofNat d.centreCount.value)),
  ("direct_bond_count",.integer (.ofNat (positiveValue d.directCount))),
  ("bridge_ligand_occurrence_count",.integer (.ofNat (match b.relations with | [] => 0 | r::_ => r.bridges.length))),
  ("bridge_path_count",.integer (.ofNat (positiveValue b.bridgeCount))),
  ("group_direct_absence",.boolean (isEmpty g.directCount)),
  ("successor_centre_count",.integer (.ofNat s.centreCount.value)),
  ("disconnected_rejected",.boolean disconnectedWitness),
  ("complete_target_count",.integer (.ofNat rows.length)),
  ("complete_source_count",.integer (.ofNat uniqueSources.length)),
  ("all_registered_surfaces_present",.boolean (surfaces.all CoordinationAnalysis.truthy)),
  ("charge_inscription_surface_count",.integer (.ofNat (roles.filter (fun x => Text.contains x "charge-inscriptions")).length)),
  ("complete_target_vector_hash",← field post "complete_target_vector_hash"),
  ("source_recapture_count",← field post "source_recapture_count"),
  ("all_rows_preserved",← field post "all_rows_preserved")]
end SFT.Chemistry.MetalClusterAnalysis
