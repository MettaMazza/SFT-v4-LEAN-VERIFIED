import SFT.Chemistry.InternalEnergyComposition
namespace SFT.Chemistry.FreeEnergyEquivalentDirection
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion SFT.Foundation.ExactOperations
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- Exact original free_energy_equivalent_direction_law_v1.py, pinned 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
inductive CountInput where
 | count (value : PositiveCount)
 | other
structure ReactionPathAccount where
 pathIdentity : HeldLabel
 reactionBoundary : HeldLabel
 conditionIdentity : HeldLabel
 retainedEnergyRequirement : Ratio
 closedDistinctionCount : PositiveCount
def accountField (input : LabelInput) (family : String) : Except String HeldLabel :=
 match input with
 | .held label => if Text.equal label.family family then .ok label
   else .error "reaction path account lost a held identity"
 | .other => .error "reaction path account lost a held identity"
def makeAccount (path boundary condition : LabelInput) (energy : Height) (distinctions : CountInput) : Except String ReactionPathAccount := do
 let path ← accountField path "reaction-path"
 let boundary ← accountField boundary "reaction-boundary"
 let condition ← accountField condition "reaction-condition"
 if !(Text.equal path.label "forward-path" || Text.equal path.label "reverse-path") then
  throw "reaction account requires forward or reverse path"
 let energy ← match energy with
  | .ratio value => pure value
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "reaction account requires exact positive energy and distinction support"
 let distinctions ← match distinctions with
  | .count value => pure value
  | .other => throw "reaction account requires exact positive energy and distinction support"
 pure ⟨path,boundary,condition,energy,distinctions⟩
inductive CountSeparation where
 | count (value : PositiveCount)
 | emptyOne
structure ReactionDirectionResult where
 orientation : HeldLabel
 energySeparation : Height
 distinctionSeparation : CountSeparation
inductive AccountInput where
 | account (value : ReactionPathAccount)
 | other
def forwardFavoured : HeldLabel := ⟨"reaction-direction","forward-favoured",rfl,rfl⟩
def reverseFavoured : HeldLabel := ⟨"reaction-direction","reverse-favoured",rfl,rfl⟩
def equilibrium : HeldLabel := ⟨"reaction-direction","equilibrium",rfl,rfl⟩
def freeEnergyEquivalentDirection (forward reverse : AccountInput) : Except String ReactionDirectionResult := do
 let (forward,reverse) ← match forward,reverse with
  | .account a,.account b => pure (a,b)
  | .other,.other | .other,.account _ | .account _,.other => throw "direction requires complete forward/reverse accounts"
 if !Text.equal forward.pathIdentity.label "forward-path" || !Text.equal reverse.pathIdentity.label "reverse-path" then
  throw "direction accounts are not ordered forward then reverse"
 if !equalLabel forward.reactionBoundary reverse.reactionBoundary || !equalLabel forward.conditionIdentity reverse.conditionIdentity then
  throw "direction comparison changed reaction boundary or conditions"
 let a := fraction forward.retainedEnergyRequirement
 let b := fraction reverse.retainedEnergyRequirement
 let ae := a.numerator*b.denominator
 let be := b.numerator*a.denominator
 let ad := forward.closedDistinctionCount.value
 let bd := reverse.closedDistinctionCount.value
 if ae==be && ad==bd then pure ⟨equilibrium,.emptyOne,.emptyOne⟩
 else
  let direction ← if ae≤be && ad≤bd && (ae<be || ad<bd) then pure forwardFavoured
   else if be≤ae && bd≤ad && (be<ae || bd<ad) then pure reverseFavoured
   else throw "incomparable path accounts do not force a reaction direction"
  let energy ← if ae==be then pure Height.emptyOne
   else if rising : a.numerator*b.denominator<b.numerator*a.denominator then
    pure (.ratio (rawRatio (LeptonTake.heldRemainder b a rising)))
   else if falling : b.numerator*a.denominator<a.numerator*b.denominator then
    pure (.ratio (rawRatio (LeptonTake.heldRemainder a b falling)))
   else throw "an SFT count must be a positive counted value"
  let distinction : CountSeparation := if ad==bd then .emptyOne
   else if rising : ad<bd then .count ⟨bd-ad,SFT.Foundation.ExactCast.subtractPositive bd ad rising⟩
   else if falling : bd<ad then .count ⟨ad-bd,SFT.Foundation.ExactCast.subtractPositive ad bd falling⟩
   else .emptyOne
  pure ⟨direction,energy,distinction⟩
def commonSuccessorPreservesDirection (forward reverse : AccountInput) (energyExtension : Height) (distinctionExtension : CountInput) : Except String Bool := do
 let energy ← match energyExtension with
  | .ratio value => pure value
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "common successor requires exact positive additions"
 let distinction ← match distinctionExtension with
  | .count value => pure value
  | .other => throw "common successor requires exact positive additions"
 let prior ← freeEnergyEquivalentDirection forward reverse
 let extend := fun input => do
  let account ← match input with
   | .account value => pure value
   | .other => throw "direction requires complete forward/reverse accounts"
  let added : PositiveCount := ⟨account.closedDistinctionCount.value+distinction.value,Nat.add_pos_left account.closedDistinctionCount.positive _⟩
  makeAccount (.held account.pathIdentity) (.held account.reactionBoundary) (.held account.conditionIdentity)
   (.ratio (rawRatio (AlphaRatio.add (fraction account.retainedEnergyRequirement) (fraction energy)))) (.count added)
 let a ← extend forward
 let b ← extend reverse
 let result ← freeEnergyEquivalentDirection (.account a) (.account b)
 pure (equalLabel result.orientation prior.orientation)
def forward : ReactionPathAccount := ⟨⟨"reaction-path","forward-path",rfl,rfl⟩,⟨"reaction-boundary","held-reaction",rfl,rfl⟩,⟨"reaction-condition","held-condition",rfl,rfl⟩,⟨⟨5,by decide⟩,⟨3,by decide⟩⟩,⟨2,by decide⟩⟩
def reverse : ReactionPathAccount := ⟨⟨"reaction-path","reverse-path",rfl,rfl⟩,forward.reactionBoundary,forward.conditionIdentity,⟨⟨8,by decide⟩,⟨3,by decide⟩⟩,⟨3,by decide⟩⟩
def equalReverse : ReactionPathAccount := {reverse with retainedEnergyRequirement := forward.retainedEnergyRequirement,closedDistinctionCount := forward.closedDistinctionCount}
def directionWitness : Except String Bool := do let result ← freeEnergyEquivalentDirection (.account forward) (.account reverse); pure (Text.equal result.orientation.label "forward-favoured")
def separationWitness : Except String Bool := do
 let result ← freeEnergyEquivalentDirection (.account forward) (.account reverse)
 let energy := match result.energySeparation with
  | .ratio r => MolecularFormationEnergy.ratioPair r==(1,1)
  | .emptyOne | .otherEmptyOne _ | .invalid => false
 let distinction := match result.distinctionSeparation with | .count n => n.value==1 | .emptyOne => false
 pure (energy && distinction)
def equilibriumWitness : Except String Bool := do
 let result ← freeEnergyEquivalentDirection (.account forward) (.account equalReverse)
 let energy := match result.energySeparation with | .emptyOne | .otherEmptyOne _ => true | .ratio _ | .invalid => false
 let distinction := match result.distinctionSeparation with | .emptyOne => true | .count _ => false
 pure (Text.equal result.orientation.label "equilibrium" && energy && distinction)
def incomparableWitness : Bool := match freeEnergyEquivalentDirection (.account {forward with closedDistinctionCount := ⟨4,by decide⟩}) (.account {reverse with closedDistinctionCount := ⟨2,by decide⟩}) with
 | .error _ => true
 | .ok _ => false
def successorWitness := commonSuccessorPreservesDirection (.account forward) (.account reverse) (.ratio ⟨⟨7,by decide⟩,⟨5,by decide⟩⟩) (.count ⟨2,by decide⟩)
theorem forwardOrder : directionWitness=.ok true := rfl
theorem positiveSeparations : separationWitness=.ok true := rfl
theorem equilibriumEmptyOne : equilibriumWitness=.ok true := rfl
theorem incomparableHalts : incomparableWitness=true := rfl
theorem commonSuccessor : successorWitness=.ok true := rfl
end SFT.Chemistry.FreeEnergyEquivalentDirection
