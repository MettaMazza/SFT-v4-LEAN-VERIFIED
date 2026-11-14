import SFT.Physics.HydrogenRydberg
open SFT.Physics SFT.Host.Canonical HydrogenRydberg
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def result : Except String Rat → Value
 | .error e => .object [("error",.text e)]
 | .ok q => frac q
#eval do
 let inputs : List FoldFirstReturn.Input := [.nonFraction,.nonFraction,.nonFraction,.nonFraction,.fraction (LeptonIntervals.normalize (-2) 1 (by decide)),.fraction (LeptonIntervals.normalize (0) 1 (by decide)),.fraction (LeptonIntervals.normalize (1) 2 (by decide)),.fraction (LeptonIntervals.normalize (1) 1 (by decide)),.fraction (LeptonIntervals.normalize (1001) 1000 (by decide)),.fraction (LeptonIntervals.normalize (2) 1 (by decide)),.fraction (LeptonIntervals.normalize (53) 3 (by decide)),.fraction (LeptonIntervals.normalize (1836) 1 (by decide)),.fraction (LeptonIntervals.normalize (10000) 1 (by decide))]
 let scale ← IO.ofExcept terminalHydrogenScaleInterval
 let rest ← IO.ofExcept terminalIonizationToElectronRestInterval
 IO.println (render (.object [("scale",.array [frac scale.1,frac scale.2]),("rest",.array [frac rest.1,frac rest.2]),("scaleAt",.array (inputs.map (fun x => result (terminalHydrogenScaleAt x))))]))
