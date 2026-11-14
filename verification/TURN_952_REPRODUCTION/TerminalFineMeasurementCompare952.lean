import SFT.Physics.TerminalFineMeasurement
open SFT.Physics SFT.Host.Canonical TerminalFineMeasurement
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def pair (q : Rat × Rat) : Value := .array [frac q.1,frac q.2]
#eval do
 let record := AtomicPrecisionRecords.registeredRecord
 let r ← IO.ofExcept (rydbergInterval record)
 let t ← IO.ofExcept (targetInterval record)
 let p ← IO.ofExcept (translatedPredictionInterval record)
 let label ← IO.ofExcept (classificationFromRecord record)
 IO.println (render (.object [("record",record),("rydberg",pair r),("target",pair t),("prediction",pair p),("label",.text label)]))
