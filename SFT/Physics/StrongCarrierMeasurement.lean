import SFT.Physics.StrongCarrierMasslessConfinedEvidence
import SFT.Physics.SymmetricRecords
namespace SFT.Physics.StrongCarrierMeasurement
open SFT.Host SFT.Host.Canonical RunningConvergenceMeasurement StrongCarrierMasslessConfinedCertificate LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def requiredTargetRows : List String := ["v1_source_entry", "v1_mass_relation", "v1_causal_relation", "v1_confinement_relation", "v1_joint_relation", "existing_v3_sector_inventory", "existing_v3_self_source", "existing_v3_empty_mass_boundary", "existing_v3_One_speed_operation", "existing_v3_finite_range_control", "existing_v3_colour_neutral_composites", "existing_v3_conserved_source", "formal_prediction_commit_precedes_target_access", "formal_colour_labels", "formal_nonsinglet_carrier_count", "formal_mass_record", "formal_causal_speed", "formal_tube_width", "formal_separation_work_successor", "formal_isolated_colour_record", "pdg_gluon_listing_identity", "pdg_gluon_colour_representation", "pdg_gluon_mass_value", "pdg_gluon_mass_value_classification", "pdg_gluon_mass_caveat", "pdg_qcd_colour_count", "pdg_qcd_gluon_count", "pdg_qcd_gluon_representation", "pdg_qcd_nonlinear_field_term_present", "pdg_qcd_three_gluon_vertex_present", "pdg_qcd_four_gluon_vertex_present", "pdg_qcd_free_quarks_or_gluons_observed", "pdg_qcd_hadrons_are_colour_singlets", "pdg_measured_CA", "pdg_expected_CA", "pdg_measured_CF", "pdg_expected_CF", "pdg_CA_CF_correlation", "pdg_colour_factor_assessment", "pdg_gluon_jet_evidence", "pdg_quark_model_confinement_status", "pdg_physical_state_boundary", "pdg_permanent_colour_confinement_status", "direct_free_gluon_time_of_flight_measurement_available", "external_values_select_formal_survivor", "external_mass_value_used_as_formal_proof_scalar", "measured_parameter_fitted_into_v3", "free_carrier_correction_added_to_v3"]
def targetRows (target : Value) (keys : List String) : Except String (List Value) := keys.mapM (field target)
def exactMeasurementAnalysis (target : Value) : Except String Value := do
 let c ← simultaneousCarrierCertificate (.integer 32)
 let frac := StrongCarrierMasslessConfinedEvidence.frac
 let ca := normalize 289 100 (by decide)
 let caBoundary := add (normalize 3 100 (by decide)) (normalize 21 100 (by decide))
 let caExpected := normalize 3 1 (by decide)
 let cf := normalize 13 10 (by decide)
 let cfBoundary := add (normalize 1 100 (by decide)) (normalize 9 100 (by decide))
 let cfExpected := normalize 4 3 (by decide)
 let prerequisites ← targetRows target ["existing_v3_sector_inventory","existing_v3_self_source","existing_v3_empty_mass_boundary","existing_v3_One_speed_operation","existing_v3_finite_range_control","existing_v3_colour_neutral_composites","existing_v3_conserved_source"]
 let scope ← targetRows target ["pdg_gluon_mass_value_classification","pdg_gluon_mass_caveat","pdg_quark_model_confinement_status","pdg_permanent_colour_confinement_status","direct_free_gluon_time_of_flight_measurement_available"]
 let eq := fun key value => do pure (sameValue (← field target key) value)
 let nonlinear ← field target "pdg_qcd_nonlinear_field_term_present"
 let selfSource ← if !SymmetricRecords.truthy nonlinear then pure nonlinear else do
  let three ← field target "pdg_qcd_three_gluon_vertex_present"
  if !SymmetricRecords.truthy three then pure three else field target "pdg_qcd_four_gluon_vertex_present"
 let keys ← match target with
  | .object fields => .ok (fields.map Prod.fst)
  | .null | .boolean _ | .integer _ | .text _ | .array _ => .error "TypeError"
 let retained := keys.length==48 && keys.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)==requiredTargetRows.map (fun s => s.toUTF8.data.toList.map UInt8.toNat)
 pure (.object [
 ("formal_colour_labels",.integer (.ofNat c.sector.chargeLabels)),("formal_carrier_count",.integer (.ofNat c.sector.mediatorCount)),("formal_coupling",frac c.sector.coupling),("formal_mass_record",.array (c.sector.massLabel.map frac)),("formal_One_speed",frac c.causal.causalSpeed),("formal_phase_retained",.boolean c.causal.phaseRetained),("formal_tube_width",frac c.tube.tubeWidth),("formal_work_successor",frac c.tube.workIncrement),("formal_arbitrary_bounds_exceeded",.boolean c.allRegisteredBoundsExceeded),("formal_isolated_colour_record",.array (c.tube.isolatedColourCarrierRecord.map frac)),("formal_joint_law",.boolean (c.simultaneouslyMasslessAndOneSpeed && c.simultaneouslyConfined)),
 ("historical_joint_relation_retained",.boolean (← eq "v1_joint_relation" (.text "masslessness-and-confinement-coexist"))),("prerequisite_rows_retained",.array prerequisites),("scope_rows_retained",.array scope),("all_target_rows_retained",.boolean retained),
 ("pdg_three_eight_correspondence",.boolean ((← eq "pdg_qcd_colour_count" (.text "Nc=3")) && (← eq "pdg_qcd_gluon_count" (.text "Nc-squared-minus-1=8")))),("pdg_massless_classification_correspondence",.boolean (← eq "pdg_gluon_mass_value" (.text "m=0"))),("pdg_mass_value_is_theoretical_not_direct_measurement",.boolean (← eq "pdg_gluon_mass_value_classification" (.text "theoretical-value"))),("pdg_mass_caveat_retained",.boolean (← eq "pdg_gluon_mass_caveat" (.text "mass-as-large-as-a-few-MeV-may-not-be-precluded"))),("pdg_self_source_correspondence",selfSource),("pdg_confinement_correspondence",.boolean ((← eq "pdg_qcd_free_quarks_or_gluons_observed" (.boolean false)) && (← eq "pdg_qcd_hadrons_are_colour_singlets" (.boolean true)))),("pdg_gluon_jet_evidence_retained",.boolean (← eq "pdg_gluon_jet_evidence" (.text "clear-experimental-evidence-for-softer-broader-gluon-jets"))),
 ("measured_CA",frac ca),("measured_CA_conservative_boundary",frac caBoundary),("expected_CA",frac caExpected),("measured_CA_contains_expected",.boolean (!caBoundary.blt (subtract caExpected ca))),("measured_CF",frac cf),("measured_CF_conservative_boundary",frac cfBoundary),("expected_CF",frac cfExpected),("measured_CF_contains_expected",.boolean (!cfBoundary.blt (subtract cfExpected cf))),("colour_factor_values_used_as_formal_proof",.boolean false),
 ("direct_free_gluon_time_of_flight_available",← field target "direct_free_gluon_time_of_flight_measurement_available"),("external_values_select_formal_survivor",← field target "external_values_select_formal_survivor"),("external_mass_value_used_as_formal_proof",← field target "external_mass_value_used_as_formal_proof_scalar"),("fitted_value_used",← field target "measured_parameter_fitted_into_v3"),("free_correction_used",← field target "free_carrier_correction_added_to_v3")])
end SFT.Physics.StrongCarrierMeasurement
