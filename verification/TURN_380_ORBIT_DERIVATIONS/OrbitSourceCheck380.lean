import SFT.Mathematics.OrbitNumberWitnesses
open SFT.Mathematics.OrbitNumberWitnesses

def main : IO Unit := do
 for i in List.range 49 do
  let q := 2*i+3
  for j in List.range (q-1) do
   let p := j+1
   if Nat.gcd p q == 1 then
    match orbitWitness p q with
    | none => throw (IO.userError "original finite orbit witness did not finish")
    | some trace => match orderWitness q with
      | none => throw (IO.userError "original finite order witness did not finish")
      | some order => IO.println (toString p ++ "\t" ++ toString q ++ "\t" ++ toString order ++ "\t" ++ ("[" ++ String.intercalate "," (trace.map toString) ++ "]"))
