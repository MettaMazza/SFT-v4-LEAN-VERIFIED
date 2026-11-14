import SFT.Physics.AtomicTransitionRateMeasurement
open SFT.Physics SFT.Host.Canonical AtomicTransitionRateMeasurement
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def pair (q : Rat × Rat) : Value := .array [frac q.1,frac q.2]
#eval do
 let record := AtomicTransitionRateRecords.registeredRecord
 let argon ← IO.ofExcept (measuredInterval record "nist_argon_metastable")
 let aluminium ← IO.ofExcept (measuredInterval record "nist_aluminium_clock")
 let allowed ← IO.ofExcept (allowedExampleLifetime record)
 let label ← IO.ofExcept (classificationFromRecord record)
 IO.println (render (.object [("record",record),("argon",pair argon),("aluminium",pair aluminium),("allowed",frac allowed),("label",.text label)]))
