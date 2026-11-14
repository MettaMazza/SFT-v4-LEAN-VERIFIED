import SFT.Physics.AtomicShellMeasurement
open SFT.Physics SFT.Host.Canonical AtomicShellMeasurement
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def pair (q : Rat × Rat) : Value := .array [frac q.1,frac q.2]
#eval do
 let record := AtomicShellRecords.registeredRecord
 let intervals ← AtomicShellRecords.requiredRows.mapM (fun symbol => do
  let p ← IO.ofExcept (ionizationInterval record symbol)
  pure (symbol,pair p))
 let label ← IO.ofExcept (classificationFromRecord record)
 IO.println (render (.object [("record",record),("intervals",.object intervals),("label",.text label)]))
