import SFT.Chemistry.KineticIsotopeFractionation
open SFT.Chemistry.KineticIsotopeFractionation SFT.Physics.CapabilityValues
def ratioText (r : Nat × Nat) : String := s!"{r.1}/{r.2}"
def valueText : Value → String
 | .emptyOne _ => "empty-One"
 | .count n => toString n.value
 | .label l => l.label
 | _ => "unexpected"
def seriesText (r : SeriesRow) : String := String.intercalate "," [ratioText r.1,ratioText r.2.1,ratioText r.2.2.1,valueText r.2.2.2]
def main : IO Unit := do
 for rank in [1,2,3] do
  for lp in [1,2,3,4,5,6,7,8,9] do
   for hp in [1,2,3,4,5,6,7,8,9] do
    let result := match row rank lp hp with
     | .error _ => "error"
     | .ok r => match project r with
      | .error _ => "error"
      | .ok p => seriesText p ++ "," ++ valueText (remaining r).1 ++ "," ++ valueText (remaining r).2
    IO.println s!"row:{rank},{lp},{hp}:{result}"
 let a ← IO.ofExcept first
 let b ← IO.ofExcept second
 let c ← IO.ofExcept (row 3 8 8)
 let wrong ← IO.ofExcept (heldLabel "reaction-path" "other")
 let cases := [[],[a],[a,b],[a,b,c],[b],[b,a],[a,c],[a,{b with reaction := wrong}]]
 for rs in cases do
  let result := match timeSeries rs with
   | .error _ => "error"
   | .ok out => String.intercalate ";" (out.map seriesText)
  IO.println ("series:" ++ result)
