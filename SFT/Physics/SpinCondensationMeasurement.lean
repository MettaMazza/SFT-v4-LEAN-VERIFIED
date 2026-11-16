import SFT.Physics.SpinCondensationAnalysis
import SFT.Physics.ThermometryMeasurement
namespace SFT.Physics.SpinCondensationMeasurement
open SFT.Host.Canonical RunningConvergenceMeasurement
def exactSpinStatisticsAnalysis (target : Value) : Except String Value := do
 let becCenter ← SectorAnchorRecords.originalInt (← field target "bec_transition_ratio_center")
 let becUncertainty ← SectorAnchorRecords.originalInt (← field target "bec_transition_ratio_uncertainty")
 let becDenominator ← SectorAnchorRecords.originalInt (← field target "bec_transition_ratio_denominator")
 let correction ← SectorAnchorRecords.originalInt (← field target "bec_reported_finite_population_correction_percent")
 let spinStates ← SectorAnchorRecords.originalInt (← field target "pauli_spin_state_count")
 let collisionFactor ← SectorAnchorRecords.originalInt (← field target "pauli_collision_cross_section_reduction_factor")
 let forced ← SectorAnchorRecords.originalInt (← field target "spinor_forced_return_degrees")
 let spinCenter ← SectorAnchorRecords.originalInt (← field target "spinor_measured_return_degrees_center")
 let spinUncertainty ← SectorAnchorRecords.originalInt (← field target "spinor_measured_return_degrees_uncertainty")
 let finite := ThermometryMeasurement.literalBoolean (← field target "bec_finite_population_measurement") true
 let ground := ThermometryMeasurement.literalBoolean (← field target "bec_ground_state_occupation_measured") true
 let cooling := ThermometryMeasurement.literalBoolean (← field target "bec_ground_share_increases_as_temperature_is_lowered") true
 let transition := ThermometryMeasurement.literalBoolean (← field target "bec_sharp_transition_feature_observed") true
 let pauli := ThermometryMeasurement.literalBoolean (← field target "pauli_blocking_directly_observed") true
 let oneTurn := ThermometryMeasurement.literalBoolean (← field target "spinor_one_turn_changes_held_orientation") true
 let twoTurns := ThermometryMeasurement.literalBoolean (← field target "spinor_two_turns_restore_identical_state") true
 let allRows := ThermometryMeasurement.literalBoolean (← field target "all_registered_rows_retained") true
 pure (SpinCondensationAnalysis.exactAnalysis ⟨becCenter,becUncertainty,becDenominator,correction,spinStates,collisionFactor,forced,spinCenter,spinUncertainty,finite,ground,cooling,transition,pauli,oneTurn,twoTurns,allRows⟩)
end SFT.Physics.SpinCondensationMeasurement
