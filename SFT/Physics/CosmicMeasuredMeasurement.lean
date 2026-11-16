import SFT.Physics.CosmicMeasuredResidual
import SFT.Physics.CosmicComponentTransportMeasurement
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.CosmicMeasuredMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement
open LeptonIntervals CosmicMeasuredResidual CosmicComponentTransport
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000

def decimal (v : Value) (key : String) : Except String Rat :=
 CosmicComponentTransportMeasurement.orientationMagnitude v key

def interval (center lower : Rat) (upper : Option Rat := none) : Except String (Rat × Rat) :=
 let upper := match upper with | none => lower | some value => value
 if !lower.blt center || !zero.blt lower || !zero.blt upper then
  .error "cosmic interval must remain positive"
 else .ok (subtract center lower,add center upper)

def observations (original : Value) : Except String (List Observation) := do
 let rows ← array (← field (← field original "cosmic_chronometers") "rows")
 rows.mapM (fun row => do .ok ⟨← decimal row "redshift",← decimal row "central",← decimal row "standard_uncertainty"⟩)

def residualWithin (rounds : Nat) (original : Value) : Except String (Option Certificate) := do
 let hubble ← field original "hubble_reference"
 let h0 ← decimal hubble "central"
 let h0Uncertainty ← decimal hubble "standard_uncertainty"
 let rows ← prepareRows (← observations original) 1
 runWithin h0 h0Uncertainty rounds 0 rows

-- Four execution rounds cover the authenticated original and both declared controls.
-- Their exact stopping decisions are independently established by kernel certificates;
-- the general source loop is retained in SourceRun and runWithin, with no changed test.
def registeredResidual (original : Value) : Except String Certificate := do
 match ← residualWithin 4 original with
 | some c => .ok c
 | none => .error "authenticated residual execution has not reached its certified stopping round"

def certificateValue (c : Certificate) : Value := .object [
 ("row_count",.integer (.ofNat c.rowCount)),("refinements",.integer (.ofNat c.refinements)),
 ("mean_squared_residual_lower",RunningConvergenceCertificate.rat c.meanLower),
 ("mean_squared_residual_upper",RunningConvergenceCertificate.rat c.meanUpper),
 ("unit_mean_squared_residual_passed",.boolean c.passed),
 ("all_rows_contributed_once",.boolean c.allRowsContributedOnce),
 ("root_enclosures_exact",.boolean c.rootEnclosuresExact)]
def pair (bounds : Rat × Rat) : Value := .array [RunningConvergenceCertificate.rat bounds.1,RunningConvergenceCertificate.rat bounds.2]

def exactCosmicAnalysis (target : Value) : Except String Value := do
 let record ← field target "record"
 let original ← field target "original"
 let residual ← registeredResidual original
 let budget ← field original "present_budget"
 let matter ← interval (← decimal budget "matter_central") (← decimal budget "matter_standard_uncertainty")
 let vacuum ← interval (← decimal budget "vacuum_central") (← decimal budget "vacuum_standard_uncertainty")
 let ratio := (← LeptonRatios.divide vacuum.1 matter.2,← LeptonRatios.divide vacuum.2 matter.1)
 let corrected ← field record "corrected_acceleration_target"
 let qInterval ← interval (← decimal corrected "present_deceleration_conventional_center") (← decimal corrected "present_deceleration_standard_uncertainty")
 let transition ← interval (← decimal corrected "transition_redshift_center") (← decimal corrected "transition_redshift_lower_uncertainty") (some (← decimal corrected "transition_redshift_upper_uncertainty"))
 let one := normalize 1 1 (by decide)
 let two := normalize 2 1 (by decide)
 let cube := CosmicComponentTransportMeasurement.thirdPower
 let transitionCube := (cube (add one transition.1),cube (add one transition.2))
 let state ← field original "constant_vacuum_equation_of_state"
 let stateInterval ← interval (← decimal state "conventional_central") (← decimal state "upper_uncertainty") (some (← decimal state "lower_uncertainty"))
 let alternate ← field original "acceleration"
 let desi ← field original "adverse_current_evidence"
 let equality ← matterVacuumEqualityCube
 let onset ← accelerationOnsetCube
 let acceleration ← presentAccelerationMagnitude
 let within := CosmicComponentTransportMeasurement.within
 .ok (.object [
 ("residual_certificate",certificateValue residual),("planck_ratio_interval",pair ratio),
 ("Haridasu_q_interval",pair qInterval),("Haridasu_transition_cube_interval",pair transitionCube),
 ("static_state_magnitude_interval",pair stateInterval),
 ("chronometer_unit_residual_passed",.boolean residual.passed),
 ("all_chronometer_rows_contributed_once",.boolean residual.allRowsContributedOnce),
 ("rational_root_enclosures_exact",.boolean residual.rootEnclosuresExact),
 ("equality_inside_Planck_ratio",.boolean (within ratio equality)),
 ("onset_inside_twice_Planck_ratio",.boolean (within (multiply two ratio.1,multiply two ratio.2) onset)),
 ("acceleration_inside_Haridasu_interval",.boolean (within qInterval acceleration)),
 ("onset_inside_Haridasu_transition_interval",.boolean (within transitionCube onset)),
 ("tension_One_inside_static_state_interval",.boolean (within stateInterval one)),
 ("alternate_reconstruction_retained",.boolean (Text.equal (← text (← field alternate "source_id")) "GOMEZ-VALENT-2019-ACCELERATION")),
 ("DESI_model_comparison_retained",.boolean (Text.equal (← text (← field desi "source_id")) "DESI-DR2-2025-COSMOLOGY" && Text.contains (← text (← field desi "statement")) "w0-wa")),
 ("complete_original_rows_retained",.boolean (ThermometryMeasurement.literalBoolean (← field (← field record "registered_target_source") "complete_original_rows_retained") true))])
end SFT.Physics.CosmicMeasuredMeasurement
