import SFT.Consciousness.StructuralModel
import Lean
open SFT.Consciousness.StructuralModel
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations
open SFT.Host SFT.Host.Canonical
namespace ConsciousnessCases
def partValue (p : Part) : Value := .array [.integer p.numerator,.integer p.denominator]
def runCase (j : Lean.Json) : Except String Value := do
 let source ← fromPair (← j.getObjValAs? Nat "n") (← j.getObjValAs? Nat "d")
 let retain ← j.getObjValAs? Bool "retain"
 let act ← observe source retain
 let (lower,upper) := preimageFibre act.image
 pure (.object [("source",partValue act.source),("image",partValue act.image),
  ("held",match act.heldFibre with | none=>.null | some l=>.array [.text l.family,.text l.label]),
  ("reversible",.boolean (reversibleFromRecord act)),("preimages",.array [partValue lower,partValue upper])])
end ConsciousnessCases
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/consciousness1374_core_inputs.json"
 let rows ← IO.ofExcept (Lean.Json.parse raw >>= Lean.Json.getArr?)
 for row in rows do
  let result ← IO.ofExcept (ConsciousnessCases.runCase row)
  IO.println (Canonical.render result)
