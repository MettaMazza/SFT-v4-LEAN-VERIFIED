import SFT.Materials.Piezoelectric
open SFT.Mathematics.DynamicsTraces
private def merge : Transitions := [("a","terminal"),("b","terminal"),("terminal","terminal")]
#eval IO.println (String.intercalate "," ([reversibleWithRecord merge merge,
 reversibleWithRecord merge [("a","terminal")],
 reversibleWithRecord merge (merge ++ [("a","terminal")]),
 reversibleWithRecord [("a","a")] [("a","a")]].map toString))
