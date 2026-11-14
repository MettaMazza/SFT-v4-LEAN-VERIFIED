import SFT.Physics.MajoranaComparisonMeasurement
open SFT.Physics SFT.Physics.MajoranaComparisonMeasurement SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let (l,u) ← IO.ofExcept (predictionBounds (LeptonIntervals.normalize 749 10000000 (by decide)))
 let label ← IO.ofExcept (majoranaClassificationFromRecord MatterAuthoritativeWitnesses.registeredRecord)
 IO.println (render (.object [("floor",fraction l),("ceiling",fraction u),("classification",.text label)]))
