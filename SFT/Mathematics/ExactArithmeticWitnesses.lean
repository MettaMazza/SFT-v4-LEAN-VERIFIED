import SFT.Mathematics.ExactTraceDistribution
namespace SFT.Mathematics.ExactArithmeticWitnesses
open ExactTraceArithmetic

def a : Trace := [["a"]]
def b : Trace := [["b"]]
def c : Trace := [["c"]]
def two : Trace := a ++ b
def three : Trace := two ++ c

theorem sourceA : trace ["a"] = .ok a := rfl
theorem sourceB : trace ["b"] = .ok b := rfl
theorem sourceC : trace ["c"] = .ok c := rfl
theorem sourceTwo : disjointJunction a b = .ok two := rfl
theorem sourceThree : disjointJunction two c = .ok three := rfl

def traceResultsEqual (left right : Except String Trace) : Bool :=
  match left with
  | .error _ => false
  | .ok a => match right with
    | .error _ => false
    | .ok b => decide (a = b)

structure Witness where
  name : String
  statement : String
  passed : Bool

def junctionAssociativity : Witness where
  name := "junction-associativity"
  statement := "(a joined b) joined c and a joined (b joined c) retain the same canonical trace."
  passed := traceResultsEqual ((disjointJunction a b).bind (fun ab => disjointJunction ab c)) ((disjointJunction b c).bind (fun bc => disjointJunction a bc))

theorem junctionAssociativityPassed : junctionAssociativity.passed = true := rfl

def pairCellCardinality : Witness where
  name := "pair-cell-cardinality"
  statement := "Two generated cells paired with three generated cells produce the complete six labelled pair cells."
  passed := match pairCellProduct two three with | .ok cells => cells.length == 6 | .error _ => false

theorem pairCellCardinalityPassed : pairCellCardinality.passed = true := rfl

def productAssociativity : Witness where
  name := "product-associativity"
  statement := "Canonical flattened pair paths are independent of binary grouping."
  passed := traceResultsEqual ((pairCellProduct a b).bind (fun ab => pairCellProduct ab c)) ((pairCellProduct b c).bind (fun bc => pairCellProduct a bc))

theorem productAssociativityPassed : productAssociativity.passed = true := rfl

def exactPairingWitness : Witness where
  name := "exact-pairing"
  statement := "Equal complete traces admit one-to-one and onto pairing; unequal traces do not."
  passed := (exactPairing two [["x"],["y"]]).isSome && (exactPairing two three).isNone

theorem exactPairingWitnessPassed : exactPairingWitness.passed = true := rfl

def heldRemainder : Witness where
  name := "held-remainder"
  statement := "A larger trace reports a positive held remainder instead of a negative value."
  passed := SFT.Host.Text.equal (orientedRemainder three two).1 "left-held"

theorem heldRemainderPassed : heldRemainder.passed = true := rfl

def witnesses : List Witness := [junctionAssociativity,pairCellCardinality,productAssociativity,exactPairingWitness,heldRemainder]

theorem everyWitnessPassed : witnesses.all Witness.passed = true := rfl

end SFT.Mathematics.ExactArithmeticWitnesses
