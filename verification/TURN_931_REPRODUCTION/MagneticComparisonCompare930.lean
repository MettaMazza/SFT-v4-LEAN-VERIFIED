import SFT.Physics.MagneticComparisonMeasurement
open SFT.Physics SFT.Physics.MagneticComparisonMeasurement SFT.Host.Canonical
def fraction (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let (l,u) ← IO.ofExcept leadingInterval
 let label ← IO.ofExcept (magneticClassificationFromRecord MatterAuthoritativeWitnesses.registeredRecord)
 IO.println (render (.object [("lower",fraction l),("upper",fraction u),("classification",.text label)]))
