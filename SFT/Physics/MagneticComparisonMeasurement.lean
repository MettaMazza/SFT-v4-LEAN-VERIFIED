import SFT.Physics.MatterAuthoritativeWitnesses
namespace SFT.Physics.MagneticComparisonMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals MatterAuthoritativeRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def magneticLabel : String := "bare-g-and-terminal-alpha-leading-structure-compared-only-with-raw-electron-and-muon-measurements__consensus-model-interpretation-excluded"
def leadingInterval : Except String (Rat × Rat) := do
 let alpha ← LeptonRatios.divide (normalize 1 1 (by decide)) (normalize 503846395469 3676744786 (by decide))
 let lower ← LeptonRatios.divide alpha (multiply (normalize 2 1 (by decide)) (normalize 355 113 (by decide)))
 let upper ← LeptonRatios.divide alpha (multiply (normalize 2 1 (by decide)) (normalize 333 106 (by decide)))
 pure (lower,upper)

def magneticClassificationRows (nist fnal : Value) : Except String String := do
 let leading ← leadingInterval
 let electron ← decimalField (← field nist "electron_magnetic_anomaly") "value"
 let muon ← decimalField (← field fnal "experimental_world_average") "value"
 if !(electron.blt leading.1 && leading.1.blt leading.2 && leading.2.blt muon) then
  throw "leading anomaly comparison ordering changed"
 let boundary ← text (← field fnal "validation_boundary")
 let requiredStart := "Only the raw measured anomaly and uncertainty enter SFT validation"
 if !Text.isPrefix requiredStart.toUTF8.data.toList boundary.toUTF8.data.toList then
  throw "muon raw-measurement validation boundary changed"
 pure magneticLabel

def magneticClassificationUsing (readSource : String → Except String Value) : Except String String := do
 let nist ← readSource "NIST-CODATA-2022-ALL-CONSTANTS"
 let fnal ← readSource "FERMILAB-MUON-G2-FINAL-2025"
 magneticClassificationRows nist fnal

def magneticClassificationFromRecord (record : Value) : Except String String :=
 magneticClassificationUsing (sourceRowsFromRecord record)
def magneticClassification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String :=
 magneticClassificationUsing (sourceRows bytes files payload)

theorem originalClassification : magneticClassificationFromRecord MatterAuthoritativeWitnesses.registeredRecord = .ok magneticLabel := rfl

def magneticCheck : Bool := match magneticClassificationFromRecord MatterAuthoritativeWitnesses.registeredRecord with
 | .ok label => Text.equal label magneticLabel
 | .error _ => false
theorem magneticCheckPassed : magneticCheck = true := rfl
end SFT.Physics.MagneticComparisonMeasurement
