import SFT.Physics.QuarkInvariants
import SFT.Physics.LeptonIntervals
namespace SFT.Physics.QuarkIsolation
open LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 4000000

inductive Hand where
 | positive | counter
 deriving BEq

/-- None is the source empty record, not a numerical mode. -/
def cubicSide (x pairSum product : Rat) : Option (Hand × Rat) :=
 let positive := add (multiply (multiply x x) x) (multiply pairSum x)
 let counter := add (multiply x x) product
 if positive == counter then none
 else if counter.blt positive then some (.positive,subtract positive counter)
 else some (.counter,subtract counter positive)

def opposite (a b : Hand) : Bool := match a,b with
 | .positive,.counter => true
 | .counter,.positive => true
 | .positive,.positive => false
 | .counter,.counter => false

def intervalRecord (lower upper pairSum product : Rat) : List (Rat × Rat) :=
 match cubicSide lower pairSum product with
 | none => [(lower,lower)]
 | some (hand,_) => match cubicSide upper pairSum product with
   | none => [(lower,upper)]
   | some (other,_) => if opposite hand other then [(lower,upper)] else []

def endpoint (n d : Nat) (positive : 0 < d) := normalize (.ofNat n) d positive

def bracketsAt (depth : Nat) (pairSum product : Rat) : List (Rat × Rat) :=
 let support := 2^depth
 let hp : 0 < support := Nat.pow_pos (by decide)
 (List.range (support-1)).flatMap fun i =>
  intervalRecord (endpoint (i+1) support hp) (endpoint (i+2) support hp) pairSum product

inductive SearchRun (pairSum product : Rat) (count : Nat) : Nat → Nat → Except String (List (Rat × Rat)) → Prop where
 | exhausted (depth : Nat) : SearchRun pairSum product count 0 depth
   (.error "complete dyadic root isolation did not halt")
 | found (fuel depth : Nat) (complete : ((bracketsAt depth pairSum product).length == count) = true) :
   SearchRun pairSum product count (fuel+1) depth (.ok (bracketsAt depth pairSum product))
 | advance (fuel depth : Nat) (incomplete : ((bracketsAt depth pairSum product).length == count) = false)
   (result : Except String (List (Rat × Rat))) (tail : SearchRun pairSum product count fuel (depth+1) result) :
   SearchRun pairSum product count (fuel+1) depth result

def search (pairSum product : Rat) (count : Nat) : Nat → Nat → Except String (List (Rat × Rat))
 | 0,_ => .error "complete dyadic root isolation did not halt"
 | fuel+1,depth => if (bracketsAt depth pairSum product).length == count then
   .ok (bracketsAt depth pairSum product) else search pairSum product count fuel (depth+1)

theorem searchCorrespondence (pairSum product : Rat) (count fuel depth : Nat) :
 SearchRun pairSum product count fuel depth (search pairSum product count fuel depth) := by
 induction fuel generalizing depth with
 | zero => exact .exhausted depth
 | succ fuel ih =>
  unfold search
  cases h : (bracketsAt depth pairSum product).length == count with
  | false => exact .advance fuel depth h _ (ih (depth+1))
  | true => exact .found fuel depth h

def isolateCubicRoots (pairSum product : Rat) : Except String (List (Rat × Rat)) := do
 let count ← FoldFirstReturn.generatorPeriod
 search pairSum product count 32 1

/-- The exact original bisection branch order, including an exact endpoint. -/
def bisectBracket (bracket : Rat × Rat) (pairSum product : Rat) : Rat × Rat :=
 let lower := bracket.1
 let upper := bracket.2
 let mid := midpoint lower upper
 match cubicSide mid pairSum product with
 | none => (mid,mid)
 | some (middleHand,_) => match cubicSide lower pairSum product with
   | none => (lower,mid)
   | some (lowerHand,_) => if opposite lowerHand middleHand then (lower,mid) else (mid,upper)

theorem midpointExactRetained (lower upper pairSum product : Rat)
 (root : cubicSide (midpoint lower upper) pairSum product = none) :
 bisectBracket (lower,upper) pairSum product = (midpoint lower upper,midpoint lower upper) := by
 unfold bisectBracket
 dsimp only
 rw [root]

def rootBrackets : Except String (List (Rat × Rat) × List (Rat × Rat)) := do
 let cubics ← QuarkInvariants.cubicInvariants
 let down ← isolateCubicRoots (BoundaryGrowth.asFraction cubics.down.2.1) (BoundaryGrowth.asFraction cubics.down.2.2)
 let up ← isolateCubicRoots (BoundaryGrowth.asFraction cubics.up.2.1) (BoundaryGrowth.asFraction cubics.up.2.2)
 .ok (down,up)
def bracketPairs (xs : List (Rat × Rat)) :=
 xs.map (fun (a,b) => ((a.num,a.den),(b.num,b.den)))

theorem exactRootBrackets : rootBrackets.map (fun (down,up) => (bracketPairs down,bracketPairs up)) =
 .ok ([((1,64),(1,32)),((7,64),(1,8)),((27,32),(55,64))],
      [((1,256),(1,128)),((11,128),(23,256)),((29,32),(233,256))]) := rfl
def positiveSeparated : List (Rat × Rat) → Bool
 | [] => true
 | (lower,upper)::tail => zero.blt lower && lower.blt upper &&
   (match tail with
    | [] => true
    | (nextLower,_)::_ => upper.blt nextLower) && positiveSeparated tail

theorem completePositiveSeparation : rootBrackets.map (fun (down,up) =>
 (down.length,up.length,positiveSeparated down,positiveSeparated up)) = .ok (3,3,true,true) := rfl
end SFT.Physics.QuarkIsolation
