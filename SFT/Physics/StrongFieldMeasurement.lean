import SFT.Physics.StrongFieldNonlinearFixedPointEvidence
import SFT.Physics.SymmetricRecords
namespace SFT.Physics.StrongFieldMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement StrongFieldNonlinearFixedPointCertificate LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def requiredTargetRows : List String := ["v1_source_entry", "v1_chargeless_relation", "v1_gravity_relation", "v1_strong_relation", "v1_joint_discriminator", "existing_v3_strong_running", "existing_v3_gravity_fixed_point", "existing_v3_field_source_response", "existing_v3_sector_inventory", "existing_v3_massless_confined_carrier", "formal_prediction_commit_precedes_target_access", "formal_chargeless_correction_record", "formal_chargeless_fixed_point", "formal_gravity_fixed_point", "formal_gravity_corrections", "formal_strong_initial_source", "formal_strong_successor", "formal_strong_correction", "formal_strong_positive_finite_fixed_point_record", "formal_strong_arbitrary_positive_bound_witness", "formal_completed_infinity_used", "pdg_qcd_nonabelian_gauge_theory", "pdg_qcd_gluon_carries_colour_charge", "pdg_qcd_three_and_four_gluon_self_interactions", "pdg_qcd_free_quarks_observed", "lattice_source_identity", "lattice_theory", "lattice_gluons_only_static_energy_relation", "lattice_linear_growth_rate", "lattice_full_QCD_pair_creation", "lattice_full_QCD_ground_state_saturates", "lattice_ground_state_asymptote", "lattice_string_and_broken_string_mixing_required", "lattice_string_branch_in_breaking_region", "lattice_light_string_breaking_distance", "lattice_strange_string_breaking_distance", "lattice_spacing", "lattice_pion_mass", "lattice_kaon_mass", "lattice_single_ensemble", "lattice_quark_masses_are_not_physical", "lattice_distances_are_not_universal_physical_thresholds", "formal_branch_correspondence", "external_values_select_formal_survivor", "external_distances_used_as_formal_proof_scalars", "measured_parameter_fitted_into_v3", "free_strong_field_correction_added_to_v3"]
def targetRows (target : Value) (keys : List String) : Except String (List Value) := keys.mapM (field target)
def exactMeasurementAnalysis (target : Value) : Except String Value := do
 let c ← fieldIterationCertificate (.integer 12)
 let frac := StrongFieldNonlinearFixedPointEvidence.frac
 let eq := fun key value => do pure (sameValue (← field target key) value)
 let pdg ← targetRows target ["pdg_qcd_nonabelian_gauge_theory","pdg_qcd_gluon_carries_colour_charge","pdg_qcd_three_and_four_gluon_self_interactions"]
 let lattice ← targetRows target ["lattice_light_string_breaking_distance","lattice_strange_string_breaking_distance","lattice_spacing","lattice_pion_mass","lattice_kaon_mass"]
 let limits ← targetRows target ["lattice_single_ensemble","lattice_quark_masses_are_not_physical","lattice_distances_are_not_universal_physical_thresholds"]
 let pairCreation ← field target "lattice_full_QCD_pair_creation"
 let saturates ← field target "lattice_full_QCD_ground_state_saturates"
 let mixing ← field target "lattice_string_and_broken_string_mixing_required"
 let keys ← match target with
  | .object fields => .ok (fields.map Prod.fst)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "TypeError"
 let retained := keys.length==47 && keys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==requiredTargetRows.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)
 pure (.object [
 ("formal_neutral_hold",.boolean c.neutralLinearHold),("formal_neutral_correction",.array (c.neutral.correctionRecord.map frac)),("formal_gravity_fixed_point",.array (c.gravity.admissibleFixedPoints.map frac)),("formal_gravity_contracts",.boolean c.gravitySelfSourceContracts),("formal_strong_initial_source",frac (c.strong.sources.headD zero)),("formal_strong_correction",frac c.strong.correction),("formal_strong_persists",.boolean c.strongSelfSourcePersists),("formal_strong_finite_fixed_point_record",.array (c.strongFiniteFixedPointRecord.map frac)),("formal_strong_no_positive_finite_fixed_point",.boolean c.strongHasNoPositiveFiniteFixedPoint),("formal_strong_registered_bounds_exceeded",.boolean c.allRegisteredBoundsExceeded),("formal_completed_infinity_used",.boolean c.completedInfinityUsed),
 ("historical_discriminator_retained",.boolean (← eq "v1_joint_discriminator" (.text "chargeless-hold-gravity-contraction-strong-persistence"))),("all_target_rows_retained",.boolean retained),("pdg_self_interaction_correspondence",.boolean (pdg.all SymmetricRecords.truthy)),("pdg_free_quark_boundary_retained",.boolean (← eq "pdg_qcd_free_quarks_observed" (.boolean false))),
 ("lattice_unbroken_branch_correspondence",.boolean ((← eq "lattice_gluons_only_static_energy_relation" (.text "grows-linearly-at-asymptotically-large-separations")) && (← eq "lattice_linear_growth_rate" (.text "string-tension-sigma")) && (← eq "lattice_string_branch_in_breaking_region" (.text "V-hat-of-r-equals-V-hat-0-plus-sigma-r")))),
 ("lattice_full_ground_state_limit_retained",.boolean (SymmetricRecords.truthy pairCreation && SymmetricRecords.truthy saturates && (← eq "lattice_ground_state_asymptote" (.text "two-noninteracting-static-light-mesons")) && SymmetricRecords.truthy mixing && (← eq "formal_branch_correspondence" (.text "persistent-Fold-self-source-corresponds-to-unbroken-string-branch-not-full-QCD-ground-state")))),
 ("lattice_values_retained",.array lattice),("lattice_limits_retained",.boolean (limits.all SymmetricRecords.truthy)),
 ("external_values_select_formal_survivor",← field target "external_values_select_formal_survivor"),("external_distances_used_as_formal_proof",← field target "external_distances_used_as_formal_proof_scalars"),("fitted_value_used",← field target "measured_parameter_fitted_into_v3"),("free_correction_used",← field target "free_strong_field_correction_added_to_v3")])
end SFT.Physics.StrongFieldMeasurement
