import SFT.Physics.PMNSSupport
import SFT.Host.Canonical
open SFT.Physics SFT.Host.Canonical

def ratValue (r : Rat) : Value := .array [.integer r.num,.integer r.den]
def main : IO Unit := do
 let b ← match AlphaCovers.binaryCount with
  | .ok n => pure n
  | .error e => throw (IO.userError e)
 let c ← match FoldFirstReturn.generatorPeriod with
  | .ok n => pure n
  | .error e => throw (IO.userError e)
 let tower ← match AlphaCovers.positivePower (.integer (.ofNat b)) (.integer (.ofNat c)) with
  | .ok n => pure n
  | .error e => throw (IO.userError e)
 let s ← match PMNSSupport.squaredSupport with
  | .ok s => pure s
  | .error e => throw (IO.userError e)
 IO.println (render (.object [("parts",.object [("atmospheric",ratValue s.atmospheric),("solar",ratValue s.solar),("reactor",ratValue s.reactor)]),("binary",.integer b),("generator",.integer c),("tower",.integer tower)]))
