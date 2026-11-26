import SFT.Chemistry.CoordinationGeometrySource
import SFT.Chemistry.CoordinationGeometry
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.CoordinationGeometryAnalysis
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field)
open CoordinationGeometry
abbrev J := Canonical.Value

-- Original validator _entity and _geometry, including retained analysis identities.
def analysisEntity (width : Nat) : Except String CoordinationEntity.Entity := do
 let central ← heldLabel "coordination-central-occurrence" "analysis-centre"
 let attachments ← (List.range width).mapM fun i => do
  let n := i+1
  CoordinationEntity.attachment (← count n) central
   (← heldLabel "coordination-ligand-occurrence" (Text.append "analysis-ligand-" (toString n)))
   (← heldLabel "coordination-ligand-group" "analysis-ligand-group")
   (← heldLabel "positive-coordination-incidence" (Text.append "analysis-incidence-" (toString n)))
 CoordinationEntity.construct
  (← heldLabel "coordination-entity" (Text.append "analysis-entity-" (toString width)))
  (← heldLabel "coordination-central-element" "analysis-element") central attachments

def analysisGeometry (entity : CoordinationEntity.Entity) (changedSecond : Bool := false) : Except String Geometry := do
 let positions ← (entity.orderedAttachments.zipIdx 1).mapM fun (attachment,n) => do
  let second : OrientationCell ← (if changedSecond && n==2 then do
   return OrientationCell.held (← heldLabel "fold-orientation-fibre" "fibre-two")
   else pure (OrientationCell.empty "empty-One"))
  position (← count n) attachment.ligandOccurrence
   [.held (← heldLabel "fold-orientation-fibre" (Text.append "fibre-" (toString n))),second,.empty "empty-One"]
 let edges ← (entity.orderedAttachments.zip (entity.orderedAttachments.drop 1)).zipIdx 1 |>.mapM fun ((a,b),n) => do
  adjacency a.ligandOccurrence b.ligandOccurrence
   (← heldLabel "coordination-boundary-adjacency" (Text.append (Text.append (Text.append "analysis-edge-" (toString n)) "-") (toString (n+1))))
 construct entity.centralOccurrence positions edges

def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 53 || !CoordinationGeometryPrediction.completeOrdinals 1 rows then
  throw "INORG-004 requires all 53 source records"
 let entity ← analysisEntity 2
 let first ← forced entity (← analysisGeometry entity)
 let second ← forced entity (← analysisGeometry entity true)
 let sourceAnalysis ← field primary "exact_postseal_analysis"
 let vector ← match ← field primary "complete_corrected_geometry_vector" with
  | .array values => pure values
  | .null | .text _ | .boolean _ | .integer _ | .object _ => throw "complete corrected geometry vector requires a sequence"
 let copied ← ["iupac_direct_ligand_position_central_relation_retained",
  "all_original_target_identity_mismatches_preserved","all_corrected_source_identities_retained",
  "positive_direct_incidence_counts_two_through_six_retained",
  "all_point_group_inscriptions_retained_without_shape_selection",
  "all_coordinate_surfaces_preserved_including_reported_absence",
  "all_reference_and_absence_status_surfaces_retained","all_fifty_three_target_surfaces_retained"].mapM fun key => do
   return (key,← field sourceAnalysis key)
 let pointGroups ← vector.mapM fun row => field row "source_point_group_inscription"
 let incidences ← vector.mapM fun row => field row "declared_positive_incidence_count"
 let surfaces ← vector.mapM fun row => field row "source_internal_coordinate_surface"
 return .object ([
  ("complete_registered_target_count",.integer (.ofNat rows.length)),
  ("positive_count_two_reconstructed",.boolean (first.positiveCoordinationCount.value==2)),
  ("generator_three_reconstructed",.boolean (first.generatedSpaceRank.value==3)),
  ("boundary_rank_two_reconstructed",.boolean (first.boundaryRank.value==2)),
  ("equal_count_different_orientation_has_different_signature",.boolean
   (first.positiveCoordinationCount.value==second.positiveCoordinationCount.value &&
    !(samePositions first.positions second.positions && sameAdjacencies first.adjacencies second.adjacencies)))] ++ copied ++ [
  ("complete_external_point_group_vector",.array pointGroups),
  ("complete_external_positive_incidence_vector",.array incidences),
  ("coordinate_absence_rows_retained",.integer (.ofNat (surfaces.filter fun v => !CoordinationAnalysis.truthy v).length)),
  ("point_group_or_coordinate_used_as_fold_parameter",← field primary "point_group_shape_angle_distance_or_coordinate_used_as_fold_proof_parameter"),
  ("coordination_count_used_to_select_shape",← field primary "coordination_count_alone_used_to_select_geometry")])
end SFT.Chemistry.CoordinationGeometryAnalysis
