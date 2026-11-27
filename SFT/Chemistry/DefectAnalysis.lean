import SFT.Chemistry.DefectSource
import SFT.Chemistry.DefectWitnesses
import SFT.Chemistry.CoordinationAnalysis
namespace SFT.Chemistry.DefectAnalysis
open SFT.Host DefectChemistry
open JointCorrelationTargets (field text)
open DefectPrediction (get equal)
abbrev J := Canonical.Value
def vector (fs : List FormulaEntry) : J := .array (fs.map fun f => .integer (.ofNat f.primitiveCount.value))
def positiveValue : CountOrEmpty → Except String J
 | .emptyOne _ => .error "EmptyOne has no value"
 | .count n => .ok (.integer (.ofNat n.value))
def classVector : Classes → Except String J
 | .emptyOne _ => .error "EmptyOne is not iterable"
 | .support xs => .ok (.array (xs.map fun x => .text x.label))
def originName : SFT.Physics.CapabilityValues.Value → Except String J
 | .label x => .ok (.text x.label)
 | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => .error "origin has no label"
def speciesRow (s : Defect) (label : String) : Except String Reconciliation :=
 match s.reconciliation.find? (fun r => Text.equal r.species.label label) with
 | none => .error "StopIteration" | some r => .ok r
def analysis (rows : List J) (primary v1Target : J) : Except String J := do
 if rows.length != 15 then throw "INORG-016 requires all fifteen external surfaces"
 let p ← defectState "pristine" DefectWitnesses.reference (DefectWitnesses.reference.map ObservedInput.text)
 let v ← defectState "vacancy" DefectWitnesses.reference [.text "A",.emptyOne "empty-One",.text "B",.text "B"]
 let i ← defectState "interstitial" DefectWitnesses.reference (DefectWitnesses.reference.map ObservedInput.text) ["A"]
 let s ← defectState "substitution" DefectWitnesses.reference [.text "A",.text "C",.text "B",.text "B"]
 let va ← speciesRow v "A"
 let ia ← speciesRow i "A"
 let sa ← speciesRow s "A"
 let sc ← speciesRow s "C"
 let post ← field primary "exact_postseal_analysis"
 let sourceIds ← rows.mapM (fun row => field row "source_id" >>= text)
 let uniqueSources := sourceIds.foldl (fun out id => if out.any (Text.equal id) then out else out++[id]) []
 let surfaces ← rows.mapM (fun row => do field (← field row "source_outcome") "registered_surface_present")
 let custody ← rows.mapM (fun row => field row "custody_class" >>= text)
 let oldRows ← (match ← field v1Target "rows" with
  | .array xs => pure xs
  | .null | .text _ | .boolean _ | .integer _ | .object _ => throw "rows must be a sequence" : Except String (List J))
 let oldSurfaces ← oldRows.mapM (fun row => do field (← field row "source_outcome") "registered_surface_present")
 return .object [
 ("pristine_defect_absence",.boolean (match p.classes with | .emptyOne _ => true | .support _ => false)),
 ("reference_formula_vector",vector p.referenceFormula),
 ("vacancy_observed_formula_vector",vector v.observedFormula),
 ("vacancy_missing_a_count",← positiveValue va.missing),
 ("vacancy_added_a_absence",.boolean (countEmpty va.added)),
 ("vacancy_class_vector",← classVector v.classes),("vacancy_origin",← originName v.origin),
 ("interstitial_observed_formula_vector",vector i.observedFormula),("interstitial_added_a_count",← positiveValue ia.added),
 ("interstitial_origin",← originName i.origin),
 ("substitution_observed_formula_vector",vector s.observedFormula),("substitution_missing_a_count",← positiveValue sa.missing),
 ("substitution_added_c_count",← positiveValue sc.added),("substitution_origin",← originName s.origin),
 ("complete_target_count",.integer (.ofNat rows.length)),("complete_source_count",.integer (.ofNat uniqueSources.length)),
 ("identity_only_unopened_target_count",.integer (.ofNat (custody.filter (Text.equal "family-identity-only-unopened")).length)),
 ("all_registered_surfaces_present",.boolean (surfaces.all CoordinationAnalysis.truthy)),
 ("definition_note_surface_count",← field post "definition_note_surface_count"),
 ("scope_mismatch_or_distinction_count",← field post "scope_mismatch_or_distinction_count"),
 ("v1_missing_registered_surface_count",.integer (.ofNat (oldSurfaces.filter (fun x => !CoordinationAnalysis.truthy x)).length)),
 ("complete_target_vector_hash",← field post "complete_target_vector_hash"),
 ("source_recapture_count",← field post "source_recapture_count"),("all_rows_preserved",← field post "all_rows_preserved")]
end SFT.Chemistry.DefectAnalysis
