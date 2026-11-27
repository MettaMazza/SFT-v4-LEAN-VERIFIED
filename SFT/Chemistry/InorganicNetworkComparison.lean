import SFT.Chemistry.InorganicNetworkAnalysis
import SFT.Chemistry.MulticentreControls
import SFT.Chemistry.CoordinationAnalysis
import SFT.Chemistry.InorganicNetworkGrammar
namespace SFT.Chemistry.InorganicNetworkComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["complete-species-and-ordered-transition-path","two-occurrence-Lewis-pair-and-retained-adduct","positive-conserved-donor-acceptor-redox-transfer","exact-reversal-and-network-successor"]
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
 let values ← ["source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"].mapM (InorganicNetworkPrediction.identityText row)
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
 let targetMatch := InorganicNetworkPrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (_primary analysis document : J) (released : List (String × J)) (_targetHash : String) : Except String (List (String × Bool)) := do
 let get := InorganicNetworkPrediction.get analysis
 let eq := InorganicNetworkPrediction.equal
 let acidRows := rows.filter (fun row => eq (InorganicNetworkPrediction.get row "source_record_role") (.text "acid-example-introduced-rendered-structure-absent"))
 let absence ← if acidRows.length==1 then do
  let row ← match acidRows with | [] => .error "tuple index out of range" | row::_ => .ok row
  let value ← JointCorrelationTargets.field (← JointCorrelationTargets.field row "source_outcome") "introduced_example_structure_present_after_colon"
  pure (eq value (.boolean false))
  else pure false
 return [("omitted_source_row_rejected",StateSymmetryControls.rejected (InorganicNetworkAnalysis.analysis (rows.take (rows.length-1)) (.object []))),
 ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
 ("all_fifteen_target_hashes_bound_postseal",released.length==15),
 ("missing_network_species_rejected",CoordinationAnalysis.truthy (get "missing_species_rejected")),
 ("rendered_acid_example_absence_preserved",absence),
 ("signed_oxidation_number_downstream_only",!Text.contains InorganicNetworkGrammar.survivorId "signed-oxidation-number-arithmetic"),
 ("sources_not_recaptured",eq (get "source_recapture_count") (.integer 0)),
 ("prediction_contains_no_definition_example_criterion_or_target_payload",!["complete_definition_text","target_payload_hash","For example:","oxidation number"].any (fun token => Text.contains (Canonical.render document) token))]
def analysisPassed (analysis : J) : Bool :=
 let get := InorganicNetworkPrediction.get analysis
 let eq := InorganicNetworkPrediction.equal
 eq (get "acid_base_species_count") (.integer 3) &&
 eq (get "acid_base_step_count") (.integer 1) &&
 eq (get "lewis_pair_occurrence_count") (.integer 2) &&
 CoordinationAnalysis.truthy (get "adduct_retained") &&
 eq (get "redox_species_count") (.integer 2) &&
 eq (get "redox_transfer_count") (.integer 2) &&
 CoordinationAnalysis.truthy (get "reverse_same_transfer_support") &&
 CoordinationAnalysis.truthy (get "reverse_endpoints_swapped") &&
 eq (get "extended_species_count") (.integer 5) &&
 eq (get "extended_step_count") (.integer 2) &&
 eq (get "complete_target_count") (.integer 15) &&
 eq (get "complete_source_count") (.integer 5) &&
 eq (get "development_observed_target_count") (.integer 7) &&
 eq (get "identity_only_unopened_target_count") (.integer 8) &&
 CoordinationAnalysis.truthy (get "all_registered_surfaces_present") &&
 eq (get "rendered_structure_absence_count") (.integer 1) &&
 CoordinationAnalysis.truthy (get "all_rows_preserved")
end SFT.Chemistry.InorganicNetworkComparison
