import SFT.Physics.TerminalFine
import SFT.Physics.AtomicPrecisionRecords
namespace SFT.Physics.TerminalFineMeasurement
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
 let row ← field (← field (← field (← field record "sources") "lamb_and_fine") "rows") "direct_experimental_fine_interval"
 symmetricInterval row "value_hz" "conservative_uncertainty_hz"
def translatedPredictionInterval (record : Value) : Except String (Rat × Rat) := do
 let rydberg ← rydbergInterval record
 let carrier ← TerminalFine.terminalFineCarrier
 pure (multiply carrier rydberg.1,multiply carrier rydberg.2)
def label : String := "terminal-fine-prediction-contained-in-conservative-direct-NIST-experimental-interval__observational-prediction-protocol-passed"
def classificationFromRecord (record : Value) : Except String String := do
 let prediction ← translatedPredictionInterval record
 let target ← targetInterval record
 if prediction.1.blt target.1 || prediction.2.blt prediction.1 || target.2.blt prediction.2 then
  throw "terminal fine prediction left the complete registered interval"
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload)
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def carrierCheck : Bool := (normalize 1 (10^6) (by decide)).blt TerminalFine.terminalFineExpected
theorem carrierCheckPassed : carrierCheck=true := rfl
end SFT.Physics.TerminalFineMeasurement
