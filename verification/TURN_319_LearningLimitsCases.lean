import SFT.Computation.LearningLimits
namespace SFT.Computation.LearningLimits
example : observed [] ("h",[]) = [] := by decide
example : observed ["a"] ("h",[]) = [] := by decide
example : observed ["b"] ("h",[]) = [] := by decide
example : observed ["a","b"] ("h",[]) = [] := by decide
example : observed [] ("h",[("a","x")]) = [] := by decide
example : observed ["a"] ("h",[("a","x")]) = [("a","x")] := by decide
example : observed ["b"] ("h",[("a","x")]) = [] := by decide
example : observed ["a","b"] ("h",[("a","x")]) = [("a","x")] := by decide
example : observed [] ("h",[("a","y")]) = [] := by decide
example : observed ["a"] ("h",[("a","y")]) = [("a","y")] := by decide
example : observed ["b"] ("h",[("a","y")]) = [] := by decide
example : observed ["a","b"] ("h",[("a","y")]) = [("a","y")] := by decide
example : observed [] ("h",[("a","x"),("a","y")]) = [] := by decide
example : observed ["a"] ("h",[("a","x"),("a","y")]) = [("a","x"),("a","y")] := by decide
example : observed ["b"] ("h",[("a","x"),("a","y")]) = [] := by decide
example : observed ["a","b"] ("h",[("a","x"),("a","y")]) = [("a","x"),("a","y")] := by decide
example : observed [] ("h",[("b","x")]) = [] := by decide
example : observed ["a"] ("h",[("b","x")]) = [] := by decide
example : observed ["b"] ("h",[("b","x")]) = [("b","x")] := by decide
example : observed ["a","b"] ("h",[("b","x")]) = [("b","x")] := by decide
example : observed [] ("h",[("a","x"),("b","x")]) = [] := by decide
example : observed ["a"] ("h",[("a","x"),("b","x")]) = [("a","x")] := by decide
example : observed ["b"] ("h",[("a","x"),("b","x")]) = [("b","x")] := by decide
example : observed ["a","b"] ("h",[("a","x"),("b","x")]) = [("a","x"),("b","x")] := by decide
example : observed [] ("h",[("a","y"),("b","x")]) = [] := by decide
example : observed ["a"] ("h",[("a","y"),("b","x")]) = [("a","y")] := by decide
example : observed ["b"] ("h",[("a","y"),("b","x")]) = [("b","x")] := by decide
example : observed ["a","b"] ("h",[("a","y"),("b","x")]) = [("a","y"),("b","x")] := by decide
example : observed [] ("h",[("a","x"),("a","y"),("b","x")]) = [] := by decide
example : observed ["a"] ("h",[("a","x"),("a","y"),("b","x")]) = [("a","x"),("a","y")] := by decide
example : observed ["b"] ("h",[("a","x"),("a","y"),("b","x")]) = [("b","x")] := by decide
example : observed ["a","b"] ("h",[("a","x"),("a","y"),("b","x")]) = [("a","x"),("a","y"),("b","x")] := by decide
example : observed [] ("h",[("b","y")]) = [] := by decide
example : observed ["a"] ("h",[("b","y")]) = [] := by decide
example : observed ["b"] ("h",[("b","y")]) = [("b","y")] := by decide
example : observed ["a","b"] ("h",[("b","y")]) = [("b","y")] := by decide
example : observed [] ("h",[("a","x"),("b","y")]) = [] := by decide
example : observed ["a"] ("h",[("a","x"),("b","y")]) = [("a","x")] := by decide
example : observed ["b"] ("h",[("a","x"),("b","y")]) = [("b","y")] := by decide
example : observed ["a","b"] ("h",[("a","x"),("b","y")]) = [("a","x"),("b","y")] := by decide
example : observed [] ("h",[("a","y"),("b","y")]) = [] := by decide
example : observed ["a"] ("h",[("a","y"),("b","y")]) = [("a","y")] := by decide
example : observed ["b"] ("h",[("a","y"),("b","y")]) = [("b","y")] := by decide
example : observed ["a","b"] ("h",[("a","y"),("b","y")]) = [("a","y"),("b","y")] := by decide
example : observed [] ("h",[("a","x"),("a","y"),("b","y")]) = [] := by decide
example : observed ["a"] ("h",[("a","x"),("a","y"),("b","y")]) = [("a","x"),("a","y")] := by decide
example : observed ["b"] ("h",[("a","x"),("a","y"),("b","y")]) = [("b","y")] := by decide
example : observed ["a","b"] ("h",[("a","x"),("a","y"),("b","y")]) = [("a","x"),("a","y"),("b","y")] := by decide
example : observed [] ("h",[("b","x"),("b","y")]) = [] := by decide
example : observed ["a"] ("h",[("b","x"),("b","y")]) = [] := by decide
example : observed ["b"] ("h",[("b","x"),("b","y")]) = [("b","x"),("b","y")] := by decide
example : observed ["a","b"] ("h",[("b","x"),("b","y")]) = [("b","x"),("b","y")] := by decide
example : observed [] ("h",[("a","x"),("b","x"),("b","y")]) = [] := by decide
example : observed ["a"] ("h",[("a","x"),("b","x"),("b","y")]) = [("a","x")] := by decide
example : observed ["b"] ("h",[("a","x"),("b","x"),("b","y")]) = [("b","x"),("b","y")] := by decide
example : observed ["a","b"] ("h",[("a","x"),("b","x"),("b","y")]) = [("a","x"),("b","x"),("b","y")] := by decide
example : observed [] ("h",[("a","y"),("b","x"),("b","y")]) = [] := by decide
example : observed ["a"] ("h",[("a","y"),("b","x"),("b","y")]) = [("a","y")] := by decide
example : observed ["b"] ("h",[("a","y"),("b","x"),("b","y")]) = [("b","x"),("b","y")] := by decide
example : observed ["a","b"] ("h",[("a","y"),("b","x"),("b","y")]) = [("a","y"),("b","x"),("b","y")] := by decide
example : observed [] ("h",[("a","x"),("a","y"),("b","x"),("b","y")]) = [] := by decide
example : observed ["a"] ("h",[("a","x"),("a","y"),("b","x"),("b","y")]) = [("a","x"),("a","y")] := by decide
example : observed ["b"] ("h",[("a","x"),("a","y"),("b","x"),("b","y")]) = [("b","x"),("b","y")] := by decide
example : observed ["a","b"] ("h",[("a","x"),("a","y"),("b","x"),("b","y")]) = [("a","x"),("a","y"),("b","x"),("b","y")] := by decide
def nativePair : Pair where
  inputs := ["a"]
  left := ("left",[("a","x"),("b","x")])
  right := ("right",[("a","x"),("b","y")])
  target := "b"
  leftRequired := "x"
  rightRequired := "y"
  sameEvidence := rfl
  unobserved := by
    intro held
    have yes := (SFT.Mathematics.DiscreteObjects.hasIff ["a"] "b").mpr held
    change false = true at yes
    cases yes
  leftSource := .tail _ (.head _)
  rightSource := .tail _ (.head _)
  different := of_decide_eq_false rfl

def nativeLearner : Learner := fun _ _ => "x"
theorem nativeSameDecision : nativeLearner (observed nativePair.inputs nativePair.left) nativePair.target =
    nativeLearner (observed nativePair.inputs nativePair.right) nativePair.target := sameDecision _ _
theorem nativeFailure : nativeLearner (observed nativePair.inputs nativePair.right) nativePair.target ≠ nativePair.rightRequired :=
  notBothCorrect nativePair nativeLearner rfl
#print axioms nativePair
#print axioms nativeSameDecision
#print axioms nativeFailure
end SFT.Computation.LearningLimits
