import SFT.Chemistry.KineticIsotopeEffect
import SFT.Chemistry.SequentialMechanismAnalysis
namespace SFT.Chemistry.KineticIsotopeEffectAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics InternalEnergyCompositionExperiment
open KineticIsotopeEffect
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
def expectedClasses : List (String×Nat) := [("complete-article-landing-record",1),("complete-article-pdf-page",8),("complete-supplementary-information-page",11),("complete-reporting-summary-page",28),("complete-source-data-worksheet",23)]
def exactPair (first second : CapabilityValues.PositiveCount) (secondPath : String := "complete-source-path") : Except String CompleteIsotopologueRatePair := do
 let roles ← ["reactant-and-condition-entry","protonated-intermediate","event","product-observation"].mapM (CapabilityValues.heldLabel "registered-reaction-path-role")
 let retained := fun isotope events path=>do
  makePath (.held ⟨"held-isotope-reaction-identity","source-reaction",rfl,rfl⟩)
   (.held (← CapabilityValues.heldLabel "held-complete-reaction-path" path))
   (.held (← CapabilityValues.heldLabel "held-isotopologue-identity" isotope)) (roles.map MolecularFormationEnergy.LabelInput.held)
   (.held ⟨"held-isotope-reaction-condition","source-condition",rfl,rfl⟩)
   (.rate (← rateFromCounts (.count events) (.count ⟨2,by decide⟩))) (.held ⟨"held-isotope-rate-status","retained",rfl,rfl⟩)
 makePair (.held ⟨"registered-ordered-isotopologue-pair","source-pair",rfl,rfl⟩)
  (.path (← retained "H2O-held-source-label" first "complete-source-path")) (.path (← retained "D2O-held-source-label" second secondPath))
structure Analysis where
 count : Nat
 classCounts : List (String×Nat)
 checks : List (String×Bool)
def exactKineticIsotopeEffectAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 if rows.length != 71 || !(rows.zipIdx.all fun (row,i)=>sameValue (get row.row "source_record_ordinal") (.integer (i+1))) then throw "KIN-012 requires the complete source-ordered 71-record vector"
 let classes ← rows.mapM fun row=>field row.row "source_record_class" >>= text
 let keys := classes.foldl (fun found key=>if found.any (Text.equal key) then found else found++[key]) []
 let census := keys.map fun key=>(key,(classes.filter (Text.equal key)).length)
 let censusMatch := census.length==expectedClasses.length && expectedClasses.all (fun (key,n)=>census.any (fun (k,m)=>Text.equal k key && m==n))
 let normal ← forcedKineticIsotopeEffectRelation (.pair (← exactPair ⟨3,by decide⟩ ⟨2,by decide⟩))
 let inverse ← forcedKineticIsotopeEffectRelation (.pair (← exactPair ⟨2,by decide⟩ ⟨3,by decide⟩))
 let equal ← forcedKineticIsotopeEffectRelation (.pair (← exactPair ⟨2,by decide⟩ ⟨2,by decide⟩))
 let vector ← field primary "complete_explicit_rate_ratio_vector" >>= RunningConvergenceMeasurement.array
 let direct ← field primary "source_reported_direct_decay_KIE_external_inscriptions" >>= RunningConvergenceMeasurement.array
 let ratios ← vector.mapM fun row=>do
  let inscription ← field row "rate_ratio_external_inscription" >>= text
  HeatWorkTransferAnalysis.sourceDecimal inscription
 let temperatures ← field (get primary "source_reported_temperature_series_boundary_external_inscriptions") "temperatures_C" >>= RunningConvergenceMeasurement.array
 let shapes ← field primary "complete_source_data_worksheet_shapes" >>= RunningConvergenceMeasurement.array
 let directValues ← direct.mapM fun row=>field row "KIE_external_inscription"
 let replicates ← vector.mapM fun row=>field row "replicate_ordinal"
 let temperaturesInRows ← vector.mapM fun row=>field row "temperature_C_external_inscription"
 pure ⟨rows.length,census,[
 ("complete_source_class_census_matches",censusMatch),
 ("two_distinct_held_isotope_identities_share_same_complete_path",!DihedralTorsion.equalLabel normal.numeratorIsotopologue normal.denominatorIsotopologue && normal.completeReactionPath.length==4),
 ("exact_positive_ordered_rate_quotient_reconstructed",(@decide (normal.exactRateRatio.num=3) (Int.decEq _ _)) && normal.exactRateRatio.den==2 && (@decide (inverse.exactRateRatio.num=2) (Int.decEq _ _)) && inverse.exactRateRatio.den==3 && (@decide (equal.exactRateRatio.num=1) (Int.decEq _ _)) && equal.exactRateRatio.den==1),
 ("normal_inverse_and_equal_orientations_remain_held",Text.equal normal.ratioOrientation.label "numerator-rate-greater" && Text.equal inverse.ratioOrientation.label "denominator-rate-greater" && Text.equal equal.ratioOrientation.label "rates-exactly-equal"),
 ("complete_47_pdf_pages_retained",(classes.filter (fun k=>["complete-article-pdf-page","complete-supplementary-information-page","complete-reporting-summary-page"].any (Text.equal k))).length==47),
 ("all_23_source_data_worksheets_retained",(classes.filter (Text.equal "complete-source-data-worksheet")).length==23 && shapes.length==23),
 ("complete_923260_nonempty_cell_surface_retained",sameValue (get primary "complete_source_data_nonempty_cell_count") (.integer 923260)),
 ("complete_39002_source_rows_with_values_retained",sameValue (get primary "complete_source_data_row_with_value_count") (.integer 39002)),
 ("complete_90_rate_ratio_vector_retained",vector.length==90 && sameValue (get primary "complete_explicit_rate_ratio_vector_count") (.integer 90)),
 ("complete_three_direct_decay_KIE_vector_retained",direct.length==3 && sameValue (.array directValues) (.array (["2.11","0.827","0.55"].map Value.text))),
 ("normal_inverse_and_near_unity_external_inscriptions_all_retained",ratios.any (fun q=>q.num > Int.ofNat q.den) && ratios.any (fun q=>q.num < Int.ofNat q.den) && ratios.any (fun q=>9 * Int.ofNat q.den ≤ 10*q.num && 10*q.num ≤ 11*Int.ofNat q.den)),
 ("all_three_independent_experiments_and_replicates_retained_without_averaging",sameValue (get primary "three_independent_experiments_retained_without_averaging") (.boolean true) && replicates.all (fun v=>[1,2,3].any (fun n=>sameValue v (.integer n))) && [1,2,3].all (fun n=>replicates.any (fun v=>sameValue v (.integer n)))),
 ("complete_five_temperature_vector_retained",sameValue (.array temperatures) (.array (["3","6","9","12","15"].map Value.text)) && temperatures.all (fun t=>(temperaturesInRows.filter (sameValue t)).length==18)),
 ("source_direct_KIE_range_and_water_splitting_boundaries_retained",sameValue (get primary "source_reported_temperature_series_boundary_external_inscriptions") (.object [("inverse_CO_KSIE_range",.array [.text "0.2",.text "0.9"]),("temperatures_C",.array (["3","6","9","12","15"].map Value.text)),("water_splitting_KSIE_at_15_C",.text "2.8")])),
 ("source_models_remain_postseal_provenance_only",sameValue (get primary "source_interpretive_transition_state_zero_point_Hooke_quantum_calculation_and_fit_models_retained_as_postseal_provenance_only") (.boolean true)),
 ("infrared_limitation_reviewer_challenges_and_controls_retained",sameValue (get primary "reporting_summary_admits_in_situ_infrared_is_not_standalone_evidence") (.boolean true) && sameValue (get primary "reporting_summary_retains_reviewer_challenges_and_control_requests") (.boolean true)),
 ("source_values_and_external_zero_decimal_continuum_inscriptions_are_not_proof",sameValue (get primary "source_reported_rate_ratio_decay_production_temperature_uncertainty_replicate_and_condition_values_used_as_fold_proof_parameters") (.boolean false) && sameValue (get primary "external_zero_negative_decimal_and_continuum_inscriptions_preserved_only_as_source_provenance") (.boolean true)),
 ("no_imported_KIE_mass_frequency_transition_state_continuum_fit_selection_or_target_correction",sameValue (get primary "imported_KIE_equation_mass_frequency_law_transition_state_continuum_fitted_exponent_statistical_weight_selection_average_interpolation_or_target_correction_used_in_law") (.boolean false) && sameValue (get primary "native_numerical_zero_negative_irrational_imaginary_signed_or_continuum_proof_value_used") (.boolean false))]⟩
end SFT.Chemistry.KineticIsotopeEffectAnalysis
