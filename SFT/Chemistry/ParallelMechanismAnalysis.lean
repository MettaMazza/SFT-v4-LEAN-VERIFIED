import SFT.Chemistry.ParallelMechanism
import SFT.Chemistry.SequentialMechanismAnalysis
namespace SFT.Chemistry.ParallelMechanismAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics InternalEnergyCompositionExperiment
open SequentialMechanism ParallelMechanism
abbrev sourceInteger := TemperatureCorrespondenceSource.integer
def observedState (label : String) (occurrence : Nat) (status : String) : Except String RetainedMechanismState := do
 let identity ← CapabilityValues.heldLabel "registered-mechanism-state" label
 let occurrence ← CapabilityValues.count occurrence
 let status ← CapabilityValues.heldLabel "held-observation-status" status
 makeState (.held identity) (.count occurrence) (.held ⟨"held-state-condition","same-reaction-held-buffer-composition-and-method",rfl,rfl⟩) (.held status)
def observedPath (row : Value) : Except String RetainedParallelPath := do
 let status ← field row "path_status" >>= identityString
 let labels ← field row "ordered_state_word" >>= RunningConvergenceMeasurement.array
 let states ← labels.zipIdx.mapM fun (label,i)=>do observedState (← identityString label) (i+1) status
 let pathName ← field row "path_identity" >>= identityString
 let transitions ← (states.zip (states.drop 1)).zipIdx.mapM fun ((a,b),i)=>do
  let identity ← CapabilityValues.heldLabel "registered-elementary-transition" (Text.intercalate "" [pathName,"-edge-",toString (i+1)])
  let occurrence ← CapabilityValues.count (i+1)
  let status ← CapabilityValues.heldLabel "held-transition-status" status
  makeTransition (.held identity) (.count occurrence) (.held a.stateIdentity) (.held b.stateIdentity)
   (.held ⟨"held-transition-condition","same-reaction-held-buffer-composition-and-method",rfl,rfl⟩) (.held status)
 let sequential ← makeMechanism (.held ⟨"registered-reaction","doi-10.1038-s41467-026-70199-4-Ac-CY-network",rfl,rfl⟩) (states.map StateInput.state) (transitions.map TransitionInput.transition)
 let identity ← CapabilityValues.heldLabel "registered-parallel-path" pathName
 let ordinal ← field row "path_row" >>= sourceInteger
 let ordinal ← match ordinal with | .ofNat n=>CapabilityValues.count n | .negSucc _=>throw "an SFT count must be a positive counted value"
 let status ← CapabilityValues.heldLabel "held-path-status" status
 ParallelMechanism.makePath (.held identity) (.count ordinal) (.mechanism sequential) (.held status)
def className (name : String) : String :=
 if (Text.chars "structural-EmptyOne").isPrefixOf (Text.chars name) then "EmptyOne"
 else if Text.equal name "external-zero-glyph-observed-absence" then "external_zero"
 else if Text.equal name "exact-positive-observed-magnitude" then "positive"
 else if Text.equal name "external-signed-directional-inscription" then "signed"
 else if Text.equal name "source-reported-derived-formula-not-used-as-proof-parameter" then "formula"
 else "label"
def classKeys : List String := ["EmptyOne","external_zero","positive","signed","formula","label"]
structure SheetObservation where
 count : Int
 dimensionsMatch : Bool
 classes : List String
def observeSheet (row : InternalEnergyCompositionSource.Target) : Except String SheetObservation := do
 let target := get row.row "target_payload"
 let count ← field target "complete_rectangular_cell_count" >>= sourceInteger
 let height ← field row.row "declared_max_row" >>= sourceInteger
 let width ← field row.row "declared_max_column" >>= sourceInteger
 let cells ← field target "complete_rectangular_cells" >>= RunningConvergenceMeasurement.array
 let coordinates ← cells.mapM fun cell=>field cell "cell_coordinate" >>= identityString
 if (coordinates.foldl (fun found c=>if found.any (Text.equal c) then found else c::found) []).length != coordinates.length then throw "KIN-008 duplicated a registered worksheet cell"
 let classes ← cells.mapM fun cell=>do
  let valueClass ← field cell "source_value_class" >>= identityString
  pure (className valueClass)
 pure ⟨count,@decide (count=height*width) (Int.decEq _ _) && @decide (count=.ofNat cells.length) (Int.decEq _ _),classes⟩
structure Analysis where
 count : Nat
 cellCount : Int
 classCounts : List (String×Nat)
 pathCount : Nat
 worksheetCount : Value
 primaryObservationCount : Value
 primaryFormulaCount : Value
 checks : List (String×Bool)
def exactParallelMechanismAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 if rows.length != 28 then throw "KIN-008 requires the complete twenty-eight-sheet vector"
 if !(rows.zipIdx.all fun (row,i)=>sameValue (get row.row "source_sheet_ordinal") (.integer (i+1))) then throw "KIN-008 complete worksheet order changed"
 let pathRows ← RunningConvergenceMeasurement.array (if hasKey primary "complete_parallel_path_family" then get primary "complete_parallel_path_family" else .array [])
 if pathRows.length != 3 then throw "KIN-008 complete parallel path family changed"
 let paths ← pathRows.mapM observedPath
 let complete ← makeParallel (.held ⟨"registered-reaction","doi-10.1038-s41467-026-70199-4-Ac-CY-network",rfl,rfl⟩) (.held ⟨"registered-mechanism-state","1-EP",rfl,rfl⟩) (paths.map PathInput.path)
 let composition ← forcedParallelMechanismComposition (.mechanism complete)
 let sheets ← rows.mapM observeSheet
 let cellCount := sheets.foldl (fun n row=>n+row.count) (0:Int)
 let classes := sheets.flatMap SheetObservation.classes
 let census := classKeys.map fun key=>(key,(classes.filter (Text.equal key)).length)
 let expected : List (String×Nat) := [("EmptyOne",8968),("external_zero",2109),("positive",6060),("signed",0),("formula",722),("label",299)]
 let products := paths.flatMap fun p=>p.mechanism.orderedStates.map (fun s=>s.stateIdentity.label)
 let supplement ← field primary "supplementary_figure_32_complete_vector"
 let supplementProducts ← field supplement "product_identity_word" >>= RunningConvergenceMeasurement.array
 let supplementProducts ← supplementProducts.mapM identityString
 let productEquality := products.all (fun p=>supplementProducts.any (Text.equal p)) && supplementProducts.all (fun p=>products.any (Text.equal p))
 let number := fun (key : String)=>(classes.filter (Text.equal key)).length
 pure ⟨rows.length,cellCount,census,composition.pathCount.value,get primary "complete_source_data_worksheet_count",get primary "complete_primary_parallel_product_time_observation_count",get primary "complete_primary_source_formula_count",[
  ("three_complete_paths_retained",composition.orderedPaths.length==3),
  ("every_path_meets_common_initial_state",composition.orderedPaths.all fun p=>match p.mechanism.orderedStates.head? with | some s=>DihedralTorsion.equalLabel s.stateIdentity composition.commonInitialStateIdentity | none=>false),
  ("every_path_retains_common_terminal_occurrence",composition.terminalStateWord.all fun s=>Text.equal s.label "2"),
  ("all_seven_product_identities_covered_without_selection",productEquality),
  ("every_path_state_edge_intermediate_and_status_retained",(composition.orderedPaths.zip pathRows).all fun (p,row)=>p.mechanism.orderedTransitions.length==p.mechanism.orderedStates.length-1 && sameValue (.text p.pathStatus.label) (get row "path_status")),
  ("all_twenty_eight_worksheets_and_cells_retained",sheets.all SheetObservation.dimensionsMatch && @decide (cellCount=18158) (Int.decEq _ _)),
  ("all_external_cell_classes_retained_exactly",(census.zip expected).all fun (actual,expected)=>actual.2==expected.2),
  ("all_source_zero_glyphs_remain_external_observed_absence",number "external_zero"==2109),
  ("no_signed_source_measurement_cell_present",number "signed"==0),
  ("all_source_formulas_retained_but_excluded_from_proof",number "formula"==722 && sameValue (get primary "source_formulas_retained_as_provenance_and_never_used_as_fold_proof_parameters") (.boolean true)),
  ("unresolved_two-structure_peak_retained_without_selection",sameValue (get (get primary "unresolved_source_disclosure") "assignment_status") (.text "two possible structures retained; no preferred structure selected")),
  ("complete_article_supplement_peer_review_workbook_and_source_inventory_retained",sameValue (get primary "complete_source_file_count") (.integer 5) && sameValue (get primary "article_page_count") (.integer 11) && sameValue (get primary "supplementary_information_page_count") (.integer 54)),
  ("no_imported_parallel_equation_stochastic_fit_selection_average_interpolation_or_target_correction",sameValue (get primary "imported_parallel_reaction_equation_stochastic_premise_fitted_path_weight_steady_state_selection_average_interpolation_or_target_correction_used_in_law") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.ParallelMechanismAnalysis
