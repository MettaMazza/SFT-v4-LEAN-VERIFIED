import SFT.Chemistry.InorganicMagneticStateSource
import SFT.Chemistry.InorganicMagneticStateDerivation
import SFT.Chemistry.ComplexSpinStateAnalysis
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.InorganicMagneticStateAnalysis
open SFT.Host InorganicMagneticState
open JointCorrelationTargets (field)
open InorganicMagneticStatePrediction (get equal)
abbrev J := Canonical.Value
def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 177 then throw "INORG-009 requires all 177 source surfaces"
 let b ← balanced
 let h ← high
 let s ← successor
 let definitions ← (rows.take 3).mapM (fun r => field r "source_outcome")
 let magnetic ← (rows.drop 3).mapM (fun r => field r "source_outcome")
 let post ← field primary "exact_postseal_analysis"
 let present := magnetic.filter (fun r => CoordinationAnalysis.truthy (get r "source_value_present"))
 let absent := magnetic.filter (fun r => !CoordinationAnalysis.truthy (get r "source_value_present"))
 return .object [
  ("balanced_moment",ComplexSpinStateAnalysis.countValue b.momentSupport),
  ("balanced_width",.integer (.ofNat b.spinWidth.value)),
  ("balanced_relation",.text b.fieldRelation.label),
  ("balanced_class",.text b.magneticClass.label),
  ("high_moment",ComplexSpinStateAnalysis.countValue h.momentSupport),
  ("high_width",.integer (.ofNat h.spinWidth.value)),
  ("high_relation",.text h.fieldRelation.label),
  ("high_class",.text h.magneticClass.label),
  ("successor_moment",ComplexSpinStateAnalysis.countValue s.momentSupport),
  ("successor_width",.integer (.ofNat s.spinWidth.value)),
  ("susceptibility_definition_present",← field (ComplexSpinStateAnalysis.rowAt definitions 0) "susceptibility_relative_permeability_relation_present"),
  ("paramagnetic_definition_present",← field (ComplexSpinStateAnalysis.rowAt definitions 1) "paramagnetic_positive_external_sign_and_drawn_relation_present"),
  ("diamagnetic_definition_present",← field (ComplexSpinStateAnalysis.rowAt definitions 2) "diamagnetic_negative_external_sign_and_repelled_relation_present"),
  ("complete_magnetic_count",.integer (.ofNat magnetic.length)),
  ("positive_magnitude_count",.integer (.ofNat present.length)),
  ("structural_absence_count",.integer (.ofNat absent.length)),
  ("orientation_class_counts",← field post "complete_orientation_class_counts"),
  ("exact_magnitude_vector_hash",← field post "complete_exact_magnitude_vector_hash"),
  ("source_recapture_count",← field post "source_recapture_count"),
  ("all_rows_preserved",← field post "all_177_rows_preserved"),
  ("forbidden_formula_or_fit_used",← field post "square_root_spin_only_formula_fitted_g_factor_or_dimensional_moment_derived")]
end SFT.Chemistry.InorganicMagneticStateAnalysis
