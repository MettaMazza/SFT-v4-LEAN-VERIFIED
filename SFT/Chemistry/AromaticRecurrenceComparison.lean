import SFT.Chemistry.AromaticRecurrenceAnalysis
import SFT.Chemistry.MulticentreControls
import SFT.Chemistry.CoordinationAnalysis
import SFT.Chemistry.AromaticRecurrenceGrammar
import SFT.Chemistry.AromaticRecurrenceSource
import SFT.Chemistry.SourceText
namespace SFT.Chemistry.AromaticRecurrenceComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["complete-two-fibre-cycle-recurrence","complete-four-ordered-pair-cell-layer","positive-recurrence-opening-gap","blind-complete-energy-vector-after-seal"]
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
 let values ← ["source_record_ordinal","source_id","authority","registered_identity","source_record_role","custody_class"].mapM (AromaticRecurrencePrediction.identityText row)
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
 let targetMatch := AromaticRecurrencePrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (_primary analysis document : J) (released : List (String × J)) (_targetHash : String) : Except String (List (String × Bool)) := do
 let get := AromaticRecurrencePrediction.get analysis
 let eq := AromaticRecurrencePrediction.equal
 let documentText := SourceText.casefold (Canonical.render document)
 return [
 ("omitted_source_row_rejected",StateSymmetryControls.rejected (AromaticRecurrenceAnalysis.analysis (rows.take (rows.length-1)) (.object []))),
 ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
 ("all_nine_target_hashes_bound_postseal",released.length==9),
 ("incomplete_pair_cell_layer_rejected",CoordinationAnalysis.truthy (get "incomplete_pair_cell_layer_rejected")),
 ("duplicated_boundary_fibre_rejected",CoordinationAnalysis.truthy (get "duplicated_boundary_fibre_rejected")),
 ("open_two_centre_cycle_rejected",CoordinationAnalysis.truthy (get "open_two_centre_cycle_rejected")),
 ("development_observed_rows_not_mislabelled_blind",eq (get "development_observed_target_count") (.integer 6)),
 ("three_independent_outcomes_opened_only_after_seal",eq (get "outcome_unopened_blind_target_count") (.integer 3)),
 ("blind_recurrence_stability_excess_clears_conservative_envelope",eq (get "blind_recurrence_stability_excess_magnitude_kj_per_mol") (.text "150.39") && eq (get "blind_stability_excess_lower_envelope_kj_per_mol") (.text "143.79")),
 ("external_signed_and_absent_inscriptions_downstream_and_preserved",CoordinationAnalysis.truthy (get "all_signed_and_absent_external_inscriptions_preserved_downstream")),
 ("blind_sources_not_recaptured",eq (get "blind_source_recapture_count") (.integer 0)),
 ("prediction_contains_no_huckel_electron_count_enthalpy_value_sign_uncertainty_or_payload",!["hückel","huckel","4n+2","hfg","82.93","-4.32","-123.14","150.39","target_payload_hash"].any (fun token => Text.contains documentText token))]
def sumValues : J → Int
 | .object fs => fs.foldl (fun total pair => match pair.2 with | .integer n => total+n | .null | .boolean _ | .text _ | .array _ | .object _ => total) 0
 | .null | .boolean _ | .integer _ | .text _ | .array _ => 0
def analysisPassed (analysis : J) : Bool :=
 let get := AromaticRecurrencePrediction.get analysis
 let eq := AromaticRecurrencePrediction.equal
 eq (get "primitive_support_count") (.integer 6) &&
 eq (get "successor_support_count") (.integer 10) &&
 eq (get "second_successor_support_count") (.integer 14) &&
 CoordinationAnalysis.truthy (get "complete_first_return") &&
 CoordinationAnalysis.truthy (get "complete_pair_cell_perturbation_closure") &&
 CoordinationAnalysis.truthy (get "positive_recurrence_opening_gap") &&
 eq (get "complete_target_count") (.integer 9) &&
 eq (get "complete_source_count") (.integer 9) &&
 CoordinationAnalysis.truthy (get "aromatic_cycle_stability_surface_present") &&
 CoordinationAnalysis.truthy (get "cyclic_delocalization_and_thermodynamic_stability_surface_present") &&
 CoordinationAnalysis.truthy (get "resonance_energy_unobservable_estimate_boundary_present") &&
 eq (get "blind_hfg_298_external_strings") (.object [("benzene",.text "82.93"),("cyclohexene",.text "-4.32"),("cyclohexane",.text "-123.14")]) &&
 eq (get "blind_hfg_298_uncertainty_external_strings") (.object [("benzene",.text "0.50"),("cyclohexene",.text "0.98"),("cyclohexane",.text "0.79")]) &&
 eq (get "blind_single_isolated_hydrogenation_magnitude_kj_per_mol") (.text "118.82") &&
 eq (get "blind_cyclic_threefold_hydrogenation_magnitude_kj_per_mol") (.text "206.07") &&
 eq (get "blind_localized_threefold_reference_magnitude_kj_per_mol") (.text "356.46") &&
 eq (get "blind_recurrence_stability_excess_magnitude_kj_per_mol") (.text "150.39") &&
 SolidLocalGenerator.sameInt (sumValues (get "blind_cccbdb_complete_table_counts")) 59 &&
 SolidLocalGenerator.sameInt (sumValues (get "blind_cccbdb_complete_row_counts")) 353 &&
 SolidLocalGenerator.sameInt (sumValues (get "development_webbook_complete_table_counts")) 9 &&
 SolidLocalGenerator.sameInt (sumValues (get "development_webbook_complete_row_counts")) 121 &&
 CoordinationAnalysis.truthy (get "all_rows_preserved")
end SFT.Chemistry.AromaticRecurrenceComparison
