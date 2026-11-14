import SFT.Physics.CausalInterval
open SFT.Physics SFT.Host.Canonical
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def part (p : Option Rat) : Value := match p with | none => .array [] | some q => fraction q
def showResult (x : Except String CausalInterval.Result) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok r => .object [("interval_square",part r.intervalSquare),("causal_class",.text r.causalClass)]
def main : IO Unit := do
 IO.println (render (showResult (CausalInterval.exactInterval ⟨1,1,by decide,by decide⟩ ⟨3,5,by decide,by decide⟩)))
 IO.println (render (showResult (CausalInterval.exactInterval ⟨1,1,by decide,by decide⟩ ⟨1,1,by decide,by decide⟩)))
 IO.println (render (showResult (CausalInterval.exactInterval ⟨2,1,by decide,by decide⟩ ⟨6,5,by decide,by decide⟩)))
 IO.println (render (showResult (CausalInterval.exactInterval ⟨3,2,by decide,by decide⟩ ⟨1,2,by decide,by decide⟩)))
 IO.println (render (showResult (CausalInterval.exactInterval ⟨1,2,by decide,by decide⟩ ⟨3,4,by decide,by decide⟩)))
 IO.println (render (showResult (CausalInterval.exactInterval ⟨1,1,by decide,by decide⟩ ⟨0,1,by decide,by decide⟩)))
 IO.println (render (showResult (CausalInterval.exactInterval ⟨0,1,by decide,by decide⟩ ⟨1,1,by decide,by decide⟩)))
 IO.println (render (showResult (CausalInterval.exactInterval ⟨-1,1,by decide,by decide⟩ ⟨-2,1,by decide,by decide⟩)))
 match CausalInterval.intervalWitness with
 | .error message => IO.println (render (.object [("error",.text message)]))
 | .ok r => IO.println (render (.object [("interval_square",part r.intervalSquare),("causal_class",.text r.causalClass),("proper_time",fraction r.properTime)]))
