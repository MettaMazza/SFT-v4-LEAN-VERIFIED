import SFT.Chemistry.ElectronCountSpin
namespace SFT.Chemistry.StateEnergyOrder
open SFT.Host SFT.Physics.CapabilityValues
abbrev OrderPosition := ElectronCountSpin.CountOrEmpty
structure OrderedMolecularState where
 molecularCarrier : HeldLabel
 stateIdentity : HeldLabel
 orderPosition : OrderPosition
 supportIdentity : HeldLabel
structure ExactFiniteStateOrder where
 molecularCarrier : HeldLabel
 states : List OrderedMolecularState

def validState (row : OrderedMolecularState) : Except String OrderedMolecularState := do
 if !Text.equal row.molecularCarrier.family "molecular-carrier" then
  throw "ordered state requires one molecular carrier"
 if !Text.equal row.stateIdentity.family "molecular-electronic-state" then
  throw "ordered state requires retained electronic-state identity"
 if !Text.equal row.supportIdentity.family "molecular-support" then
  throw "state order must retain its complete molecular support"
 pure row

def isGround (position : OrderPosition) : Bool :=
 match position with
 | .emptyOne identity => Text.equal identity "empty-One"
 | .count _ => false

def positivePositions : List OrderedMolecularState → List Nat
 | [] => []
 | row::rest => match row.orderPosition with
   | .emptyOne _ => positivePositions rest
   | .count n => n.value :: positivePositions rest

def insertPosition (n : Nat) : List Nat → List Nat
 | [] => [n]
 | a::rest => if n ≤ a then n::a::rest else a::insertPosition n rest

def sortPositions : List Nat → List Nat
 | [] => []
 | n::rest => insertPosition n (sortPositions rest)

def validOrder (order : ExactFiniteStateOrder) : Except String ExactFiniteStateOrder := do
 if order.states.isEmpty || order.states.any (fun row => !ElectronCountSpin.sameLabel row.molecularCarrier order.molecularCarrier) then
  throw "finite state order requires positive support on one molecule"
 if !ElectronCountSpin.distinctLabels (order.states.map OrderedMolecularState.stateIdentity) then
  throw "state order cannot duplicate a state identity"
 if (order.states.filter (fun row => isGround row.orderPosition)).length != 1 then
  throw "finite molecular state order requires one structural least state"
 if sortPositions (positivePositions order.states) != (List.range (order.states.length-1)).map (fun n => n+1) then
  throw "excited states must exhaust the positive successor positions exactly once"
 pure order

def groundState (order : ExactFiniteStateOrder) : Except String OrderedMolecularState :=
 match order.states.find? (fun row => isGround row.orderPosition) with
 | some row => .ok row
 | none => .error "StopIteration"

def buildRows (carrier : HeldLabel) : Nat → List String → Except String (List OrderedMolecularState)
 | _,[] => .ok []
 | index,label::rest => do
  let state ← heldLabel "molecular-electronic-state" label
  let position ← if index == 0 then pure (.emptyOne "empty-One") else do
   let n ← count index
   pure (.count n)
  let support ← heldLabel "molecular-support" (Text.append label "-support")
  let row ← validState ⟨carrier,state,position,support⟩
  let rows ← buildRows carrier (index+1) rest
  pure (row::rows)

def buildExactStateOrder (molecularLabel : String) (labels : List String) : Except String ExactFiniteStateOrder := do
 if labels.isEmpty then throw "state order requires positive finite support"
 let carrier ← heldLabel "molecular-carrier" molecularLabel
 let rows ← buildRows carrier 0 labels
 validOrder ⟨carrier,rows⟩

def positionValue : OrderPosition → Except String Nat
 | .count n => .ok n.value
 | .emptyOne _ => .error "'EmptyOne' object has no attribute 'value'"

def precedes (left right : OrderedMolecularState) : Except String Bool := do
 if !ElectronCountSpin.sameLabel left.molecularCarrier right.molecularCarrier then
  throw "state comparison requires the same molecular carrier"
 if isGround left.orderPosition then return !isGround right.orderPosition
 if isGround right.orderPosition then return false
 let a ← positionValue left.orderPosition
 let b ← positionValue right.orderPosition
 pure (a < b)

#print axioms validState
#print axioms isGround
#print axioms positivePositions
#print axioms insertPosition
#print axioms sortPositions
#print axioms validOrder
#print axioms groundState
#print axioms buildRows
#print axioms buildExactStateOrder
#print axioms positionValue
#print axioms precedes
end SFT.Chemistry.StateEnergyOrder
