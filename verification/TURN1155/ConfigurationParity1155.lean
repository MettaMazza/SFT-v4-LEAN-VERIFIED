import SFT.Chemistry.ConfigurationOrder
open SFT.Chemistry.ConfigurationOrder
def display : Except String Bool → String
 | .error e => "error:"++e
 | .ok b => toString b
def main : IO Unit := do
 let heights : List Height := [.emptyOne,(.otherEmptyOne "other"),(.ratio ⟨1,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨1,by decide⟩ ⟨2,by decide⟩),(.ratio ⟨2,by decide⟩ ⟨1,by decide⟩),(.ratio ⟨3,by decide⟩ ⟨2,by decide⟩)]
 for a in heights do
  for b in heights do
   for c in heights do
    let x ← IO.ofExcept (witnessNode "0" a)
    let y ← IO.ofExcept (witnessNode "1" b)
    let z ← IO.ofExcept (witnessNode "2" c)
    for kind in [true,false] do
     for pos in ([-1,0,1,2,3] : List Int) do
      IO.println (display (localComparison kind [x,y,z] pos))
