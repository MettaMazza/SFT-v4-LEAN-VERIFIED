import SFT.Chemistry.InternalEnergyComposition
namespace SFT.Chemistry.RealGasExchange
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- Pinned real_gas_exchange_law_v1.py: original constructors and operations.
structure GasCompositionCoordinate where
 componentIdentity : HeldLabel
 coordinate : Height
inductive CoordinateInput where
 | coordinate (value : GasCompositionCoordinate)
 | other
inductive CountInput where
 | count (value : PositiveCount)
 | other
def makeCoordinate (component : LabelInput) (coordinate : Height) : Except String GasCompositionCoordinate := do
 let component ← match component with
  | .held label => if Text.equal label.family "chemical-component" then pure label else throw "gas coordinate lost its component identity"
  | .other => throw "gas coordinate lost its component identity"
 match coordinate with
 | .invalid => throw "gas coordinate must be an exact positive part or structural absence"
 | .ratio value =>
  if value.numerator.value>value.denominator.value then throw "gas composition coordinate exceeds the One"
  pure ⟨component,coordinate⟩
 | .emptyOne | .otherEmptyOne _ => pure ⟨component,coordinate⟩
structure GasComponentExchangeAccount where
 componentIdentity : HeldLabel
 gasPhaseIdentity : HeldLabel
 environmentIdentity : HeldLabel
 composition : List GasCompositionCoordinate
 accessibleExchangeSupport : PositiveCount
 referenceExchangeSupport : PositiveCount
 independentlyComposedSupport : PositiveCount
def accountField (input : LabelInput) (family : String) : Except String HeldLabel :=
 match input with
 | .held label => if Text.equal label.family family then .ok label else .error "gas exchange account lost a held identity"
 | .other => .error "gas exchange account lost a held identity"
def supportCount (input : CountInput) : Except String PositiveCount :=
 match input with
 | .count n => .ok n
 | .other => .error "gas exchange support must be exact positive counts"
def makeAccount (component phase environment : LabelInput) (composition : List CoordinateInput)
 (accessible reference independent : CountInput) : Except String GasComponentExchangeAccount := do
 let component ← accountField component "chemical-component"
 let phase ← accountField phase "chemical-phase"
 let environment ← accountField environment "chemical-environment"
 if composition.isEmpty then throw "gas exchange account requires the complete composition"
 let composition ← composition.mapM fun row => match row with
  | .coordinate c => pure c
  | .other => throw "gas exchange account requires the complete composition"
 if !distinctAtoms (composition.map GasCompositionCoordinate.componentIdentity) then
  throw "gas composition duplicated a component"
 let accessible ← supportCount accessible
 let reference ← supportCount reference
 let independent ← supportCount independent
 if accessible.value>reference.value then throw "accessible gas support exceeds its complete reference support"
 pure ⟨component,phase,environment,composition,accessible,reference,independent⟩
inductive AccountInput where
 | account (value : GasComponentExchangeAccount)
 | other
inductive SupportSeparation where
 | count (value : PositiveCount)
 | emptyOne
structure GasInteractionResult where
 relation : HeldLabel
 supportSeparation : SupportSeparation
def exactFugacityEquivalent (input : AccountInput) : Except String Ratio :=
 match input with
 | .account a => .ok ⟨a.accessibleExchangeSupport,a.referenceExchangeSupport⟩
 | .other => .error "fugacity-equivalent relation requires a complete gas exchange account"
def realGasInteractionRelation (input : AccountInput) : Except String GasInteractionResult := do
 let account ← match input with
  | .account a => pure a
  | .other => throw "real-gas relation requires a complete gas exchange account"
 let actual := account.accessibleExchangeSupport.value
 let independent := account.independentlyComposedSupport.value
 if actual==independent then pure ⟨⟨"gas-mixture","independent-support",rfl,rfl⟩,.emptyOne⟩
 else if lower : actual<independent then
  pure ⟨⟨"gas-mixture","interaction-restricted-support",rfl,rfl⟩,.count ⟨independent-actual,SFT.Foundation.ExactCast.subtractPositive independent actual lower⟩⟩
 else if higher : independent<actual then
  pure ⟨⟨"gas-mixture","interaction-expanded-support",rfl,rfl⟩,.count ⟨actual-independent,SFT.Foundation.ExactCast.subtractPositive actual independent higher⟩⟩
 else throw "an SFT count must be a positive counted value"
structure PhaseExchangeResult where
 relation : HeldLabel
 supportSeparation : SupportSeparation
def phaseExchangeRelation (input : AccountInput) (partner : CountInput) : Except String PhaseExchangeResult := do
 let (account,partner) ← match input,partner with
  | .account a,.count p => pure (a,p)
  | .other,.other | .other,.count _ | .account _,.other => throw "phase exchange requires complete gas and partner support"
 let gas := account.accessibleExchangeSupport.value
 let partner := partner.value
 if gas==partner then pure ⟨⟨"phase-exchange","balanced",rfl,rfl⟩,.emptyOne⟩
 else if smaller : gas<partner then
  pure ⟨⟨"phase-exchange","partner-expanded",rfl,rfl⟩,.count ⟨partner-gas,SFT.Foundation.ExactCast.subtractPositive partner gas smaller⟩⟩
 else if larger : partner<gas then
  pure ⟨⟨"phase-exchange","gas-expanded",rfl,rfl⟩,.count ⟨gas-partner,SFT.Foundation.ExactCast.subtractPositive gas partner larger⟩⟩
 else throw "an SFT count must be a positive counted value"
def replicatedSupportPreservesGasLaw (input : AccountInput) (partner replication : CountInput) : Except String Bool := do
 let replication ← match replication with
  | .count n => pure n
  | .other => throw "gas-law successor requires exact positive counts"
 let partner ← match partner with
  | .count n => pure n
  | .other => throw "gas-law successor requires exact positive counts"
 let priorRatio ← exactFugacityEquivalent input
 let priorInteraction ← realGasInteractionRelation input
 let priorPhase ← phaseExchangeRelation input (.count partner)
 let account ← match input with
  | .account a => pure a
  | .other => throw "fugacity-equivalent relation requires a complete gas exchange account"
 let multiplyCount := fun (n : PositiveCount) => (⟨n.value*replication.value,Nat.mul_pos n.positive replication.positive⟩ : PositiveCount)
 let replicated ← makeAccount (.held account.componentIdentity) (.held account.gasPhaseIdentity) (.held account.environmentIdentity)
  (account.composition.map CoordinateInput.coordinate)
  (.count (multiplyCount account.accessibleExchangeSupport)) (.count (multiplyCount account.referenceExchangeSupport))
  (.count (multiplyCount account.independentlyComposedSupport))
 let ratio ← exactFugacityEquivalent (.account replicated)
 let interaction ← realGasInteractionRelation (.account replicated)
 let phase ← phaseExchangeRelation (.account replicated) (.count (multiplyCount partner))
 pure (ratio.numerator.value*priorRatio.denominator.value==priorRatio.numerator.value*ratio.denominator.value &&
  equalLabel interaction.relation priorInteraction.relation && equalLabel phase.relation priorPhase.relation)
def composition : List GasCompositionCoordinate := [⟨⟨"chemical-component","component-a",rfl,rfl⟩,.ratio ⟨⟨3,by decide⟩,⟨5,by decide⟩⟩⟩,⟨⟨"chemical-component","component-b",rfl,rfl⟩,.ratio ⟨⟨2,by decide⟩,⟨5,by decide⟩⟩⟩]
def account : GasComponentExchangeAccount := ⟨⟨"chemical-component","component-a",rfl,rfl⟩,⟨"chemical-phase","gas-mixture",rfl,rfl⟩,⟨"chemical-environment","held-temperature-pressure",rfl,rfl⟩,composition,⟨6,by decide⟩,⟨10,by decide⟩,⟨8,by decide⟩⟩
def ratioWitness : Except String Bool := do
 let r ← exactFugacityEquivalent (.account account)
 pure (r.numerator.value*5==3*r.denominator.value)
def interactionWitness : Except String Bool := do
 let r ← realGasInteractionRelation (.account account)
 pure (Text.equal r.relation.label "interaction-restricted-support")
def balanceWitness : Except String Bool := do
 let r ← phaseExchangeRelation (.account account) (.count ⟨6,by decide⟩)
 pure (Text.equal r.relation.label "balanced" && match r.supportSeparation with | .emptyOne => true | .count _ => false)
def successorWitness := replicatedSupportPreservesGasLaw (.account account) (.count ⟨6,by decide⟩) (.count ⟨7,by decide⟩)
theorem exactRatio : ratioWitness=.ok true := rfl
theorem restrictedInteraction : interactionWitness=.ok true := rfl
theorem phaseBalance : balanceWitness=.ok true := rfl
theorem commonReplication : successorWitness=.ok true := rfl
end SFT.Chemistry.RealGasExchange
