import SFT.Physics.HydrogenRydberg
open SFT.Physics SFT.Host.Canonical HydrogenRydberg
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def result : Except String (Rat × Rat) → Value
 | .error e => .object [("error",.text e)]
 | .ok p => .array [frac p.1,frac p.2]
#eval do
 let inputs : List FoldFirstReturn.Input := [.nonFraction,.nonFraction,.nonFraction,.nonFraction,.fraction (LeptonIntervals.normalize (-1) 1 (by decide)),.fraction (LeptonIntervals.normalize (0) 1 (by decide)),.fraction (LeptonIntervals.normalize (1) 1 (by decide)),.fraction (LeptonIntervals.normalize (2) 1 (by decide)),.fraction (LeptonIntervals.normalize (1) 100000 (by decide)),.fraction (LeptonIntervals.normalize (3) 4 (by decide)),.fraction (LeptonIntervals.normalize (5) 36 (by decide)),.fraction (LeptonIntervals.normalize (99999) 100000 (by decide))]
 IO.println (render (.array (inputs.map fun x => result (terminalLineRatioInterval x))))
