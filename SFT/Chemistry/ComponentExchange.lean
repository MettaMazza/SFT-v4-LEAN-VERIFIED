import SFT.Chemistry.InternalEnergyComposition
namespace SFT.Chemistry.ComponentExchange
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion SFT.Foundation.ExactOperations
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- Exact original component_exchange_law_v1.py, pinned 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
inductive CountInput where
 | count (value : PositiveCount)
 | other
structure ComponentAdditionAccount where
 componentIdentity : HeldLabel
 phaseIdentity : HeldLabel
 environmentIdentity : HeldLabel
 retainedEnergyIncrement : Ratio
 closedDistinctionIncrement : PositiveCount
def accountField (input : LabelInput) (family : String) : Except String HeldLabel :=
 match input with
 | .held label => if Text.equal label.family family then .ok label
   else .error "component-addition account lost a held identity"
 | .other => .error "component-addition account lost a held identity"
def makeAccount (path boundary condition : LabelInput) (energy : Height) (distinctions : CountInput) : Except String ComponentAdditionAccount := do
 let path ← accountField path "chemical-component"
 let boundary ← accountField boundary "chemical-phase"
 let condition ← accountField condition "chemical-environment"
 let energy ← match energy with
  | .ratio value => pure value
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "component-addition account requires exact positive increments"
 let distinctions ← match distinctions with
  | .count value => pure value
  | .other => throw "component-addition account requires exact positive increments"
 pure ⟨path,boundary,condition,energy,distinctions⟩
inductive CountSeparation where
 | count (value : PositiveCount)
 | emptyOne
structure ComponentExchangeResult where
 orientation : HeldLabel
 energySeparation : Height
 distinctionSeparation : CountSeparation
inductive AccountInput where
 | account (value : ComponentAdditionAccount)
 | other
def forwardFavoured : HeldLabel := ⟨"component-exchange","toward-first-phase",rfl,rfl⟩
def reverseFavoured : HeldLabel := ⟨"component-exchange","toward-second-phase",rfl,rfl⟩
def equilibrium : HeldLabel := ⟨"component-exchange","equilibrium",rfl,rfl⟩
def componentExchangeRelation (forward reverse : AccountInput) : Except String ComponentExchangeResult := do
 let (forward,reverse) ← match forward,reverse with
  | .account a,.account b => pure (a,b)
  | .other,.other | .other,.account _ | .account _,.other => throw "component exchange requires two complete phase accounts"
 if !equalLabel forward.componentIdentity reverse.componentIdentity then
  throw "component exchange changed component identity"
 if !equalLabel forward.environmentIdentity reverse.environmentIdentity then
  throw "component exchange changed the fixed environment"
 if equalLabel forward.phaseIdentity reverse.phaseIdentity then
  throw "component exchange requires distinct phases"
 let a := fraction forward.retainedEnergyIncrement
 let b := fraction reverse.retainedEnergyIncrement
 let ae := a.numerator*b.denominator
 let be := b.numerator*a.denominator
 let ad := forward.closedDistinctionIncrement.value
 let bd := reverse.closedDistinctionIncrement.value
 if ae==be && ad==bd then pure ⟨equilibrium,.emptyOne,.emptyOne⟩
 else
  let direction ← if ae≤be && ad≤bd && (ae<be || ad<bd) then pure forwardFavoured
   else if be≤ae && bd≤ad && (be<ae || bd<ad) then pure reverseFavoured
   else throw "crossed component-addition accounts do not force a scalar chemical potential"
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
def commonContextSuccessorPreservesExchange (forward reverse : AccountInput) (energyExtension : Height) (distinctionExtension : CountInput) : Except String Bool := do
 let energy ← match energyExtension with
  | .ratio value => pure value
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "common successor requires exact positive additions"
 let distinction ← match distinctionExtension with
  | .count value => pure value
  | .other => throw "common successor requires exact positive additions"
 let prior ← componentExchangeRelation forward reverse
 let extend := fun input => do
  let account ← match input with
   | .account value => pure value
   | .other => throw "component exchange requires two complete phase accounts"
  let added : PositiveCount := ⟨account.closedDistinctionIncrement.value+distinction.value,Nat.add_pos_left account.closedDistinctionIncrement.positive _⟩
  makeAccount (.held account.componentIdentity) (.held account.phaseIdentity) (.held account.environmentIdentity)
   (.ratio (rawRatio (AlphaRatio.add (fraction account.retainedEnergyIncrement) (fraction energy)))) (.count added)
 let a ← extend forward
 let b ← extend reverse
 let result ← componentExchangeRelation (.account a) (.account b)
 pure (equalLabel result.orientation prior.orientation)
def forward : ComponentAdditionAccount := ⟨⟨"chemical-component","held-component",rfl,rfl⟩,⟨"chemical-phase","liquid",rfl,rfl⟩,⟨"chemical-environment","held-environment",rfl,rfl⟩,⟨⟨5,by decide⟩,⟨3,by decide⟩⟩,⟨2,by decide⟩⟩
def reverse : ComponentAdditionAccount := ⟨forward.componentIdentity,⟨"chemical-phase","gas",rfl,rfl⟩,forward.environmentIdentity,⟨⟨8,by decide⟩,⟨3,by decide⟩⟩,⟨3,by decide⟩⟩
def equalReverse : ComponentAdditionAccount := {reverse with retainedEnergyIncrement := forward.retainedEnergyIncrement,closedDistinctionIncrement := forward.closedDistinctionIncrement}
def directionWitness : Except String Bool := do let result ← componentExchangeRelation (.account forward) (.account reverse); pure (Text.equal result.orientation.label "toward-first-phase")
def equilibriumWitness : Except String Bool := do
 let result ← componentExchangeRelation (.account forward) (.account equalReverse)
 let energy := match result.energySeparation with | .emptyOne | .otherEmptyOne _ => true | .ratio _ | .invalid => false
 let distinction := match result.distinctionSeparation with | .emptyOne => true | .count _ => false
 pure (Text.equal result.orientation.label "equilibrium" && energy && distinction)
def incomparableWitness : Bool := match componentExchangeRelation (.account {forward with closedDistinctionIncrement := ⟨4,by decide⟩}) (.account {reverse with closedDistinctionIncrement := ⟨2,by decide⟩}) with
 | .error _ => true
 | .ok _ => false
def successorWitness := commonContextSuccessorPreservesExchange (.account forward) (.account reverse) (.ratio ⟨⟨7,by decide⟩,⟨5,by decide⟩⟩) (.count ⟨2,by decide⟩)
theorem forwardOrder : directionWitness=.ok true := rfl
theorem equilibriumEmptyOne : equilibriumWitness=.ok true := rfl
theorem incomparableHalts : incomparableWitness=true := rfl
theorem commonSuccessor : successorWitness=.ok true := rfl
end SFT.Chemistry.ComponentExchange
