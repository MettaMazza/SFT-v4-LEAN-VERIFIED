import SFT.Chemistry.StateEnergyValidation
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
def target (j : Lean.Json) : Except String StateEnergyTargets.Target := do
 return ⟨← text j "target_id",← text j "state_record",← text j "energy_inscription",
  ← j.getObjValAs? Int "exact_value_numerator",← j.getObjValAs? Int "exact_value_denominator",
  ← text j "source_quality",← convert (j.compress.utf8ByteSize+1) j⟩
def main (args : List String) : IO Unit := do
 let body ← IO.FS.readFile args[0]!
 let j ← IO.ofExcept (Lean.Json.parse body)
 let identities ← IO.ofExcept (do (← items j "identities").mapM orbitalIdentity)
 let targets ← IO.ofExcept (do (← items j "targets").mapM target)
 let snapshots ← IO.ofExcept (do (← items j "snapshots").mapM snapshot)
 let result ← IO.ofExcept (do
  StateEnergyValidation.validate (← text j "identity_hash") (← text j "target_hash")
   (.text (← text j "identity_schema")) (.text (← text j "target_schema")) identities targets snapshots
   (← text j "derivation_seal") (← text j "host") (← text j "implementation")
   (← text j "first_hash") (← text j "changed_hash")
   (← protectedSnapshot (← field j "before")) (← protectedSnapshot (← field j "after")))
 IO.println (SFT.Host.Canonical.render result)
