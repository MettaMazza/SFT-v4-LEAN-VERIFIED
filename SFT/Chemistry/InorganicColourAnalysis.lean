import SFT.Chemistry.InorganicColourSource
import SFT.Chemistry.InorganicColourDerivation
import SFT.Chemistry.ComplexSpinStateAnalysis
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.InorganicColourAnalysis
open SFT.Host SFT.Physics.CapabilityValues InorganicColour
open JointCorrelationTargets (field)
open InorganicColourPrediction (get equal)
abbrev J := Canonical.Value
def array : J → List J
 | .array xs => xs
 | .null | .text _ | .integer _ | .boolean _ | .object _ => []
def integer : J → Except String Int
 | .integer n => .ok n
 | .null | .text _ | .array _ | .boolean _ | .object _ => .error "point count must be integer"
def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 8 then throw "INORG-008 requires all eight source surfaces"
 let classes ← InorganicColour.classes
 let t ← build "validation-complex" "ligand" "metal" "lower" "upper" ⟨1,by decide⟩ ⟨3,by decide⟩
 let a ← heldLabel "observation-distinction" "d-1"
 let b ← heldLabel "observation-distinction" "d-2"
 let c ← heldLabel "observation-distinction" "d-3"
 let ab ← selective t [a,b,c] [a]
 let definitions ← (rows.take 4).mapM (fun r => field r "source_outcome")
 let spectra ← (rows.drop 4).mapM (fun r => field r "source_outcome")
 let post ← field primary "exact_postseal_analysis"
 let points ← spectra.mapM (fun r => field r "exact_point_count")
 let counts ← points.mapM integer
 let maxima ← spectra.mapM (fun r => field r "complete_interior_local_maxima")
 let positions ← maxima.mapM (fun r => do return Canonical.Value.array (← (array r).mapM (fun peak => field peak "x")))
 return .object [
  ("transition_classes",.array (classes.map (fun x => .text x.label))),
  ("exact_gap",.integer (.ofNat t.positiveOrderGap.value)),
  ("absorbed_count",.integer (.ofNat (absorbedCount ab).value)),
  ("retained_colour_count",.integer (.ofNat (retainedCount ab).value)),
  ("generic_definition_present",← field (ComplexSpinStateAnalysis.rowAt definitions 0) "two_distinct_electronic_levels_present"),
  ("ll_definition_present",← field (ComplexSpinStateAnalysis.rowAt definitions 1) "ligand_to_ligand_endpoint_surface_present"),
  ("lm_definition_present",← field (ComplexSpinStateAnalysis.rowAt definitions 2) "ligand_to_metal_endpoint_surface_present"),
  ("ml_definition_present",← field (ComplexSpinStateAnalysis.rowAt definitions 3) "metal_to_ligand_endpoint_surface_present"),
  ("metal_to_metal_definition_absent_preserved",← field post "metal_to_metal_definition_surface_absent_from_frozen_family"),
  ("spectrum_count",.integer (.ofNat spectra.length)),
  ("point_count_vector",.array points),
  ("total_point_count",.integer (counts.foldl (fun a b => a+b) 0)),
  ("interior_maximum_count_vector",.array (maxima.map (fun xs => .integer (.ofNat (array xs).length)))),
  ("interior_maximum_position_vector",.array positions),
  ("all_spectra_selective",.boolean (maxima.all CoordinationAnalysis.truthy)),
  ("originally_blind_count",← field post "originally_law_sealed_blind_spectrum_count"),
  ("source_recapture_count",← field post "source_recapture_count"),
  ("all_rows_preserved",← field post "all_eight_rows_preserved"),
  ("dimensional_value_or_colour_fitted",← field post "dimensional_wavelength_intensity_or_colour_name_fitted_or_derived")]
end SFT.Chemistry.InorganicColourAnalysis
