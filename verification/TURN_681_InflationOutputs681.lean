import SFT.Materials.QuasicrystalInflation
open SFT.Materials.QuasicrystalInflation
#eval do
 for n in [1,2,3,4,5,6] do
  if h : 0<n then
   let pairs := (substitutionPopulations ⟨n,h⟩).map (fun (p : PopulationPair) => toString p.first.val ++ "," ++ toString p.second.val)
   IO.println (toString n ++ ":" ++ String.intercalate ";" pairs)
