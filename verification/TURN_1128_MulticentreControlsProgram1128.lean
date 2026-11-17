import SFT.Chemistry.MulticentreControls
import Lean
open SFT.Chemistry SFT.Physics
abbrev CJ := SFT.Host.Canonical.Value
def convert : Nat → Lean.Json → Except String CJ
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
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/multicentretargets1128_output.json"
 let input ← IO.ofExcept (Lean.Json.parse raw >>= Lean.Json.getArr?)
 let targets ← input.toList.mapM fun row => IO.ofExcept (do
  let id ← text row "target_id"
  let fields ← (← row.getObj?).toList.mapM fun (k,v) => do return (k,← convert (raw.utf8ByteSize+1) v)
  MulticentreTargets.resolve ⟨id,fields.filter (fun p => !(SFT.Host.Text.equal p.1 "magnitude" || SFT.Host.Text.equal p.1 "target_value"))⟩)
 let predicted ← IO.ofExcept MulticentreComparison.expected
 IO.ofExcept (MulticentreComparison.validatePrediction predicted)
 let comparisons ← IO.ofExcept (targets.mapM (MulticentreComparison.compare predicted))
 let counts ← IO.ofExcept (MulticentreControls.counts comparisons)
 let hashRaw ← IO.FS.readFile "work/multicentre1128_control_hashes.json"
 let hashes ← IO.ofExcept (Lean.Json.parse hashRaw)
 let originalHash ← IO.ofExcept (text hashes "original")
 let changedHash ← IO.ofExcept (text hashes "changed")
 let adverse ← IO.ofExcept (MulticentreControls.adverse targets comparisons counts originalHash changedHash)
 IO.println (SFT.Host.Canonical.render (.object [("comparisons",.array comparisons),
  ("counts",.object (counts.map (fun (k,n) => (k,.integer (.ofNat n))))),
  ("adverse",.object (adverse.map (fun (k,b) => (k,.boolean b))))]))
