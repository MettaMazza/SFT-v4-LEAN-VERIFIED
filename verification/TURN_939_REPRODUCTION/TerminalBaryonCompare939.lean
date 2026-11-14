import SFT.Physics.TerminalBaryonMeasurement
open SFT.Physics SFT.Host.Canonical
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def frac (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
#eval do
 let r := TerminalBaryon.terminalBaryonRelation
 let p ← IO.ofExcept TerminalBaryon.predictionInterval
 let label ← IO.ofExcept (TerminalBaryonMeasurement.classificationFromRecord TerminalMatterRecords.registeredRecord)
 IO.println (render (.object [("relation",.object [("mixing_source",.text r.mixingSource),("cp_measure",.text r.cpMeasure),("imbalance_share",frac r.imbalanceShare),("eta_relation",.text r.etaRelation)]),("prediction",.array [frac p.1,frac p.2]),("classification",.text label)]))
