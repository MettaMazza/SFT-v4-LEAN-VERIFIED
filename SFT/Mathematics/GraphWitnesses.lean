import SFT.Mathematics.GraphCycleTrace
namespace SFT.Mathematics.GraphWitnesses
open GraphOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 2000000
def chain : GeneratedGraph := ⟨["a","b","c"],[("a","b"),("b","c")]⟩
theorem chainAccepted : makeGraph chain.nodes chain.edges = .ok chain := rfl
def cycle : GeneratedGraph := ⟨["a","b","c"],[("a","b"),("b","c"),("c","a")]⟩
theorem cycleAccepted : makeGraph cycle.nodes cycle.edges = .ok cycle := rfl

structure Witness where
  name : String
  statement : String
  passed : Bool

def validPath : Witness where
  name := "valid-path"
  statement := "The chain retains both required adjacent edges."
  passed := pathIsValid chain ["a","b","c"]

theorem validPathPassed : validPath.passed = true := rfl

def missingEdgeControl : Witness where
  name := "missing-edge-control"
  statement := "An endpoint sequence with a missing adjacency is not a path."
  passed := !pathIsValid chain ["a","c"]

theorem missingEdgeControlPassed : missingEdgeControl.passed = true := rfl

def reachability : Witness where
  name := "reachability"
  statement := "Generated path search reaches c from a and does not reach a from c in the directed chain."
  passed := reachable chain "a" "c" && !reachable chain "c" "a"

theorem reachabilityPassed : reachability.passed = true := by
  have forward : reachable chain "a" "c" = true := pathWitnessReachable chain "a" "c" ⟨["a","b"],rfl,rfl⟩
  have backward : reachable chain "c" "a" = false := by
    unfold reachable
    rw [ite_eq_right (by decide)]
    rw [searchLoopEquation]
    change searchLoop chain.edges "a" (expandState chain.edges (initialSearch chain.edges "c") "c" [] rfl) = false
    exact searchEmpty _ _ _ rfl
  change (reachable chain "a" "c" && !reachable chain "c" "a") = true
  rw [forward,backward]
  rfl

def cycleReturn : Witness where
  name := "cycle-return"
  statement := "The explicit c-to-a return distinguishes the cycle from the chain."
  passed := directedCycleExists cycle && !directedCycleExists chain

theorem cycleReturnPassed : cycleReturn.passed = true := by
  have returns : directedCycleExists cycle = true :=
    completeReturnPathDetected cycle "a" ["b","c"] "a" (List.Mem.head _) rfl (List.Mem.head _)
  have fromC (state : CycleState chain.edges) (current : state.node = "c") : cycleVisit chain.edges state = false := by
    apply cycleVisitNoOutgoing
    intro edge member
    rw [current]
    cases member with
    | head => decide
    | tail _ h =>
      cases h with
      | head => decide
      | tail _ h => cases h
  have fromB (state : CycleState chain.edges) (current : state.node = "b")
      (freshC : DiscreteObjects.has state.heldPath "c" = false) : cycleVisit chain.edges state = false := by
    cases state with
    | mk unseen held node covered =>
      dsimp only at current freshC
      cases current
      rw [cycleVisitEquation]
      change (if DiscreteObjects.has held "c" = true then true else
        if cycleVisit chain.edges (cycleNext chain.edges ⟨unseen,held,"b",covered⟩ "c") then true else false) = false
      rw [freshC]
      change (if cycleVisit chain.edges (cycleNext chain.edges ⟨unseen,held,"b",covered⟩ "c") then true else false) = false
      rw [fromC _ rfl]
      rfl
  have fromA : cycleVisit chain.edges (initialCycle chain.edges "a") = false := by
    rw [cycleVisitEquation]
    change (if cycleVisit chain.edges (cycleNext chain.edges (initialCycle chain.edges "a") "b") then true else false) = false
    rw [fromB _ rfl rfl]
    rfl
  have noReturn : directedCycleExists chain = false := by
    change (cycleVisit chain.edges (initialCycle chain.edges "a") ||
      (cycleVisit chain.edges (initialCycle chain.edges "b") ||
      (cycleVisit chain.edges (initialCycle chain.edges "c") || false))) = false
    rw [fromA,fromB _ rfl rfl,fromC _ rfl]
    rfl
  change (directedCycleExists cycle && !directedCycleExists chain) = true
  rw [returns,noReturn]
  rfl

def cutSelection : Witness where
  name := "cut-selection"
  statement := "Holding the first chain node selects exactly its crossing edge."
  passed := match crossingCut chain ["a"] with
    | .error _ => false
    | .ok edges => decide (edges = [("a","b")])

theorem cutSelectionPassed : cutSelection.passed = true := rfl

def pairedBalance : Witness where
  name := "paired-balance"
  statement := "Equal unique ingress and egress token traces witness internal balance."
  passed := internalBalance [["i1"],["i2"]] [["o1"],["o2"]]

theorem pairedBalancePassed : pairedBalance.passed = true := rfl

def witnesses : List Witness := [validPath,missingEdgeControl,reachability,cycleReturn,cutSelection,pairedBalance]

theorem allWitnessesPass : witnesses.all Witness.passed = true := by
  change (validPath.passed && (missingEdgeControl.passed && (reachability.passed && (cycleReturn.passed && (cutSelection.passed && (pairedBalance.passed && true)))))) = true
  rw [validPathPassed,missingEdgeControlPassed,reachabilityPassed,cycleReturnPassed,cutSelectionPassed,pairedBalancePassed]
  rfl

end SFT.Mathematics.GraphWitnesses
