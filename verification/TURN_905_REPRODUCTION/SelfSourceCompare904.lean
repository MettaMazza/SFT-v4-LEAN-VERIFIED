import SFT.Physics.GravitySelfSource
open SFT.Physics SFT.Host.Canonical
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def main : IO Unit := do
 match GravitySelfSource.nonlinearGravity with
 | .error message => IO.println (render (.object [("error",.text message)]))
 | .ok r => IO.println (render (.object [("source",fraction r.source),("coupling",fraction r.coupling),("linear_field",fraction r.linearField),("field_energy",fraction r.fieldEnergy),("self_source_correction",fraction r.selfSourceCorrection)]))
