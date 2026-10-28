import SFT.Mathematics.DynamicsStability
namespace SFT.Mathematics.DynamicsWitnesses
open DynamicsTraces DynamicsReturns DynamicsStability
structure Witness where
  name : String
  statement : String
  passed : Bool

def states : List String := ["a","b","terminal"]
def flow : Transitions := [("a","b"),("b","terminal"),("terminal","terminal")]
def merge : Transitions := [("a","terminal"),("b","terminal"),("terminal","terminal")]
def timePairs : Bool := match transitionTime ["a","b","terminal"] with
  | .error _ => false
  | .ok result => match result with
    | .inl _ => false
    | .inr pairs => decide (pairs = [("a","b"),("b","terminal")])
def timeIdentity : Bool := match transitionTime ["a"] with
  | .error _ => false
  | .ok result => match result with
    | .inl labels => decide (labels = ["empty-One"])
    | .inr _ => false
def stableCheck : Bool := stableUnderRegisteredPerturbations flow "terminal" states

theorem stableCheckPassed : stableCheck = true := by
  apply (stabilityMeaning flow "terminal" states).mpr
  intro start member
  cases member with
  | head => exact Reaches.step (Reaches.step Reaches.identity (List.Mem.head _)) (List.Mem.tail _ (List.Mem.head _))
  | tail _ member => cases member with
    | head => exact Reaches.step Reaches.identity (List.Mem.tail _ (List.Mem.head _))
    | tail _ member => cases member with
      | head => exact Reaches.identity
      | tail _ member => cases member

def witnesses : List Witness := [
  ⟨"well-formed","Every witness transition remains in the complete state carrier.",(validDynamics states flow)⟩,
  ⟨"trajectory","The a-to-b-to-terminal trace retains both allowed transitions.",(trajectoryValid flow ["a","b","terminal"])⟩,
  ⟨"time","Two transitions are retained exactly and an identity trajectory returns empty One.",(timePairs && timeIdentity)⟩,
  ⟨"fixed-form","The terminal witness has an explicit identity transition.",(decide (fixedForms flow = ["terminal"]))⟩,
  ⟨"first-return","A repeated canonical state yields its exact first return trace.",(decide (firstReturn ["a","b","a","b"] = some ["a","b","a"]))⟩,
  ⟨"predecessor-retention","Both merged predecessors remain distinct and an exact retained ledger reverses them.",(decide (predecessorRecords merge "terminal" = ["a","b","terminal"]) && reversibleWithRecord merge merge)⟩,
  ⟨"registered-stability","Every registered witness perturbation reaches terminal.",(stableCheck)⟩
]

theorem allWitnessesPass : witnesses.all Witness.passed = true := by
  change (stableCheck && true) = true
  rw [stableCheckPassed]
  rfl

end SFT.Mathematics.DynamicsWitnesses
