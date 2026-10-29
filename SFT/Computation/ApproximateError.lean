import SFT.Computation.ApproximateBound
import SFT.Computation.NumericalTrace
namespace SFT.Computation.ApproximateError
open ApproximateBound NumericalError NumericalLedger
open SFT.Foundation.ExactOperations

def referenceValue (rows : ObjectiveRows) (record : BoundRecord rows) : PositiveFraction :=
  normalizePositive record.optimumCells 1 (exactBound rows record).1 (Nat.zero_lt_succ 0)

def candidateValue (rows : ObjectiveRows) (record : BoundRecord rows) : PositiveFraction :=
  normalizePositive record.candidateCells 1
    (Nat.lt_of_lt_of_le (exactBound rows record).1 (exactBound rows record).2.1) (Nat.zero_lt_succ 0)

def errorRow (rows : ObjectiveRows) (record : BoundRecord rows) : NumericalError.Row :=
  ("cell-1",errorValue (referenceValue rows record) (candidateValue rows record))

theorem referenceRatio (rows : ObjectiveRows) (record : BoundRecord rows) :
    record.optimumCells * (referenceValue rows record).denominator =
      (referenceValue rows record).numerator * 1 :=
  normalizedValuePreserved _ _ _ _

theorem candidateRatio (rows : ObjectiveRows) (record : BoundRecord rows) :
    record.candidateCells * (candidateValue rows record).denominator =
      (candidateValue rows record).numerator * 1 :=
  normalizedValuePreserved _ _ _ _

theorem exactError (rows : ObjectiveRows) (record : BoundRecord rows) :
    exactErrorLedger [.positive (referenceValue rows record)] [.positive (candidateValue rows record)] =
      .ok [errorRow rows record] := by
  apply (exactAdmission _ _ _).mpr
  constructor
  · intro h; cases h
  · exact Rows.next 1 _ _ [] [] [] (Rows.base 2)

theorem errorReconstruction (rows : ObjectiveRows) (record : BoundRecord rows) :
    Rows 1 [.positive (referenceValue rows record)] [.positive (candidateValue rows record)] [errorRow rows record] :=
  ((exactAdmission _ _ _).mp (exactError rows record)).2

theorem errorPositive (rows : ObjectiveRows) (record : BoundRecord rows) :
    0 < (errorRow rows record).2.1.numerator :=
  (errorRow rows record).2.1.positive

-- Connect an actual registered terminal observation to this same bound's
-- candidate/reference counts, not to an unrelated error ledger.
theorem terminalObservation (rows : ObjectiveRows) (record : BoundRecord rows)
    (table : NumericalTrace.ValueTable) (terminal : String)
    (registered : SFT.InformationScience.EncodingMaps.lookupFirst table terminal =
      some [.positive (candidateValue rows record)]) :
    NumericalTrace.records table [.positive (referenceValue rows record)] [terminal] =
      some [(terminal,[.positive (candidateValue rows record)],[errorRow rows record])] := by
  apply NumericalTrace.replay
  exact NumericalTrace.Records.next terminal [] _ _ [] registered (exactError rows record) .base

theorem appendTerminal (rows : ObjectiveRows) (record : BoundRecord rows)
    (table : NumericalTrace.ValueTable) (before : List String) (records : List NumericalTrace.Record)
    (terminal : String)
    (prior : NumericalTrace.Records table [.positive (referenceValue rows record)] before records)
    (registered : SFT.InformationScience.EncodingMaps.lookupFirst table terminal =
      some [.positive (candidateValue rows record)]) :
    NumericalTrace.Records table [.positive (referenceValue rows record)] (before++[terminal])
      (records++[(terminal,[.positive (candidateValue rows record)],[errorRow rows record])]) :=
  NumericalTrace.successorRecord _ _ _ _ prior _ _ _ registered (exactError rows record)

end SFT.Computation.ApproximateError
