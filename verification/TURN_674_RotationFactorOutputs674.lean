import SFT.Materials.RotationFactors
open SFT.Materials.RotationFactors
#eval do
 for n in List.range 65 do
  match positivePrimeFactors (.integer (.ofNat n)) with
  | .ok rows => IO.println (toString n ++ "\tok\t" ++ String.intercalate "," (rows.map toString))
  | .error e => IO.println (toString n ++ "\terror\t" ++ e)
