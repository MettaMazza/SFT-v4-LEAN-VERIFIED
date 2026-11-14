import SFT.Physics.HydrogenSpectrum
open SFT.Physics SFT.Host.Canonical GeneratorOperations
def output : Except String Rat → Value
 | .error e => .object [("error",.text e)]
 | .ok q => .array [.integer q.num,.integer (.ofNat q.den)]
#eval do
 let values : List CountInput := [.boolean false,.boolean true,.integer (-3),.integer (-2),.integer (-1),.integer (0),.integer (1),.integer (2),.integer (3),.integer (4),.integer (5),.integer (6),.integer (7),.integer (8),.integer (9),.integer (10),.integer (11),.integer (12)]
 IO.println (render (.object [("levels",.array (values.map fun x => output (HydrogenSpectrum.hydrogenLevel x))),
 ("transitions",.array (values.flatMap fun u => values.map fun l => output (HydrogenSpectrum.hydrogenTransition u l)))]))
