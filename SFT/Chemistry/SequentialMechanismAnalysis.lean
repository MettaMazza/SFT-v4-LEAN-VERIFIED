import SFT.Chemistry.SequentialMechanism
import SFT.Chemistry.CompetingChannelAnalysis
namespace SFT.Chemistry.SequentialMechanismAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open SequentialMechanism
abbrev fractionText := InternalEnergyCompositionSource.fractionText
def sourceFraction (value : Value) : Except String Rat :=
 match value with
 | .text _ => ActivationBarrierAnalysis.sourceFraction value
 | .integer n => .ok (normalize n 1 (by decide))
 | .boolean b => .ok (normalize (if b then 1 else 0) 1 (by decide))
 | .null | .array _ | .object _ => .error "argument should be a string or a Rational instance"
abbrev sameFraction := CompetingChannelAnalysis.sameFraction
def observedState (row : InternalEnergyCompositionSource.Target) (ordinal : Nat) : Except String RetainedMechanismState := do
 let target := get row.row "target_payload"
 let pdb ← field target "pdb_identity" >>= identityString
 let observed ← field target "experimentally_retained_state_identity" >>= identityString
 let identity ← CapabilityValues.heldLabel "registered-mechanism-state" (Text.intercalate "" [pdb,":",observed])
 let occurrence ← CapabilityValues.count ordinal
 let condition ← field target "source_condition_external_inscription" >>= identityString >>= CapabilityValues.heldLabel "held-state-condition"
 let status ← field target "source_status" >>= identityString >>= CapabilityValues.heldLabel "held-observation-status"
 makeState (.held identity) (.count occurrence) (.held condition) (.held status)
def expectedClasses : List (String×Nat) := [("deposited-structure-snapshot",5),("late-structure-observation",2),("complete-power-titration-column",7),("negative-delay-control",1),("interleaved-dark-adverse-control",1),("unresolved-multiple-intermediate-disclosure",1)]
def expectedPdb : List String := ["8WZF","8WZG","8WZR","8WZT","8WZV"]
def atomCounts (carbon : Nat) : Value := .object [("C",.integer carbon),("O",.integer carbon),("MN",.integer 1)]
def expectedCounts : List Value := [atomCounts 3,atomCounts 2,atomCounts 2,atomCounts 2,atomCounts 1]
def expectedOccupancies : List Rat := [normalize 1 1 (by decide),normalize 9 10 (by decide),normalize 9 10 (by decide),normalize 17 20 (by decide),normalize 13 20 (by decide)]
def structureObservation (row : InternalEnergyCompositionSource.Target) (pdb : String) (counts : Value) (occupancy : Rat) : Except String (Value×Rat) := do
 let target := get row.row "target_payload"
 let foundCounts := get target "XTX_component_exact_atom_counts"
 let foundOccupancy ← sourceFraction (get target "XTX_component_exact_occupancy")
 let resolution ← sourceFraction (get target "resolution_angstrom_exact_fraction")
 if !sameValue (get target "pdb_identity") (.text pdb) || !sameValue foundCounts counts ||
  !sameFraction foundOccupancy occupancy || !sameFraction resolution (normalize 8 5 (by decide)) ||
  !sameValue (get target "source_status") (.text "experimentally deposited atomic model and map-coefficient identity") then
  throw "KIN-007 deposited structural vector changed"
 pure (foundCounts,foundOccupancy)
structure PowerObservation where
 sigmas : List Rat
 densities : List Rat
 absences : Nat
def powerObservation (row : InternalEnergyCompositionSource.Target) (ordinal : Nat) : Except String PowerObservation := do
 let target := get row.row "target_payload"
 if !sameValue (get target "power_table_column") (.integer ordinal) then throw "KIN-007 power-titration column changed"
 let positives ← ["delay_second_exact_fraction","power_joule_exact_fraction","scale_exact_positive_fraction"].mapM fun k=>sourceFraction (get target k)
 if !(positives.all fun r=>@decide (0<r.num) (Int.decLt _ _)) then throw "KIN-007 power-titration column changed"
 let features ← match get target "measured_difference_density_features" with
  | .object fields=>pure fields
  | .null | .boolean _ | .integer _ | .text _ | .array _=>throw "KIN-007 power-titration column changed"
 let names := features.map Prod.fst
 if names.length != 4 || !(["Mn","COax","COeq1","COeq2"].all fun k=>names.any (Text.equal k)) then throw "KIN-007 power-titration column changed"
 let decoded ← features.mapM fun (_,feature)=>do
  if sameValue (get feature "exact_positive_magnitude_present") (.boolean false) then
   if !sameValue (get feature "external_inscription") (.text "0") || !sameValue (get feature "sft_interpretation") (.text "structural-EmptyOne-observed-absence") then
    throw "KIN-007 external absence glyph changed"
   pure (none : Option (Rat×Rat))
  else if sameValue (get feature "exact_positive_magnitude_present") (.boolean true) then
   let sigma ← field feature "sigma_exact_positive_fraction" >>= sourceFraction
   let density ← field feature "electron_density_exact_positive_fraction" >>= sourceFraction
   if !(@decide (0<sigma.num) (Int.decLt _ _)) || !(@decide (0<density.num) (Int.decLt _ _)) ||
    !sameValue (get feature "orientation") (.text "held-negative-difference-density-direction-with-exact-positive-magnitude") then
    throw "KIN-007 exact measured density magnitude changed"
   pure (some (sigma,density))
  else throw "KIN-007 power feature status changed"
 pure ⟨decoded.filterMap (fun v=>v.map Prod.fst),decoded.filterMap (fun v=>v.map Prod.snd),(decoded.filter Option.isNone).length⟩
structure Analysis where
 count : Nat
 classCounts : List (String×Nat)
 supplementCount : Value
 pdfCount : Nat
 pdbCount : Value
 counts : List Value
 occupancies : List Rat
 sigmaBounds : Rat×Rat
 densityBounds : Rat×Rat
 absences : Nat
 checks : List (String×Bool)
def exactSequentialMechanismAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 if rows.length != 17 then throw "KIN-007 requires the complete seventeen-record vector"
 let classes := expectedClasses.map fun (name,_) => (name,(rows.filter fun row=>sameValue (get row.row "source_record_class") (.text name)).length)
 if !((classes.zip expectedClasses).all fun (actual,expected)=>actual.2==expected.2) then throw "KIN-007 complete target-class census changed"
 let structures := rows.take 5
 let observed ← (((structures.zip expectedPdb).zip expectedCounts).zip expectedOccupancies).mapM fun (((row,pdb),counts),occupancy)=>structureObservation row pdb counts occupancy
 let initialRow ← match structures.head? with | some row=>pure row | none=>throw "KIN-007 deposited structural vector changed"
 let firstRow ← match (structures.drop 1).head? with | some row=>pure row | none=>throw "KIN-007 deposited structural vector changed"
 let secondRow ← match (structures.drop 4).head? with | some row=>pure row | none=>throw "KIN-007 deposited structural vector changed"
 let initial ← observedState initialRow 1
 let first ← observedState firstRow 2
 let second ← observedState secondRow 3
 let reaction ← field initialRow.row "reaction_identity" >>= identityString >>= CapabilityValues.heldLabel "registered-reaction"
 let edge1 ← makeTransition (.held ⟨"registered-elementary-transition","COax-release-and-water-exchange",rfl,rfl⟩) (.count ⟨1,by decide⟩)
  (.held initial.stateIdentity) (.held first.stateIdentity) (.held ⟨"held-transition-condition","complete-darkness-to-first-photoexcited-record",rfl,rfl⟩) (.held ⟨"held-transition-status","experimentally-retained-first-CO-release",rfl,rfl⟩)
 let edge2 ← makeTransition (.held ⟨"registered-elementary-transition","COeq1-release-and-water-exchange",rfl,rfl⟩) (.count ⟨2,by decide⟩)
  (.held first.stateIdentity) (.held second.stateIdentity) (.held ⟨"held-transition-condition","held-time-and-dose-change-not-collapsed",rfl,rfl⟩) (.held ⟨"held-transition-status","experimentally-retained-second-CO-release",rfl,rfl⟩)
 let mechanism ← makeMechanism (.held reaction) [.state initial,.state first,.state second] [.transition edge1,.transition edge2]
 let composition ← forcedSequentialMechanismComposition (.mechanism mechanism)
 let late := (rows.drop 5).take 2
 if !(late.all fun row=>let target := get row.row "target_payload"
  sameValue (get target "assignment_status") (.text "unresolved-multiple-intermediate-mixture; no precise single atomic model") && sameValue (get target "pdb_deposit_status") (.text "structural-EmptyOne-no-deposited-model")) then throw "KIN-007 unresolved late-state boundary changed"
 let power := (rows.drop 7).take 7
 let observations ← power.zipIdx.mapM fun (row,i)=>powerObservation row (i+1)
 let sigmas := observations.flatMap PowerObservation.sigmas
 let densities := observations.flatMap PowerObservation.densities
 let absences := observations.foldl (fun n row=>n+row.absences) 0
 let sigmaBounds ← RealGasAnalysis.bounds sigmas
 let densityBounds ← RealGasAnalysis.bounds densities
 let controls := (rows.drop 14).take 3
 let favorable := match controls.head? with | some row=>get row.row "target_payload" | none=>Value.null
 let adverse := match (controls.drop 1).head? with | some row=>get row.row "target_payload" | none=>Value.null
 let unresolved := match (controls.drop 2).head? with | some row=>get row.row "target_payload" | none=>Value.null
 let contains := fun (record : Value) (key needle : String)=>match get record key with | .text s=>Text.contains s needle | .null | .boolean _ | .integer _ | .array _ | .object _=>false
 let retainedControls := sameValue (get favorable "observed_difference_density") (.text "structural-EmptyOne-no-difference-feature") && contains favorable "held_orientation" "reversed event order" && contains adverse "observed_adverse_result" "possible light contamination" && contains unresolved "assignment_boundary" "cannot be determined precisely"
 let listField := fun (key : String)=>RunningConvergenceMeasurement.array (if hasKey primary key then get primary key else .array [])
 let pdfs ← listField "supplement_pdf_records"
 let files ← listField "complete_supplementary_files"
 let pdbs ← listField "complete_pdb_records"
 let custody := get primary "cxidb_custody_record"
 let custodyLength := match custody with | .array xs=>xs.length | .object xs=>xs.length | .text s=>(Text.chars s).length | .null | .boolean _ | .integer _=>0
 let counts := observed.map Prod.fst
 let occupancy := observed.map Prod.snd
 pure ⟨rows.length,classes,get primary "complete_supplementary_file_count",pdfs.length,get primary "complete_pdb_deposit_count",counts,occupancy,sigmaBounds,densityBounds,absences,[
  ("three_distinct_experimental_states_force_two_boundary-matched_edges",composition.orderedStates.length==3 && composition.orderedTransitions.length==2 && (match composition.orderedTransitions with | [a,b]=>DihedralTorsion.equalLabel a.exitStateIdentity b.entryStateIdentity | [] | [_] | _::_::_::_=>false)),
  ("initial_first_intermediate_and_second_intermediate_retained_exactly",equalState composition.initialState initial && equalState composition.terminalState second && (match composition.intermediateStates with | [s]=>equalState s first | [] | _::_::_=>false)),
  ("all_three_repeat_observations_of_first_intermediate_retained",((counts.drop 1).take 3).length==3 && (((counts.drop 1).take 3).zip ((expectedCounts.drop 1).take 3)).all (fun (a,b)=>sameValue a b)),
  ("complete_five_deposited_structure_vector_retained",(structures.zip expectedPdb).all fun (row,pdb)=>sameValue (get row.row "pdb_identity") (.text pdb)),
  ("both_late_unresolved_records_retained_without_inference",late.length==2),
  ("all_seven_power_columns_and_four_features_retained",power.length==7 && sigmas.length+absences==28),
  ("favorable_adverse_and_unresolved_controls_retained",retainedControls),
  ("complete_article_thirteen_files_three_pdfs_five_PDB_and_CXIDB_custody_retained",sameValue (get primary "complete_article_supplements_pdb_and_raw_custody_metadata_preserved") (.boolean true) && sameValue (get primary "complete_supplementary_file_count") (.integer 13) && files.length==13 && pdfs.length==3 && sameValue (get primary "complete_pdb_deposit_count") (.integer 5) && pdbs.length==5 && custodyLength==2),
  ("experimental_calculated_and_unresolved_provenance_separated",sameValue (get primary "experimental_deposited_calculated_and_unresolved_provenance_separated") (.boolean true) && sameValue (get (get primary "computational_trajectory_archive_identity") "accession") (.text "BSM00067")),
  ("no_imported_evolution_fit_selection_interpolation_or_target_correction",sameValue (get primary "imported_differential_equation_exponential_decay_fitted_lifetime_steady_state_selection_interpolation_average_or_target_correction_used_in_fold_law") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false) && sameValue (get primary "image_curves_not_digitized_and_unreported_values_not_inferred") (.boolean true))]⟩
end SFT.Chemistry.SequentialMechanismAnalysis
