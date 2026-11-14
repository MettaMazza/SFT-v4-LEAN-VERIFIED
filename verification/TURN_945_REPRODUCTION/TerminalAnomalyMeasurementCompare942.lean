import SFT.Physics.TerminalAnomalyMeasurement
open SFT.Physics SFT.Host.Canonical
set_option maxRecDepth 20000
def frac (q : Rat) : Value := .array [.integer q.num,.integer (.ofNat q.den)]
#eval do
 let record := TerminalAnomalyRecords.registeredRecord
 let e ← IO.ofExcept (TerminalAnomalyMeasurement.sourceIntervalFromRecord record "electron")
 let m ← IO.ofExcept (TerminalAnomalyMeasurement.sourceIntervalFromRecord record "muon")
 let el ← IO.ofExcept (TerminalAnomalyMeasurement.classificationFromRecord record "electron")
 let ml ← IO.ofExcept (TerminalAnomalyMeasurement.classificationFromRecord record "muon")
 IO.println (render (.object [("record",record),("electron",.array [frac e.1,frac e.2,.text el]),("muon",.array [frac m.1,frac m.2,.text ml])]))
