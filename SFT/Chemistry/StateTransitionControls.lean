import SFT.Chemistry.StateTransitionComparison
import SFT.Chemistry.MulticentreControls
namespace SFT.Chemistry.StateTransitionControls
open SFT.Host SFT.Physics.CapabilityValues
open MolecularStateTransition
open StateSymmetryControls (rejected)
open MulticentreControls (textAt)
abbrev J := Canonical.Value

def counts (rows : List J) : Except String (List (String × Nat)) := do
 let kinds ← rows.mapM (fun row => textAt row "row_kind")
 let classes ← rows.mapM (fun row => textAt row "observation_class")
 let bands ← rows.mapM (fun row => textAt row "exact_band")
 return [("records",rows.length),("primary",(kinds.filter (Text.equal · "primary-state")).length),
  ("continuation",(kinds.filter (Text.equal · "continuation-transition")).length),
  ("directional",(classes.filter (Text.equal · "observed-directional-transition")).length),
  ("coupled",(classes.filter (Text.equal · "observed-coupled-state-relation")).length),
  ("absent_transition",(classes.filter (Text.equal · "absent-transition-coordinate")).length),
  ("positive_band",(bands.filter (fun s => !Text.equal s "structural-absence")).length),
  ("absent_band",(bands.filter (Text.equal · "structural-absence")).length)]
def expectedCounts : List (String × Nat) := [("records",60),("primary",46),("continuation",14),
 ("directional",55),("coupled",4),("absent_transition",1),("positive_band",55),("absent_band",5)]

def adverse (counts : List (String × Nat)) (actualHash changedHash : String) : Except String (List (String × Bool)) := do
 let first ← observedTransition "H2" "A" "B" forward "A-B"
 let second ← observedTransition "H2" "B" "C" forward "B-C"
 let composed ← composeTransitionPath first second
 let other ← observedTransition "H2" "D" "E" forward "D-E"
 let absence ← absentTransition "H2" "A" "absent"
 let oldBand ← StateTransitionInscription.exactBand "26232.3"
 let newBand ← StateTransitionInscription.exactBand "26232.4"
 let allCounts := counts.length==expectedCounts.length && expectedCounts.all (fun (key,n) => counts.any (fun (k,m) => Text.equal key k && n==m))
 return [("matching_path_composes",composed.length==6),
  ("mismatched_endpoints_rejected",rejected (composeTransitionPath first other)),
  ("self_transition_rejected",rejected (observedTransition "H2" "A" "A" forward "invalid")),
  ("absence_composition_rejected",rejected (composeTransitionPath absence second)),
  ("numerical_zero_rejected",rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])),
  ("omitted_primary_rejected",(← PairExchangeControls.countAt counts "primary")==46),
  ("omitted_continuation_rejected",(← PairExchangeControls.countAt counts "continuation")==14),
  ("present_only_selection_rejected",(← PairExchangeControls.countAt counts "absent_transition")==1),
  ("coupling_rows_retained",(← PairExchangeControls.countAt counts "coupled")==4),
  ("changed_band_rejected",!equal oldBand newBand),
  ("tampered_source_rejected",Text.equal actualHash StateTransitionTargets.sourceHash && !Text.equal changedHash StateTransitionTargets.sourceHash),
  ("complete_vector_retained",allCounts)]
end SFT.Chemistry.StateTransitionControls
