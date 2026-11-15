import SFT.Physics.SymmetryActionPathBoundary
namespace SFT.Physics.SymmetryActionPathCoverage
open SymmetryActionPaths SymmetryActionPathProofs SymmetryActionPathLedger SymmetryActionPathBoundary
open VacuumLedgerProofs VacuumScaleProofs
open SFT.Computation.ErrorBound SFT.Foundation.ExactOperations
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def sourceInputs (parts : List PositiveFraction) : List FoldFirstReturn.Input :=
 parts.map (fun p => .fraction (BoundaryGrowth.asFraction p))
def scaledInputs (d : Nat) (hd : 0<d) (coordinates : List Nat) : List FoldFirstReturn.Input :=
 coordinates.map (fun n => .fraction (natRatio n d hd))
theorem originalCoordinateValue (p : PositiveFraction) (n d : Nat) (hd : 0<d)
 (same : n*p.denominator=p.numerator*d) : BoundaryGrowth.asFraction p=natRatio n d hd := by
 apply representedIdentity
 · rfl
 · exact same
theorem originalCoordinatePositive (p : PositiveFraction) (n d : Nat) (hd : 0<d)
 (same : n*p.denominator=p.numerator*d) : 0<n := by
 apply Nat.pos_of_ne_zero
 intro empty
 rw [empty,Nat.zero_mul] at same
 exact Nat.ne_of_gt (Nat.mul_pos p.positive hd) same.symm
theorem originalScalePreservesInputs (d : Nat) (hd : 0<d) (parts : List PositiveFraction) (coordinates : List Nat)
 (rows : ScaledRows d parts coordinates) : sourceInputs parts=scaledInputs d hd coordinates := by
 induction rows with
 | base => rfl
 | step p n parts coordinates same tail ih =>
  change FoldFirstReturn.Input.fraction (BoundaryGrowth.asFraction p)::sourceInputs parts=
   FoldFirstReturn.Input.fraction (natRatio n d hd)::scaledInputs d hd coordinates
  rw [originalCoordinateValue p n d hd same,ih]
-- Every finite positive rational path obtains its scale from its own denominators.
theorem originalEveryPositivePathRepresented (parts : List PositiveFraction) :
 sourceInputs parts=scaledInputs (generateScale parts).denominator (generateScale parts).positive (generateScale parts).coordinates :=
 originalScalePreservesInputs _ _ _ _ (generateScale parts).rows
inductive SourceAdmitted : PositiveFraction → List PositiveFraction → Prop where
 | last (p : PositiveFraction) : SourceAdmitted p []
 | next (p q : PositiveFraction) (rest : List PositiveFraction)
   (different : BoundaryGrowth.asFraction p≠BoundaryGrowth.asFraction q)
   (tail : SourceAdmitted q rest) : SourceAdmitted p (q::rest)
theorem originalScalePreservesAdmission (p : PositiveFraction) (parts : List PositiveFraction) (admitted : SourceAdmitted p parts)
 (d : Nat) (hd : 0<d) (n : Nat) (coordinates : List Nat) (rows : ScaledRows d (p::parts) (n::coordinates)) : Admitted n coordinates := by
 induction admitted generalizing n coordinates with
 | last p =>
  cases rows with
  | step _ _ _ _ same tail =>
   cases tail
   exact .last n (originalCoordinatePositive p n d hd same)
 | next p q parts different tail ih =>
  cases rows with
  | step _ _ _ _ same suffix =>
   cases suffix with
   | step _ next _ rest nextSame remaining =>
    apply Admitted.next n next rest (originalCoordinatePositive p n d hd same)
    · intro equal
      apply different
      rw [originalCoordinateValue p n d hd same,originalCoordinateValue q next d hd nextSame,equal]
    · exact ih next rest (.step _ _ _ _ nextSame remaining)
theorem originalEverySourceDetour (p q : PositiveFraction) (parts : List PositiveFraction)
 (admitted : SourceAdmitted p (q::parts))
 (different : BoundaryGrowth.asFraction p≠BoundaryGrowth.asFraction (lastPart p (q::parts))) :
 detourCannotLowerAction (sourceInputs (p::q::parts))=.ok true := by
 let scale := generateScale (p::q::parts)
 have rows := scale.rows
 cases coordinates : scale.coordinates with
 | nil => rw [coordinates] at rows; cases rows
 | cons x rest =>
  rw [coordinates] at rows
  cases rest with
  | nil => cases rows with | step _ _ _ _ _ tail => cases tail
  | cons y tail =>
   have admission := originalScalePreservesAdmission p (q::parts) admitted scale.denominator scale.positive x (y::tail) rows
   have endpointDifferent : x≠terminal x (y::tail) := by
    intro equal
    have final := terminalScaling scale.denominator p (q::parts) x (y::tail) rows
    cases rows with
    | step _ _ _ _ firstSame remaining =>
     apply different
     rw [originalCoordinateValue p x scale.denominator scale.positive firstSame,
      originalCoordinateValue (lastPart p (q::parts)) (terminal x (y::tail)) scale.denominator scale.positive final]
     exact congrArg (fun n => natRatio n scale.denominator scale.positive) equal
   rw [originalScalePreservesInputs scale.denominator scale.positive _ _ rows]
   exact originalEveryDetour x y tail admission endpointDifferent scale.denominator scale.positive
theorem originalMonotonePredicateComplete (x : Nat) (rest : List Nat) (admitted : Admitted x rest)
 (d : Nat) (hd : 0<d) (checked : isMonotoneDescent (scaledInputs d hd (x::rest))=.ok true) :
 Descending x rest := by
 induction admitted with
 | last x positive => exact .last x
 | next x y rest positive different tail ih =>
  unfold scaledInputs isMonotoneDescent at checked
  dsimp only [List.map] at checked
  cases Nat.lt_or_gt_of_ne different with
  | inl upper =>
   rw [originalUpwardMagnitude x y d hd positive upper] at checked
   cases checked
  | inr lower =>
   rw [originalDownwardMagnitude x y d hd (originalInitialPositive y rest tail) lower] at checked
   dsimp only [Except.bind,Bind.bind] at checked
   exact .next x y rest lower (ih checked)
theorem originalEverySourceMonotoneTelescopes (p q : PositiveFraction) (parts : List PositiveFraction)
 (admitted : SourceAdmitted p (q::parts))
 (checked : isMonotoneDescent (sourceInputs (p::q::parts))=.ok true) :
 descentTelescopes (sourceInputs (p::q::parts))=.ok true := by
 let scale := generateScale (p::q::parts)
 have rows := scale.rows
 cases coordinates : scale.coordinates with
 | nil => rw [coordinates] at rows; cases rows
 | cons x rest =>
  rw [coordinates] at rows
  cases rest with
  | nil => cases rows with | step _ _ _ _ _ tail => cases tail
  | cons y tail =>
   have admission := originalScalePreservesAdmission p (q::parts) admitted scale.denominator scale.positive x (y::tail) rows
   have represented := originalScalePreservesInputs scale.denominator scale.positive _ _ rows
   rw [represented] at checked ⊢
   exact originalEveryMonotoneTelescopes x y tail admission (originalMonotonePredicateComplete x (y::tail) admission scale.denominator scale.positive checked) scale.denominator scale.positive
end SFT.Physics.SymmetryActionPathCoverage
