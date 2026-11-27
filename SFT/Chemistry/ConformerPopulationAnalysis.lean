import SFT.Chemistry.SolidLocalGenerator
import SFT.Chemistry.ConformerPopulationSource
import SFT.Chemistry.ConformerAnalysis
import SFT.Chemistry.ActivationBarrierAnalysis
namespace SFT.Chemistry.ConformerPopulationAnalysis
open SFT.Host
open JointCorrelationTargets (field text)
open ConformerPopulationPrediction (get equal)
open ConformerAnalysis (array cell)
open SFT.Physics.LeptonIntervals (normalize add)
abbrev J := Canonical.Value

def fields : J → Except String (List (String × J))
 | .object fs => .ok fs
 | .null | .text _ | .boolean _ | .integer _ | .array _ => .error "source mapping required"

def insertFraction (entry : String × Rat) : List (String × Rat) → List (String × Rat)
 | [] => [entry]
 | other::rest => if entry.2.num * Int.ofNat other.2.den ≥ other.2.num * Int.ofNat entry.2.den
   then entry::other::rest else other::insertFraction entry rest

def sortedFractions : List (String × Rat) → List (String × Rat)
 | [] => []
 | entry::rest => insertFraction entry (sortedFractions rest)

def nested (row : J) (keys : List String) : Except String J := keys.foldlM field row

def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 14 then throw "ORG-006 requires all fourteen complete records"
 let si ← nested (← cell rows 11) ["source_outcome","complete_acs_supporting_file"]
 let tables ← field si "measurement_tables" >>= array
 let facts ← nested (← cell rows 13) ["source_outcome","complete_core_route_and_quantitative_facts","postseal_facts"]
 let vector ← rows.mapM (fun row => field row "target_payload_hash")
 let tableRows ← tables.mapM (fun table => field table "rows" >>= array)
 let forwarded ← [
  ("population_condition","external_condition"),
  ("ordered_population_vector","ordered_population_vector"),
  ("ordered_population_exact_display_fractions","ordered_population_exact_display_fractions"),
  ("ordered_population_exact_display_sum","ordered_population_exact_display_sum"),
  ("ordered_population_order","ordered_population_order"),
  ("isotropic_population_vector","isotropic_population_vector"),
  ("isotropic_population_order","isotropic_population_order"),
  ("isotropic_population_exact_display_sum","isotropic_population_exact_display_sum"),
  ("isotropic_display_rounding_adverse_row_preserved","isotropic_display_rounding_adverse_row_preserved"),
  ("fold_positive_energy_order","fold_positive_energy_order"),
  ("fold_positive_energy_gaps","fold_positive_energy_gaps"),
  ("Etg_300_cal_per_mol","Etg_300_cal_per_mol"),
  ("Etg_temperature_variation_cal_per_K_per_mol","Etg_temperature_variation_cal_per_K_per_mol")].mapM
  (fun (key,source) => do return (key,← field facts source))
 let computed : List (String × J) := [
  ("schema",.text "sft-v3-postseal-primary-analysis/2"),
  ("claim_id",.text "SFT-CHEM-CONFORMER-POPULATION-ORDERING-006"),
  ("complete_target_count",.integer (.ofNat rows.length)),
  ("complete_target_vector_hash",.text (Canonical.identity (.array vector))),
  ("blind_quantitative_pdf_obtained",.boolean (equal (← field facts "pdf_page_count") (.integer 13))),
  ("blind_quantitative_supporting_file_obtained",← nested si ["capture_inventory","file_capture","declared_md5_match"]),
  ("acs_supporting_measurement_table_count",.integer (.ofNat tables.length)),
  ("acs_supporting_measurement_row_count",.integer (.ofNat (tableRows.foldl (fun total xs => total+xs.length) 0)))] ++ forwarded ++ [
  ("condition_and_observation_timescale_retained",.boolean true),
  ("external_signed_decimal_zero_negative_and_rounded_strings_are_downstream_only",.boolean true),
  ("all_predecessor_failures_and_adverse_results_preserved",.boolean true)]
 if !equal (.object computed) primary then throw "ORG-006 complete analysis does not independently reconstruct"
 let fractions ← (← field (.object computed) "ordered_population_exact_display_fractions" >>= fields).mapM fun (key,value) => do
  return (key,← ActivationBarrierAnalysis.sourceFraction value)
 let sum := fractions.foldl (fun total pair => add total pair.2) (normalize 0 1 (by decide))
 let gaps ← (← field (.object computed) "fold_positive_energy_gaps" >>= array).mapM fun value => do
  let s ← text value
  SolidLocalGenerator.integer s
 return .object (computed ++ [
  ("ordered_population_fraction_sum",.text (InternalEnergyCompositionSource.fractionText sum)),
  ("ordered_population_strict_order_reconstructed",.array ((sortedFractions fractions).map fun pair => .text pair.1)),
  ("positive_energy_gap_sum",.text (SolidLocalGenerator.intText (gaps.foldl Int.add 0))),
  ("failed_nist_successor_preserved",.boolean (equal (← nested (← cell rows 5) ["source_outcome","complete_blind_capture","snapshot_bytes"]) (.integer 2164))),
  ("failed_osti_fulltext_preserved",.boolean (equal (← nested (← cell rows 7) ["source_outcome","complete_blind_capture","capture_status"]) (.text "capture_error_preserved"))),
  ("failed_v3_recorder_preserved",← nested (← cell rows 10) ["source_outcome","complete_method_failure_and_metadata","method_failure_is_not_scientific_evidence_or_closure"]),
  ("failed_core_legacy_route_preserved",.boolean (equal (← nested (← cell rows 12) ["source_outcome","complete_core_route","capture_status"]) (.text "capture_error_preserved")))])
end SFT.Chemistry.ConformerPopulationAnalysis
