import SFT.Physics.MolecularSpectroscopy
import SFT.Physics.MolecularSpectroscopyRecords
namespace SFT.Physics.MolecularSpectroscopyMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals MolecularSpectroscopyRecords
set_option maxRecDepth 20000
def sourceInterval (record : Value) (isotope rowName : String) : Except String (Rat × Rat) := do
 let row ← field (← field (← field (← field record "sources") isotope) "rows") rowName
 let centre ← decimalField row "inscription"
 let halfWidth ← decimalField row "last_inscribed_digit_half_width"
 let lower ← RunningConvergence.positiveTake centre halfWidth
 pure (lower,add centre halfWidth)
def outwardRatioInterval (numerator denominator : Rat × Rat) : Except String (Rat × Rat) := do
 if !zero.blt numerator.1 || !zero.blt denominator.1 then throw "ratio interval requires positive endpoints"
 pure (← LeptonRatios.divide numerator.1 denominator.2,← LeptonRatios.divide numerator.2 denominator.1)
def squaredInterval (interval : Rat × Rat) : Except String (Rat × Rat) := do
 if !zero.blt interval.1 then throw "squared interval requires positive endpoints"
 pure (multiply interval.1 interval.1,multiply interval.2 interval.2)
def measuredRatioIntervals (record : Value) : Except String (List (String × (Rat × Rat))) := do
 let hv ← sourceInterval record "hydrogen" "vibrational_constant_cm_inverse"
 let ha ← sourceInterval record "hydrogen" "anharmonic_constant_cm_inverse"
 let hr ← sourceInterval record "hydrogen" "rotational_constant_cm_inverse"
 let dv ← sourceInterval record "deuterium" "vibrational_constant_cm_inverse"
 let dr ← sourceInterval record "deuterium" "rotational_constant_cm_inverse"
 pure [("hydrogen_rotation_over_vibration",← outwardRatioInterval hr hv),
 ("hydrogen_anharmonic_over_vibration",← outwardRatioInterval ha hv),
 ("deuterium_rotation_over_hydrogen_rotation",← outwardRatioInterval dr hr),
 ("deuterium_vibration_over_hydrogen_vibration_squared",← squaredInterval (← outwardRatioInterval dv hv))]
def sealedRatioVector : Except String (List (String × Rat)) := do
 pure [("hydrogen_rotation_over_vibration",← MolecularSpectroscopy.hydrogenRotationalToVibrational),
 ("hydrogen_anharmonic_over_vibration",← MolecularSpectroscopy.hydrogenAnharmonicToVibrational),
 ("deuterium_rotation_over_hydrogen_rotation",← MolecularSpectroscopy.deuteriumRotationalTransport),
 ("deuterium_vibration_over_hydrogen_vibration_squared",← MolecularSpectroscopy.deuteriumVibrationalSquaredTransport)]
def label : String := "terminal-molecular-JJplusOne-anharmonic-and-isotope-relations-contained-in-complete-NIST-H2-D2-displayed-resolution-vector__observational-prediction-protocol-passed"
def classificationFromRecord (record : Value) : Except String String := do
 let intervals ← measuredRatioIntervals record
 let sealed ← sealedRatioVector
 let _ ← sealed.foldlM (fun (_ : Unit) item => do
  let interval ← match intervals.find? (fun x => Text.equal x.1 item.1) with
   | none => .error (Text.append "KeyError: " item.1)
   | some x => .ok x.2
  if item.2.blt interval.1 || interval.2.blt item.2 then
   throw (Text.append "sealed molecular ratio left the complete NIST displayed-resolution interval: " item.1)
  pure ()) ()
 let h ← field (← field (← field record "sources") "hydrogen") "rows"
 let d ← field (← field (← field record "sources") "deuterium") "rows"
 let names := ["vibrational_constant_cm_inverse","anharmonic_constant_cm_inverse","rotational_constant_cm_inverse"]
 let hv ← names.mapM (fun name => do decimalField (← field h name) "inscription")
 let dv ← names.mapM (fun name => do decimalField (← field d name) "inscription")
 let h0 ← LeptonRatios.atIndex hv 0
 let h1 ← LeptonRatios.atIndex hv 1
 let h2 ← LeptonRatios.atIndex hv 2
 let d0 ← LeptonRatios.atIndex dv 0
 let d1 ← LeptonRatios.atIndex dv 1
 let d2 ← LeptonRatios.atIndex dv 2
 if !(h1.blt h0 && h2.blt h1 && zero.blt h2) then throw "NIST H2 hierarchy no longer confirms distinct positive carriers"
 if !(d1.blt d0 && d2.blt d1 && zero.blt d2) then throw "NIST D2 hierarchy no longer confirms distinct positive carriers"
 if !((dv.zip hv).all (fun p => p.1.blt p.2)) then throw "NIST isotope direction no longer confirms the heavier-carrier shift"
 pure label
def classification (bytes : ByteArray) (files : List (String × ByteArray)) (payload : Value) : Except String String := do
 classificationFromRecord (← authoritativeRecord bytes files payload)
theorem originalClassification : classificationFromRecord registeredRecord=.ok label := rfl
def carrierCheck : Bool := (sealedRatioVector.toOption.getD []).all (fun p => zero.blt p.2)
theorem carrierCheckPassed : carrierCheck=true := rfl
end SFT.Physics.MolecularSpectroscopyMeasurement
