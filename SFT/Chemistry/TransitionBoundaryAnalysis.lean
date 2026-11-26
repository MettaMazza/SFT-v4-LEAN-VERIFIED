import SFT.Chemistry.TransitionBoundary
import SFT.Chemistry.ActivationBarrierAnalysis
namespace SFT.Chemistry.TransitionBoundaryAnalysis
open SFT.Host SFT.Host.Canonical SFT.Physics SFT.Physics.LeptonIntervals InternalEnergyCompositionExperiment
open TransitionBoundary
abbrev fractionText := InternalEnergyCompositionSource.fractionText
abbrev ratioRat := SolvationDissolutionAnalysis.ratioRat
abbrev sourceFraction := ActivationBarrierAnalysis.sourceFraction
def structuralPath (ordinal : Nat) (isotope : String) : Except String TransitionPath := do
 let path ← CapabilityValues.heldLabel "generated-reaction-path" (Text.append "complete-source-path-" (toString ordinal))
 let isotope ← CapabilityValues.heldLabel "held-isotopologue" isotope
 let source ← CapabilityValues.count ordinal
 makePath (.held ⟨"registered-reaction","molecular-isotope-dissociative-activation",rfl,rfl⟩) (.held path) (.held isotope) [
  .state ⟨⟨"generated-path-state","entry-least-state",rfl,rfl⟩,.emptyOne⟩,
  .state ⟨⟨"generated-path-state","entry-positive-state",rfl,rfl⟩,.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩⟩,
  .state ⟨⟨"generated-path-state","unique-boundary-state",rfl,rfl⟩,.ratio ⟨⟨3,by decide⟩,⟨1,by decide⟩⟩⟩,
  .state ⟨⟨"generated-path-state","exit-positive-state",rfl,rfl⟩,.ratio ⟨⟨2,by decide⟩,⟨1,by decide⟩⟩⟩] (.count source)
def fractionInput : Value → FractionInput
 | .text s=>.text s
 | .integer n=>.integer n
 | .boolean b=>.boolean b
 | .null | .array _ | .object _=>.other
structure RowAnalysis where
 lawPath : TransitionPath
 signature : ExternalBarrierSignature
 targetOrientation : Value
def analyzeRow (row : InternalEnergyCompositionSource.Target) (ordinal : Nat) : Except String RowAnalysis := do
 let t := get row.row "target_payload"
 if !sameValue (get t "source_status") (.text "experimentally measured TPD uptake and source-reported apparent barrier") then
  throw "KIN-005 nonexperimental record entered the measurement vector"
 let isotope ← field t "isotopologue_identity" >>= identityString
 let path ← structuralPath ordinal isotope
 let carrier ← forcedTransitionBoundary (.path path)
 let partition := match carrier.entryWord,carrier.exitWord with | .word a,.word b=>a.length==2 && b.length==1 | .emptyOne, _ | .word _, .emptyOne=>false
 if !partition || !Text.equal carrier.isotopologueIdentity.label isotope then throw "KIN-005 finite path partition changed"
 let signed ← field t "apparent_barrier_external_signed_inscription_eV"
 let orientation ← field t "apparent_barrier_orientation"
 let uncertainty ← field t "uncertainty_external_inscription_eV"
 let signature ← externalBarrierSignature (match signed with | .text s=>.text s | .null | .boolean _ | .integer _ | .array _ | .object _=>.other)
  (match orientation with | .text s=>.text s | .null | .boolean _ | .integer _ | .array _ | .object _=>.other) (fractionInput uncertainty)
 let magnitudeFraction ← field t "apparent_barrier_external_magnitude_exact_fraction_eV" >>= sourceFraction
 let uncertaintyFraction ← field t "uncertainty_exact_fraction_eV" >>= sourceFraction
 if !Text.equal (fractionText (ratioRat signature.positiveMagnitude)) (fractionText magnitudeFraction) ||
  !Text.equal (fractionText (ratioRat signature.uncertainty)) (fractionText uncertaintyFraction) then
  throw "KIN-005 exact post-seal barrier signature changed"
 let direction ← field t "uptake_temperature_order_signature"
 pure ⟨path,signature,direction⟩
structure Analysis where
 count : Nat
 supplementCount : Value
 hMagnitude : String
 dMagnitude : String
 commonUncertainty : String
 hOrientation : String
 dOrientation : String
 checks : List (String×Bool)
def exactTransitionBoundaryAnalysis (rows : List InternalEnergyCompositionSource.Target) (primary : Value) : Except String Analysis := do
 if rows.length != 2 then throw "KIN-005 requires the complete H2/D2 target pair"
 let analyzed ← rows.zipIdx.mapM fun (row,i)=>analyzeRow row (i+1)
 let paths := analyzed.map RowAnalysis.lawPath
 let collection ← forcedBoundaryCollection (paths.map PathInput.path)
 let partitions ← paths.mapM fun path=>do
  let result ← forcedTransitionBoundary (.path path)
  pure (match result.entryWord,result.exitWord with | .word _,.word _=>true | .emptyOne, _ | .word _, .emptyOne=>false)
 let isotopes := collection.orderedRows.map fun (_,_,isotope,_)=>isotope.label
 let disclosure := get primary "calculated_fitted_and_interpretive_records_retained_but_excluded_from_measurement_targets"
 let files ← RunningConvergenceMeasurement.array (if hasKey primary "complete_supplementary_files" then get primary "complete_supplementary_files" else .array [])
 match analyzed with
 | [h,d]=>pure ⟨rows.length,get primary "complete_supplementary_file_count",
  fractionText (ratioRat h.signature.positiveMagnitude),fractionText (ratioRat d.signature.positiveMagnitude),
  fractionText (ratioRat h.signature.uncertainty),h.signature.orientation.label,d.signature.orientation.label,[
  ("both_isotopologue_identities_retained",match isotopes with | [a,b]=>Text.equal a "H2" && Text.equal b "D2" | [] | [_] | _::_::_::_=>false),
  ("both_opposite_measured_temperature_directions_retained",sameValue h.targetOrientation (.text "uptake-decreases-as-temperature-is-raised") && sameValue d.targetOrientation (.text "uptake-increases-as-temperature-is-raised")),
  ("external_signed_barriers_translated_without_negative_proof_number",Text.equal h.signature.orientation.label "reverse-held-temperature-order" && Text.equal d.signature.orientation.label "held-temperature-order"),
  ("complete_finite_entry_boundary_exit_partitions_retained",partitions.all id),
  ("complete_article_and_thirteen_supplement_files_retained",sameValue (get primary "all_article_and_supplement_files_preserved") (.boolean true) && sameValue (get primary "complete_supplementary_file_count") (.integer 13) && files.length==13),
  ("experimental_and_calculated_provenance_separated",sameValue (get primary "experimental_and_calculated_provenance_separated") (.boolean true) &&
   ["source_discloses_systematic_model_parameter_adjustments_for_agreement","source_discloses_fitted_or_assumed_model_parameters_in_supplement_Table_S1","none_used_as_experimental_measurement_or_fold_law_parameter"].all (fun key=>sameValue (get disclosure key) (.boolean true))),
  ("no_imported_saddle_KIE_fit_or_target_correction",["transition_state_geometry_saddle_continuum_conventional_kie_equation_arrhenius_prefactor_fitted_barrier_selection_or_target_correction_used_in_fold_law","external_values_used_as_proof_parameters","negative_number_used_in_fold_proof"].all (fun key=>sameValue (get primary key) (.boolean false)))]⟩
 | [] | [_] | _::_::_::_=>throw "KIN-005 requires the complete H2/D2 target pair"
end SFT.Chemistry.TransitionBoundaryAnalysis
