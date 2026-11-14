import SFT.Physics.OpticalOperations
open SFT.Physics SFT.Host.Canonical
def fraction (q : Rat) : Value := .object [("numerator",.integer q.num),("denominator",.integer (.ofNat q.den))]
def showResult (x : Except String OpticalOperations.Result) : Value := match x with
 | .error message => .object [("error",.text message)]
 | .ok r => .object [("propagation",.array (r.propagation.map fraction)),("polarization",.array (r.polarization.map Value.text)),("bright_support",fraction r.brightSupport),("dark_record",.array []),("mixing",.object [("sum",fraction r.mixing.sum),("positive_difference",fraction r.mixing.positiveDifference),("second_harmonic",fraction r.mixing.secondHarmonic),("kerr_self_action",fraction r.mixing.kerrSelfAction),("third_harmonic",fraction r.mixing.thirdHarmonic)])]
def main : IO Unit := IO.println (render (showResult OpticalOperations.exactOpticalOperations))
