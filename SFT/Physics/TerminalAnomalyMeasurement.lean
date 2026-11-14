import SFT.Physics.TerminalMuonAnomaly
import SFT.Physics.TerminalAnomalyRecords
namespace SFT.Physics.TerminalAnomalyMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals
open TerminalAnomalyRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def electronLabel : String := "terminal-target-inaccessible-electron-anomaly-prediction-inside-complete-CODATA-interval__observational-prediction-protocol-passed"
def muonLabel : String := "terminal-target-inaccessible-muon-anomaly-prediction-inside-complete-Fermilab-world-average-interval__observational-prediction-protocol-passed"
def sourceIntervalFromRecord (record : Value) (key : String) : Except String (Rat × Rat) := do
 let row ← field (← field (← field record "sources") key) "row"
 let centre ← decimalField row "value"
 let uncertainty ← decimalField row "standard_uncertainty"
 let lower ← RunningConvergence.positiveTake centre uncertainty
 pure (lower,add centre uncertainty)
def classificationFromRecord (record : Value) (key : String) : Except String String := do
 let prediction ← if Text.equal key "electron" then TerminalElectronAnomaly.terminalElectronAnomaly
  else if Text.equal key "muon" then TerminalMuonAnomaly.terminalMuonAnomaly
  else .error (Text.append "KeyError: " key)
 let target ← sourceIntervalFromRecord record key
 if prediction.blt target.1 || target.2.blt prediction then
  throw (Text.append (Text.append "terminal " key) " anomaly prediction left its complete interval")
 pure (if Text.equal key "electron" then electronLabel else muonLabel)
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) (key : String) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload) key
theorem originalElectronClassification : classificationFromRecord registeredRecord "electron"=.ok electronLabel := rfl
theorem originalMuonClassification : classificationFromRecord registeredRecord "muon"=.ok muonLabel := rfl
def electronCheck : Bool := (normalize 1 10000 (by decide)).blt TerminalElectronAnomaly.terminalElectronAnomalyExpected
def muonCheck : Bool := (normalize 1 10000 (by decide)).blt TerminalMuonAnomaly.terminalMuonAnomalyExpected
theorem electronCheckPassed : electronCheck=true := rfl
theorem muonCheckPassed : muonCheck=true := rfl
def electronClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := classification bytes files payload "electron"
def muonClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := classification bytes files payload "muon"
end SFT.Physics.TerminalAnomalyMeasurement
