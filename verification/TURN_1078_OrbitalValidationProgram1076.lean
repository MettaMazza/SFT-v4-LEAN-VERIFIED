import SFT.Chemistry.OrbitalSupportValidation
import SFT.Chemistry.OrbitalSupportTargets
import SFT.Chemistry.ElectronSpinValidation
import Lean
open SFT.Chemistry SFT.Physics
def convert : Nat → Lean.Json → Except String SFT.Host.Canonical.Value
 | 0,_ => .error "JSON nesting exceeds input byte count"
 | n+1,j => match j with
   | .null => .ok .null
   | .bool b => .ok (.boolean b)
   | .num _ => do return .integer (← j.getInt?)
   | .str s => .ok (.text s)
   | .arr xs => do return .array (← xs.toList.mapM (convert n))
   | .obj fs => do return .object (← fs.toList.mapM fun (k,v) => do return (k,← convert n v))
def field (j : Lean.Json) (name : String) := j.getObjVal? name
def text (j : Lean.Json) (name : String) := j.getObjValAs? String name
def items (j : Lean.Json) (name : String) : Except String (List Lean.Json) := do
 return (← (← field j name).getArr?).toList
def population (j : Lean.Json) : Except String ElectronSpinRegistry.PopulationFields := do
 return ⟨← text j "element_symbol",← j.getObjValAs? Int "atomic_number",← j.getObjValAs? Int "occurrence_count"⟩
def inputRow (j : Lean.Json) : Except String ElectronSpinRegistry.InputFields := do
 let charge : Option SFT.Host.Canonical.Value ← match field j "charge_count" with
  | .error _ => .ok none
  | .ok v => (convert (v.compress.utf8ByteSize+1) v).map some
 return ⟨← text j "row_id",← text j "molecular_formula",← text j "charge_action",charge,
  ← (← items j "nuclear_composition").mapM population⟩
def targetRow (j : Lean.Json) : Except String ElectronSpinTargets.TargetFields := do
 return ⟨← text j "row_id",⟨← text j "snapshot_hash",← text j "ground_state_term",← j.getObjValAs? Nat "measured_multiplicity"⟩⟩
def event (j : Lean.Json) : Except String ElectronSpinHtml.Event := do
 let xs ← j.getArr?
 let kind ← xs[0]!.getStr?
 let value ← xs[1]!.getStr?
 if kind == "data" then return .data value
 if kind == "end" then return .endTag value
 let attrs ← xs[2]!.getArr?
 let pairs ← attrs.toList.mapM fun a => do
  let pair ← a.getArr?
  let key ← pair[0]!.getStr?
  let value := match pair[1]! with | .null => none | _ => pair[1]!.getStr?.toOption
  return (key,value)
 return .startTag value pairs
def snapshot (j : Lean.Json) : Except String ElectronSpinTargets.Snapshot := do
 return ⟨← text j "path",← text j "hash",← (← items j "events").mapM event⟩
def protectedSnapshot (j : Lean.Json) : Except String HostilePackage.Snapshot := do
 let pairs ← (← items j "file_hashes").mapM fun row => do
  let a ← row.getArr?
  return (← a[0]!.getStr?,← a[1]!.getStr?)
 return ⟨← text j "root_identity",pairs,← text j "snapshot_hash"⟩
def orbitalIdentity (j : Lean.Json) : Except String OrbitalSupportTargets.Identity := do
 return ⟨← text j "target_id",← text j "species_row_id",← text j "snapshot_path",← text j "snapshot_hash",← j.getObjValAs? Int "state_row_ordinal"⟩
def orbitalTarget (j : Lean.Json) : Except String OrbitalSupportTargets.Target := do
 let cells ← (← items j "spectroscopic_cells").mapM Lean.Json.getStr?
 let terms ← (← items j "term_assignments").mapM fun row => do
  return (← row.getObjValAs? Int "measured_multiplicity",← text row "conventional_support_symbol")
 let configs ← (← items j "configuration_assignments").mapM fun row => do
  let occupancy ← match text row "occupancy_record" with
   | .ok "implicit-single-occurrence" => .ok (1 : Int)
   | .ok s => match s.toInt? with | some n => .ok n | none => .error "invalid occupancy integer"
   | .error _ => row.getObjValAs? Int "occupancy_record"
  return (← row.getObjValAs? Int "positive_radial_recurrence",← text row "source_family_label",← text row "conventional_support_symbol",occupancy)
 return ⟨← text j "target_id",cells,← text j "state_record",terms,configs⟩
def resolvedValue (row : OrbitalSupportTargets.Resolved) : SFT.Host.Canonical.Value := .object [
 ("target_id",.text row.targetId),("species_row_id",.text row.speciesRowId),("state_record",.text row.stateRecord),
 ("terms",.array (row.terms.map fun t => .array [.integer (.ofNat t.multiplicity),.text t.symbol])),
 ("configs",.array (row.configurations.map fun c => .array [.integer (.ofNat c.radial),.text c.family,.text c.symbol,.integer (.ofNat c.occupancy)])),
 ("snapshot_hash",.text row.snapshotHash),("target_value",CapabilityValues.canonical row.targetValue)]
def main (args : List String) : IO Unit := do
 let body ← IO.FS.readFile args[0]!
 let j ← IO.ofExcept (Lean.Json.parse body)
 let inputs ← IO.ofExcept (do (← items j "inputs").mapM inputRow)
 let identities ← IO.ofExcept (do (← items j "identities").mapM orbitalIdentity)
 let targets ← IO.ofExcept (do (← items j "targets").mapM orbitalTarget)
 let snapshots ← IO.ofExcept (do (← items j "snapshots").mapM snapshot)
 let before ← IO.ofExcept (do protectedSnapshot (← field j "before"))
 let after ← IO.ofExcept (do protectedSnapshot (← field j "after"))
 let inputSchema ← IO.ofExcept (do convert (body.utf8ByteSize+1) (← field j "input_schema"))
 let result ← IO.ofExcept (do
  OrbitalSupportValidation.validate (← text j "input_hash") (some inputSchema) inputs
   (← text j "identity_hash") (← text j "target_hash") identities targets snapshots
   (← text j "changed_first_hash") (← text j "derivation_seal")
   (← text j "host") (← text j "implementation") before after)
 IO.println (SFT.Host.Canonical.render result.value)
