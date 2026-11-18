import SFT.Chemistry.InternalEnergyComposition
namespace SFT.Chemistry.SolutionActivity
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- Pinned solution_activity_law_v1.py: original constructors and operations.
structure SolutionCompositionCoordinate where
 componentIdentity : HeldLabel
 coordinate : Height
inductive CoordinateInput where
 | coordinate (value : SolutionCompositionCoordinate)
 | other
inductive CountInput where
 | count (value : PositiveCount)
 | other
def makeCoordinate (component : LabelInput) (coordinate : Height) : Except String SolutionCompositionCoordinate := do
 let component ← match component with
  | .held label => if Text.equal label.family "chemical-component" then pure label else throw "solution coordinate lost its component identity"
  | .other => throw "solution coordinate lost its component identity"
 match coordinate with
 | .invalid => throw "solution coordinate must be exact positive or structural absence"
 | .ratio _ | .emptyOne | .otherEmptyOne _ => pure ⟨component,coordinate⟩
structure SolutionActivityAccount where
 componentIdentity : HeldLabel
 phaseIdentity : HeldLabel
 environmentIdentity : HeldLabel
 composition : List SolutionCompositionCoordinate
 accessibleExchangeSupport : PositiveCount
 referenceExchangeSupport : PositiveCount
 independentlyComposedSupport : PositiveCount
def accountField (input : LabelInput) (family : String) : Except String HeldLabel :=
 match input with
 | .held label => if Text.equal label.family family then .ok label else .error "solution activity account lost a held identity"
 | .other => .error "solution activity account lost a held identity"
def supportCount (input : CountInput) : Except String PositiveCount :=
 match input with
 | .count n => .ok n
 | .other => .error "solution activity account requires exact positive support counts"
def makeAccount (component phase environment : LabelInput) (composition : List CoordinateInput)
 (accessible reference independent : CountInput) : Except String SolutionActivityAccount := do
 let component ← accountField component "chemical-component"
 let phase ← accountField phase "chemical-phase"
 let environment ← accountField environment "chemical-environment"
 if composition.isEmpty then throw "solution activity account requires the complete composition"
 let composition ← composition.mapM fun row => match row with
  | .coordinate c => pure c
  | .other => throw "solution activity account requires the complete composition"
 if !distinctAtoms (composition.map SolutionCompositionCoordinate.componentIdentity) then
  throw "solution composition duplicated a component"
 let accessible ← supportCount accessible
 let reference ← supportCount reference
 let independent ← supportCount independent
 if accessible.value>reference.value then throw "accessible exchange support exceeds the held reference support"
 pure ⟨component,phase,environment,composition,accessible,reference,independent⟩
inductive AccountInput where
 | account (value : SolutionActivityAccount)
 | other
inductive SupportSeparation where
 | count (value : PositiveCount)
 | emptyOne
structure NonIdealCompositionResult where
 relation : HeldLabel
 supportSeparation : SupportSeparation
def exactRelativeActivity (input : AccountInput) : Except String Ratio :=
 match input with
 | .account a => .ok ⟨a.accessibleExchangeSupport,a.referenceExchangeSupport⟩
 | .other => .error "relative activity requires a complete solution account"
def nonidealCompositionRelation (input : AccountInput) : Except String NonIdealCompositionResult := do
 let account ← match input with
  | .account a => pure a
  | .other => throw "non-ideal relation requires a complete solution account"
 let actual := account.accessibleExchangeSupport.value
 let independent := account.independentlyComposedSupport.value
 if actual==independent then pure ⟨⟨"solution-composition","independent",rfl,rfl⟩,.emptyOne⟩
 else if lower : actual<independent then
  pure ⟨⟨"solution-composition","interaction-restricted",rfl,rfl⟩,.count ⟨independent-actual,SFT.Foundation.ExactCast.subtractPositive independent actual lower⟩⟩
 else if higher : independent<actual then
  pure ⟨⟨"solution-composition","interaction-expanded",rfl,rfl⟩,.count ⟨actual-independent,SFT.Foundation.ExactCast.subtractPositive actual independent higher⟩⟩
 else throw "an SFT count must be a positive counted value"
def replicatedSupportPreservesActivityAndRelation (input : AccountInput) (replication : CountInput) : Except String Bool := do
 let replication ← match replication with
  | .count n => pure n
  | .other => throw "support successor requires an exact positive replication count"
 let priorActivity ← exactRelativeActivity input
 let priorRelation ← nonidealCompositionRelation input
 let account ← match input with
  | .account a => pure a
  | .other => throw "relative activity requires a complete solution account"
 let multiplyCount := fun (n : PositiveCount) => (⟨n.value*replication.value,Nat.mul_pos n.positive replication.positive⟩ : PositiveCount)
 let replicated ← makeAccount (.held account.componentIdentity) (.held account.phaseIdentity) (.held account.environmentIdentity)
  (account.composition.map CoordinateInput.coordinate)
  (.count (multiplyCount account.accessibleExchangeSupport)) (.count (multiplyCount account.referenceExchangeSupport))
  (.count (multiplyCount account.independentlyComposedSupport))
 let activity ← exactRelativeActivity (.account replicated)
 let relation ← nonidealCompositionRelation (.account replicated)
 pure (activity.numerator.value*priorActivity.denominator.value==priorActivity.numerator.value*activity.denominator.value && equalLabel relation.relation priorRelation.relation)
def composition : List SolutionCompositionCoordinate := [⟨⟨"chemical-component","solute-a",rfl,rfl⟩,.ratio ⟨⟨3,by decide⟩,⟨2,by decide⟩⟩⟩,⟨⟨"chemical-component","solute-b",rfl,rfl⟩,.emptyOne⟩]
def restricted : SolutionActivityAccount := ⟨⟨"chemical-component","water",rfl,rfl⟩,⟨"chemical-phase","liquid-solution",rfl,rfl⟩,⟨"chemical-environment","held-environment",rfl,rfl⟩,composition,⟨6,by decide⟩,⟨10,by decide⟩,⟨8,by decide⟩⟩
def independent : SolutionActivityAccount := {restricted with accessibleExchangeSupport := ⟨8,by decide⟩}
def expanded : SolutionActivityAccount := {restricted with accessibleExchangeSupport := ⟨9,by decide⟩}
def activityWitness : Except String Bool := do
 let value ← exactRelativeActivity (.account restricted)
 pure (value.numerator.value*5==3*value.denominator.value)
def relationsWitness : Except String Bool := do
 let a ← nonidealCompositionRelation (.account restricted)
 let b ← nonidealCompositionRelation (.account independent)
 let c ← nonidealCompositionRelation (.account expanded)
 pure (Text.equal a.relation.label "interaction-restricted" && Text.equal b.relation.label "independent" && Text.equal c.relation.label "interaction-expanded")
def absenceWitness : Bool := match (restricted.composition.drop 1).head? with
 | some row => match row.coordinate with | .emptyOne | .otherEmptyOne _ => true | .ratio _ | .invalid => false
 | none => false
def successorWitness := replicatedSupportPreservesActivityAndRelation (.account restricted) (.count ⟨7,by decide⟩)
theorem exactRelativeActivityWitness : activityWitness=.ok true := rfl
theorem threeRelationsWitness : relationsWitness=.ok true := rfl
theorem structuralAbsenceWitness : absenceWitness=true := rfl
theorem replicationWitness : successorWitness=.ok true := rfl
end SFT.Chemistry.SolutionActivity
