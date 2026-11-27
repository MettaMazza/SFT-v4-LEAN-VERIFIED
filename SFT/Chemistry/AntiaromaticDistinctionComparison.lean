import SFT.Chemistry.AntiaromaticDistinctionAnalysis
import SFT.Chemistry.MulticentreControls
import SFT.Chemistry.CoordinationAnalysis
import SFT.Chemistry.AntiaromaticDistinctionGrammar
import SFT.Chemistry.AromaticRecurrenceComparison
import SFT.Chemistry.AntiaromaticDistinctionSource
import SFT.Chemistry.SourceText
namespace SFT.Chemistry.AntiaromaticDistinctionComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["complete-three-class-same-cycle-census","exact-closed-broken-frustrated-support-boundary","positive-two-step-stability-order","blind-complete-structure-energy-vector-after-seal"]
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
 let values ← ["source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"].mapM (AntiaromaticDistinctionPrediction.identityText row)
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
 let targetMatch := AntiaromaticDistinctionPrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (_primary analysis document : J) (released : List (String × J)) (_targetHash : String) : Except String (List (String × Bool)) := do
 let get := AntiaromaticDistinctionPrediction.get analysis
 let eq := AntiaromaticDistinctionPrediction.equal
 let truth := fun key => CoordinationAnalysis.truthy (get key)
 let documentText := SourceText.casefold (Canonical.render document)
 return [
 ("omitted_source_row_rejected",StateSymmetryControls.rejected (AntiaromaticDistinctionAnalysis.analysis (rows.take (rows.length-1)) (.object []))),
 ("numerical_zero_rejected_by_fold_program",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
 ("all_five_target_hashes_bound_postseal",released.length==5),
 ("inconsistent_antiaromatic_break_rejected",truth "inconsistent_antiaromatic_break_rejected"),
 ("missing_nonaromatic_break_rejected",truth "missing_nonaromatic_break_rejected"),
 ("development_observed_rows_not_mislabelled_blind",eq (get "development_observed_target_count") (.integer 3)),
 ("two_independent_outcomes_opened_only_after_seal",eq (get "outcome_unopened_blind_target_count") (.integer 2)),
 ("complete_blind_structure_vector_present",truth "blind_true_and_false_minimum_rows_present" && truth "blind_cot_bond_alternation_rows_present" && truth "blind_cyclooctatetraene_opposed_z_coordinate_signs_present"),
 ("positive_repeated_unit_energy_gap_clears_uncertainty",eq (get "exact_repeated_ch_unit_lower_gap_kj_per_mol") (.text "578/25")),
 ("absent_cyclobutadiene_hfg_preserved_not_fabricated",truth "blind_cyclobutadiene_hfg_absence_preserved"),
 ("external_signed_zero_and_absent_inscriptions_downstream",truth "all_signed_and_absent_external_inscriptions_preserved_downstream"),
 ("prediction_contains_no_class_name_geometry_energy_value_sign_uncertainty_or_payload",!["cyclobutadiene","cyclooctatetraene","d2h","d2d","1.337","1.470","82.93","297.60","8.160","hfg","target_payload_hash"].any (fun token => Text.contains documentText token))]
def sumValues := AromaticRecurrenceComparison.sumValues
def analysisPassed (analysis : J) : Bool :=
 let get := AntiaromaticDistinctionPrediction.get analysis
 let eq := AntiaromaticDistinctionPrediction.equal
 eq (get "base_supports") (.array [.integer 6,.text "structural-EmptyOne",.integer 4]) &&
 eq (get "successor_supports") (.array [.integer 10,.text "structural-EmptyOne",.integer 8]) &&
 eq (get "exact_class_order") (.array [.text "closed-aromatic-recurrence",.text "broken-nonaromatic-recurrence",.text "frustrated-antiaromatic-recurrence"]) &&
 eq (get "complete_target_count") (.integer 5) &&
 eq (get "complete_source_count") (.integer 5) &&
 CoordinationAnalysis.truthy (get "aromatic_closed_cycle_and_stability_surface_present") &&
 CoordinationAnalysis.truthy (get "antiaromatic_reduced_stability_surface_present") &&
 CoordinationAnalysis.truthy (get "antiaromatic_bond_alternation_surface_present") &&
 eq (get "blind_conformation_external_strings") (.object [("cyclobutadiene",.text "D2H"),("cyclooctatetraene",.text "D2D")]) &&
 eq (get "blind_cyclobutadiene_ionization_energy_external_strings_ev") (.array [.text "8.160",.text "0.030"]) &&
 eq (get "blind_cyclooctatetraene_hfg_external_strings_kj_per_mol") (.array [.text "297.60",.text "1.40"]) &&
 eq (get "development_benzene_hfg_external_strings_kj_per_mol") (.array [.text "82.93",.text "0.50"]) &&
 eq (get "exact_repeated_ch_unit_hfg_gap_kj_per_mol") (.text "14027/600") &&
 SolidLocalGenerator.sameInt (sumValues (get "blind_cccbdb_complete_table_counts")) 36 &&
 SolidLocalGenerator.sameInt (sumValues (get "blind_cccbdb_complete_row_counts")) 172 &&
 eq (get "development_webbook_complete_table_count") (.integer 3) &&
 eq (get "development_webbook_complete_row_count") (.integer 54) &&
 CoordinationAnalysis.truthy (get "all_favourable_adverse_absent_scope_and_unresolved_rows_preserved")
end SFT.Chemistry.AntiaromaticDistinctionComparison
