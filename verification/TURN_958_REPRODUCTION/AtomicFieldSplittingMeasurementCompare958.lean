import SFT.Physics.AtomicFieldSplittingMeasurement
open SFT.Physics SFT.Host.Canonical AtomicFieldSplittingMeasurement
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def pair (q : Rat × Rat) : Value := .array [frac q.1,frac q.2]
#eval do
 let record := AtomicFieldSplittingRecords.registeredRecord
 let cesium ← IO.ofExcept (RunningConvergenceMeasurement.field (← IO.ofExcept (RunningConvergenceMeasurement.field (← IO.ofExcept (RunningConvergenceMeasurement.field record "sources")) "nist_cesium_quadratic_stark")) "reported_record")
 let operating ← IO.ofExcept (operatingField cesium)
 let label ← IO.ofExcept (classificationFromRecord record)
 IO.println (render (.object [("record",record),("operating",frac operating),("label",.text label)]))
