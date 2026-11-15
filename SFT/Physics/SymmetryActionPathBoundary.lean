import SFT.Physics.SymmetryActionPathLedger
namespace SFT.Physics.SymmetryActionPathBoundary
open SymmetryActionPaths SymmetryActionPathProofs SymmetryActionPathLedger
open VacuumLedgerProofs VacuumScaleProofs
open SFT.Computation.ErrorBound
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
theorem originalEveryDetour (x y : Nat) (rest : List Nat) (admitted : Admitted x (y::rest))
 (different : x≠terminal x (y::rest)) (d : Nat) (hd : 0<d) :
 detourCannotLowerAction ((x::y::rest).map (fun n => FoldFirstReturn.Input.fraction (natRatio n d hd)))=.ok true := by
 unfold detourCannotLowerAction
 rw [originalPathAction x y rest admitted d hd,originalEndpointSeparation x (y::rest) admitted different d hd]
 dsimp only [Except.bind,Bind.bind]
 have positive := originalGapPositive x (terminal x (y::rest)) different
 rw [originalNonlowerAction _ _ d hd (Nat.lt_of_lt_of_le positive (accumulatedBound x (y::rest))) positive (accumulatedBound x (y::rest))]
 rfl
inductive Descending : Nat → List Nat → Prop where
 | last (x : Nat) : Descending x []
 | next (x y : Nat) (rest : List Nat) (lower : y<x) (tail : Descending y rest) : Descending x (y::rest)
theorem originalDescendingLedger (x : Nat) (rest : List Nat) (descent : Descending x rest) :
 terminal x rest≤x ∧ accumulated x rest=x-terminal x rest := by
 induction descent with
 | last x => exact ⟨Nat.le_refl _,(Nat.sub_self x).symm⟩
 | next x y rest lower tail ih =>
  constructor
  · exact Nat.le_trans ih.1 (Nat.le_of_lt lower)
  · change gap x y+accumulated y rest=x-terminal y rest
    rw [gapSymmetry x y,gapOfLE y x (Nat.le_of_lt lower),ih.2,Nat.add_comm]
    exact monotoneAccumulation _ _ _ ih.1 (Nat.le_of_lt lower)
theorem originalDescendingPredicate (x : Nat) (rest : List Nat) (admitted : Admitted x rest)
 (descent : Descending x rest) (d : Nat) (hd : 0<d) :
 isMonotoneDescent ((x::rest).map (fun n => FoldFirstReturn.Input.fraction (natRatio n d hd)))=.ok true := by
 induction descent with
 | last x => rfl
 | next x y rest lower tail ih =>
  cases admitted with
  | next _ _ _ positive different suffix =>
   unfold isMonotoneDescent
   dsimp only [List.map]
   rw [originalDownwardMagnitude x y d hd (originalInitialPositive y rest suffix) lower]
   dsimp only [Except.bind,Bind.bind]
   exact ih suffix
theorem originalEveryMonotoneTelescopes (x y : Nat) (rest : List Nat)
 (admitted : Admitted x (y::rest)) (descent : Descending x (y::rest)) (d : Nat) (hd : 0<d) :
 descentTelescopes ((x::y::rest).map (fun n => FoldFirstReturn.Input.fraction (natRatio n d hd)))=.ok true := by
 have ledger := originalDescendingLedger x (y::rest) descent
 have strict : terminal x (y::rest)<x := by
  cases descent with
  | next _ _ _ lower tail => exact Nat.lt_of_le_of_lt (originalDescendingLedger y rest tail).1 lower
 have different := Nat.ne_of_gt strict
 unfold descentTelescopes
 rw [originalDescendingPredicate x (y::rest) admitted descent d hd]
 dsimp only [Except.bind,Bind.bind,ite_true]
 rw [originalPathAction x y rest admitted d hd,originalEndpointSeparation x (y::rest) admitted different d hd]
 dsimp only [Except.bind,Bind.bind]
 rw [gapSymmetry x _,gapOfLE _ _ ledger.1,ledger.2,originalSameAction]
 rfl
end SFT.Physics.SymmetryActionPathBoundary
