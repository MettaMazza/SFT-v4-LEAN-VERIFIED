import SFT.Computation.CausalTermination
open SFT.Computation.CausalTermination
#eval closeRows (pairCells ["a","b","c"]) [("a","b"),("b","c")]
#eval closeRows (pairCells ["a","b"]) [("a","b"),("b","a")]
#eval closeRows (pairCells ["a"]) []
#eval closeRows (pairCells []) []
