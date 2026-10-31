import SFT.Physics.CosmicComponentTransport
import SFT.Physics.RunningConvergenceMeasurement
import SFT.Host.SHA256Chunks
namespace SFT.Physics.CosmicComponentTransportMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement LeptonIntervals CosmicComponentTransport

def sourcePath := "experiments/external_sources/physics/snapshots/cosmic_transport_terminal-source-record.json"
def sourceHash := "sha256:6a88728657b19dba0bcf2430d28218a595c0798c6ac34bf2778ef53a1b540705"

def checkNested (files : List (String × ByteArray)) : List Value → Except String Unit
 | [] => .ok ()
 | row::rest => do
  let path ← text (← field row "snapshot_path")
  let expected ← text (← field row "snapshot_hash")
  let id ← text (← field row "source_id")
  let bytes ← match files.find? (fun p => Text.equal p.1 path) with
   | none => throw (Text.append "nested cosmic source changed: " id)
   | some (_,bytes) => pure bytes
  if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) expected then
   throw (Text.append "nested cosmic source changed: " id)
  checkNested files rest

def sourcePayload (files : List (String × ByteArray)) (bytes : ByteArray) (payload : Value) : Except String Value := do
 if !Text.equal (Text.append "sha256:" (SHA256Chunks.digest bytes)) sourceHash then throw "cosmic transport source record changed"
 checkNested files (← array (← field payload "sources"))
 pure payload

def intervalOverlap (left right : Rat × Rat) : Bool := !right.2.blt left.1 && !left.2.blt right.1
def positiveOrEmptyDifference (whole part : Rat) : Rat := if part.blt whole then subtract whole part else zero
def fractionText (q : Rat) : String := if q.den==1 then render (.integer q.num)
 else Text.join [render (.integer q.num),"/",render (.integer (.ofNat q.den))]
def intervalText (bounds : Rat × Rat) : Value := .array [.text (fractionText bounds.1),.text (fractionText bounds.2)]
def square (q : Rat) := multiply q q
def thirdPower (q : Rat) := multiply (multiply q q) q
def within (bounds : Rat × Rat) (q : Rat) : Bool := !q.blt bounds.1 && !bounds.2.blt q
def removeMinus (s : String) : String :=
 match Text.chars s with
 | [] => s
 | c::cs => if c=='-' then String.ofList cs else s

def orientationMagnitude (row : Value) (key : String) : Except String Rat := do
 LeptonDecimal.exactDecimal (removeMinus (← text (← field row key)))

def chronometerRow (hubble : Rat × Rat) (position : Nat) (row : Value) : Except String Value := do
 let redshift ← decimalField row "redshift"
 let central ← decimalField row "central"
 let uncertainty ← decimalField row "standard_uncertainty"
 let stretch := add (normalize 1 1 (by decide)) redshift
 let e2 ← lateSquaredExpansion stretch
 let predicted := (multiply (square hubble.1) e2,multiply (square hubble.2) e2)
 let twice := multiply (normalize 2 1 (by decide)) uncertainty
 let observed := (positiveOrEmptyDifference central twice,add central twice)
 let observedSquared := (square observed.1,square observed.2)
 let digits := render (.integer (.ofNat position))
 let id := Text.append "CCH-H2-" (if position<10 then Text.append "0" digits else digits)
 pure (.object [("target_id",.text id),("redshift",.text (fractionText redshift)),("stretch",.text (fractionText stretch)),
 ("e2",.text (fractionText e2)),("predicted_squared_interval",intervalText predicted),
 ("observed_two_uncertainty_squared_interval",intervalText observedSquared),("passed",.boolean (intervalOverlap predicted observedSquared))])

def measurementRecord (payload : Value) : Except String Value := do
 let h0 ← field payload "hubble_reference"
 let hc ← decimalField h0 "central"
 let hu ← decimalField h0 "standard_uncertainty"
 let h := (subtract hc hu,add hc hu)
 let sourceRows ← array (← field (← field payload "cosmic_chronometers") "rows")
 let rows ← sourceRows.zipIdx.mapM fun (row,i) => chronometerRow h (i+1) row
 let budget ← field payload "present_budget"
 let mc ← decimalField budget "matter_central"
 let mu ← decimalField budget "matter_standard_uncertainty"
 let vc ← decimalField budget "vacuum_central"
 let vu ← decimalField budget "vacuum_standard_uncertainty"
 let lower ← LeptonRatios.divide (subtract vc vu) (add mc mu)
 let upper ← LeptonRatios.divide (add vc vu) (subtract mc mu)
 let ratioInterval := (lower,upper)
 let equality ← matterVacuumEqualityCube
 let onset ← accelerationOnsetCube
 let acceleration ← field payload "acceleration"
 let qc ← orientationMagnitude acceleration "conventional_q0_central"
 let qu ← decimalField acceleration "q0_standard_uncertainty"
 let two := normalize 2 1 (by decide)
 let qi := (subtract qc (multiply two qu),add qc (multiply two qu))
 let tc ← decimalField acceleration "transition_redshift_central"
 let tu ← decimalField acceleration "transition_redshift_standard_uncertainty"
 let ti := (subtract tc (multiply two tu),add tc (multiply two tu))
 let one := normalize 1 1 (by decide)
 let cubes := (thirdPower (add one ti.1),thirdPower (add one ti.2))
 let state ← field payload "constant_vacuum_equation_of_state"
 let sc ← orientationMagnitude state "conventional_central"
 let su ← decimalField state "upper_uncertainty"
 let sl ← decimalField state "lower_uncertainty"
 let tension := (subtract sc su,add sc sl)
 let adverse ← field payload "adverse_current_evidence"
 let adverseId ← text (← field adverse "source_id")
 let statement ← text (← field adverse "statement")
 let status ← text (← field adverse "status")
 let retained := Text.equal adverseId "DESI-DR2-2025-COSMOLOGY" && Text.contains statement "3.1 sigma" &&
  Text.contains statement "2.8 to 4.2 sigma" && Text.equal status "retained_model_extension_tension_not_deleted_or_used_to_select_the_static_law"
 let passedRows ← rows.mapM (fun row => boolField row "passed")
 let magnitude ← presentAccelerationMagnitude
 let onsetInterval := (multiply two lower,multiply two upper)
 pure (.object [
 ("chronometer_rows",.array rows),("all_thirty_two_chronometers_pass",.boolean (rows.length==32 && passedRows.all id)),
 ("equality_cube",.text (fractionText equality)),("planck_ratio_interval",intervalText ratioInterval),
 ("equality_passed",.boolean (within ratioInterval equality)),("acceleration_onset_cube",.text (fractionText onset)),
 ("planck_acceleration_ratio_interval",intervalText onsetInterval),("planck_onset_passed",.boolean (within onsetInterval onset)),
 ("present_acceleration_magnitude",.text (fractionText magnitude)),("q_magnitude_interval",intervalText qi),
 ("q_magnitude_passed",.boolean (within qi magnitude)),("transition_cube_interval",intervalText cubes),
 ("transition_passed",.boolean (within cubes onset)),("vacuum_tension_magnitude",.text "1"),
 ("vacuum_tension_interval",intervalText tension),("vacuum_tension_passed",.boolean (within tension one)),
 ("desi_adverse_row_retained",.boolean retained)])

def requiredChecks : List String := ["all_thirty_two_chronometers_pass","equality_passed","planck_onset_passed",
 "q_magnitude_passed","transition_passed","vacuum_tension_passed","desi_adverse_row_retained"]
def completeExternalVector (record : Value) : Except String Bool := do
 let checks ← requiredChecks.mapM (boolField record)
 pure (checks.all id)

theorem emptyDifferenceRetained (whole part : Rat) (notLarger : part.blt whole=false) :
 positiveOrEmptyDifference whole part=zero := by
 unfold positiveOrEmptyDifference
 rw [notLarger]
 rfl

theorem positiveDifferenceRetained (whole part : Rat) (larger : part.blt whole=true) :
 positiveOrEmptyDifference whole part=subtract whole part := by
 unfold positiveOrEmptyDifference
 rw [larger]
 rfl
end SFT.Physics.CosmicComponentTransportMeasurement
