import SFT.Physics.TerminalFine
open SFT.Physics SFT.Host.Canonical
#eval do
 let q ← IO.ofExcept TerminalFine.terminalFineCarrier
 IO.println (render (.array [.integer q.num,.integer (.ofNat q.den)]))
