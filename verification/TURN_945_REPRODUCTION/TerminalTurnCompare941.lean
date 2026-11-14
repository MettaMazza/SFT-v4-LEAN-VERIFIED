import SFT.Physics.TerminalTurn
open SFT.Physics SFT.Host.Canonical
#eval do
 let s ← IO.ofExcept TerminalTurn.terminalTurnSupport
 let q ← IO.ofExcept TerminalTurn.terminalTurnProjection
 IO.println (render (.array [.integer (.ofNat s),.integer q.num,.integer (.ofNat q.den)]))
