import SFT.Physics.TerminalCKMMeasurement
open SFT.Physics SFT.Host.Canonical
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def frac (r : Rat) : Value := .array [.integer r.num,.integer (.ofNat r.den)]
def interval (r : Rat × Rat) : Value := .array [frac r.1,frac r.2]
#eval do
 let r ← IO.ofExcept TerminalCKM.terminalCKMRelation
 let roots ← IO.ofExcept TerminalQuarkRoots.refinedQuarkRoots
 let p ← IO.ofExcept TerminalCKMComparison.predictionIntervals
 let label ← IO.ofExcept (TerminalCKMMeasurement.classificationFromRecord TerminalMatterRecords.registeredRecord)
 IO.println (render (.object [("relation",.object [("leading_s23",.text r.leadingS23),("terminal_contribution",frac r.terminalContribution),("terminal_s23",.text r.terminalS23),("s12_squared",.text r.s12Squared),("s13_squared",.text r.s13Squared),("phase",frac r.phase)]),("roots",.object [("down",.array (roots.1.map interval)),("up",.array (roots.2.map interval))]),("predictions",.object [("s12_squared",interval p.s12Squared),("s23_squared",interval p.s23Squared),("s13_squared",interval p.s13Squared),("jarlskog_squared",interval p.jarlskogSquared)]),("record",TerminalMatterRecords.registeredRecord),("classification",.text label)]))
