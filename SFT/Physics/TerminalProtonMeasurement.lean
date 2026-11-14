import SFT.Physics.TerminalProtonComparison
import SFT.Physics.TerminalProtonRecords
namespace SFT.Physics.TerminalProtonMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals
open TerminalProtonRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def label : String := "terminal-target-free-proton-electron-prediction-contained-inside-complete-CODATA-standard-uncertainty__observational-prediction-protocol-passed"
def sourceIntervalFromRecord (record : Value) : Except String (Rat × Rat) := do
 let row ← field (← field record "source") "row"
 let centre ← decimalField row "value"
 let uncertainty ← decimalField row "standard_uncertainty"
 pure (subtract centre uncertainty,add centre uncertainty)
def classificationFromRecord (record : Value) : Except String String := do
 let p ← TerminalProtonComparison.protonRatioInterval
 let t ← sourceIntervalFromRecord record
 if p.1.blt t.1 || p.2.blt p.1 || t.2.blt p.2 then
  throw "terminal proton prediction left the complete CODATA interval"
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload)
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def contributionCheck : Bool := (normalize 1 (10^6) (by decide)).blt TerminalProton.originalRecord.dressing && TerminalProton.originalRecord.dressing.blt (normalize 1 1000 (by decide))
theorem contributionCheckPassed : contributionCheck=true := rfl
end SFT.Physics.TerminalProtonMeasurement
