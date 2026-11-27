import SFT.Chemistry.AdditionCarrier
import SFT.Host.Canonical
import Lean
open SFT.Chemistry.AdditionCarrier SFT.Physics.CapabilityValues
abbrev J := SFT.Host.Canonical.Value
def field (x : Lean.Json) (key : String) := x.getObjVal? key
def rows (x : Lean.Json) : Except String (List Lean.Json) := do return (← x.getArr?).toList
def held (x : Lean.Json) : Except String HeldLabel := do
 heldLabel (← (← field x "family").getStr?) (← (← field x "label").getStr?)
def readState (x : Lean.Json) : Except String State := do
 let identity ← field x "identity" >>= held
 let atoms ← (← field x "atoms" >>= rows).mapM held
 let bonds ← (← field x "bonds" >>= rows).mapM fun b => do
  bond (← field b "left" >>= held) (← field b "right" >>= held) (← field b "held_support" >>= held)
 let free ← (← field x "free_supports" >>= rows).mapM fun f => do
  freeSupport (← field f "owner" >>= held) (← field f "held_support" >>= held)
 state identity atoms bonds free
def labelValue (x : HeldLabel) : J := .object [("family",.text x.family),("label",.text x.label)]
def value (s : State) : J := .object [
 ("identity",labelValue s.identity),("atoms",.array (s.atoms.map labelValue)),
 ("bonds",.array (s.bonds.map fun b => .object [("left",labelValue b.left),("right",labelValue b.right),("held_support",labelValue b.heldSupport)])),
 ("free_supports",.array (s.freeSupports.map fun f => .object [("owner",labelValue f.owner),("held_support",labelValue f.heldSupport)]))]
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/addition1499_carrier_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw >>= rows)
 let output := input.map fun x => match readState x with
  | .error e => SFT.Host.Canonical.Value.object [("error",.text e)]
  | .ok s => SFT.Host.Canonical.Value.object [("value",value s)]
 IO.println (SFT.Host.Canonical.render (.array output))
