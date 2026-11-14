import SFT.Physics.MolecularSpectroscopyMeasurement
open SFT.Physics SFT.Host.Canonical MolecularSpectroscopyMeasurement
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
def pair (q : Rat × Rat) : Value := .array [frac q.1,frac q.2]
#eval do
 let record := MolecularSpectroscopyRecords.registeredRecord
 let intervals ← IO.ofExcept (measuredRatioIntervals record)
 let predictions ← IO.ofExcept sealedRatioVector
 let label ← IO.ofExcept (classificationFromRecord record)
 let rows ← ["hydrogen","deuterium"].flatMapM fun isotope => ["vibrational_constant_cm_inverse","anharmonic_constant_cm_inverse","rotational_constant_cm_inverse"].mapM fun name => do
  let interval ← IO.ofExcept (sourceInterval record isotope name)
  pure (Value.array [.text isotope,.text name,pair interval])
 IO.println (render (.object [("record",record),("rows",.array rows),("intervals",.object (intervals.map (fun (p : String × (Rat × Rat)) => (p.1,pair p.2)))),("predictions",.object (predictions.map (fun (p : String × Rat) => (p.1,frac p.2)))),("label",.text label)]))
