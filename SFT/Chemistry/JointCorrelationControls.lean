import SFT.Chemistry.JointCorrelationComparison
import SFT.Chemistry.PairExchangeControls
namespace SFT.Chemistry.JointCorrelationControls
open SFT.Host SFT.Physics.CapabilityValues
open JointCorrelationTargets (field text integer)
open StateSymmetryControls (rejected)
abbrev J := Canonical.Value
def textAt (row : J) (key : String) : Except String String := field row key >>= text

def counts (rows : List J) : Except String (List (String × Nat)) := do
 let sources ← rows.mapM (fun row => textAt row "source_id")
 let kinds ← rows.mapM (fun row => textAt row "record_kind")
 let uncertainties ← rows.mapM (fun row => textAt row "uncertainty_inscription")
 let species ← rows.mapM (fun row => textAt row "species")
 let unique := species.foldl (fun seen s => if seen.any (Text.equal s) then seen else seen++[s]) ([] : List String)
 return [("records",rows.length),
 ("APS_records",(sources.filter (Text.equal · "APS-PRA-49-2460-1994")).length),
 ("NIST_records",(sources.filter (Text.equal · "NIST-CHEMISTRY-WEBBOOK-SRD69-H2-DISSOCIATION")).length),
 ("direct_or_compiled",(kinds.filter (fun s => !Text.equal s "derived_from_measured-neutral-and-ionization-intervals")).length),
 ("derived_ionic",(kinds.filter (Text.equal · "derived_from_measured-neutral-and-ionization-intervals")).length),
 ("positive_uncertainties",(uncertainties.filter (fun s => !Text.equal s "absence")).length),
 ("absent_uncertainties",(uncertainties.filter (Text.equal · "absence")).length),("species",unique.length)]
def expectedCounts : List (String × Nat) := [("records",9),("APS_records",6),("NIST_records",3),
 ("direct_or_compiled",7),("derived_ionic",2),("positive_uncertainties",7),("absent_uncertainties",2),("species",4)]
def adverse (rows : List J) (counts : List (String × Nat)) (actualHash changedHash : String) : Except String (List (String × Bool)) := do
 let base ← JointCorrelationSupport.completeSupport "control" "left" "right"
 let incomplete := rejected (JointCorrelationSupport.construct base.molecularCarrier base.leftCentre base.rightCentre (base.jointWords.take 1))
 let sameLeft ← JointCorrelationSupport.assignmentWord "lower-fibre" base.leftCentre "upper-fibre" base.leftCentre
 let sameRight ← JointCorrelationSupport.assignmentWord "lower-fibre" base.rightCentre "upper-fibre" base.rightCentre
 let factorized := rejected (JointCorrelationSupport.construct base.molecularCarrier base.leftCentre base.rightCentre (base.jointWords++[sameLeft,sameRight]))
 let sameCentre := rejected (JointCorrelationSupport.completeSupport "control" "same" "same")
 let numericZero := rejected (ConjugatedSupportControls.wordCells [.inr (.integer 0)])
 let nonpositive := rejected (JointCorrelationObservation.positiveRatio 0 1)
 let first ← match rows with | [] => .error "list index out of range" | row::_ => .ok row
 let n ← field first "value_numerator" >>= integer
 let d ← field first "value_denominator" >>= integer
 let oldValue ← JointCorrelationObservation.positiveRatio n d
 let newValue ← JointCorrelationObservation.positiveRatio (n+1) d
 let oldUncertainty ← JointCorrelationObservation.positiveRatio 4 100
 let newUncertainty ← JointCorrelationObservation.positiveRatio 5 100
 let allCounts := counts.length==expectedCounts.length && expectedCounts.all (fun (key,n) => counts.any (fun (k,m) => Text.equal key k && n==m))
 return [("incomplete_one_word_support_rejected",incomplete),("factorized_four_word_support_rejected",factorized),
 ("same_centre_support_rejected",sameCentre),("numerical_zero_rejected",numericZero),("nonpositive_energy_rejected",nonpositive),
 ("omitted_record_rejected",rows.length-1 != 9),("omitted_derived_ion_rejected",(← PairExchangeControls.countAt counts "derived_ionic")==2),
 ("selected_newer_only_rejected",(← PairExchangeControls.countAt counts "NIST_records")==3),
 ("selected_NIST_only_rejected",(← PairExchangeControls.countAt counts "APS_records")==6),
 ("changed_value_rejected",!equal oldValue newValue),("changed_uncertainty_rejected",!equal oldUncertainty newUncertainty),
 ("tampered_snapshot_rejected",Text.equal actualHash JointCorrelationTargets.apsHash && !Text.equal changedHash JointCorrelationTargets.apsHash),
 ("complete_provenance_vector_retained",allCounts)]
end SFT.Chemistry.JointCorrelationControls
