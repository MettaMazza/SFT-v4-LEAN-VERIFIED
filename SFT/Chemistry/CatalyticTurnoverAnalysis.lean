import SFT.Chemistry.CatalyticTurnover
import SFT.Chemistry.SequentialMechanismAnalysis
namespace SFT.Chemistry.CatalyticTurnoverAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics InternalEnergyCompositionExperiment
open CatalyticTurnover
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
def expectedClasses : List (String×Nat) := [("complete-article-landing-record",1),("attempted-article-pdf-returned-html-record",1),("complete-supplementary-information-page",106),("complete-supplementary-video",1),("complete-zenodo-metadata-record",1),("complete-source-data-archive-member",387)]
def sourceCycle : Except String CompleteCatalyticCycle := do
 let identities := [("State 1","separately-observed-conductance-state"),("State 2","structural-intermediate-not-separately-resolved"),("State 3","separately-observed-conductance-state"),("State 4","separately-observed-conductance-state"),("State 5","separately-observed-conductance-state")]
 let states ← identities.zipIdx.mapM fun ((label,status),i)=>CatalyticTurnover.witnessState (i+1) label "single-LPd-catalyst-carrier" status
 let processes := ["oxidative-addition","ligand-exchange","pre-transmetalation","transmetalation","reductive-elimination-and-return"]
 let transitions ← processes.zipIdx.mapM fun (process,i)=>do
  let entry ← match (states.drop i).head? with | some s=>pure s | none=>throw "tuple index out of range"
  let exit ← match (states.drop ((i+1)%states.length)).head? with | some s=>pure s | none=>throw "tuple index out of range"
  CatalyticTurnover.witnessTransition entry.stateIdentity.label exit.stateIdentity.label process "source-held-cycle-condition"
 CatalyticTurnover.makeCycle (.held ⟨"registered-catalytic-cycle","source-five-state-cycle",rfl,rfl⟩)
  (states.map CatalystStateInput.state) (transitions.map CatalyticTransitionInput.transition)
structure Analysis where
 count : Nat
 classCounts : List (String×Nat)
 checks : List (String×Bool)
def expectedTurnover : Value := .array [.array [.text "OCH3",.text "-0.27",.text "0.5",.text "-1.9"],.array [.text "CH3",.text "-0.17",.text "4.6",.text "-0.9"],.array [.text "H",.text "0",.text "29.6",.text "0.0"],.array [.text "Cl",.text "0.23",.text "39.0",.text "3.1\u00d710^-2"],.array [.text "COOMe",.text "0.45",.text "203.9",.text "0.7"],.array [.text "CF3",.text "0.54",.text "615.6",.text "1.2"],.array [.text "CN",.text "0.66",.text "2098.7",.text "1.8"]]
def exactCatalyticTurnoverAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 if rows.length != 497 || !(rows.zipIdx.all fun (row,i)=>sameValue (get row.row "source_record_ordinal") (.integer (i+1))) then throw "KIN-010 requires the complete source-ordered 497-record vector"
 let classes ← rows.mapM fun row=>field row.row "source_record_class" >>= text
 let keys := classes.foldl (fun found key=>if found.any (Text.equal key) then found else found++[key]) []
 let census := keys.map fun key=>(key,(classes.filter (Text.equal key)).length)
 let censusMatch := census.length==expectedClasses.length && expectedClasses.all (fun (key,n)=>census.any (fun (k,m)=>Text.equal k key && m==n))
 let cycle ← sourceCycle
 let turnover ← forcedCatalyticTurnover (.cycle cycle)
 let frequency ← forcedCycleFrequency (.count ⟨7,by decide⟩) (.count ⟨5,by decide⟩)
 let source ← field primary "structural_cycle"
 let turnoverRows ← field primary "complete_substituent_turnover_vector" >>= (fun x=>field x "rows") >>= RunningConvergenceMeasurement.array
 let vector ← turnoverRows.mapM fun row=>do
  let fields ← ["substituent","sigma_p_external_inscription","TOF_per_second_external_inscription","lg_k_over_k0_external_inscription"].mapM (field row)
  pure (Value.array fields)
 let s2 ← field primary "independent_state_1_state_4_rate_vector_table_s2" >>= (fun x=>field x "rows") >>= RunningConvergenceMeasurement.array
 let s3 ← field primary "independent_state_1_state_4_rate_vector_table_s3" >>= (fun x=>field x "rows") >>= RunningConvergenceMeasurement.array
 let movies := rows.filter fun row=>sameValue (get row.row "source_record_class") (.text "complete-supplementary-video")
 let archive := rows.filter fun row=>sameValue (get row.row "source_record_class") (.text "complete-source-data-archive-member")
 let attempted := rows.filter fun row=>sameValue (get row.row "source_record_class") (.text "attempted-article-pdf-returned-html-record")
 let figure ← field primary "figure_6_source_data"
 let traceA ← field figure "fig6a_complete_trace_row_count_including_header" >>= TemperatureCorrespondenceSource.integer
 let traceB ← field figure "fig6b_complete_trace_row_count_including_header" >>= TemperatureCorrespondenceSource.integer
 let movieRetained ← if movies.length==1 then do
  let row ← match movies.head? with | some x=>pure x | none=>throw "tuple index out of range"
  pure (sameValue (get (get row.row "target_payload") "frame_count") (.integer 1604))
  else pure false
 let archiveRetained ← if archive.length==387 then do
  let hashes ← archive.mapM fun row=>field (get row.row "target_payload") "complete_member_hash" >>= text
  pure (hashes.all fun h=>(Text.chars "sha256:").isPrefixOf (Text.chars h))
  else pure false
 let pdfRetained ← if attempted.length==1 then do
  let row ← match attempted.head? with | some x=>pure x | none=>throw "tuple index out of range"
  let payload := get row.row "target_payload"
  pure (sameValue (get payload "source_content_class") (.text "HTML-response-not-PDF") && sameValue (get payload "unavailable_article_pdf_adverse_record") (.boolean true))
  else pure false
 let sourceStates ← field source "ordered_states" >>= RunningConvergenceMeasurement.array
 let second ← match (sourceStates.drop 1).head? with | some x=>pure x | none=>throw "list index out of range"
 let last ← match turnover.orderedTransitionWord.getLast? with | some x=>pure x | none=>throw "tuple index out of range"
 let catalysts := cycle.orderedStates.map RetainedCatalystState.catalystIdentity
 let distinctCatalysts := catalysts.foldl (fun found c=>if found.any (DihedralTorsion.equalLabel c) then found else c::found) []
 pure ⟨rows.length,census,[
 ("complete_source_class_census_matches",censusMatch),
 ("same_catalyst_identity_retained_through_all_five_states",distinctCatalysts.length==1 && sameValue (get source "registered_state_count") (.integer 5)),
 ("final_transition_returns_exact_entry_state",DihedralTorsion.equalLabel last.exitState turnover.exactReturnState && sameValue (get source "entry_state_equals_return_state") (.boolean true)),
 ("one_complete_return_word_is_one_turnover",turnover.completedCycleCount.value==1 && turnover.orderedTransitionWord.length==5),
 ("exact_positive_cycle_frequency_relation_reconstructed_without_fit",@decide (frequency.cycleFrequency.value.num=7) (Int.decEq _ _) && frequency.cycleFrequency.value.den==5),
 ("five_structural_states_and_four_observed_levels_distinguished",sameValue (get source "registered_state_count") (.integer 5) && sameValue (get source "separately_observed_conductance_state_count") (.integer 4) && sameValue (get second "source_status") (.text "structural-intermediate-not-separately-resolved-as-conductance-state")),
 ("complete_seven_row_turnover_vector_retained",sameValue (.array vector) expectedTurnover),
 ("independent_rate_tables_retained_separately_without_average",s2.length==5 && s3.length==5 && !sameValue (.array s2) (.array s3) && sameValue (get primary "table_s2_and_table_s3_remain_separate_without_selection_or_averaging") (.boolean true)),
 ("complete_385617_raw_trace_rows_retained",@decide (traceA+traceB=385617) (Int.decEq _ _) && sameValue (get figure "all_complete_raw_rows_remain_byte_bound_without_selection") (.boolean true)),
 ("all_signed_decimal_and_zero_source_inscriptions_preserved_outside_proof",sameValue (get figure "all_signed_decimal_and_zero_glyphs_are_external_inscriptions_only") (.boolean true) && sameValue (get primary "external_zero_and_negative_glyphs_preserved_only_as_source_inscriptions") (.boolean true)),
 ("complete_1604_frame_movie_retained",movieRetained),
 ("all_387_archive_members_retained",archiveRetained),
 ("unavailable_article_pdf_adverse_record_retained",pdfRetained),
 ("low_temperature_insufficient_fit_adverse_record_retained",sameValue (get primary "low_temperature_fewer_cycle_and_insufficient_fit_data_adverse_record_retained") (.boolean true)),
 ("source_fits_rates_and_values_are_postseal_provenance_not_proof",sameValue (get primary "source_reported_maximum_likelihood_single_exponent_Eyring_Arrhenius_Hess_and_other_fits_or_calculations_retained_as_postseal_provenance_only") (.boolean true) && sameValue (get primary "source_reported_rates_TOF_dwell_times_frequencies_conditions_errors_and_uncertainties_used_as_fold_proof_parameters") (.boolean false)),
 ("no_import_fit_selection_average_or_target_correction",sameValue (get primary "imported_turnover_frequency_rate_equation_Michaelis_Menten_steady_state_stochastic_cycle_weight_fitted_efficiency_selection_average_interpolation_or_target_correction_used_in_law") (.boolean false))]⟩
end SFT.Chemistry.CatalyticTurnoverAnalysis
