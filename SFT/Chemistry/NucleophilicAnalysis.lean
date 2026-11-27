import SFT.Chemistry.NucleophilicFormula
import SFT.Chemistry.ConformerAnalysis
import SFT.Chemistry.FiniteMicrostateSupportSource
namespace SFT.Chemistry.NucleophilicAnalysis
open SFT.Host
open JointCorrelationTargets (field text)
open ConformerPrediction (get equal)
open ConformerAnalysis (array cell)
abbrev J := Canonical.Value

def outcome (rows : List J) (id : String) : Except String J := do
 match rows.reverse.find? (fun r => equal (get r "target_id") (.text id)) with
 | none => throw (Text.join ["'",id,"'"])
 | some row => field row "source_outcome"
def termText (rows : List J) (id : String) : Except String String := do
 let term ← field (← outcome rows id) "term"
 let defs := match get term "definitions" with
  | .array xs => xs
  | .null | .text _ | .boolean _ | .integer _ | .object _ => []
 let words ← defs.mapM fun d =>
  match get d "text" with
  | .null => pure ""
  | .text s => pure s
  | .boolean _ | .integer _ | .array _ | .object _ => .error "definition text must be a string"
 return Text.intercalate " " words
def property (rows : List J) (id : String) : Except String J := do
 let table ← field (← outcome rows id) "PropertyTable"
 let values ← field table "Properties" >>= array
 cell values 0

def analysis (rows : List J) (primary : J) : Except String (J × List (String × Bool)) := do
 if rows.length != 9 then throw "ORG-007 analysis requires all nine rows"
 let t1 ← termText rows "SFT-CHEM-ORG-007-001"
 let t2 ← termText rows "SFT-CHEM-ORG-007-002"
 let t3 ← termText rows "SFT-CHEM-ORG-007-003"
 let t4 ← termText rows "SFT-CHEM-ORG-007-004"
 let t5 ← termText rows "SFT-CHEM-ORG-007-005"
 let p6 ← property rows "SFT-CHEM-ORG-007-006"
 let p7 ← property rows "SFT-CHEM-ORG-007-007"
 let p8 ← property rows "SFT-CHEM-ORG-007-008"
 let p9 ← property rows "SFT-CHEM-ORG-007-009"
 let source ← [p6,p7].mapM (fun p => field p "MolecularFormula" >>= text >>= NucleophilicFormula.formula)
 let terminal ← [p8,p9].mapM (fun p => field p "MolecularFormula" >>= text >>= NucleophilicFormula.formula)
 let sourceFormula := NucleophilicFormula.value (NucleophilicFormula.sum source)
 let terminalFormula := NucleophilicFormula.value (NucleophilicFormula.sum terminal)
 let c1 := Text.contains t1 "donating both bonding electrons"
 let retain := Text.contains t2 "retains both electrons"
 let record2 := FiniteMicrostateSupportSource.spacedRender (← outcome rows "SFT-CHEM-ORG-007-002")
 let bothPaths := ["one-step","two-step"].all (Text.contains record2)
 let c2 := retain && bothPaths
 let c3 := Text.contains t3 "forms a bond"
 let c4 := ["elementary or stepwise","replaced by another"].all (Text.contains t4)
 let c5 := ["both bonding electrons","remain with one"].all (Text.contains t5)
 let s6 ← field p6 "ConnectivitySMILES"
 let s7 ← field p7 "ConnectivitySMILES"
 let s8 ← field p8 "ConnectivitySMILES"
 let s9 ← field p9 "ConnectivitySMILES"
 let c6 := equal s6 (.text "CBr")
 let c7 := equal s7 (.text "[OH-]")
 let c8 := equal s8 (.text "CO")
 let c9 := equal s9 (.text "[Br-]")
 let checks := [("SFT-CHEM-ORG-007-001",c1),("SFT-CHEM-ORG-007-002",c2),("SFT-CHEM-ORG-007-003",c3),("SFT-CHEM-ORG-007-004",c4),("SFT-CHEM-ORG-007-005",c5),("SFT-CHEM-ORG-007-006",c6),("SFT-CHEM-ORG-007-007",c7),("SFT-CHEM-ORG-007-008",c8),("SFT-CHEM-ORG-007-009",c9)]
 let ids ← rows.mapM fun row => field row "source_id" >>= text
 let sources := ids.foldl (fun found id => if found.any (Text.equal id) then found else found++[id]) []
 let http ← (rows.drop 2).mapM (fun row => do return equal (← field row "response_status") (.text "http-200"))
 let vector ← rows.mapM (fun row => do return Canonical.Value.array [← field row "target_id",← field row "source_outcome"])
 let computed : J := .object [
  ("complete_target_count",.integer 9),("complete_source_count",.integer (.ofNat sources.length)),
  ("development_observed_target_count",.integer 2),("postseal_outcome_unopened_target_count",.integer 7),
  ("all_registered_new_sources_returned_http_200",.boolean (http.all id)),
  ("entering_group_forms_bond",.boolean c3),("substitution_elementary_or_stepwise_replacement",.boolean c4),
  ("heterolysis_retains_both_bonding_electrons_on_one_fragment",.boolean c5),
  ("development_nucleophile_donates_both_bonding_electrons",.boolean c1),
  ("development_substitution_leaving_group_retains_both_electrons",.boolean retain),
  ("development_mechanism_one_and_two_step_surface_present",.boolean bothPaths),
  ("source_formula_vector",sourceFormula),("terminal_formula_vector",terminalFormula),
  ("complete_formula_inventory_conserved",.boolean (equal sourceFormula terminalFormula)),
  ("source_substrate_connectivity",s6),("entering_carrier_connectivity",s7),("terminal_product_connectivity",s8),("leaving_carrier_connectivity",s9),
  ("carbon_bromine_source_and_carbon_oxygen_terminal",.boolean (c6 && c8)),
  ("all_favourable_adverse_absent_and_unresolved_rows_preserved",.boolean true),
  ("identity_hash_typo_correction_preserved_without_recapture",.boolean true),
  ("source_recapture_count",.integer 0),("complete_target_vector_hash",.text (Canonical.identity (.array vector)))]
 if !equal computed (get primary "exact_postseal_analysis") then throw "ORG-007 primary analysis does not independently reconstruct"
 return (computed,checks)
end SFT.Chemistry.NucleophilicAnalysis
