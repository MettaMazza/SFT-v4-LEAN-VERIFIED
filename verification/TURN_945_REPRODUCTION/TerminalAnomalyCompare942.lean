import SFT.Physics.TerminalMuonAnomaly
open SFT.Physics SFT.Host.Canonical
#eval do
 let q0 ← IO.ofExcept TerminalElectronAnomaly.electronLoopCarrier
 let q1 ← IO.ofExcept TerminalElectronAnomaly.electronAnomalyRetention
 let q2 ← IO.ofExcept TerminalElectronAnomaly.terminalElectronAnomaly
 let q3 ← IO.ofExcept TerminalMuonAnomaly.muonGenerationCorrection
 let q4 ← IO.ofExcept TerminalMuonAnomaly.terminalMuonAnomaly
 IO.println (render (.array [.array [.integer q0.num,.integer (.ofNat q0.den)],.array [.integer q1.num,.integer (.ofNat q1.den)],.array [.integer q2.num,.integer (.ofNat q2.den)],.array [.integer q3.num,.integer (.ofNat q3.den)],.array [.integer q4.num,.integer (.ofNat q4.den)]]))
