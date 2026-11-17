import SFT.Chemistry.RadiotracerCustody
open SFT.Chemistry.RadiotracerCustody SFT.Physics.CapabilityValues
def displayLoss : Value → String
 | .emptyOne _ => "empty-One"
 | .count n => toString n.value
 | _ => "unexpected"
def displayRow (r : RecordRow) : String := s!"{r.1.label},{r.2.1.1}/{r.2.1.2},{displayLoss r.2.2}"
def main : IO Unit := do
 for rank in [1,2,3] do
  for observed in [1,2,3,4,5] do
   for administered in [1,2,3,4,5] do
    let result := match row rank observed administered "place" with
     | .error _ => "error"
     | .ok r => displayRow (project r)
    IO.println s!"row:{rank},{observed},{administered}:{result}"
 let a ← IO.ofExcept first
 let b ← IO.ofExcept second
 let c ← IO.ofExcept (row 3 5 5 "terminal")
 let wrong ← IO.ofExcept (heldLabel "radiotracer" "other")
 let wrongCarrier ← IO.ofExcept (heldLabel "chemical-carrier" "other")
 let cases := [[],[a],[a,b],[a,b,c],[b],[b,a],[a,c],[a,{b with tracer := wrong}],[a,{b with chemicalCarrier := wrongCarrier}],[a,a]]
 for rs in cases do
  let result := match tracerRecord rs with
   | .error _ => "error"
   | .ok output => String.intercalate ";" (output.map displayRow)
  IO.println ("record:" ++ result)
