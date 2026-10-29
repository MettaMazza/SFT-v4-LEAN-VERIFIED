import SFT.Physics.LeptonIntervals
namespace SFT.Physics.LeptonIsolation
open LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 20000000

def cell (depth index : Nat) : Rat × Rat :=
 let denominator := 2^depth
 let positive := Nat.pow_pos (by decide : 0 < 2)
 (normalize (.ofNat index) denominator positive,
  normalize (.ofNat (index+1)) denominator positive)

def cellRoots (pairSum product : Rat) (bracket : Rat × Rat) : List (Rat × Rat) :=
 let atLower := cubic bracket.1 pairSum product
 let atUpper := cubic bracket.2 pairSum product
 if atLower == zero then [(bracket.1,bracket.1)]
 else if (multiply atLower atUpper).blt zero then [bracket]
 else []

def bracketsAt (depth : Nat) (pairSum product : Rat) : List (Rat × Rat) :=
 (List.range (2^depth)).flatMap fun index => cellRoots pairSum product (cell depth index)

def isolated (brackets : List (Rat × Rat)) : Bool :=
 brackets.length == 3 && brackets.all (fun b => zero.blt b.1 && b.1.blt b.2)

inductive IsolationRun (pairSum product : Rat) : Nat → List (Rat × Rat) → Prop where
 | stop (depth : Nat) (accepted : isolated (bracketsAt depth pairSum product) = true) :
   IsolationRun pairSum product depth (bracketsAt depth pairSum product)
 | next (depth : Nat) (rejected : isolated (bracketsAt depth pairSum product) = false)
   (result : List (Rat × Rat)) (later : IsolationRun pairSum product (depth+1) result) :
   IsolationRun pairSum product depth result

def searchWithin (pairSum product : Rat) : Nat → Nat → Option (List (Rat × Rat))
 | 0,_ => none
 | fuel+1,depth =>
   let brackets := bracketsAt depth pairSum product
   if isolated brackets then some brackets else searchWithin pairSum product fuel (depth+1)

theorem searchSound (pairSum product : Rat) (fuel depth : Nat) (result : List (Rat × Rat))
 (found : searchWithin pairSum product fuel depth = some result) :
 IsolationRun pairSum product depth result := by
 induction fuel generalizing depth result with
 | zero => cases found
 | succ fuel ih =>
   unfold searchWithin at found
   dsimp only at found
   cases h : isolated (bracketsAt depth pairSum product) with
   | false =>
     rw [h] at found
     exact .next depth h result (ih (depth+1) result found)
   | true =>
     rw [h] at found
     have same : bracketsAt depth pairSum product = result := Option.some.inj found
     cases same
     exact .stop depth h

def pairSum : Rat := ⟨1,6,by decide,by decide⟩

def terminalSearch : Except String (Option (List (Rat × Rat))) := do
 let product ← LeptonTerminal.terminalProduct
 .ok (searchWithin pairSum (BoundaryGrowth.asFraction product) 7 1)

def endpoint (n d : Nat) (positive : 0 < d) : Rat := normalize (.ofNat n) d positive

def terminalBrackets : List (Rat × Rat) :=
 [(endpoint 1 128 (by decide),endpoint 1 64 (by decide)),
  (endpoint 3 16 (by decide),endpoint 25 128 (by decide)),
  (endpoint 101 128 (by decide),endpoint 51 64 (by decide))]

theorem terminalSearchComplete : terminalSearch = .ok (some terminalBrackets) := rfl

theorem terminalNativeRun (product : SFT.Foundation.ExactOperations.PositiveFraction)
 (source : LeptonTerminal.terminalProduct = .ok product) :
 IsolationRun pairSum (BoundaryGrowth.asFraction product) 1 terminalBrackets := by
 have found := terminalSearchComplete
 unfold terminalSearch at found
 rw [source] at found
 exact searchSound pairSum (BoundaryGrowth.asFraction product) 7 1 terminalBrackets (Except.ok.inj found)

end SFT.Physics.LeptonIsolation
