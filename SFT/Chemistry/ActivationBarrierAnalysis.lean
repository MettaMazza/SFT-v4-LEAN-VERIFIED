import SFT.Chemistry.ActivationBarrier
import SFT.Chemistry.MolecularDiffusionAnalysis
namespace SFT.Chemistry.ActivationBarrierAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open ActivationBarrier
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev ratioRat := SolvationDissolutionAnalysis.ratioRat
def sourceFraction (value : Value) : Except String Rat := do
 let inscription ← identityString value
 match SolvationDissolution.fractionInscription inscription with
 | .ok r=>pure r
 | .error _=>throw (Text.intercalate "" ["Invalid literal for Fraction: '",inscription,"'"])
structure RowAnalysis where
 lawPath : BarrierPathRecord
 barrier : Rat
 wavenumber : Rat
 stateCount : Nat
 explicitZeros : Nat
 missingReference : Bool
 missingLeast : Bool
def analyzeRow (row : InternalEnergyCompositionSource.Target) (targetOrdinal : Nat) : Except String RowAnalysis := do
 let t := get row.row "target_payload"
 if !sameValue (get t "source_status") (.text "NIST CCCBDB experimental barrier collection with complete cited-source identity") ||
  !sameValue (get t "fitted_barrier_or_absolute_energy_origin_used_in_fold_law") (.boolean false) ||
  !sameValue (get t "uncertainty_support") (.text "EmptyOne") || !sameValue (get t "measurement_method_support") (.text "EmptyOne") then
  throw "KIN-004 external source status or structural-absence boundary changed"
 let raw ← RunningConvergenceMeasurement.array (if hasKey t "complete_source_ordered_path_states" then get t "complete_source_ordered_path_states" else .array [])
 if raw.isEmpty || !sameValue (.integer raw.length) (get t "complete_path_state_count") then throw "KIN-004 complete path-state record changed"
 let statesAndZeros ← raw.mapM fun s=>do
  let inscription ← field s "energy_kJ_mol_minus1_fold_support"
  let support ← externalNonnegativeSupport (match inscription with | .text s=>.text s | .null | .boolean _ | .integer _ | .array _ | .object _=>.other)
  let external ← field s "energy_kJ_mol_minus1_external_inscription"
  let absent := match support with | .emptyOne | .otherEmptyOne _=>true | .ratio _ | .invalid=>false
  if absent && !( ["0","0.0","0.00","EmptyOne"].any (fun x=>sameValue external (.text x))) then
   throw "KIN-004 EmptyOne is not source-bound to zero displacement or absence"
  let ordinal ← field s "source_state_ordinal" >>= identityString
  let angle ← field s "external_angle_state_label" >>= identityString
  let label ← CapabilityValues.heldLabel "generated-path-state" (Text.intercalate "" ["state-",ordinal,"-angle-label-",angle])
  let state ← makeState (.held label) support
  pure (state,absent && !sameValue external (.text "EmptyOne"))
 let states := statesAndZeros.map Prod.fst
 let missingLeast := !(states.any (fun s=>match s.relativeSupport with | .emptyOne | .otherEmptyOne _=>true | .ratio _ | .invalid=>false))
 let states := if missingLeast then
  (⟨⟨"generated-path-state","source-least-state-coordinate-absent",rfl,rfl⟩,.emptyOne⟩ : BarrierPathState)::states else states
 let referenceValue ← field t "source_reference_identity"
 let missingReference := sameValue referenceValue (.text "EmptyOne")
 let reference ← if missingReference then pure Provenance.emptyOne else do
  let text ← identityString referenceValue
  pure (Provenance.held (← CapabilityValues.heldLabel "source-reference" text))
 let cas ← field t "casno_source_identity" >>= identityString
 let name ← field t "species_name" >>= identityString
 let torsion ← field t "torsion_index_source_identity" >>= identityString
 let atoms ← field t "torsion_atom_identity" >>= identityString
 let rotor ← field t "rotor_type_identity" >>= identityString
 let species ← CapabilityValues.heldLabel "registered-species" (Text.intercalate "" [cas,":",name])
 let path ← CapabilityValues.heldLabel "generated-reaction-path" (Text.intercalate "" ["torsion-",torsion,"-atoms-",atoms,"-rotor-",rotor])
 let ordinal ← CapabilityValues.count targetOrdinal
 let lawPath ← makePath (.held species) (.held path) (states.map StateInput.state) (.count ordinal) reference .emptyOne .emptyOne
 let forced ← forcedActivationBarrier (.path lawPath)
 let magnitude ← field t "barrier_kJ_mol_minus1_external_inscription"
 let declared ← externalPositiveMagnitude (match magnitude with | .text s=>.text s | .null | .boolean _ | .integer _ | .array _ | .object _=>.other)
 let declaredFraction ← field t "barrier_kJ_mol_minus1_exact_fraction" >>= sourceFraction
 if !Text.equal (fractionText (ratioRat forced.barrierSupport)) (fractionText (ratioRat declared)) ||
  !Text.equal (fractionText (ratioRat declared)) (fractionText declaredFraction) then
  throw "KIN-004 forced path boundary does not match the post-seal external barrier"
 let wavenumber ← field t "barrier_cm_minus1_exact_fraction" >>= sourceFraction
 pure ⟨lawPath,declaredFraction,wavenumber,raw.length,(statesAndZeros.filter Prod.snd).length,missingReference,missingLeast⟩
structure Analysis where
 count : Nat
 speciesCount : Nat
 detailCount : Nat
 stateCount : Nat
 zeroCount : Nat
 missingReferenceCount : Nat
 missingLeastCount : Nat
 unresolvedCount : Nat
 barrierBounds : Rat×Rat
 wavenumberBounds : Rat×Rat
 checks : List (String×Bool)
def exactActivationBarrierAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 let analyzed ← rows.zipIdx.mapM fun (row,i)=>analyzeRow row (i+1)
 let relation ← forcedBarrierCollection (analyzed.map fun row=>PathInput.path row.lawPath)
 let details ← RunningConvergenceMeasurement.array (if hasKey primary "complete_detail_pages" then get primary "complete_detail_pages" else .array [])
 let unresolved ← RunningConvergenceMeasurement.array (if hasKey primary "complete_unresolved_path_rows" then get primary "complete_unresolved_path_rows" else .array [])
 let unresolvedStates ← unresolved.mapM fun row=>do
  let states ← field row "complete_source_ordered_path_states" >>= RunningConvergenceMeasurement.array
  pure states.length
 let stateCount := analyzed.foldl (fun n row=>n+row.stateCount) 0 + unresolvedStates.foldl Nat.add 0
 let zeros := analyzed.foldl (fun n row=>n+row.explicitZeros) 0
 let missingReferences := (analyzed.filter RowAnalysis.missingReference).length
 let missingLeast := (analyzed.filter RowAnalysis.missingLeast).length
 let species ← rows.mapM fun row=>field row.row "casno_source_identity"
 let speciesCount := (species.foldl (fun acc x=>if acc.any (sameValue x) then acc else acc++[x]) []).length
 let sourceOrder := relation.orderedRows.map fun (_,_,_,_,n)=>n.value
 let expected := (List.range 44).map (fun n=>n+1)
 let orderCheck := sourceOrder.length==expected.length && (sourceOrder.zip expected).all (fun (x,y)=>x==y)
 let barriers ← RealGasAnalysis.bounds (analyzed.map RowAnalysis.barrier)
 let wavenumbers ← RealGasAnalysis.bounds (analyzed.map RowAnalysis.wavenumber)
 pure ⟨rows.length,speciesCount,details.length,stateCount,zeros,missingReferences,missingLeast,unresolved.length,barriers,wavenumbers,[
  ("all_forty_four_targets_retained_in_source_order",orderCheck),
  ("all_forty_one_species_retained",speciesCount==41),
  ("all_seven_hundred_eighty_two_path_states_retained",stateCount==782),
  ("unresolved_source_row_preserved",unresolved.length==1),
  ("all_detail_pages_and_index_preserved",details.length==41 && sameValue (get primary "complete_index_species_count") (.integer 41)),
  ("structural_absence_and_missing_provenance_preserved",missingReferences==12 && missingLeast==2),
  ("no_imported_fitted_or_selected_barrier_law",sameValue (get primary "transition_state_saddle_continuum_arrhenius_prefactor_fitted_activation_absolute_origin_selection_average_or_target_correction_used_in_law") (.boolean false) && sameValue (get primary "external_values_used_as_proof_parameters") (.boolean false))]⟩
end SFT.Chemistry.ActivationBarrierAnalysis
