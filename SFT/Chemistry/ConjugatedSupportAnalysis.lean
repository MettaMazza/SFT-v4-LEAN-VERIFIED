import SFT.Chemistry.ConjugatedSupportWitnesses
namespace SFT.Chemistry.ConjugatedSupportAnalysis
open SFT.Host SFT.Chemistry.ConjugatedSupportWitnesses
abbrev J := Canonical.Value
structure SourceRow where
 sourceId : String
 custodyClass : String
 sourceRecordRole : String
 sourceOutcome : J

def field (value : J) (key : String) : Except String J :=
 match value with
 | .object fields => match fields.find? (fun p => Text.equal p.1 key) with
   | some p => .ok p.2
   | none => .error (Text.intercalate "" ["'",key,"'"])
 | .text _ | .boolean _ | .integer _ | .null | .array _ => .error "source field requires an object"
def array (value : J) : Except String (List J) :=
 match value with | .array xs => .ok xs | .text _ | .boolean _ | .integer _ | .null | .object _ => .error "source table requires an array"
def valueAt : List J → Nat → Except String J
 | [],_ => .error "list index out of range"
 | x::_,0 => .ok x
 | _::xs,n+1 => valueAt xs n
def isText (value : J) (text : String) : Bool :=
 match value with | .text s => Text.equal s text | .boolean _ | .integer _ | .null | .array _ | .object _ => false

def byRole (rows : List SourceRow) (role : String) : Except String J :=
 match rows.filter (fun row => Text.equal row.sourceRecordRole role) with
 | [row] => .ok row.sourceOutcome
 | [] | _::_::_ => .error (Text.append "ORG-001 role cardinality changed: " role)
def rccValues (value : J) : Except String (List J) := do
 let table ← field value "complete_internal_coordinate_table" >>= array
 table.foldlM (fun out row => do
  let cells ← array row
  let name ← valueAt cells 0
  if isText name "rCC" then do
   let distance ← valueAt cells 1
   pure (out++[distance])
  else pure out) []
def smilesFirst : List J → Except String J
 | [] => .error "StopIteration"
 | row::rest => do
  let cells ← array row
  if cells.length != 4 then smilesFirst rest else do
   let name ← valueAt cells 3
   if isText name "Buta-1,3-diene" then valueAt cells 2 else smilesFirst rest

def smilesValue (value : J) : Except String J := do
 let table ← field value "complete_identity_table" >>= array
 smilesFirst table

def distinctSources (rows : List SourceRow) : List String :=
 rows.foldl (fun seen row => if seen.any (Text.equal row.sourceId) then seen else seen++[row.sourceId]) []
def forwardedKeys : List String := [
 "alternating_single_multiple_surface_count","connected_intervening_bond_surface_present",
 "delocalized_nonlocal_support_surface_present","complete_vibrational_table_rows",
 "uv_visible_declared_point_count","uv_visible_preserved_point_count","uv_visible_jcamp_link_present",
 "external_signed_control_inscription_preserved","preserved_v1_parser_overrun_count","v2_corrected_table_count",
 "complete_target_vector_hash","source_recapture_count","all_rows_preserved"]

def exactAnalysis (rows : List SourceRow) (primary : J) : Except String J := do
 if rows.length != 10 then throw "ORG-001 requires all ten external surfaces"
 let initial ← base
 let extended ← successor
 let conjugated ← byRole rows "complete-conjugated-bond-and-coordinate-surface"
 let separated ← byRole rows "complete-separated-double-bond-control-coordinate-surface"
 let molecule ← byRole rows "complete-conjugated-molecular-identity-surface"
 let spectrum ← byRole rows "complete-uv-visible-jcamp-point-surface"
 let distances ← rccValues conjugated
 let separatedDistances ← rccValues separated
 let smiles ← smilesValue molecule
 let postseal ← field primary "exact_postseal_analysis"
 let firstFields ← (forwardedKeys.take 3).mapM (fun key => do let value ← field postseal key; pure (key,value))
 let middleFields ← ((forwardedKeys.drop 3).take 3).mapM (fun key => do let value ← field postseal key; pure (key,value))
 let headers ← field spectrum "headers"
 let first ← field headers "FIRSTX"
 let last ← field headers "LASTX"
 let maximum ← field headers "MAXY"
 let lastFields ← (forwardedKeys.drop 6).mapM (fun key => do let value ← field postseal key; pure (key,value))
 return .object ([
 ("base_atom_count",.integer (.ofNat initial.atoms.length)),
 ("base_support_count",.integer (.ofNat initial.supportFibres.length)),
 ("successor_atom_count",.integer (.ofNat extended.atoms.length)),
 ("successor_support_count",.integer (.ofNat extended.supportFibres.length)),
 ("prior_incidence_prefix_preserved",.boolean successorWitness),
 ("repeated_fibre_rejected",.boolean repetitionWitness),
 ("incomplete_incidence_rejected",.boolean coverageWitness),
 ("duplicate_occurrence_rejected",.boolean identityWitness),
 ("complete_target_count",.integer (.ofNat rows.length)),
 ("complete_source_count",.integer (.ofNat (distinctSources rows).length)),
 ("development_observed_target_count",.integer (.ofNat (rows.filter (fun row => Text.equal row.custodyClass "family-development-observed")).length)),
 ("identity_only_unopened_target_count",.integer (.ofNat (rows.filter (fun row => Text.contains row.custodyClass "identity-only-unopened")).length)),
 ("conjugated_smiles_inscription",smiles),
 ("conjugated_rcc_external_strings",.array distances),
 ("separated_control_rcc_external_strings",.array separatedDistances),
 ("uv_visible_first_x_external_string",first),("uv_visible_last_x_external_string",last),
 ("uv_visible_max_y_external_string",maximum)] ++ firstFields ++ middleFields ++ lastFields)
#print axioms field
#print axioms array
#print axioms valueAt
#print axioms isText
#print axioms byRole
#print axioms rccValues
#print axioms smilesFirst
#print axioms smilesValue
#print axioms distinctSources
#print axioms forwardedKeys
#print axioms exactAnalysis
end SFT.Chemistry.ConjugatedSupportAnalysis
