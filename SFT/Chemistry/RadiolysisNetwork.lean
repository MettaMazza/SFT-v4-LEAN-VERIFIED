import SFT.Chemistry.FissionProductDistribution
import SFT.Chemistry.MulticentreSupport
namespace SFT.Chemistry.RadiolysisNetwork
open SFT.Host SFT.Physics.CapabilityValues
open IsotopeExchange (sameLabel)
open FissionProductDistribution (normalized)
structure Channel where
 medium : HeldLabel
 reactant : HeldLabel
 product : HeldLabel
 channel : HeldLabel
 productEvents : PositiveCount
 depositedResource : PositiveCount

def construct (medium reactant product channel : HeldLabel) (events resource : PositiveCount) : Except String Channel := do
 if !(Text.equal medium.family "radiolysis-medium" && Text.equal reactant.family "chemical-species" &&
  Text.equal product.family "chemical-species" && Text.equal channel.family "reaction-channel") then
  throw "complete radiolysis channel required"
 if sameLabel reactant product then throw "reactant and product must be distinct"
 return ⟨medium,reactant,product,channel,events,resource⟩

def yieldRatio (row : Channel) : Nat × Nat := normalized row.productEvents.value row.depositedResource.value
def total (rows : List Channel) : Nat := rows.foldl (fun n r => n+r.productEvents.value) 0
abbrev Reading := HeldLabel × HeldLabel × HeldLabel × (Nat × Nat) × (Nat × Nat)
inductive Network where
 | emptyOne
 | rows (values : List Reading)
def readings (rows : List Channel) : List Reading := rows.map fun r =>
 (r.reactant,r.product,r.channel,yieldRatio r,normalized r.productEvents.value (total rows))
def oneMedium (rows : List Channel) : Bool := match rows with
 | [] => false
 | first::rest => rest.all (fun row => sameLabel row.medium first.medium)
def distinctChannels (rows : List Channel) : Bool := MulticentreSupport.distinct (rows.map Channel.channel)
def network (rows : List Channel) : Except String Network :=
 if rows.isEmpty then .ok .emptyOne else
 if !oneMedium rows || !distinctChannels rows then
  .error "one medium and distinct complete channels required"
 else .ok (.rows (readings rows))

def row (reactant product channel : String) (events : Nat) : Except String Channel := do
 construct (← heldLabel "radiolysis-medium" "water") (← heldLabel "chemical-species" reactant)
  (← heldLabel "chemical-species" product) (← heldLabel "reaction-channel" channel) (← count events) (← count 10)
def originalRows : Except String (List Channel) := do
 return [← row "water" "hydroxyl" "ionization" 3,← row "water" "hydrogen" "dissociation" 2]
def handoffWitness : Bool := match originalRows with
 | .error _ => false
 | .ok rows => match rows with | [] => false | first::_ => first.depositedResource.value==10
def identityWitness : Bool := match originalRows with
 | .error _ => false
 | .ok rows => match rows with
  | [] => false
  | first::_ => Text.equal first.medium.label "water" && !sameLabel first.reactant first.product
def networkWitness : Bool := match originalRows with
 | .error _ => false
 | .ok rows => (rows.map Channel.channel).length==2 && distinctChannels rows
def eventsWitness : Bool := match originalRows with
 | .error _ => false
 | .ok rows => (rows.map (fun r => r.productEvents.value)) == [3,2]
def yieldWitness : Bool := match originalRows with
 | .error _ => false
 | .ok rows => match rows with | [] => false | first::_ => yieldRatio first == (3,10)
def partitionWitness : Bool := match (do network (← originalRows)) with
 | .error _ => false
 | .ok .emptyOne => false
 | .ok (.rows values) =>
  let sum := values.foldl (fun (a : Nat × Nat) r =>
   let b := r.2.2.2.2
   normalized (a.1*b.2+b.1*a.2) (a.2*b.2)) (0,1)
  sum == (1,1)
def closureWitness : Bool := match network [] with
 | .ok .emptyOne => true
 | .ok (.rows _) | .error _ => false
def extensionWitness : Bool := match (do
 let rows ← originalRows
 network (rows++[← row "water" "peroxide" "recombination" 1])) with
 | .error _ => false
 | .ok .emptyOne => false
 | .ok (.rows rows) => rows.length==3

theorem handoffWitnessPassed : handoffWitness = true := rfl
theorem identityWitnessPassed : identityWitness = true := rfl
theorem networkWitnessPassed : networkWitness = true := rfl
theorem eventsWitnessPassed : eventsWitness = true := rfl
theorem yieldWitnessPassed : yieldWitness = true := rfl
theorem partitionWitnessPassed : partitionWitness = true := rfl
theorem closureWitnessPassed : closureWitness = true := rfl
theorem extensionWitnessPassed : extensionWitness = true := rfl

theorem acceptedNetworkExact (rows : List Channel) (out : List Reading)
 (accepted : network rows = .ok (.rows out)) : out = readings rows := by
 unfold network at accepted
 cases empty : rows.isEmpty with
 | true =>
  rw [empty] at accepted
  exact (congrArg (fun (x : Except String Network) => match x with
   | .ok (.rows values) => values
   | .ok .emptyOne | .error _ => readings rows) accepted).symm
 | false =>
  rw [empty] at accepted
  cases guard : (!oneMedium rows || !distinctChannels rows) with
  | true =>
   rw [guard] at accepted
   exact (congrArg (fun (x : Except String Network) => match x with
    | .ok (.rows values) => values
    | .ok .emptyOne | .error _ => readings rows) accepted).symm
  | false =>
   rw [guard] at accepted
   exact (congrArg (fun (x : Except String Network) => match x with
    | .ok (.rows values) => values
    | .ok .emptyOne | .error _ => readings rows) accepted).symm
end SFT.Chemistry.RadiolysisNetwork
