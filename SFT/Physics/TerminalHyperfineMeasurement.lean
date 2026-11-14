import SFT.Physics.TerminalHyperfine
import SFT.Physics.AtomicPrecisionRecords
namespace SFT.Physics.TerminalHyperfineMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals AtomicPrecisionRecords
set_option maxRecDepth 20000
def symmetricInterval (row : Value) (value uncertainty : String) : Except String (Rat × Rat) := do
 let centre ← decimalField row value
 let spread ← decimalField row uncertainty
 let lower ← RunningConvergence.positiveTake centre spread
 pure (lower,add centre spread)
def rydbergInterval (record : Value) : Except String (Rat × Rat) := do
 let row ← field (← field (← field record "sources") "rydberg") "row"
 symmetricInterval row "value_hz" "standard_uncertainty_hz"
def targetInterval (record : Value) : Except String (Rat × Rat) := do
 let row ← field (← field (← field record "sources") "hyperfine") "row"
 symmetricInterval row "value_hz" "standard_uncertainty_hz"
def translatedPredictionInterval (record : Value) : Except String (Rat × Rat) := do
 let rydberg ← rydbergInterval record
 let carrier ← TerminalHyperfine.terminalHyperfineCarrierInterval
 pure (multiply carrier.1 rydberg.1,multiply carrier.2 rydberg.2)
def centralCarrierInterval (record : Value) : Except String (Rat × Rat) := do
 let row ← field (← field (← field record "sources") "rydberg") "row"
 let centre ← decimalField row "value_hz"
 let carrier ← TerminalHyperfine.terminalHyperfineCarrierInterval
 pure (multiply carrier.1 centre,multiply carrier.2 centre)
def intervalsOverlap (left right : Rat × Rat) : Bool := !(right.2.blt left.1) && !(left.2.blt right.1)
def label : String := "terminal-hyperfine-central-prediction-inside-NIST-21cm-interval-and-complete-carrier-interval-overlaps__observational-prediction-protocol-passed"
def classificationFromRecord (record : Value) : Except String String := do
 let prediction ← translatedPredictionInterval record
 let target ← targetInterval record
 let central ← centralCarrierInterval record
 if !intervalsOverlap prediction target then throw "complete hyperfine carrier and measurement intervals do not overlap"
 if central.1.blt target.1 || central.2.blt central.1 || target.2.blt central.2 then
  throw "central-Rydberg hyperfine prediction left the complete NIST interval"
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload)
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def carrierCheck : Bool := (normalize 1 (10^7) (by decide)).blt TerminalHyperfine.hyperfineExpected.1
theorem carrierCheckPassed : carrierCheck=true := rfl
end SFT.Physics.TerminalHyperfineMeasurement
