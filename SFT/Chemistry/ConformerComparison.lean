import SFT.Chemistry.ConformerAnalysis
import SFT.Chemistry.CoordinationAnalysis
import SFT.Chemistry.MulticentreControls
import SFT.Chemistry.FiniteMicrostateSupportSource
namespace SFT.Chemistry.ConformerComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)

abbrev J := Canonical.Value

def expectedLaws : List String := ["complete-cartesian-held-state-generation","exhaustive-graph-automorphism-census","exact-disjoint-orbit-equivalence","development-observed-complete-external-census-after-seal"]
def cellAt : List Value → Nat → Except String Value
 | [],_ => .error "tuple index out of range"
 | x::_,0 => .ok x
 | _::xs,n+1 => cellAt xs n

def compare (predicted : JointCorrelationComparison.Predictions) (released : List (String × J)) (row : J) : Except String J := do
 let targetId ← field row "target_id" >>= text
 let word ← JointCorrelationComparison.lookup predicted targetId
 let cells ← match word with
  | .word cells => pure cells
  | .emptyOne _ | .count _ | .ratio _ _ | .label _ | .pair _ _ | .table _ => throw "prediction consequence requires a word"
 let values ← ["source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"].mapM (ConformerPrediction.identityText row)
 let identities ← (values.zipIdx 1).mapM fun (value,index) => do
  let cell ← cellAt cells index
  return match cell with
   | .label h => Text.equal h.label value
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
 let lawLabels ← (cells.drop 7).mapM fun cell => match cell with
  | .label h => pure h.label
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "law consequence requires a label"
 let lawMatch := lawLabels.length==expectedLaws.length && (lawLabels.zip expectedLaws).all (fun (a,b) => Text.equal a b)
 let actual ← match released.find? (fun p => Text.equal p.1 targetId) with
  | some p => pure p.2
  | none => throw (Text.intercalate "" ["'",targetId,"'"])
 let wanted := canonical (.label (← heldLabel "external-complete-source-record-hash" (← field row "target_payload_hash" >>= text)))
 let targetMatch := ConformerPrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (analysis document : J) (released : List (String × J)) : Except String (List (String × Bool)) := do
 let get := ConformerPrediction.get analysis
 let documentText := HalfReactionOrientationAnalysis.casefold (FiniteMicrostateSupportSource.spacedRender document)
 return [("omitted_source_rejected",StateSymmetryControls.rejected (ConformerAnalysis.analysis (rows.take (rows.length-1)) (.object []))),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("all_four_target_hashes_bound_postseal",released.length==4),
  ("development_observed_not_mislabelled_blind",ConformerPrediction.equal (get "outcome_unopened_blind_target_count") (.integer 0)),
  ("complete_assignment_partition",ConformerPrediction.equal (get "partition_occurrence_count") (get "generated_assignment_count") && ConformerPrediction.equal (get "generated_assignment_count") (.integer 3)),
  ("complete_graph_action_census",ConformerPrediction.equal (get "graph_automorphism_count") (.integer 2)),
  ("incomplete_reversal_rejected",CoordinationAnalysis.truthy (get "incomplete_reversal_rejected")),
  ("adverse_gauche_false_row_preserved",CoordinationAnalysis.truthy (get "external_gauche_adverse_false_row_preserved")),
  ("all_external_inscriptions_preserved",CoordinationAnalysis.truthy (get "all_signed_zero_absent_favourable_adverse_and_unresolved_external_inscriptions_preserved")),
  ("prediction_contains_no_returned_conformer_energy_or_payload",!(["anti","gauche","16.6","-125.79","target_payload_hash"].any (Text.contains documentText)))]

def analysisPassed (analysis : J) : Bool :=
 let get := ConformerPrediction.get analysis
 let eq := ConformerPrediction.equal
 eq (get "generated_assignment_count") (.integer 3) &&
 eq (get "equivalence_class_count") (.integer 2) &&
 eq (get "equivalence_class_sizes") (.array [.integer 1,.integer 2]) &&
 eq (get "complete_external_conformer_class_labels") (.array [.text "Anti",.text "Gauche"]) &&
 eq (get "complete_external_conformer_class_count") (.integer 2) &&
 CoordinationAnalysis.truthy (get "conformer_distinct_potential_energy_minimum_surface_present") &&
 CoordinationAnalysis.truthy (get "conformation_single_bond_rotation_surface_present") &&
 CoordinationAnalysis.truthy (get "conformational_analysis_relative_energy_surface_present") &&
 eq (get "external_internal_rotation_barrier_strings") (.array [.text "16.6",.text "",.text "kJ mol -1"]) &&
 eq (get "cccbdb_complete_table_count") (.integer 19) && eq (get "cccbdb_complete_row_count") (.integer 105)
end SFT.Chemistry.ConformerComparison
