import SFT.Physics.TerminalLamb
open SFT.Physics SFT.Host.Canonical TerminalLamb
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
#eval do
 let alpha ← IO.ofExcept exactAlpha
 let heavy ← IO.ofExcept depthThreeHeavyComplement
 let support ← IO.ofExcept predecessorUpSupport
 let terminal ← IO.ofExcept terminalBinarySupport
 let lamb ← IO.ofExcept terminalLambCarrier
 IO.println (render (.object [("alpha",frac alpha),("heavy",.integer heavy),("support",.integer (.ofNat support)),("terminal",.integer (.ofNat terminal)),("lamb",frac lamb)]))
