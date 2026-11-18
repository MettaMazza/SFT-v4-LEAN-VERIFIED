import SFT.Chemistry.DihedralTorsion
import SFT.Chemistry.MolecularGraphEnumeration
namespace SFT.Chemistry.DihedralTorsionCycle
open SFT.Host SFT.Physics.CapabilityValues DihedralTorsion
structure Cycle where
 sectors : PositiveCount
 nodes : List Node
def checkPositions (sectors : PositiveCount) : Nat → List Node → Except String Unit
 | _,[] => .ok ()
 | index,node::rest => do
  if node.position.value != index+1 then throw "torsion path position is missing or displaced"
  let expected ← generatedCoordinate (.count node.position) (.count sectors)
  if !equalHeight node.coordinate expected then throw "torsion coordinate does not follow the generated cycle"
  checkPositions sectors (index+1) rest
def validateCycle (sectors : CountInput) (nodes : List Node) : Except String Cycle := do
 let n ← match sectors with
  | .other => throw "torsion cycle requires positive sector support"
  | .count n => pure n
 if nodes.length != n.value+1 then throw "torsion cycle must include every sector and one recurrence endpoint"
 let first ← match nodes with
  | [] => throw "one torsion cycle requires one retained ordered carrier"
  | first::_ => pure first
 if !(nodes.all fun node => equalCarrier node.carrier first.carrier) then
  throw "one torsion cycle requires one retained ordered carrier"
 checkPositions n 0 nodes
 match first.coordinate with
 | .emptyOne => pure ()
 | .ratio _ | .otherEmptyOne _ | .invalid => throw "torsion cycle must begin at structural EmptyOne"
 let last ← match nodes.getLast? with
  | none => throw "torsion cycle must terminate at the recurrent One"
  | some last => pure last
 match last.coordinate with
 | .ratio value =>
  if value.numerator.value != value.denominator.value then throw "torsion cycle must terminate at the recurrent One"
 | .emptyOne | .otherEmptyOne _ | .invalid => throw "torsion cycle must terminate at the recurrent One"
 if !equalHeight last.height first.height then throw "recurrent torsion endpoint must retain the initial state height"
 pure ⟨n,nodes⟩
def uniqueNodes (cycle : Cycle) := cycle.nodes.take (cycle.nodes.length-1)
inductive Direction where
 | backward | forward
def step (size cursor : Nat) : Direction → Nat
 | .backward => if cursor==0 then size-1 else cursor-1
 | .forward => (cursor+1)%size
def nodeAt (nodes : List Node) (index : Nat) : Except String Node :=
 match MolecularGraphEnumeration.atIndex nodes index with
 | none => .error "torsion path position is missing or displaced"
 | some node => .ok node
def extremum (nodes : List Node) (index : Nat) (barrier : Bool) : Except String Bool := do
 let node ← nodeAt nodes index
 let left ← nodeAt nodes (step nodes.length index .backward)
 let right ← nodeAt nodes (step nodes.length index .forward)
 if barrier then
  let a ← less left.height node.height
  if !a then pure false else less right.height node.height
 else
  let a ← less node.height left.height
  if !a then pure false else less node.height right.height
def localPositions (cycle : Cycle) (barrier : Bool) : Except String (List PositiveCount) := do
 let unique := uniqueNodes cycle
 let entries ← (unique.zipIdx).mapM fun (node,index) => do
  pure (if ← extremum unique index barrier then [node.position] else [])
 pure entries.flatten
def localConformerPositions (cycle : Cycle) := localPositions cycle false
def localBarrierPositions (cycle : Cycle) := localPositions cycle true
-- The source checks at most n successors in each direction, including wrap.
def nearestConformer (size : Nat) (conformers : List Nat) (direction : Direction) : Nat → Nat → Except String Nat
 | 0,_ => .error "torsional barrier has no adjacent conformer minimum"
 | fuel+1,cursor =>
  let next := step size cursor direction
  if conformers.any (fun position => position==next) then .ok next
  else nearestConformer size conformers direction fuel next
structure Transition where
 barrier : PositiveCount
 conformer : PositiveCount
 magnitude : Ratio
def barrierTransitions (cycle : Cycle) : Except String (List Transition) := do
 let unique := uniqueNodes cycle
 let conformers := (← localConformerPositions cycle).map (fun position => position.value-1)
 let barriers ← localBarrierPositions cycle
 let paths ← barriers.mapM fun barrier => do
  let index := barrier.value-1
  let high ← nodeAt unique index
  [Direction.backward,Direction.forward].mapM fun direction => do
   let cursor ← nearestConformer unique.length conformers direction unique.length index
   let low ← nodeAt unique cursor
   pure (⟨barrier,low.position,← barrierTake high.height low.height⟩ : Transition)
 pure paths.flatten

theorem uniqueNodesRetainOrder (cycle : Cycle) :
 uniqueNodes cycle = cycle.nodes.take (cycle.nodes.length-1) := rfl
theorem backwardWrap (size : Nat) : step size 0 .backward = size-1 := rfl
theorem noConformerAfterCompleteTraversal (size : Nat) (conformers : List Nat) (direction : Direction) (cursor : Nat) :
 nearestConformer size conformers direction 0 cursor = .error "torsional barrier has no adjacent conformer minimum" := rfl
theorem nearestStopsAtFirst (size : Nat) (conformers : List Nat) (direction : Direction)
 (fuel cursor : Nat) (present : conformers.any (fun position => position==step size cursor direction) = true) :
 nearestConformer size conformers direction (fuel+1) cursor = .ok (step size cursor direction) := by
 dsimp only [nearestConformer]
 rw [present]
 rfl
end SFT.Chemistry.DihedralTorsionCycle
