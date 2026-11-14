import SFT.Physics.TerminalHyperfine
open SFT.Physics SFT.Host.Canonical TerminalHyperfine
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def result : Except String Rat → Value
 | .error e => .object [("error",.text e)]
 | .ok q => frac q
#eval do
 let inputs : List FoldFirstReturn.Input := [.nonFraction,.nonFraction,.nonFraction,.nonFraction,.fraction (LeptonIntervals.normalize (-2) 1 (by decide)),.fraction (LeptonIntervals.normalize (0) 1 (by decide)),.fraction (LeptonIntervals.normalize (1) 2 (by decide)),.fraction (LeptonIntervals.normalize (1) 1 (by decide)),.fraction (LeptonIntervals.normalize (1001) 1000 (by decide)),.fraction (LeptonIntervals.normalize (2) 1 (by decide)),.fraction (LeptonIntervals.normalize (53) 3 (by decide)),.fraction (LeptonIntervals.normalize (1836) 1 (by decide)),.fraction (LeptonIntervals.normalize (10000) 1 (by decide))]
 let proton ← IO.ofExcept terminalProtonRatioInterval
 let interval ← IO.ofExcept terminalHyperfineCarrierInterval
 IO.println (render (.object [("proton",.array [frac proton.1,frac proton.2]),("interval",.array [frac interval.1,frac interval.2]),("magnetic",result terminalProtonMagneticProjection),("reduced",.array (inputs.map (fun x => result (reducedMassRetention x)))),("hyperfine",.array (inputs.map (fun x => result (hyperfineCarrierAt x))))]))
