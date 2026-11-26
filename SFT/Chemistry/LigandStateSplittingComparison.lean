import SFT.Chemistry.LigandStateSplittingAnalysis
import SFT.Chemistry.MulticentreControls
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.LigandStateSplittingComparison
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text)
open CoordinationEntity
abbrev J := Canonical.Value

def expectedLaws : List String := ["five-supports-from-generator-three-and-boundary-rank-two","complete-ligand-incidence-signature-partitions-levels","positive-block-cardinalities-preserve-all-members","exact-normalized-separation-and-complementary-balance","all-thirty-two-definition-development-adverse-absent-ancillary-and-blind-surfaces-retained"]
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
 let values ← ["source_record_ordinal","source_id","authority","source_record_role","custody_class"].mapM (LigandStateSplittingPrediction.identityText row)
 let identities ← (values.zipIdx 1).mapM fun (value,index) => do
  let cell ← cellAt cells index
  return match cell with
   | .label h => Text.equal h.label value
   | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
 let lawLabels ← (cells.drop 6).mapM fun cell => match cell with
  | .label h => pure h.label
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => throw "law consequence requires a label"
 let lawMatch := lawLabels.length==expectedLaws.length && (lawLabels.zip expectedLaws).all (fun (a,b) => Text.equal a b)
 let actual ← match released.find? (fun p => Text.equal p.1 targetId) with
  | some p => pure p.2
  | none => throw (Text.intercalate "" ["'",targetId,"'"])
 let wanted := canonical (.label (← heldLabel "external-complete-source-record-hash" (← field row "target_payload_hash" >>= text)))
 let targetMatch := LigandStateSplittingPrediction.equal actual wanted
 let identityMatch := identities.all id
 return .object [("target_id",.text targetId),("identity_match",.boolean identityMatch),
  ("law_match",.boolean lawMatch),("postseal_target_hash_match",.boolean targetMatch),
  ("passed",.boolean (identityMatch && lawMatch && targetMatch))]

def controls (rows : List J) (primary analysis document : J) (released : List (String × J)) (_targetHash : String) : Except String (List (String × Bool)) := do
 let get := LigandStateSplittingPrediction.get analysis
 let eq := LigandStateSplittingPrediction.equal
 return [("omitted_source_row_rejected",StateSymmetryControls.rejected (LigandStateSplittingAnalysis.analysis (rows.take (rows.length-1)) primary)),
  ("numerical_zero_rejected",StateSymmetryControls.rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("tampered_six_direct_axis_multiplicity_rejected",!eq (get "six_multiplicity_vector") (.array [.integer 2,.integer 3])),
  ("all_32_target_hashes_bound_postseal",released.length==32),
  ("prediction_contains_no_target_payload_hash_or_peak_value",!Text.contains (Canonical.render document) "target_payload_hash" && !Text.contains (Canonical.render document) "48361/200"),
  ("two_adverse_blind_absences_preserved",eq (get "law_sealed_adverse_absence_count") (.integer 2)),
  ("twelve_development_ancillary_rows_preserved",eq (get "development_ancillary_count") (.integer 12))]
def analysisPassed (analysis : J) : Bool :=
 let get := LigandStateSplittingPrediction.get analysis
 let eq := LigandStateSplittingPrediction.equal
 eq (get "generated_support_count") (.integer 5) &&
 eq (get "six_multiplicity_vector") (.array [.integer 3,.integer 2]) &&
 eq (get "six_separation_vector") (.array [.text "2/3"]) &&
 eq (get "six_balance_vector") (.array [.text "2/5",.text "3/5"]) &&
 eq (get "four_multiplicity_vector") (.array [.integer 2,.integer 3]) &&
 eq (get "four_separation_vector") (.array [.text "1"]) &&
 eq (get "four_balance_vector") (.array [.text "3/5",.text "2/5"]) &&
 ["all_members_preserved","removal_remerges_one_five_member_class","iupac_removal_of_degeneracy_surface_present",
  "iupac_ligand_attachment_reduced_symmetry_surface_present","iupac_conventional_variable_parameter_surface_preserved_as_downstream",
  "blind_distinguishability_condition_passed","complete_32_rows_preserved","no_dimensional_wavelength_fitted_or_claimed"].all
  (fun key => CoordinationAnalysis.truthy (get key)) &&
 eq (get "blind_spectrum_payload_count") (.integer 1)
end SFT.Chemistry.LigandStateSplittingComparison
