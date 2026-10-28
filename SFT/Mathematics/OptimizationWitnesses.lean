import SFT.Mathematics.OptimizationBounds
namespace SFT.Mathematics.OptimizationWitnesses
open OptimizationSelection OptimizationBounds
structure Witness where
  name : String
  statement : String
  passed : Bool

def feasible : Except String (List String) := feasibleCarrier ["a","b","c"] [("a",true),("b",true),("c",false)]
def exactList (result : Except String (List String)) (expected : List String) : Bool :=
  match result with
  | .error _ => false
  | .ok items => decide (items = expected)
def uniqueResult (result : Except String Optimum) : Bool :=
  match result with
  | .error _ => false
  | .ok optimum => match optimum with
    | .unique label => decide (label = "a")
    | .retainedClass _ _ => false
def tiedResult (result : Except String Optimum) : Bool :=
  match result with
  | .error _ => false
  | .ok optimum => match optimum with
    | .unique _ => false
    | .retainedClass tag items => decide (tag = "retained-equivalence-class") && decide (items = ["a","b"])
def witnesses : List Witness := [
  ⟨"feasible-selection","The complete verdict relation retains exactly a and b.",(exactList feasible ["a","b"])⟩,
  ⟨"unique-optimum","A witnessed a-over-b relation leaves a as the singleton optimum.",(match feasible with | .error _ => false | .ok held => uniqueResult (exactOptimum held [("a","b")]))⟩,
  ⟨"ties-retained","With no forced preference both feasible forms survive explicitly.",(match feasible with | .error _ => false | .ok held => tiedResult (exactOptimum held []))⟩,
  ⟨"constraint-membership","The witness candidate is checked against every exact allowed set.",(respectsConstraints "a" [("first",["a","b"]),("second",["a","c"])])⟩,
  ⟨"pareto-incomparability","Opposed exact criteria retain both incomparable forms.",(decide (paretoFrontier ["a","b"] [("left",[("a","b")]),("right",[("b","a")])] = ["a","b"]))⟩,
  ⟨"exact-bound","Three generated cells against a two-cell optimum produce exact two-over-three.",(match exactApproximation 3 2 with | .error _ => false | .ok part => part.numerator == 2 && part.denominator == 3)⟩
]

theorem allWitnessesPass : witnesses.all Witness.passed = true := rfl

end SFT.Mathematics.OptimizationWitnesses
