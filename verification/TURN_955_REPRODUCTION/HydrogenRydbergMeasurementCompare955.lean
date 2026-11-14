import SFT.Physics.HydrogenRydbergMeasurement
open SFT.Physics SFT.Host.Canonical HydrogenRydbergMeasurement
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def pair (q : Rat × Rat) : Value := .array [frac q.1,frac q.2]
#eval do
 let record := HydrogenRydbergRecords.registeredRecord
 let r ← IO.ofExcept (rydbergInterval record)
 let t ← IO.ofExcept (ionizationTargetInterval record)
 let p ← IO.ofExcept (predictedIonizationInterval record)
 let l ← IO.ofExcept (predictedLineInterval record (LeptonIntervals.normalize 3 4 (by decide)))
 let b ← IO.ofExcept (predictedLineInterval record (LeptonIntervals.normalize 5 36 (by decide)))
 let lt ← IO.ofExcept (lineTargetInterval record "lyman_alpha")
 let bt ← IO.ofExcept (lineTargetInterval record "balmer_alpha")
 let label ← IO.ofExcept (classificationFromRecord record)
 IO.println (render (.object [("record",record),("rydberg",pair r),("target",pair t),("prediction",pair p),("lyman",pair l),("balmer",pair b),("lymanTarget",pair lt),("balmerTarget",pair bt),("label",.text label)]))
