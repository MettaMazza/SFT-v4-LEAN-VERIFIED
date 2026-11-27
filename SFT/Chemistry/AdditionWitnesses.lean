import SFT.Chemistry.AdditionTransform
namespace SFT.Chemistry.AdditionWitnesses
open SFT.Host SFT.Physics.CapabilityValues AdditionCarrier AdditionGraph AdditionTransform
open DihedralTorsion (equalLabel)
local infixr:65 " +++ " => SFT.Host.Text.append
def makeState (label : String) (atoms : List HeldLabel) (bonds : List Bond) (free : List FreeSupport := []) : Except String State := do
 state (← heldLabel "addition-state" label) atoms bonds free
def simpleExample (site : String) (reducedLayers : Nat := 1) : Except String Result := do
 let left ← atom (site +++ "-left"); let middle ← atom (site +++ "-middle"); let right ← atom (site +++ "-right")
 let enteringLeft ← atom (site +++ "-entering-left"); let enteringRight ← atom (site +++ "-entering-right")
 let atoms := [left,middle,right,enteringLeft,enteringRight]
 let baseLeft ← support (site +++ "-base-left"); let baseRight ← support (site +++ "-base-right")
 let layers ← (List.range reducedLayers).mapM fun n => support (site +++ "-layer-" +++ toString (n+1))
 let addend ← support (site +++ "-addend")
 let sourceBonds := [← bond left middle baseLeft, ← bond middle right baseRight] ++
  (← layers.mapM fun h => bond left middle h) ++ [← bond enteringLeft enteringRight addend]
 let (attachmentLeft,attachmentRight) ←
  if Text.equal site "same" then pure (left,left)
  else if Text.equal site "adjacent" then pure (left,middle)
  else if Text.equal site "nonadjacent" then pure (left,right)
  else throw "unknown generated site witness"
 let first ← match layers with
  | [] => throw "tuple index out of range"
  | h::_ => pure h
 let terminalBonds := [← bond left middle baseLeft, ← bond middle right baseRight,
  ← bond attachmentLeft enteringLeft first, ← bond attachmentRight enteringRight addend]
 let terminalFree ← layers.tail.mapM fun h => freeSupport right h
 transform (← heldLabel "registered-reaction" (site +++ "-complete-addition"))
  (← makeState (site +++ "-source") atoms sourceBonds)
  (← makeState (site +++ "-terminal") atoms terminalBonds terminalFree)
def cycloadditionExample : Except String Result := do
 let a ← atom "cyclo-a"; let b ← atom "cyclo-b"; let c ← atom "cyclo-c"
 let d ← atom "cyclo-d"; let e ← atom "cyclo-e"; let f ← atom "cyclo-f"
 let baseAB ← support "cyclo-base-ab"; let baseBC ← support "cyclo-base-bc"
 let baseCD ← support "cyclo-base-cd"; let baseEF ← support "cyclo-base-ef"
 let layerAB ← support "cyclo-layer-ab"; let layerCD ← support "cyclo-layer-cd"; let layerEF ← support "cyclo-layer-ef"
 let source ← makeState "cyclo-source" [a,b,c,d,e,f] [← bond a b baseAB,← bond a b layerAB,
  ← bond b c baseBC,← bond c d baseCD,← bond c d layerCD,← bond e f baseEF,← bond e f layerEF]
 let terminal ← makeState "cyclo-terminal" source.atoms [← bond a b baseAB,← bond b c baseBC,← bond b c layerAB,
  ← bond c d baseCD,← bond e f baseEF,← bond a e layerCD,← bond d f layerEF]
 transform (← heldLabel "registered-reaction" "complete-cycloaddition") source terminal
def witnesses : Except String (List Bool) := do
 let same ← simpleExample "same"
 let adjacent ← simpleExample "adjacent"
 let nonadjacent ← simpleExample "nonadjacent"
 let multiple ← simpleExample "adjacent" 3
 let cyclo ← cycloadditionExample
 let noReductionRejected := match transform adjacent.reactionIdentity adjacent.source adjacent.source with
  | .error _ => true
  | .ok _ => false
 let anchor ← atom "nonadjacent-middle"
 let successor ← extend nonadjacent anchor (← atom "complete-successor") (← support "complete-successor")
 let classes := ([same,adjacent,nonadjacent].flatMap fun r => r.componentSiteClasses).map fun row => row.label.label
 return [classes.all (fun c => ["same-site","adjacent-sites","non-adjacent-sites"].any (Text.equal c)) &&
   ["same-site","adjacent-sites","non-adjacent-sites"].all (fun c => classes.any (Text.equal c)),
  multiple.reducedLayerCount.value == 3,
  sameLabels same.source.atoms same.terminal.atoms,
  sameSupport (supports multiple.source) (supports multiple.terminal),
  [same,adjacent,nonadjacent,multiple,cyclo].all (fun r => r.newBondCount.value == 2),
  cyclo.newBondCount.value == 2 && cyclo.reducedLayerCount.value == 3 && cyclo.relocatedSupports.length == 3,
  cyclo.componentSiteClasses.length == 2,noReductionRejected,successor]
end SFT.Chemistry.AdditionWitnesses
