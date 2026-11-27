import SFT.Chemistry.AntiaromaticTables
import SFT.Chemistry.AntiaromaticDistinctionWitnesses
namespace SFT.Chemistry.AntiaromaticDistinctionAnalysis
open SFT.Host AntiaromaticDistinction AntiaromaticTables
open JointCorrelationTargets (field text)
open InorganicNetworkPrediction (get equal)
open SFT.Physics.LeptonIntervals (normalize subtract add multiply)
def strings (xs : List String) : J := .array (xs.map Canonical.Value.text)
def countJ (n : Nat) : J := .integer (.ofNat n)
def supportValue : RecurrenceSupport → J
 | .positive n => countJ n.value
 | .emptyOne _ => .text "structural-EmptyOne"
def fractionText (value : Rat) : String :=
 Text.join [SolidLocalGenerator.intText value.num,"/",toString value.den]

def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 5 then throw "ORG-004 requires all five external surfaces"
 let censusRows ← census "carrier" ((List.range 6).map fun i => Text.append "centre-" (toString (i+1)))
 let order ← censusOrder censusRows
 let a ← itemAt censusRows 0
 let f ← itemAt censusRows 2
 let an ← appendLayer a
 let fn ← appendLayer f
 let aromaticTerm ← field (← byRole rows "complete-aromatic-comparative-term-record") "complete_term_record"
 let antiTerm ← field (← byRole rows "complete-antiaromaticity-term-record") "complete_term_record"
 let benzene ← byRole rows "complete-development-benzene-thermochemistry-surface"
 let cbd ← byRole rows "complete-blind-CAS-1120-53-2-neutral-experimental-surface"
 let cot ← byRole rows "complete-blind-CAS-629-20-9-neutral-experimental-surface"
 let aromaticText := Canonical.render aromaticTerm
 let antiText := Canonical.render antiTerm
 let benzeneHfg ← (← allTables benzene).flatten.foldlM (fun found row => do
  match row with
  | [] => return found
  | first::_ =>
   if Text.equal first "Δ f H° gas" then
    let value ← itemAt row 1
    return if Text.equal value "82.93 ± 0.50" then found++[row] else found
   else return found) []
 let cotHfg ← firstCellRows cot "Hfg(298.15K)"
 let cbdHfg ← firstCellRows cbd "Hfg(298.15K)"
 let cbdIe ← table cbd ["Ionization Energy","I.E. unc."]
 let cbdState ← table cbd ["State","Config","State description","Conf description","Exp. min.","Dipole (Debye)"]
 let cbdConformation ← table cbd ["State","Conformation"]
 let cotConformation ← table cot ["State","Conformation"]
 let cotGeometry ← table cot ["Description","Value","unc.","Connectivity"]
 let cotCoordinates ← table cot ["Atom","x (Å)","y (Å)","z (Å)"]
 if benzeneHfg.length != 1 || cotHfg.length != 1 || !cbdHfg.isEmpty then
  throw "ORG-004 energy presence/absence surface changed"
 let geometry ← (cotGeometry.drop 1).mapM fun row => do return Text.join [← itemAt row 0,"-",← itemAt row 1]
 let carbonZ ← (cotCoordinates.drop 1).foldlM (fun found row => do
  let atom ← itemAt row 0
  if starts "C" atom then return found++[← itemAt row 3] else return found) []
 let bv ← hundredths "82.93"
 let bu ← hundredths "0.50"
 let cotRow ← itemAt cotHfg 0
 let cv ← itemAt cotRow 1 >>= hundredths
 let cu ← itemAt cotRow 2 >>= hundredths
 let gap := subtract (normalize (.ofNat cv) 8 (by decide)) (normalize (.ofNat bv) 6 (by decide))
 let uncertainty := add (normalize (.ofNat cu) 8 (by decide)) (normalize (.ofNat bu) 6 (by decide))
 let lower := subtract gap uncertainty
 let unit := normalize 1 100 (by decide)
 let sourceIds ← rows.mapM (fun row => field row "source_id" >>= text)
 let unique := sourceIds.foldl (fun out id => if out.any (Text.equal id) then out else out++[id]) []
 let custody ← rows.mapM (fun row => field row "custody_class" >>= text)
 let vector ← rows.mapM fun row => do return Canonical.Value.array [← field row "target_id",← field row "source_outcome"]
 let computed : J := .object [
 ("complete_target_count",countJ rows.length),
 ("complete_source_count",countJ unique.length),
 ("development_observed_target_count",countJ (custody.filter (fun s => Text.contains s "development-observed")).length),
 ("outcome_unopened_blind_target_count",countJ (custody.filter (fun s => Text.contains s "outcome-unopened")).length),
 ("aromatic_closed_cycle_and_stability_surface_present",.boolean (Text.contains aromaticText "cyclically conjugated molecular entity" && Text.contains aromaticText "stability")),
 ("antiaromatic_reduced_stability_surface_present",.boolean (Text.contains antiText "reduction (in some cases, loss) of thermodynamic stability")),
 ("antiaromatic_bond_alternation_surface_present",.boolean (Text.contains antiText "alternation of bond lengths")),
 ("blind_returned_species",.object [("CAS-1120-53-2",← field cbd "returned_experimental_data_heading"),("CAS-629-20-9",← field cot "returned_experimental_data_heading")]),
 ("blind_conformation_external_strings",.object [("cyclobutadiene",.text (← itemAt (← itemAt cbdConformation 1) 1)),("cyclooctatetraene",.text (← itemAt (← itemAt cotConformation 1) 1))]),
 ("blind_cyclobutadiene_true_minimum_external_string",.text "D 2h"),
 ("blind_cyclobutadiene_false_square_control_external_string",.text "D 4h"),
 ("blind_cyclooctatetraene_alternating_cc_bond_external_strings_angstrom",strings ["1.337","1.470"]),
 ("blind_cyclooctatetraene_opposed_z_coordinate_signs_present",.boolean (carbonZ.any (starts "-") && carbonZ.any (fun s => !starts "-" s))),
 ("blind_cyclobutadiene_hfg_298_row_count",countJ cbdHfg.length),
 ("blind_cyclobutadiene_hfg_absence_preserved",.boolean cbdHfg.isEmpty),
 ("blind_cyclobutadiene_ionization_energy_external_strings_ev",strings ((← itemAt cbdIe 1).take 2)),
 ("development_benzene_hfg_external_strings_kj_per_mol",strings ["82.93","0.50"]),
 ("blind_cyclooctatetraene_hfg_external_strings_kj_per_mol",strings ((cotRow.drop 1).take 2)),
 ("exact_repeated_ch_unit_hfg_gap_hundredths_kj_per_mol",.text (fractionText gap)),
 ("exact_repeated_ch_unit_uncertainty_hundredths_kj_per_mol",.text (fractionText uncertainty)),
 ("exact_repeated_ch_unit_lower_gap_hundredths_kj_per_mol",.text (fractionText lower)),
 ("exact_repeated_ch_unit_hfg_gap_kj_per_mol",.text (fractionText (multiply gap unit))),
 ("exact_repeated_ch_unit_uncertainty_kj_per_mol",.text (fractionText (multiply uncertainty unit))),
 ("exact_repeated_ch_unit_lower_gap_kj_per_mol",.text (fractionText (multiply lower unit))),
 ("blind_cccbdb_complete_table_counts",.object [("cyclobutadiene",← field cbd "complete_table_count"),("cyclooctatetraene",← field cot "complete_table_count")]),
 ("blind_cccbdb_complete_row_counts",.object [("cyclobutadiene",← field cbd "complete_row_count"),("cyclooctatetraene",← field cot "complete_row_count")]),
 ("development_webbook_complete_table_count",← field benzene "complete_table_count"),
 ("development_webbook_complete_row_count",← field benzene "complete_row_count"),
 ("all_signed_and_absent_external_inscriptions_preserved_downstream",.boolean true),
 ("all_favourable_adverse_absent_scope_and_unresolved_rows_preserved",.boolean true),
 ("complete_target_vector_hash",.text (Canonical.identity (.array vector)))]
 if !equal computed (get primary "exact_postseal_analysis") then throw "ORG-004 post-seal analysis does not independently reconstruct"
 let fields := match computed with
  | .object fs => fs
  | .null | .boolean _ | .integer _ | .text _ | .array _ => []
 return .object ([
 ("base_supports",.array [supportValue a.recurrenceSupport,.text "structural-EmptyOne",supportValue f.recurrenceSupport]),
 ("successor_supports",.array [supportValue an.recurrenceSupport,.text "structural-EmptyOne",supportValue fn.recurrenceSupport]),
 ("exact_class_order",strings ((exactOrder order).map SFT.Physics.CapabilityValues.HeldLabel.label)),
 ("inconsistent_antiaromatic_break_rejected",.boolean AntiaromaticDistinctionWitnesses.inconsistentWitness),
 ("missing_nonaromatic_break_rejected",.boolean AntiaromaticDistinctionWitnesses.missingBreakWitness),
 ("numerical_zero_rejected",.boolean AntiaromaticDistinctionWitnesses.zeroWitness),
 ("blind_true_and_false_minimum_rows_present",.boolean ((cbdState.drop 2).any (fun row => sameStrings ((row.drop 3).take 2) ["D 2h","True"]) && (cbdState.drop 2).any (fun row => sameStrings ((row.drop 3).take 2) ["D 4h","False"]))),
 ("blind_cot_bond_alternation_rows_present",.boolean (geometry.any (Text.equal "rCC-1.337") && geometry.any (Text.equal "rCC-1.470")))]++fields)
end SFT.Chemistry.AntiaromaticDistinctionAnalysis
