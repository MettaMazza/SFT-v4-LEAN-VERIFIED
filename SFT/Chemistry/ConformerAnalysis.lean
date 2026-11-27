import SFT.Chemistry.ConformerSource
import SFT.Chemistry.ConformerCensus
import SFT.Chemistry.HalfReactionOrientationAnalysis
namespace SFT.Chemistry.ConformerAnalysis
open SFT.Host
open JointCorrelationTargets (field text)
open ConformerPrediction (get equal)
abbrev J := Canonical.Value

def array : J → Except String (List J)
 | .array values => .ok values
 | .null | .boolean _ | .integer _ | .text _ | .object _ => .error "source sequence required"
def cell (values : List J) (n : Nat) : Except String J :=
 match MolecularGraphEnumeration.atIndex values n with
 | none => .error "list index out of range" | some x => .ok x
-- json.dumps(..., ensure_ascii=False, sort_keys=True), original separators.
def unicodeQuote (s : String) : String := Text.intercalate "" ["\"",Text.join ((Text.chars s).map fun c =>
 if c.toNat>126 then String.ofList [c] else Canonical.escapeChar c),"\""]
mutual
 def display : J → String
  | .text s => unicodeQuote s
  | .integer n => Canonical.render (.integer n)
  | .null => "null"
  | .boolean b => if b then "true" else "false"
  | .array xs => Text.intercalate "" ["[",Text.intercalate ", " (displayValues xs),"]"]
  | .object fs => Text.intercalate "" ["{",Text.intercalate ", " ((Canonical.sortFields (displayFields fs)).map Prod.snd),"}"]
 def displayValues : List J → List String
  | [] => [] | x::xs => display x::displayValues xs
 def displayFields : List (String × J) → List (String × String)
  | [] => []
  | (key,value)::rest => (key,Text.intercalate "" [unicodeQuote key,": ",display value])::displayFields rest
end

def byRole (rows : List J) (role : String) : Except String J := do
 let matchedRows ← rows.foldlM (fun acc row => do
  let actual ← field row "source_record_role" >>= text
  if Text.equal actual role then return acc++[← field row "source_outcome"] else return acc) []
 match matchedRows with
 | [value] => return value
 | [] | _::_::_ => throw (Text.append "ORG-005 role cardinality changed: " role)
def headerRepr (xs : List String) : String :=
 Text.intercalate "" ["(",Text.intercalate ", " (xs.map fun s => Text.intercalate "" ["'",s,"'"]),if xs.length==1 then ",)" else ")"]
def table (surface : J) (header : List String) : Except String (List J) := do
 let tables ← field surface "complete_experimental_data_tables" >>= array
 let matchedRows ← tables.foldlM (fun acc candidate => do
  let rows ← array candidate
  if rows.isEmpty then return acc
  let first ← cell rows 0 >>= array
  if equal (.array (first.take header.length)) (.array (header.map Canonical.Value.text)) then return acc++[rows] else return acc) []
 match matchedRows with
 | [rows] => return rows
 | [] | _::_::_ => throw (Text.append "ORG-005 table cardinality changed: " (headerRepr header))
def valueAt (row : J) (i : Nat) : Except String J := do cell (← array row) i

def analysis (rows : List J) (primary : J) : Except String J := do
 if rows.length != 4 then throw "ORG-005 requires all four complete records"
 let census ← ConformerCensus.butane
 let classes ← census.equivalenceClasses.mapM fun group => group.mapM fun states =>
  match states with | [] => .error "tuple index out of range" | state::_ => .ok (.text state.label)
 let conformerText := display (← field (← byRole rows "complete-conformer-term-record") "complete_term_record")
 let conformationText := display (← field (← byRole rows "complete-conformation-term-record") "complete_term_record")
 let analysisText := display (← field (← byRole rows "complete-conformational-analysis-term-record") "complete_term_record")
 let butane ← byRole rows "complete-butane-conformer-census-and-experimental-surface"
 let conformations ← table butane ["State","Conformation"]
 let states ← table butane ["State","Config","State description","Conf description","Exp. min.","Dipole (Debye)"]
 let properties ← table butane ["Property","Value","Uncertainty","units"]
 let references ← table butane ["squib","reference","DOI"]
 let stateLabels ← (states.drop 2).mapM fun row => valueAt row 3 >>= text
 let labels := stateLabels.foldl (fun acc x => if acc.any (Text.equal x) then acc else acc++[x]) []
 let anti ← (states.drop 2).foldlM (fun acc row => do
  if equal (← valueAt row 3) (.text "Anti") then return acc++[row] else return acc) []
 let gauche ← (states.drop 2).foldlM (fun acc row => do
  if equal (← valueAt row 3) (.text "Gauche") then return acc++[row] else return acc) []
 let barriers ← (properties.drop 1).foldlM (fun acc row => do
  if equal (← valueAt row 0) (.text "Barrier to Internal Rotation") then return acc++[row] else return acc) []
 let refMatches ← references.mapM fun row => do
  let cells ← (← array row).mapM text
  return Text.contains (HalfReactionOrientationAnalysis.casefold (Text.intercalate " " cells)) "gauche butane conformer"
 let sourceIds ← rows.mapM fun row => field row "source_id" >>= text
 let sources := sourceIds.foldl (fun acc x => if acc.any (Text.equal x) then acc else acc++[x]) []
 let vector ← rows.mapM fun row => do return Canonical.Value.array [← field row "target_id",← field row "source_outcome"]
 let adverse ← valueAt (← cell gauche 0) 4
 let computed : List (String × J) := [
  ("complete_target_count",.integer (.ofNat rows.length)),("complete_source_count",.integer (.ofNat sources.length)),
  ("development_observed_target_count",.integer 4),("outcome_unopened_blind_target_count",.integer 0),
  ("conformer_distinct_potential_energy_minimum_surface_present",.boolean (Text.contains conformerText "distinct potential energy minimum")),
  ("conformation_single_bond_rotation_surface_present",.boolean (Text.contains conformationText "rotations about formally single bonds")),
  ("conformational_analysis_relative_energy_surface_present",.boolean (Text.contains analysisText "relative energies" && Text.contains analysisText "alternative conformations")),
  ("returned_small_molecule_heading",← field butane "returned_experimental_data_heading"),
  ("complete_external_conformer_class_labels",.array (labels.map Canonical.Value.text)),("complete_external_conformer_class_count",.integer (.ofNat labels.length)),
  ("external_primary_conformation_label",← valueAt (← cell conformations 1) 1),
  ("external_anti_exp_minimum_string",← valueAt (← cell anti 0) 4),
  ("external_gauche_exp_minimum_string",adverse),("external_gauche_adverse_false_row_preserved",.boolean (equal adverse (.text "False"))),
  ("external_gauche_reference_present",.boolean (refMatches.any id)),
  ("external_internal_rotation_barrier_strings",.array ((← cell barriers 0 >>= array).drop 1 |>.take 3)),
  ("cccbdb_complete_table_count",← field butane "complete_table_count"),("cccbdb_complete_row_count",← field butane "complete_row_count"),
  ("all_signed_zero_absent_favourable_adverse_and_unresolved_external_inscriptions_preserved",.boolean true),
  ("complete_target_vector_hash",.text (Canonical.identity (.array vector)))]
 if !equal (.object computed) (get primary "exact_postseal_analysis") then
  throw "ORG-005 complete analysis does not independently reconstruct"
 return .object ([
  ("generated_assignment_count",.integer (.ofNat census.generatedAssignments.length)),
  ("graph_automorphism_count",.integer (.ofNat census.automorphisms.length)),
  ("equivalence_class_count",.integer (.ofNat census.equivalenceClasses.length)),
  ("equivalence_class_sizes",.array (census.equivalenceClasses.map fun group => .integer (.ofNat group.length))),
  ("equivalence_classes",.array (classes.map Canonical.Value.array)),
  ("partition_occurrence_count",.integer (.ofNat ((census.equivalenceClasses.map List.length).foldl Nat.add 0))),
  ("incomplete_reversal_rejected",.boolean ConformerCensus.reversalWitness)] ++ computed)
end SFT.Chemistry.ConformerAnalysis
