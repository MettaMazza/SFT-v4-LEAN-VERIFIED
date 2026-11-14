import SFT.Physics.AtomicPostsealMeasurement
open SFT.Physics SFT.Host.Canonical
set_option maxRecDepth 20000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
#eval do
 let record := AtomicPostsealRecords.registeredRecord
 let observed ← IO.ofExcept (AtomicPostsealMeasurement.cubicObservedCoordination record)
 let h ← IO.ofExcept (AtomicPostsealMeasurement.hydrogenComparison record)
 IO.println (render (.object [("record",record),("observed",.integer (.ofNat observed)),("hydrogen",.object [("scale",frac h.scale),("lyman_prediction",frac h.lymanPrediction),("lyman_lower",frac h.lymanLower),("lyman_upper",frac h.lymanUpper),("lyman_passed",.boolean h.lymanPassed),("balmer_prediction",frac h.balmerPrediction),("balmer_lower",frac h.balmerLower),("balmer_upper",frac h.balmerUpper),("balmer_passed",.boolean h.balmerPassed)])]))
