import SFT.Chemistry.AdditionTransform
import SFT.Host.Canonical
import Lean
open SFT.Chemistry.AdditionTransform SFT.Chemistry.AdditionGraph
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
def countValue (n : PositiveCount) : J := .object [("value",.integer (Int.ofNat n.value))]
def separationValue : Separation → J
 | .emptyOne => .object [("identity",.text "empty-One")]
 | .count n => countValue n
 | .otherEmptyOne _ => .object [("identity",.text "empty-One")]
def resultValue (r : Result) : J := .object [
 ("reaction_identity",labelValue r.reactionIdentity),("source",value r.source),("terminal",value r.terminal),
 ("source_component_count",countValue r.sourceComponentCount),
 ("new_adjacencies",.array (r.newAdjacencies.map fun e => .array ((sortLabels [e.1,e.2]).map labelValue))),
 ("new_bond_count",countValue r.newBondCount),
 ("reduced_multiplicity_supports",.array (r.reducedMultiplicitySupports.map labelValue)),
 ("reduced_layer_count",countValue r.reducedLayerCount),
 ("component_site_classes",.array (r.componentSiteClasses.map fun c => .object [
 ("source_component_ordinal",countValue c.sourceComponentOrdinal),("label",labelValue c.label),("separation",separationValue c.separation)])),
 ("relocated_supports",.array (r.relocatedSupports.map labelValue))]
def runCase (x : Lean.Json) : Except String Result := do
 transform (← field x "identity" >>= held) (← field x "source" >>= readState) (← field x "terminal" >>= readState)
def main : IO Unit := do
 let raw ← IO.FS.readFile "work/addition1501_transform_input.json"
 let input ← IO.ofExcept (Lean.Json.parse raw >>= rows)
 let output := input.map fun x => match runCase x with
  | .error e => SFT.Host.Canonical.Value.object [("error",.text e)]
  | .ok r => SFT.Host.Canonical.Value.object [("value",resultValue r)]
 IO.println (SFT.Host.Canonical.render (.array output))
