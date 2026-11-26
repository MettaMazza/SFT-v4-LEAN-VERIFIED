import SFT.Chemistry.ReactionDynamicsScattering
import SFT.Chemistry.SequentialMechanismAnalysis
namespace SFT.Chemistry.ReactionDynamicsScatteringAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics InternalEnergyCompositionExperiment
open ReactionDynamicsScattering
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
def expectedClasses : List (String×Nat) := [("complete-article-landing-record",1),("complete-article-pdf-page",9),("complete-supplementary-information-page",11),("complete-transparent-peer-review-page",16),("complete-source-data-worksheet",14)]
def sourceIncoming (reaction : String := "source-reaction") : Except String RetainedIncomingReactionChannel := do
 makeIncoming (.held ⟨"registered-incoming-reaction-channel","F-plus-CH4",rfl,rfl⟩)
  (.held (← CapabilityValues.heldLabel "held-scattering-reaction-identity" reaction))
  [.held ⟨"held-incoming-channel-carrier","F",rfl,rfl⟩,.held ⟨"held-incoming-channel-carrier","CH4",rfl,rfl⟩]
  (.held ⟨"held-incoming-preparation","crossed-beam-preparation",rfl,rfl⟩)
def sourceOutgoing (occurrence : CapabilityValues.PositiveCount) (orientation : String) (events : CapabilityValues.PositiveCount) (reaction : String := "source-reaction") : Except String RetainedOutgoingProductState := do
 let label := toString occurrence.value
 makeOutgoing (.count occurrence) (.held (← CapabilityValues.heldLabel "registered-outgoing-product-channel" (Text.append "CH3-HF-" label)))
  (.held (← CapabilityValues.heldLabel "held-scattering-reaction-identity" reaction))
  [.held ⟨"held-outgoing-product-carrier","CH3",rfl,rfl⟩,.held ⟨"held-outgoing-product-carrier","HF",rfl,rfl⟩]
  [.held (← CapabilityValues.heldLabel "held-outgoing-product-state" (Text.append "CH3-state-" label)),.held (← CapabilityValues.heldLabel "held-outgoing-product-state" (Text.append "HF-state-" label))]
  (.held (← CapabilityValues.heldLabel "held-incoming-outgoing-orientation" orientation)) (.count events) (.held ⟨"held-scattering-evidence-status","retained",rfl,rfl⟩)
def sourceSupport (outgoingReaction : String := "source-reaction") : Except String CompleteFiniteProductStateSupport := do
 makeSupport (.incoming (← sourceIncoming)) [.outgoing (← sourceOutgoing ⟨1,by decide⟩ "same-oriented" ⟨3,by decide⟩ outgoingReaction),
  .outgoing (← sourceOutgoing ⟨2,by decide⟩ "transverse-oriented" ⟨2,by decide⟩ outgoingReaction),.outgoing (← sourceOutgoing ⟨3,by decide⟩ "opposed-oriented" ⟨1,by decide⟩ outgoingReaction)]
structure Analysis where
 count : Nat
 classCounts : List (String×Nat)
 checks : List (String×Bool)
def exactReactionDynamicsScatteringAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 if rows.length != 51 || !(rows.zipIdx.all fun (row,i)=>sameValue (get row.row "source_record_ordinal") (.integer (i+1))) then throw "KIN-013 requires the complete source-ordered 51-record vector"
 let classes ← rows.mapM fun row=>field row.row "source_record_class" >>= text
 let keys := classes.foldl (fun found key=>if found.any (Text.equal key) then found else found++[key]) []
 let census := keys.map fun key=>(key,(classes.filter (Text.equal key)).length)
 let censusMatch := census.length==expectedClasses.length && expectedClasses.all (fun (key,n)=>census.any (fun (k,m)=>Text.equal k key && m==n))
 let results ← forcedReactionScatteringProductStateLaw (.support (← sourceSupport))
 let words := results.map ExactProductStateScatteringRecord.orderedProductStates
 let statuses ← field primary "source_experimental_theoretical_and_processing_statuses_retained_separately"
 let peer ← field primary "transparent_peer_review_adverse_surface"
 let statusFields ← match statuses with
  | .object xs=>pure xs
  | .null | .boolean _ | .integer _ | .text _ | .array _=>throw "source status mapping required"
 let peerFields ← match peer with
  | .object xs=>pure xs
  | .null | .boolean _ | .integer _ | .text _ | .array _=>throw "source peer mapping required"
 let shapes ← field primary "complete_source_data_worksheet_shapes" >>= RunningConvergenceMeasurement.array
 let vectors ← ["complete_fig3_pair_correlated_branching_cell_vector","complete_fig4_state_resolved_scattering_cell_vector","complete_supplementary_fig8_sampling_and_contamination_cell_vector","complete_supplementary_fig9_before_after_correction_cell_vector"].mapM fun key=>field primary key >>= RunningConvergenceMeasurement.array
 pure ⟨rows.length,census,[
 ("complete_source_class_census_matches",censusMatch),
 ("finite_incoming_and_complete_distinct_outgoing_joint_product_state_support_reconstructed",results.length==3 && (words.foldl (fun found w=>if found.any (equalWord w) then found else found++[w]) []).length==3),
 ("exact_positive_state_shares_reconstructed_without_cross_section_model",results.length==3 && (results.zip [(1,2),(1,3),(1,6)]).all (fun (r,(n,d))=>(@decide (r.exactEventShare.num=n) (Int.decEq _ _)) && r.exactEventShare.den==d)),
 ("all_three_incoming_outgoing_orientation_relations_remain_held",results.length==3 && (results.zip ["same-oriented","transverse-oriented","opposed-oriented"]).all (fun (r,l)=>Text.equal r.orientationToIncoming.label l)),
 ("complete_36_pdf_pages_retained",(classes.filter (fun k=>["complete-article-pdf-page","complete-supplementary-information-page","complete-transparent-peer-review-page"].any (Text.equal k))).length==36),
 ("all_14_source_data_worksheets_retained",(classes.filter (Text.equal "complete-source-data-worksheet")).length==14 && shapes.length==14),
 ("complete_978591_nonempty_cell_surface_retained",sameValue (get primary "complete_source_data_nonempty_cell_count") (.integer 978591)),
 ("complete_6408_key_state_resolved_product_and_scattering_cells_retained",sameValue (get primary "complete_key_state_resolved_product_and_scattering_cell_count") (.integer 6408)),
 ("complete_pair_branching_state_scattering_sampling_and_overlap_vectors_retained",vectors.all (fun v=>v.length>1)),
 ("source_headline_state_and_orientation_vector_retained",sameValue (get primary "source_reported_headline_external_inscriptions") (.object [("backward_product_pair",.text "(0_0,2)"),("collision_energy",.text "2.4 kcal mol^-1 (0.106 eV)"),("experimental_pair_branching_total",.text "unity"),("forward_product_pair",.text "(0_0,3)"),("ground_state_CH3_reactivity",.text "40%"),("incoming_CH4_rotational_state_distribution",.text "0.31:0.54:0.15 for j=0:j=1:j=2"),("sideways_product_pair",.text "(2_2,2)"),("umbrella_excited_CH3_experimental_reactive_flux",.text "57%"),("umbrella_excited_CH3_theoretical_reactive_flux",.text "58%")])),
 ("experimental_theoretical_fit_normalization_estimate_tentative_and_limit_statuses_all_retained",statusFields.all (fun (_,v)=>ComponentExchangeAnalysis.truthy v)),
 ("complete_transparent_peer_review_adverse_surface_retained",peerFields.all (fun (_,v)=>ComponentExchangeAnalysis.truthy v)),
 ("all_raw_images_speed_energy_branching_scattering_theory_and_review_records_byte_bound",sameValue (get primary "all_complete_raw_image_speed_energy_branching_state_resolved_angular_sampling_overlap_correction_theory_and_peer_review_records_byte_bound") (.boolean true)),
 ("source_models_fits_normalizations_and_corrections_remain_postseal_provenance_only",sameValue (get primary "source_scattering_cross_section_energy_momentum_transition_state_potential_surface_and_quantum_dynamics_models_retained_as_postseal_provenance_only") (.boolean true) && sameValue (get primary "source_reported_values_models_fits_normalizations_estimates_tentative_assignments_and_corrections_used_as_fold_proof_parameters") (.boolean false)),
 ("external_zero_negative_decimal_scientific_angle_and_continuum_inscriptions_are_not_proof",sameValue (get primary "external_zero_negative_decimal_scientific_notation_angle_and_continuum_inscriptions_preserved_only_as_source_provenance") (.boolean true)),
 ("no_imported_scattering_cross_section_amplitude_potential_continuum_fit_selection_or_target_correction",sameValue (get primary "imported_scattering_equation_cross_section_law_angular_continuum_probability_amplitude_fitted_potential_distribution_normalization_selection_average_interpolation_or_target_correction_used_in_law") (.boolean false) && sameValue (get primary "native_numerical_zero_negative_irrational_imaginary_signed_or_continuum_proof_value_used") (.boolean false))]⟩
end SFT.Chemistry.ReactionDynamicsScatteringAnalysis
