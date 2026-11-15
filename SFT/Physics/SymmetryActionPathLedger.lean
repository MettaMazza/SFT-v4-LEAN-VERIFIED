import SFT.Physics.SymmetryActionPathProofs
namespace SFT.Physics.SymmetryActionPathLedger
open SymmetryActionPaths SymmetryActionPathProofs LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
open SFT.Computation.ErrorBound
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
-- Exactly the positive-coordinate and distinct-adjacent guards of path_action.
inductive Admitted : Nat → List Nat → Prop where
 | last (x : Nat) (positive : 0<x) : Admitted x []
 | next (x y : Nat) (rest : List Nat) (positive : 0<x) (different : x≠y)
   (tail : Admitted y rest) : Admitted x (y::rest)
theorem originalInitialPositive (x : Nat) (rest : List Nat) (h : Admitted x rest) : 0<x := by
 cases h with
 | last _ positive => exact positive
 | next _ _ _ positive _ _ => exact positive
theorem originalTerminalPositive (x : Nat) (rest : List Nat) (h : Admitted x rest) : 0<terminal x rest := by
 induction h with
 | last _ positive => exact positive
 | next _ _ _ _ _ _ ih => exact ih
theorem originalGapPositive (a b : Nat) (different : a≠b) : 0<gap a b := by
 cases Nat.lt_or_gt_of_ne different with
 | inl upper => rw [gapOfLE a b (Nat.le_of_lt upper)]; exact RunningConvergence.orderedDifferencePositive _ _ upper
 | inr lower => rw [gapSymmetry a b,gapOfLE b a (Nat.le_of_lt lower)];exact RunningConvergence.orderedDifferencePositive _ _ lower
theorem originalAppendAction (initial : Nat) (rest : List Nat) (admitted : Admitted initial rest)
 (d total : Nat) (hd : 0<d) (ht : 0<total) :
 appendAction (.fraction (natRatio initial d hd)) (rest.map (fun n => FoldFirstReturn.Input.fraction (natRatio n d hd))) (natRatio total d hd)=
 .ok (natRatio (total+accumulated initial rest) d hd) := by
 induction admitted generalizing total with
 | last x positive =>
  change (if zero.blt (natRatio total d hd) then Except.ok (natRatio total d hd) else Except.error _) = _
  rw [positiveNormalized total d ht hd]
  rfl
 | next x y rest positive different tail ih =>
  unfold appendAction
  dsimp only [List.map]
  rw [originalStepMagnitude x y d hd positive (originalInitialPositive y rest tail) different]
  dsimp only [Except.bind,Bind.bind]
  rw [addNormalized]
  rw [ih (total+gap x y) (Nat.lt_of_lt_of_le ht (Nat.le_add_right total (gap x y)))]
  rw [Nat.add_assoc]
  rfl
theorem originalPathAction (x y : Nat) (rest : List Nat) (admitted : Admitted x (y::rest))
 (d : Nat) (hd : 0<d) :
 pathAction ((x::y::rest).map (fun n => FoldFirstReturn.Input.fraction (natRatio n d hd)))=
 .ok (natRatio (accumulated x (y::rest)) d hd) := by
 cases admitted with
 | next _ _ _ positive different tail =>
  unfold pathAction
  dsimp only [List.map]
  rw [originalStepMagnitude x y d hd positive (originalInitialPositive y rest tail) different]
  dsimp only [Except.bind,Bind.bind]
  exact originalAppendAction y rest tail d (gap x y) hd (originalGapPositive x y different)
theorem originalLastCoordinate (initial : Nat) (rest : List Nat) (d : Nat) (hd : 0<d) :
 (rest.map (fun n => FoldFirstReturn.Input.fraction (natRatio n d hd))).foldl (fun _ x => x) (.fraction (natRatio initial d hd))=
 .fraction (natRatio (terminal initial rest) d hd) := by
 induction rest generalizing initial with
 | nil => rfl
 | cons x xs ih => exact ih x
theorem originalEndpointSeparation (initial : Nat) (rest : List Nat) (admitted : Admitted initial rest)
 (different : initial≠terminal initial rest) (d : Nat) (hd : 0<d) :
 endpointSeparation ((initial::rest).map (fun n => FoldFirstReturn.Input.fraction (natRatio n d hd)))=
 .ok (natRatio (gap initial (terminal initial rest)) d hd) := by
 unfold endpointSeparation
 dsimp only [List.map]
 rw [originalLastCoordinate]
 cases Nat.lt_or_gt_of_ne different with
 | inl upper =>
  rw [originalUpwardMagnitude initial (terminal initial rest) d hd (originalInitialPositive _ _ admitted) upper]
  rw [gapOfLE _ _ (Nat.le_of_lt upper)]
  rfl
 | inr lower =>
  rw [originalDownwardMagnitude initial (terminal initial rest) d hd (originalTerminalPositive _ _ admitted) lower]
  rw [gapSymmetry initial _,gapOfLE _ _ (Nat.le_of_lt lower)]
  rfl
end SFT.Physics.SymmetryActionPathLedger
