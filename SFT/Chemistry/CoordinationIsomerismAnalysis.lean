import SFT.Chemistry.CoordinationIsomerismSource
import SFT.Chemistry.CoordinationIsomerismWitnesses
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.CoordinationIsomerismAnalysis
open SFT.Host SFT.Physics.CapabilityValues CoordinationIsomerism
open JointCorrelationTargets (field)
abbrev J := Canonical.Value
def word (labels : List String) : Except String (List Cell) := labels.mapM fun label => do
 if Text.equal label "EmptyOne" then return .empty "empty-One"
 return .held (← heldLabel "fold-orientation-fibre" label)
def makeForm (compositions attachments : List String) (words : List (List String))
 (pairs : List (Nat × Nat)) : Except String Form := do
 construct (← compositions.mapM (heldLabel "coordination-composition-label"))
  (← attachments.mapM (heldLabel "coordination-attachment-mode"))
  (← words.mapM word) (← pairs.mapM fun (a,b) => do return (← count a,← count b))
-- Python dictionary unpacking updates an existing key, retaining its position.
def store (rows : List (String × J)) (key : String) (value : J) : List (String × J) :=
 if rows.any (fun row => Text.equal row.1 key) then
  rows.map (fun row => if Text.equal row.1 key then (key,value) else row)
 else rows++[(key,value)]
def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 17 || !CoordinationIsomerismPrediction.completeOrdinals 1 rows then
  throw "INORG-005 requires all 17 source records"
 let base ← CoordinationIsomerismWitnesses.base
 let reordered ← makeForm ["L","L"] ["mode-one","mode-one"]
  [["fibre-two","EmptyOne","EmptyOne"],["fibre-one","EmptyOne","EmptyOne"]] [(1,2)]
 let attachment ← CoordinationIsomerismWitnesses.attachmentForm
 let orientation ← CoordinationIsomerismWitnesses.orientationForm
 let chiral ← CoordinationIsomerismWitnesses.chiral
 let mirrorForm ← makeForm ["A","B","C"] ["mode-one","mode-one","mode-one"]
  [["fibre-two","EmptyOne","EmptyOne"],["fibre-two","fibre-one","EmptyOne"],
   ["fibre-one","fibre-two","EmptyOne"]] [(1,2),(2,3),(3,1)]
 let successor ← CoordinationIsomerismWitnesses.successor
 let equivalentRecord ← forced base reordered
 let attachmentRecord ← forced base attachment
 let orientationRecord ← forced base orientation
 let mirrorRecord ← forced chiral mirrorForm
 let different ← makeForm ["L","M"] ["mode-one","mode-one"]
  [["fibre-one","EmptyOne","EmptyOne"],["fibre-two","EmptyOne","EmptyOne"]] [(1,2)]
 let differentRejected := match forced base different with
  | .error _ => true
  | .ok _ => false
 let sourceAnalysis ← (match ← field primary "exact_postseal_analysis" with
  | .object fs => pure fs
  | .null | .text _ | .boolean _ | .integer _ | .array _ => throw "postseal analysis must be a mapping")
 let retained := CoordinationIsomerismWitnesses.sameList MulticentreSupport.sameLabel
    (successor.composition.take 2) base.composition &&
  CoordinationIsomerismWitnesses.sameList MulticentreSupport.sameLabel (successor.attachment.take 2) base.attachment &&
  CoordinationIsomerismWitnesses.sameList (CoordinationIsomerismWitnesses.sameList CoordinationIsomerismWitnesses.sameCell)
   (successor.orientation.take 2) base.orientation &&
  CoordinationIsomerismWitnesses.sameList (fun (a,b) (c,d) => a.value==c.value && b.value==d.value)
   (successor.adjacency.take 1) base.adjacency
 let twoFibres := [base,reordered,attachment,orientation,chiral,mirrorForm,successor].all fun f =>
  f.orientation.all fun w => w.all fun c => match c with
   | .empty _ => true
   | .held h => Text.equal h.label "fibre-one" || Text.equal h.label "fibre-two"
 let initial : List (String × J) := [
  ("complete_registered_target_count",.integer (.ofNat rows.length)),
  ("occurrence_permutation_equivalence_reconstructed",.boolean equivalentRecord.exactEquivalence),
  ("different_composition_rejected",.boolean differentRejected),
  ("attachment_class_reconstructed",.boolean (Text.equal attachmentRecord.nativeDistinctionClass.label "attachment-class-distinction")),
  ("orientation_adjacency_class_reconstructed",.boolean (Text.equal orientationRecord.nativeDistinctionClass.label "orientation-adjacency-class-distinction")),
  ("mirror_complement_class_reconstructed",.boolean (Text.equal mirrorRecord.nativeDistinctionClass.label "mirror-complement-class-distinction")),
  ("successor_preserves_complete_prior_subform",.boolean retained),
  ("only_two_forced_fibre_labels_used",.boolean twoFibres)]
 let merged := sourceAnalysis.foldl (fun acc (key,value) => store acc key value) initial
 let final ← [("registered_to_presented_identity_redirect_count","registered_to_presented_identity_redirect_count"),
  ("registered_to_presented_identity_redirects_preserved","registered_to_presented_identity_redirects_preserved"),
  ("explicit_linkage_literal_absence_preserved","explicit_linkage_literal_absence_preserved"),
  ("imported_catalogue_or_observed_class_used_as_fold_parameter","isomer_catalogue_name_point_group_plane_mirror_or_observed_class_used_as_fold_proof_parameter")].mapM fun (key,source) => do return (key,← field primary source)
 return .object (final.foldl (fun acc (key,value) => store acc key value) merged)
end SFT.Chemistry.CoordinationIsomerismAnalysis
