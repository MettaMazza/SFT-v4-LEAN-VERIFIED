import SFT.Mathematics.FoldScalar
open SFT.Mathematics.FoldScalar SFT.Foundation.ExactOperations

def record : Scalar → String
  | .emptyOne => "empty-One"
  | .positive o x => orientationName o ++ ":" ++ toString x.numerator ++ "/" ++ toString x.denominator

def main : IO Unit := do
  let mut values : List Scalar := [.emptyOne]
  for i in List.range 5 do
    for j in List.range 5 do
      let x := normalizePositive (i+1) (j+1) (Nat.zero_lt_succ i) (Nat.zero_lt_succ j)
      values := values ++ [.positive .forward x, .positive .counter x]
  for x in values do
    IO.println ("reverse\t" ++ record x ++ "\t" ++ record (reverse x))
    for y in values do
      IO.println ("multiply\t" ++ record x ++ "\t" ++ record y ++ "\t" ++ record (multiply x y))
      let d := subtract x y
      IO.println ("add\t" ++ record x ++ "\t" ++ record y ++ "\t" ++ record (add x y))
      IO.println ("subtract\t" ++ record x ++ "\t" ++ record y ++ "\t" ++ record d)
      for k in List.range 5 do
        let t := normalizePositive (k+1) (k+2) (Nat.zero_lt_succ k)
          (Nat.zero_lt_succ (k+1))
        IO.println ("rate\t" ++ record x ++ "\t" ++ record y ++ "\t" ++ record (.positive .forward t) ++ "\t" ++ record (dividePositive d t))
