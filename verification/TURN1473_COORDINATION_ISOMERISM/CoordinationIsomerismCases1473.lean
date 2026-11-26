import SFT.Chemistry.CoordinationIsomerism
import Lean
open SFT.Chemistry.CoordinationIsomerism SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def arr (x : Lean.Json) : Except String (List Lean.Json) := do return (← x.getArr?).toList
def field (x : Lean.Json) (key : String) := x.getObjVal? key
def label (x : Lean.Json) : Except String HeldLabel := do
 heldLabel (← x.getObjValAs? String "family") (← x.getObjValAs? String "label")
def cell (x : Lean.Json) : Except String Cell :=
 match x.getObjValAs? String "empty" with
 | .ok s => .ok (.empty s)
 | .error _ => do return .held (← label x)
def readForm (x : Lean.Json) : Except String Form := do
 let composition ← (← field x "composition_labels" >>= arr).mapM label
 let attachment ← (← field x "attachment_labels" >>= arr).mapM label
 let orientation ← (← field x "orientation_words" >>= arr).mapM fun row => do (← arr row).mapM cell
 let edges ← (← field x "adjacency_pairs" >>= arr).mapM fun row => do
  let a ← row.getArr?
  return (← count (← a[0]!.getNat?),← count (← a[1]!.getNat?))
 construct composition attachment orientation edges
def jLabel (x : HeldLabel) : J := .object [("family",.text x.family),("label",.text x.label)]
def jCell : Cell → J
 | .empty s => .object [("empty",.text s)]
 | .held h => jLabel h
def jNat (n : Nat) : J := .integer (.ofNat n)
def jForm (f : Form) : J := .object [
 ("composition_labels",.array (f.composition.map jLabel)),
 ("attachment_labels",.array (f.attachment.map jLabel)),
 ("orientation_words",.array (f.orientation.map fun xs => .array (xs.map jCell))),
 ("adjacency_pairs",.array (f.adjacency.map fun (a,b) => .array [jNat a.value,jNat b.value]))]
def jSignature (s : Signature) : J := .array [
 .array (s.vertices.map fun v => .array [.text v.composition,.text v.attachment,.array (v.orientation.map SFT.Host.Canonical.Value.text)]),
 .array (s.edges.map fun (a,b) => .array [jNat a,jNat b])]
def jRecord (r : Record) : J := .object [
 ("positive_occurrence_count",jNat r.positiveOccurrenceCount.value),
 ("same_complete_composition",.boolean r.sameCompleteComposition),
 ("exact_equivalence",.boolean r.exactEquivalence),
 ("native_distinction_class",jLabel r.nativeDistinctionClass),
 ("left_signature",jSignature r.leftSignature),("right_signature",jSignature r.rightSignature)]
def runCase (row : Lean.Json) : Except String J := do
 let form ← field row "form" >>= readForm
 let op ← row.getObjValAs? String "op"
 if op=="construct" then return jForm form
 if op=="canonical" then return jSignature (← canonical form ((row.getObjValAs? Bool "orientation").toOption.getD true))
 if op=="mirror" then return jForm (← mirror form)
 if op=="forced" then return jRecord (← forced form (← field row "right" >>= readForm))
 if op=="extend" then
  let c ← field row "composition" >>= label
  let a ← field row "attachment" >>= label
  let word ← (← field row "word" >>= arr).mapM cell
  let prior : Extension ← (match ← field row "prior" with
   | .null => pure Extension.empty
   | .arr xs => do return Extension.endpoints (← xs.toList.mapM fun x => do count (← x.getNat?))
   | .bool _ | .num _ | .str _ | .obj _ => throw "bad prior")
  return jForm (← extend form c a word prior)
 throw "unknown operation"
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/coordisomer1473_core_cases.json"
 let cases ← IO.ofExcept (Lean.Json.parse raw >>= arr)
 let output := cases.map fun c => match runCase c with
  | .ok x => SFT.Host.Canonical.Value.object [("ok",x)]
  | .error e => SFT.Host.Canonical.Value.object [("error",.text e)]
 IO.println (SFT.Host.Canonical.render (.array output))
