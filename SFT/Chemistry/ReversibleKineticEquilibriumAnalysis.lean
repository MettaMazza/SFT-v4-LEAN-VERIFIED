import SFT.Chemistry.ReversibleKineticEquilibrium
import SFT.Chemistry.SequentialMechanismAnalysis
import SFT.Chemistry.ElectronSpinHtml
namespace SFT.Chemistry.ReversibleKineticEquilibriumAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics InternalEnergyCompositionExperiment
open ReversibleKineticEquilibrium
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
def expectedClasses : List (String×Nat) := [("complete-primary-article-page",10),("complete-supplementary-information-page",144),("complete-additional-file-description-page",1),("complete-supplementary-movie",1),("complete-source-data-archive-member",8)]
def requiredFragments : List (Nat×List String) := [(81,["83% 2-E-II and 17% 2-E-I", "32% 2-E-II and 68% 2-E-I", "88 hours"]),(82,["2-E-II to 2-E-I", "slope m = 0.001007", "25.6 kcal/mol"]),(83,["98% 2-E-I and 2% 2-E-II", "71% 2-E-I and 29% 2-E-II", "82 hours"]),(84,["2-E-I to 2-E-II", "slope m = 0. 000691", "25.9 kcal mol"]),(85,["58% 2-E-I and 42% 2-Z-I", "84% 2-E-I and 16% 2-Z-I", "71 hours"]),(86,["2-E-I to 2-Z-I", "slope m = 0. 003854", "21.8 kcal mol"]),(87,["61% 2-E-II and 39% 2-Z-II", "80% 2-E-II and 20% 2-Z-II", "71 hours"]),(88,["2-E-II to 2-Z-II", "slope m = 0. 005570", "21.6 kcal mol"]),(89,["Supplementary Table 1", "2-E-II 25.9", "Supplementary Table 2", "2-Z-II 1.4"])]
def observedTransition (label entry exit orientation : String) : Except String RetainedDirectedTransition := do
 makeDirectedTransition (.held (← CapabilityValues.heldLabel "registered-reversible-transition" label))
  (.held (← CapabilityValues.heldLabel "registered-reversible-state" entry))
  (.held (← CapabilityValues.heldLabel "registered-reversible-state" exit))
  (.held (← CapabilityValues.heldLabel "held-transition-orientation" orientation))
  (.held ⟨"held-reversible-condition","80-degree-Celsius-in-(CDCl2)2",rfl,rfl⟩)
  (.held ⟨"held-reversible-status","measured",rfl,rfl⟩)
def observedGraph : Except String CompleteReversiblePairGraph := do
 makeGraph (.held ⟨"registered-reversible-pair","2-E-I--2-E-II",rfl,rfl⟩)
  (.held ⟨"registered-reversible-state","2-E-II",rfl,rfl⟩) (.held ⟨"registered-reversible-state","2-E-I",rfl,rfl⟩)
  (← observedTransition "2-E-II-to-2-E-I" "2-E-II" "2-E-I" "first-to-second")
  (← observedTransition "2-E-I-to-2-E-II" "2-E-I" "2-E-II" "second-to-first")
structure Analysis where
 count : Nat
 classCounts : List (String×Nat)
 checks : List (String×Bool)
def arrayLength (v : Value) : Nat := match v with
 | .array xs=>xs.length
 | .object xs=>xs.length
 | .text s=>(Text.chars s).length
 | .null=>0
 | .boolean _=>0
 | .integer _=>0
def sourceTruthy (v : Value) : Bool := match v with
 | .null=>false
 | .boolean b=>b
 | .integer i=> !(@decide (i=0) (Int.decEq _ _))
 | .text s=> !(Text.chars s).isEmpty
 | .array xs=> !xs.isEmpty
 | .object xs=> !xs.isEmpty
def sourceValueAt (xs : List Value) (n : Nat) : Except String Value := match (xs.drop n).head? with
 | some x=>pure x
 | none=>throw "list index out of range"
def exactReversibleKineticEquilibriumAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 if rows.length != 164 || !(rows.zipIdx.all fun (row,i)=>sameValue (get row.row "source_record_ordinal") (.integer (i+1))) then
  throw "KIN-009 requires the complete source-ordered 164-record vector"
 let classes ← rows.mapM fun row=>field row.row "source_record_class" >>= text
 let keys := classes.foldl (fun found key=>if found.any (Text.equal key) then found else found++[key]) []
 let census := keys.map fun key=>(key,(classes.filter (Text.equal key)).length)
 let censusMatch := census.length==expectedClasses.length && expectedClasses.all (fun (key,n)=>census.any (fun (k,m)=>Text.equal k key && m==n))
 let pages ← (rows.filter fun row=>hasKey (get row.row "target_payload") "complete_extracted_page_text").mapM fun row=>do
  let doc ← field row.row "source_document_identity" >>= text
  let ordinal ← field row.row "source_page_ordinal"
  let content ← field (get row.row "target_payload") "complete_extracted_page_text" >>= text
  pure (doc,ordinal,ElectronSpinHtml.normalizeSpace content)
 let fragments ← requiredFragments.mapM fun (page,fragments)=>do
  let found := pages.reverse.find? fun (doc,ordinal,_)=>Text.equal doc "supplementary-information.pdf" && sameValue ordinal (.integer page)
  let content ← match found with
   | some (_,_,content)=>pure content
   | none=>throw (Text.intercalate "" ["('supplementary-information.pdf', ",toString page,")"])
  pure (fragments.all fun fragment=>Text.contains content fragment)
 let graph ← observedGraph
 let correspondence ← forcedReversibleKineticEquilibriumCorrespondence (.graph graph)
 let pair ← field primary "bidirectional_same_pair_record"
 let directional ← field pair "directional_records" >>= RunningConvergenceMeasurement.array
 let continuations ← field primary "continuation_reversible_pair_records" >>= RunningConvergenceMeasurement.array
 let forward ← sourceValueAt directional 0
 let reverse ← sourceValueAt directional 1
 let observedDirections ← continuations.mapM fun row=>field row "observed_direction_identity" >>= text
 let directionStatuses ← continuations.mapM fun row=>field row "direction_label_disagreement_retained"
 let movies := rows.filter fun row=>sameValue (get row.row "source_record_class") (.text "complete-supplementary-movie")
 let archive := rows.filter fun row=>sameValue (get row.row "source_record_class") (.text "complete-source-data-archive-member")
 let movieRetained ← if movies.length==1 then do
  let movie ← match movies.head? with | some m=>pure m | none=>throw "tuple index out of range"
  let payload := get movie.row "target_payload"
  pure (sameValue (← field payload "frame_count") (.integer 73) && sameValue (← field payload "complete_movie_hash") (.text "sha256:f4462d9274601b7991848b765c6b0f126253690926b5f5d60fa22a30aa3ae2d9"))
  else pure false
 let archiveRetained ← if archive.length==8 then do
  let hashes ← archive.mapM fun row=>field (get row.row "target_payload") "complete_member_hash" >>= text
  pure (hashes.all fun h=>(Text.chars "sha256:").isPrefixOf (Text.chars h))
  else pure false
 let activations ← field primary "supplementary_table_1_activation_energy_vector"
 let energies ← field primary "supplementary_table_2_relative_energy_vector" >>= RunningConvergenceMeasurement.array
 let reference ← sourceValueAt energies 0
 pure ⟨rows.length,census,[
 ("complete_source_class_census_matches",censusMatch),
 ("same_exact_pair_graph_supplies_both_directions",DihedralTorsion.equalLabel correspondence.recurrenceSupport.1 graph.firstState && DihedralTorsion.equalLabel correspondence.recurrenceSupport.2 graph.secondState && correspondence.graphEdgeCount.value==2),
 ("exact_forward_direction_retained",sameValue (get forward "initial_support") (.object [("2-E-II",.text "83/100"),("2-E-I",.text "17/100")]) && sameValue (get forward "terminal_equilibrium_support") (.object [("2-E-II",.text "8/25"),("2-E-I",.text "17/25")])),
 ("exact_reverse_direction_retained",sameValue (get reverse "initial_support") (.object [("2-E-I",.text "49/50"),("2-E-II",.text "1/50")]) && sameValue (get reverse "terminal_equilibrium_support") (.object [("2-E-I",.text "71/100"),("2-E-II",.text "29/100")])),
 ("forward_reverse_terminal_disagreement_retained_without_average",sameValue (get pair "equilibrium_disagreement_retained_not_averaged") (.text "68/32 and 71/29 terminal compositions remain separate source observations")),
 ("continuation_pair_records_retained",continuations.length==2 && observedDirections.all (fun d=>Text.equal d "2-Z-I-to-2-E-I" || Text.equal d "2-Z-II-to-2-E-II") && observedDirections.any (Text.equal "2-Z-I-to-2-E-I") && observedDirections.any (Text.equal "2-Z-II-to-2-E-II")),
 ("source_direction_label_disagreements_retained",directionStatuses.all sourceTruthy && sameValue (get primary "source_direction_label_disagreements_preserved_without_selection") (.boolean true)),
 ("all_four_directional_experiments_and_terminal_compositions_retained",sameValue (get primary "complete_directional_experiment_count") (.integer 4) && sameValue (get primary "complete_terminal_equilibrium_composition_count") (.integer 4)),
 ("all_nine_decisive_supplement_pages_reproduced",fragments.all id),
 ("complete_movie_retained",movieRetained),
 ("all_archive_members_retained",archiveRetained),
 ("activation_and_relative_energy_vectors_retained",arrayLength activations==4 && energies.length==4),
 ("external_zero_reference_is_structural_empty_one_only",sameValue (get reference "external_energy_inscription") (.text "0") && sameValue (get reference "sft_interpretation") (.text "structural-EmptyOne-reference-separation")),
 ("source_fits_and_values_are_postseal_provenance_not_proof",sameValue (get primary "source_reported_equations_fits_slopes_energies_corrections_and_calculations_retained_as_postseal_provenance") (.boolean true) && sameValue (get primary "source_fit_slope_or_energy_used_as_fold_proof_parameter") (.boolean false)),
 ("no_import_fit_selection_average_or_target_correction",sameValue (get primary "imported_reversible_rate_equation_equilibrium_law_or_constant_stochastic_premise_fitted_direction_weight_steady_state_selection_refit_average_interpolation_renormalization_or_target_correction_used_in_law") (.boolean false))]⟩
end SFT.Chemistry.ReversibleKineticEquilibriumAnalysis
