import SFT.Physics.FoldFirstReturn
namespace SFT.Physics.GeneratorOperations
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open GeneratorThreeDerivation

inductive CountInput where
 | integer (value : Int)
 | boolean (value : Bool)

def foldWordSupportCount : CountInput → Except String Nat
 | .boolean _ => .error "ValueError: Fold-word depth must be a positive generated count"
 | .integer (.negSucc _) => .error "ValueError: Fold-word depth must be a positive generated count"
 | .integer (.ofNat 0) => .error "ValueError: Fold-word depth must be a positive generated count"
 | .integer (.ofNat (n+1)) => .ok (supportCount (n+1))

def positivePredecessor : CountInput → Except String Nat
 | .boolean _ => .error "ValueError: a positive predecessor requires a count beyond the One"
 | .integer (.negSucc _) => .error "ValueError: a positive predecessor requires a count beyond the One"
 | .integer (.ofNat 0) => .error "ValueError: a positive predecessor requires a count beyond the One"
 | .integer (.ofNat 1) => .error "ValueError: a positive predecessor requires a count beyond the One"
 | .integer (.ofNat (n+2)) => .ok (n+1)

def generatorUnitPart : CountInput → Except String Part
 | .boolean _ => .error "ValueError: Fold-word depth must be a positive generated count"
 | .integer (.negSucc _) => .error "ValueError: Fold-word depth must be a positive generated count"
 | .integer (.ofNat 0) => .error "ValueError: Fold-word depth must be a positive generated count"
 | .integer (.ofNat (n+1)) => .ok (unitPart (n+1) (Nat.zero_lt_succ _))

theorem publicSupport (depth : Nat) : foldWordSupportCount (.integer (.ofNat (depth+1))) =
    .ok (SFT.Foundation.FoldAssembly.supportAfterExtensions (depth+1)).length := by
  change Except.ok (supportCount (depth+1)) = _
  rw [completeSupportCount]

theorem publicPredecessor (n : Nat) : positivePredecessor (.integer (.ofNat (n+2))) = .ok (n+1) := rfl

theorem firstPredecessorWitness (count candidate : Nat) (positive : 0 < candidate)
    (successor : candidate+1 = count) :
    positivePredecessor (.integer (.ofNat count)) = .ok candidate ∧
    ∀ earlier, earlier < candidate → earlier+1 ≠ count := by
  cases candidate with
  | zero => cases positive
  | succ n =>
    cases successor
    refine ⟨rfl,?_⟩
    intro earlier before same
    have eq := Nat.succ.inj same
    exact Nat.ne_of_lt before eq

theorem publicUnit (depth : Nat) : generatorUnitPart (.integer (.ofNat (depth+1))) =
    .ok (unitPart (depth+1) (Nat.zero_lt_succ _)) := rfl

theorem booleanDepthRejected (value : Bool) : foldWordSupportCount (.boolean value) =
    .error "ValueError: Fold-word depth must be a positive generated count" := rfl

theorem booleanPredecessorRejected (value : Bool) : positivePredecessor (.boolean value) =
    .error "ValueError: a positive predecessor requires a count beyond the One" := rfl

end SFT.Physics.GeneratorOperations
