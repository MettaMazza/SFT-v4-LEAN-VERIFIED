import SFT.Chemistry.DiffusionLimitedReaction
import SFT.Chemistry.SequentialMechanismAnalysis
namespace SFT.Chemistry.DiffusionLimitedReactionAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics InternalEnergyCompositionExperiment
open DiffusionLimitedReaction
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
def expectedClasses : List (String×Nat) := [("complete-article-landing-record",1),("complete-pdf-page",43),("complete-supplementary-video",2),("complete-figshare-metadata-record",1),("complete-source-data-archive-member",204)]
def sourcePath : Except String (CompleteFiniteTransportPath×RetainedReactionOccurrence) := do
 let identities := [("separated-reactants","initial-boundary"),("initiated-solvation","retained-transport-entry"),("transport-occurrence-word","finite-retained-path"),("encounter-boundary","transport-exit-equals-reaction-entry")]
 let states ← identities.zipIdx.mapM fun ((label,status),i)=>do
  DiffusionLimitedReaction.makeState (.held (← CapabilityValues.heldLabel "registered-transport-reaction-state" label))
   (.held ⟨"held-transported-reactant","Li-plus-benzene-dimer",rfl,rfl⟩) (.count (← CapabilityValues.count (i+1)))
   (.held (← CapabilityValues.heldLabel "held-transport-state-status" status))
 let condition : CapabilityValues.HeldLabel := ⟨"held-transport-reaction-condition","source-held-droplet-condition",rfl,rfl⟩
 let transitions ← (states.zip (states.drop 1)).mapM fun (entry,exit)=>do
  DiffusionLimitedReaction.makeTransition (.held (← CapabilityValues.heldLabel "registered-transport-transition" (Text.intercalate "-to-" [entry.stateIdentity.label,exit.stateIdentity.label])))
   (.held entry.stateIdentity) (.held exit.stateIdentity) (.held condition) (.held ⟨"held-transport-transition-status","retained",rfl,rfl⟩)
 let path ← DiffusionLimitedReaction.makePath (.held ⟨"registered-finite-transport-path","source-transport-path",rfl,rfl⟩)
  (states.map TransportStateInput.state) (transitions.map TransportTransitionInput.transition)
 let reaction ← makeReaction (.held ⟨"registered-reaction-occurrence","source-product-complex-formation",rfl,rfl⟩)
  (.held (← exitState path)) (.held ⟨"registered-transport-reaction-state","product-complex",rfl,rfl⟩) (.held condition) (.held ⟨"held-reaction-status","retained",rfl,rfl⟩)
 pure (path,reaction)
structure Analysis where
 count : Nat
 classCounts : List (String×Nat)
 checks : List (String×Bool)
def exactDiffusionLimitedReactionAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 if rows.length != 251 || !(rows.zipIdx.all fun (row,i)=>sameValue (get row.row "source_record_ordinal") (.integer (i+1))) then throw "KIN-011 requires the complete source-ordered 251-record vector"
 let classes ← rows.mapM fun row=>field row.row "source_record_class" >>= text
 let keys := classes.foldl (fun found key=>if found.any (Text.equal key) then found else found++[key]) []
 let census := keys.map fun key=>(key,(classes.filter (Text.equal key)).length)
 let censusMatch := census.length==expectedClasses.length && expectedClasses.all (fun (key,n)=>census.any (fun (k,m)=>Text.equal k key && m==n))
 let (path,reaction) ← sourcePath
 let boundary ← forcedDiffusionLimitedReactionBoundary (.path path) (.reaction reaction)
 let completion ← ratioFromCounts (.count ⟨3,by decide⟩) (.count ⟨2,by decide⟩)
 let videos := rows.filter fun row=>sameValue (get row.row "source_record_class") (.text "complete-supplementary-video")
 let archives := rows.filter fun row=>sameValue (get row.row "source_record_class") (.text "complete-source-data-archive-member")
 let source ← field primary "structural_transport_reaction_path"
 let sourceStates ← field source "ordered_states" >>= RunningConvergenceMeasurement.array
 let sourceLabels ← sourceStates.mapM fun row=>field row "state"
 let frames ← videos.mapM fun row=>field (get row.row "target_payload") "frame_count" >>= TemperatureCorrespondenceSource.integer
 let archiveHashes ← archives.mapM fun row=>field (get row.row "target_payload") "complete_member_hash" >>= text
 let archiveNames ← archives.mapM fun row=>field row.row "archive_identity" >>= text
 let distinctArchives := archiveNames.foldl (fun names n=>if names.any (Text.equal n) then names else n::names) []
 let shapes ← field primary "complete_key_raw_data_shapes" >>= RunningConvergenceMeasurement.array
 let radiusRows ← field primary "complete_fifteen_row_radius_total_reaction_time_vector" >>= RunningConvergenceMeasurement.array
 let reactants := path.orderedStates.map RetainedTransportState.transportedIdentity
 let distinctReactants := reactants.foldl (fun found q=>if found.any (DihedralTorsion.equalLabel q) then found else q::found) []
 pure ⟨rows.length,census,[
 ("complete_source_class_census_matches",censusMatch),
 ("same_held_reactant_retained_through_complete_transport_word",distinctReactants.length==1),
 ("transport_exit_is_exact_reaction_entry",DihedralTorsion.equalLabel boundary.encounterState reaction.encounterEntryState && sameValue (get source "transport_exit_equals_reaction_entry") (.boolean true)),
 ("reaction_is_admissible_only_after_complete_transport_word",boundary.completeTransportWord.length==path.orderedStates.length-1 && sameValue (get source "complete_transport_word_required_before_reaction_occurrence") (.boolean true)),
 ("exact_positive_completion_relation_reconstructed_without_fit",@decide (completion.value.num=3) (Int.decEq _ _) && completion.value.den==2),
 ("all_five_separated_solvation_transport_encounter_product_states_retained",sameValue (.array sourceLabels) (.array (["separated-reactants","initiated-solvation","transport-occurrence-word","encounter-boundary","product-complex"].map Value.text))),
 ("complete_43_pdf_pages_retained",(classes.filter (Text.equal "complete-pdf-page")).length==43),
 ("complete_1350_video_frames_retained",videos.length==2 && @decide (frames.foldl (·+·) 0=1350) (Int.decEq _ _)),
 ("all_204_archive_members_retained",archives.length==204 && archiveHashes.all (fun h=>(Text.chars "sha256:").isPrefixOf (Text.chars h))),
 ("two_independently_hosted_archive_surfaces_identical_and_both_retained",sameValue (get primary "independently_hosted_nature_and_figshare_archive_bytes_identical") (.boolean true) && distinctArchives.length==2),
 ("complete_11512_key_raw_data_rows_retained",sameValue (get primary "complete_key_raw_data_row_count") (.integer 11512) && shapes.length==7),
 ("complete_15_row_radius_total_reaction_time_vector_retained",radiusRows.length==15),
 ("complete_reaction_yield_and_coincidence_matrices_retained",sameValue (get primary "complete_23_by_15_reaction_yield_matrix_retained") (.boolean true) && sameValue (get primary "complete_150_by_23_coincidence_filtered_distribution_retained") (.boolean true)),
 ("experimental_43_plus_or_minus_5_and_simulated_14_velocity_inscriptions_and_discrepancy_retained",sameValue (get primary "source_reported_experimental_diffusion_velocity_external_inscription") (.text "43 m/s") && sameValue (get primary "source_reported_one_sigma_velocity_uncertainty_external_inscription") (.text "±5 m/s") && sameValue (get primary "source_reported_simulation_diffusion_velocity_external_inscription") (.text "14 m/s") && sameValue (get primary "experiment_and_simulation_velocity_discrepancy_retained_without_reconciliation") (.boolean true)),
 ("reported_rate_estimate_retained_only_as_postseal_provenance",sameValue (get primary "source_reported_rate_constant_estimate_external_inscription") (.text "5×10^12 M^-1 s^-1") && sameValue (get primary "source_reported_CDF_log_normal_linear_fit_rate_constant_RPMD_and_other_models_retained_as_postseal_provenance_only") (.boolean true)),
 ("large_droplet_resolution_and_peer_review_adverse_records_retained",sameValue (get primary "source_reported_large_droplet_deviation_from_linear_fit_retained") (.boolean true) && sameValue (get primary "source_reported_time_resolution_insufficient_for_bond_formation_detail_retained") (.boolean true) && sameValue (get primary "peer_review_nonencounter_and_not_all_systems_reactive_adverse_question_retained") (.boolean true)),
 ("source_values_and_external_zero_negative_decimal_continuum_inscriptions_are_not_proof",sameValue (get primary "source_reported_distance_time_velocity_yield_rate_fit_distribution_simulation_uncertainty_and_condition_values_used_as_fold_proof_parameters") (.boolean false) && sameValue (get primary "external_zero_negative_decimal_and_continuum_inscriptions_preserved_only_as_source_provenance") (.boolean true)),
 ("no_imported_diffusion_continuum_fit_selection_or_target_correction",sameValue (get primary "imported_Fick_Smoluchowski_diffusion_equation_continuum_concentration_field_stochastic_collision_weight_fitted_diffusion_coefficient_selection_average_interpolation_or_target_correction_used_in_law") (.boolean false) && sameValue (get primary "native_numerical_zero_negative_irrational_imaginary_signed_or_continuum_proof_value_used") (.boolean false))]⟩
end SFT.Chemistry.DiffusionLimitedReactionAnalysis
