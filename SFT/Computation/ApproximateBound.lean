import SFT.Computation.OptimizationTrace
namespace SFT.Computation.ApproximateBound
open SFT.Mathematics.OptimizationBounds
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations

-- Exact successful-output characterization of the inherited V3 operation.
-- The raw signed integer domain and original rejection are unchanged.
theorem admission (candidate optimum : Int) (part : Part) :
    exactApproximation candidate optimum = .ok part ↔
    ∃ c o : Nat, ∃ positive : 0 < o, ∃ bound : o ≤ c,
      candidate = .ofNat c ∧ optimum = .ofNat o ∧
      part = normalizePart o c positive bound := by
  constructor
  · intro accepted
    cases candidate with
    | negSucc n => cases accepted
    | ofNat c =>
      cases optimum with
      | negSucc n => cases accepted
      | ofNat o =>
        unfold exactApproximation at accepted
        dsimp only at accepted
        split at accepted
        next positive =>
          split at accepted
          next bound => exact ⟨c,o,positive,bound,rfl,rfl,(Except.ok.inj accepted).symm⟩
          next bad => cases accepted
        next bad => cases accepted
  · intro ⟨c,o,positive,bound,hc,ho,hp⟩
    cases hc; cases ho; cases hp
    exact approximationAdmitted c o positive bound

theorem reconstruct (candidate optimum : Int) (part : Part)
    (accepted : exactApproximation candidate optimum = .ok part) :
    ∃ c o : Nat, candidate = .ofNat c ∧ optimum = .ofNat o ∧
      0 < o ∧ o ≤ c ∧ o * part.denominator = part.numerator * c := by
  obtain ⟨c,o,positive,bound,hc,ho,hp⟩ := (admission _ _ _).mp accepted
  cases hp
  exact ⟨c,o,hc,ho,positive,bound,approximationRatio c o positive bound⟩

theorem positiveCandidate (candidate optimum : Int) (part : Part)
    (accepted : exactApproximation candidate optimum = .ok part) :
    ∃ c : Nat, candidate = .ofNat c ∧ 0 < c := by
  obtain ⟨c,o,hc,ho,positive,bound,ratio⟩ := reconstruct _ _ _ accepted
  exact ⟨c,hc,Nat.lt_of_lt_of_le positive bound⟩

theorem boundedPart (candidate optimum : Int) (part : Part)
    (accepted : exactApproximation candidate optimum = .ok part) :
    0 < part.numerator ∧ part.numerator ≤ part.denominator := by
  obtain ⟨c,o,positive,bound,hc,ho,hp⟩ := (admission _ _ _).mp accepted
  cases hp
  exact ⟨(normalizePart o c positive bound).positive,approximationThroughOne c o positive bound⟩

theorem rejectsNegativeCandidate (n : Nat) (optimum : Int) :
    exactApproximation (.negSucc n) optimum =
      .error "approximation requires positive generated cell counts and a valid lower optimum" := rfl

theorem rejectsNegativeOptimum (candidate : Int) (n : Nat) :
    exactApproximation candidate (.negSucc n) =
      .error "approximation requires positive generated cell counts and a valid lower optimum" := by
  cases candidate <;> rfl

-- A bound is attached to held objective rows, not to an imported objective.
abbrev ObjectiveRows := List (String × Nat)
structure BoundRecord (rows : ObjectiveRows) where
  candidate : String
  optimum : String
  candidateCells : Nat
  optimumCells : Nat
  candidateRow : (candidate,candidateCells) ∈ rows
  optimumRow : (optimum,optimumCells) ∈ rows
  part : Part
  accepted : exactApproximation (.ofNat candidateCells) (.ofNat optimumCells) = .ok part

theorem sourceRows (rows : ObjectiveRows) (record : BoundRecord rows) :
    (record.candidate,record.candidateCells) ∈ rows ∧
    (record.optimum,record.optimumCells) ∈ rows :=
  ⟨record.candidateRow,record.optimumRow⟩

theorem exactBound (rows : ObjectiveRows) (record : BoundRecord rows) :
    0 < record.optimumCells ∧ record.optimumCells ≤ record.candidateCells ∧
    record.optimumCells * record.part.denominator = record.part.numerator * record.candidateCells := by
  obtain ⟨c,o,hc,ho,positive,bound,ratio⟩ := reconstruct _ _ _ record.accepted
  have ec := Int.ofNat.inj hc
  have eo := Int.ofNat.inj ho
  rw [ec,eo]
  exact ⟨positive,bound,ratio⟩

def extend (rows added : ObjectiveRows) (record : BoundRecord rows) : BoundRecord (rows ++ added) where
  candidate := record.candidate
  optimum := record.optimum
  candidateCells := record.candidateCells
  optimumCells := record.optimumCells
  candidateRow := SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ record.candidateRow
  optimumRow := SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ record.optimumRow
  part := record.part
  accepted := record.accepted

theorem extensionPreserves (rows added : ObjectiveRows) (record : BoundRecord rows) :
    (extend rows added record).candidate = record.candidate ∧
    (extend rows added record).optimum = record.optimum ∧
    (extend rows added record).part = record.part := ⟨rfl,rfl,rfl⟩

end SFT.Computation.ApproximateBound
