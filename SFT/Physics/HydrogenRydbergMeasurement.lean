import SFT.Physics.HydrogenRydberg
import SFT.Physics.HydrogenRydbergRecords
namespace SFT.Physics.HydrogenRydbergMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals HydrogenRydbergRecords
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def symmetricInterval (row : Value) (value uncertainty : String) : Except String (Rat × Rat) := do
 let centre ← decimalField row value
 let spread ← decimalField row uncertainty
 let lower ← RunningConvergence.positiveTake centre spread
 pure (lower,add centre spread)
def rydbergInterval (record : Value) : Except String (Rat × Rat) := do
 let row ← field (← field (← field record "sources") "rydberg") "row"
 symmetricInterval row "value_cm_inverse" "standard_uncertainty_cm_inverse"
def ionizationTargetInterval (record : Value) : Except String (Rat × Rat) := do
 let row ← field (← field (← field record "sources") "hydrogen_ionization") "row"
 symmetricInterval row "value_cm_inverse" "last_inscribed_digit_half_width_cm_inverse"
def lineTargetInterval (record : Value) (kind : String) : Except String (Rat × Rat) := do
 let row ← field (← field (← field (← field record "sources") "hydrogen_lines") "rows") kind
 symmetricInterval row "value_cm_inverse" "standard_uncertainty_cm_inverse"
def outwardRatioInterval (numerator denominator : Rat × Rat) : Except String (Rat × Rat) := do
 if !(VacuumLedgerProofs.wholeRatio 0).blt numerator.1 || !(VacuumLedgerProofs.wholeRatio 0).blt denominator.1 then
  throw "hydrogen Rydberg ratio requires positive endpoints"
 pure (← LeptonRatios.divide numerator.1 denominator.2,← LeptonRatios.divide numerator.2 denominator.1)
def predictedIonizationInterval (record : Value) : Except String (Rat × Rat) := do
 let scale ← HydrogenRydberg.terminalHydrogenScaleInterval
 let rydberg ← rydbergInterval record
 pure (multiply scale.1 rydberg.1,multiply scale.2 rydberg.2)
def predictedLineInterval (record : Value) (gap : Rat) : Except String (Rat × Rat) := do
 let ionization ← predictedIonizationInterval record
 pure (multiply gap ionization.1,multiply gap ionization.2)
def intervalsOverlap (left right : Rat × Rat) : Bool := !right.2.blt left.1 && !left.2.blt right.1
def label : String := "terminal-hydrogen-reduced-mass-and-radiative-scale-contained-in-NIST-ionization-Rydberg-ratio__absolute-ionization-Lyman-Balmer-vector-passed"
def classificationFromRecord (record : Value) : Except String String := do
 let scale ← HydrogenRydberg.terminalHydrogenScaleInterval
 let targetScale ← outwardRatioInterval (← ionizationTargetInterval record) (← rydbergInterval record)
 if scale.1.blt targetScale.1 || scale.2.blt scale.1 || targetScale.2.blt scale.2 then
  throw "terminal hydrogen/Rydberg scale left the complete registered interval"
 let ionization ← predictedIonizationInterval record
 let target ← ionizationTargetInterval record
 if ionization.1.blt target.1 || ionization.2.blt ionization.1 || target.2.blt ionization.2 then
  throw "terminal hydrogen ionization left the displayed-resolution enclosure"
 let lines := [("lyman_alpha",normalize 3 4 (by decide)),("balmer_alpha",normalize 5 36 (by decide))]
 let _ ← lines.foldlM (fun (_ : Unit) pair => do
  let prediction ← predictedLineInterval record pair.2
  let target ← lineTargetInterval record pair.1
  if !intervalsOverlap prediction target then throw (Text.append "terminal hydrogen line left the complete NIST interval: " pair.1)
  pure ()) ()
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload)
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def carrierCheck : Bool := (normalize 99 100 (by decide)).blt HydrogenRydberg.scaleExpected.1 && HydrogenRydberg.scaleExpected.1.blt HydrogenRydberg.scaleExpected.2 && HydrogenRydberg.scaleExpected.2.blt (VacuumLedgerProofs.wholeRatio 1)
theorem carrierCheckPassed : carrierCheck=true := rfl
end SFT.Physics.HydrogenRydbergMeasurement
