import SFT.Physics.FieldElectricPotential
open SFT.Mathematics.FoldScalar SFT.Foundation.ExactOperations

def record : Scalar → String
  | .emptyOne => "empty-One"
  | .positive o x => orientationName o ++ ":" ++ toString x.numerator ++ "/" ++ toString x.denominator

def main : IO Unit := do
  let mut values : List Scalar := [.emptyOne]
  let mut charges : List SFT.Physics.FieldElectricDistinction.Charge := []
  for i in List.range 5 do
    for j in List.range 5 do
      let x := normalizePositive (i+1) (j+1) (Nat.zero_lt_succ i) (Nat.zero_lt_succ j)
      values := values ++ [.positive .forward x,.positive .counter x]
      charges := charges ++ [⟨x,.first⟩,⟨x,.second⟩]
  for x in values do
    for q in charges do
      let qs := Scalar.positive (SFT.Physics.MechanicalAcceleration.scalarOrientation q.held) q.amount
      IO.println ("divide\t" ++ record x ++ "\t" ++ record qs ++ "\t" ++
        record (SFT.Physics.FieldElectricPotential.normalizeCharge x q))
