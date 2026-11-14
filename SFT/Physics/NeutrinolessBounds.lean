import SFT.Physics.MajoranaStructure
namespace SFT.Physics.NeutrinolessBounds
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
abbrev Bracket := Rat × Rat

def wholeUpper (numerator denominator : Nat) : Nat → Nat → Nat
 | 0,upper => upper
 | fuel+1,upper => if upper*upper*denominator<numerator then
    wholeUpper numerator denominator fuel (upper+1) else upper

inductive WholeUpperRun (n d : Nat) : Nat → Nat → Prop where
 | stop (u : Nat) (closed : ¬u*u*d<n) : WholeUpperRun n d u u
 | next (u result : Nat) (below : u*u*d<n) (tail : WholeUpperRun n d (u+1) result) : WholeUpperRun n d u result

theorem wholeUpperCorrespondence (n d fuel u : Nat) (positive : 0<d) (bound : n<u+fuel) :
 WholeUpperRun n d u (wholeUpper n d fuel u) := by
 induction fuel generalizing u with
 | zero =>
   rw [Nat.add_zero] at bound
   apply WholeUpperRun.stop
   have square : u≤u*u := by
    cases u with
    | zero => exact Nat.le_refl 0
    | succ k => exact Nat.le_mul_of_pos_right (k+1) (Nat.zero_lt_succ k)
   exact Nat.not_lt_of_ge (Nat.le_trans (Nat.le_of_lt bound)
    (Nat.le_trans square (Nat.le_mul_of_pos_right (u*u) positive)))
 | succ fuel ih =>
   by_cases h : u*u*d<n
   · rw [wholeUpper,if_pos h]
     apply WholeUpperRun.next _ _ h
     apply ih
     rw [Nat.succ_add]
     rw [Nat.add_succ] at bound
     exact bound
   · rw [wholeUpper,if_neg h]
     exact WholeUpperRun.stop u h

theorem wholeUpperFromOne (n d : Nat) (positive : 0<d) :
 WholeUpperRun n d 1 (wholeUpper n d (n+1) 1) :=
 wholeUpperCorrespondence n d (n+1) 1 positive
  (Nat.lt_of_lt_of_le (Nat.lt_succ_self n) (Nat.le_add_left (n+1) 1))

def scanDyadic (value : Rat) (support : Nat) (positive : 0<support) : Nat → Nat → Option Bracket
 | 0,_ => none
 | fuel+1,index =>
   let lower := natRatio index support positive
   let upper := natRatio (index+1) support positive
   if !value.blt (multiply lower lower) && !(multiply upper upper).blt value then
    some (lower,upper)
   else scanDyadic value support positive fuel (index+1)

def dyadicSearch (value : Rat) : Nat → Nat → Except String Bracket
 | 0,_ => .error "positive square-root enclosure did not halt"
 | fuel+1,depth => do
   let b ← AlphaCovers.binaryCount
   let support ← AlphaCovers.positivePower (.integer (.ofNat b)) (.integer (.ofNat depth))
   if h : 0<support then
    match scanDyadic value support h (support-1) 1 with
    | some bracket => .ok bracket
    | none => dyadicSearch value fuel (depth+1)
   else .error "positive square-root enclosure did not halt"

def sqrtBracket : FoldFirstReturn.Input → Except String Bracket
 | .nonFraction => .error "square-root carrier must be an exact positive fraction"
 | .fraction value => do
   if !zero.blt value then throw "square-root carrier must be an exact positive fraction"
   let upper := wholeUpper value.num.natAbs value.den (value.num.natAbs+1) 1
   if 1<upper then .ok (wholeRatio (upper-1),wholeRatio upper)
   else dyadicSearch value 64 1

def bisectSquare (bracket : Bracket) (value : Rat) : Except String Bracket := do
 let b ← AlphaCovers.binaryCount
 let midpoint ← LeptonRatios.divide (add bracket.1 bracket.2) (wholeRatio b)
 if (multiply midpoint midpoint).blt value then .ok (midpoint,bracket.2)
 else .ok (bracket.1,midpoint)

structure State where
 squares : Rat × Rat × Rat
 weights : Rat × Rat × Rat
 brackets : Bracket × Bracket × Bracket

structure Result where
 positiveFloorCoefficient : Rat
 ceilingCoefficient : Rat
 rootBrackets : Bracket × Bracket × Bracket

def lowerTerms (s : State) : Rat × Rat × Rat :=
 (multiply s.weights.1 s.brackets.1.1,multiply s.weights.2.1 s.brackets.2.1.1,multiply s.weights.2.2 s.brackets.2.2.1)
def upperTerms (s : State) : Rat × Rat × Rat :=
 (multiply s.weights.1 s.brackets.1.2,multiply s.weights.2.1 s.brackets.2.1.2,multiply s.weights.2.2 s.brackets.2.2.2)
def noncancels (s : State) : Bool :=
 let low := lowerTerms s
 let high := upperTerms s
 (add high.1 high.2.2).blt low.2.1
def finish (s : State) : Result :=
 let low := lowerTerms s
 let high := upperTerms s
 ⟨subtract (subtract low.2.1 high.1) high.2.2,
  add (add high.1 high.2.1) high.2.2,s.brackets⟩
def refine (s : State) : Except String State := do
 let a ← bisectSquare s.brackets.1 s.squares.1
 let b ← bisectSquare s.brackets.2.1 s.squares.2.1
 let c ← bisectSquare s.brackets.2.2 s.squares.2.2
 pure ⟨s.squares,s.weights,(a,b,c)⟩

inductive SourceLoopRun : State → Result → Prop where
 | stop (s : State) (passed : noncancels s=true) : SourceLoopRun s (finish s)
 | advance (s next : State) (result : Result) (notPassed : noncancels s=false)
   (step : refine s=.ok next) (tail : SourceLoopRun next result) : SourceLoopRun s result

def initialState : Except String State := do
 let squares ← NeutrinoLadder.neutrinoMassSquares
 let weights ← PMNSPhysical.pmnsCPStructure
 let a ← sqrtBracket (.fraction squares.lightest)
 let b ← sqrtBracket (.fraction squares.middle)
 let c ← sqrtBracket (.fraction squares.heavy)
 pure ⟨(squares.lightest,squares.middle,squares.heavy),weights.electronWeights,(a,b,c)⟩

def originalState : State :=
 ⟨(⟨1,32,by decide,by decide⟩,⟨33,32,by decide,by decide⟩,⟨3203,96,by decide,by decide⟩),
  (⟨47,72,by decide,by decide⟩,⟨47,144,by decide,by decide⟩,⟨1,48,by decide,by decide⟩),
  ((⟨1,8,by decide,by decide⟩,⟨1,4,by decide,by decide⟩),
   (⟨1,1,by decide,by decide⟩,⟨2,1,by decide,by decide⟩),
   (⟨5,1,by decide,by decide⟩,⟨6,1,by decide,by decide⟩))⟩

theorem exactInitialState : initialState=.ok originalState := rfl

theorem originalStoppingCondition : noncancels originalState=true := rfl

def zeroNuNoncancellation : Except String Result :=
 match h : initialState with
 | .error e => .error e
 | .ok s => if passed : noncancels s=true then .ok (finish s)
   else False.elim (passed (by
    have same : s=originalState := Except.ok.inj (h.symm.trans exactInitialState)
    cases same
    exact originalStoppingCondition))

theorem exactSourceLoop : SourceLoopRun originalState (finish originalState) :=
 .stop originalState originalStoppingCondition

theorem completeSourceResult : zeroNuNoncancellation=.ok (finish originalState) := rfl

theorem exactPositiveFloor : (finish originalState).positiveFloorCoefficient=(⟨11,288,by decide,by decide⟩ : Rat) := rfl

theorem exactCeiling : (finish originalState).ceilingCoefficient=(⟨271,288,by decide,by decide⟩ : Rat) := rfl

theorem strictlyPositiveFloor : zero.blt (finish originalState).positiveFloorCoefficient=true := rfl
def squareEnclosed (bracket : Bracket) (value : Rat) : Bool :=
 !value.blt (multiply bracket.1 bracket.1) && !(multiply bracket.2 bracket.2).blt value

theorem allOriginalSquareBounds :
 squareEnclosed originalState.brackets.1 originalState.squares.1=true ∧
 squareEnclosed originalState.brackets.2.1 originalState.squares.2.1=true ∧
 squareEnclosed originalState.brackets.2.2 originalState.squares.2.2=true := ⟨rfl,rfl,rfl⟩

theorem exactOppositionBudget : add (upperTerms originalState).1 (upperTerms originalState).2.2=
 (⟨83,288,by decide,by decide⟩ : Rat) := rfl

theorem exactMiddleLower : (lowerTerms originalState).2.1=(⟨47,144,by decide,by decide⟩ : Rat) := rfl

theorem everyBoundedOppositionFails (numerator denominator : Nat) (positive : 0<denominator)
 (sourceBound : 288*numerator≤83*denominator) : 288*numerator<94*denominator :=
 Nat.lt_of_le_of_lt sourceBound (Nat.mul_lt_mul_of_pos_right (by decide : 83<94) positive)
end SFT.Physics.NeutrinolessBounds
