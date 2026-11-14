import SFT.Physics.TerminalProtonMeasurement
open SFT.Physics SFT.Host.Canonical
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def frac (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def interval (p : Rat × Rat) : Value := .array [frac p.1,frac p.2]
#eval do
 let r ← IO.ofExcept TerminalProton.terminalProtonRelation
 let p ← IO.ofExcept TerminalProtonComparison.protonRatioInterval
 let target ← IO.ofExcept (TerminalProtonMeasurement.sourceIntervalFromRecord TerminalProtonRecords.registeredRecord)
 let label ← IO.ofExcept (TerminalProtonMeasurement.classificationFromRecord TerminalProtonRecords.registeredRecord)
 IO.println (render (.object [("relation",.object [("base",.text r.base),("composite_depth",.integer (.ofNat r.compositeDepth)),("heavy_complement",frac r.heavyComplement),("bulk_boundary_support",.integer (.ofNat r.bulkBoundarySupport)),("self_coupling_order",.integer (.ofNat r.selfCouplingOrder)),("terminal_transport",frac r.terminalTransport),("dressing",frac r.dressing),("retention",frac r.retention),("result",.text r.result)]),("roots",.array (TerminalProtonComparison.refinedBrackets.map interval)),("prediction",interval p),("record",TerminalProtonRecords.registeredRecord),("target",interval target),("classification",.text label)]))
