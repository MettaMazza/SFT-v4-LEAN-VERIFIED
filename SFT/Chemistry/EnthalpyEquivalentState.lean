import SFT.Chemistry.InternalEnergyComposition
namespace SFT.Chemistry.EnthalpyEquivalentState
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- Original enthalpy_equivalent_state_law_v1.py at 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
structure EnvironmentTransferPart where
 identity : HeldLabel
 exactPositiveContent : Ratio
def makePart (input : LabelInput) (content : Height) : Except String EnvironmentTransferPart := do
 let label ← match input with
  | .held value =>
   if Text.equal value.family "environment-transfer-part" then pure value
   else throw "environment transfer requires a held identity"
  | .other => throw "environment transfer requires a held identity"
 match content with
 | .ratio value => pure ⟨label,value⟩
 | .emptyOne | .otherEmptyOne _ | .invalid => throw "environment transfer requires exact positive content"
inductive PartInput where
 | part (value : EnvironmentTransferPart)
 | other
inductive PartsInput where
 | tuple (values : List PartInput)
 | emptyOne (identity : String)
 | other
def composeEnthalpyEquivalentContent (internal : Height) (input : PartsInput) : Except String Ratio := do
 let internal ← match internal with
  | .ratio value => pure value
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "enthalpy composition requires exact positive internal energy"
 match input with
 | .emptyOne _ => pure internal
 | .other | .tuple [] => throw "environment contribution is EmptyOne or a nonempty exact part tuple"
 | .tuple (first::rest) =>
  let parts ← (first::rest).mapM fun item => match item with
   | .part value => pure value
   | .other => throw "environment contribution is EmptyOne or a nonempty exact part tuple"
  if !distinctAtoms (parts.map EnvironmentTransferPart.identity) then
   throw "environment contribution duplicated a named part"
  pure (rawRatio (parts.foldl (fun total part => AlphaRatio.add total (fraction part.exactPositiveContent)) (fraction internal)))
structure EnthalpyEquivalentChemicalState where
 composition : HeldLabel
 molecularState : HeldLabel
 phase : HeldLabel
 environment : HeldLabel
 internalEnergy : Ratio
 environmentTransferParts : PartsInput
 enthalpyEquivalentContent : Ratio
structure StateFields where
 composition : LabelInput
 molecularState : LabelInput
 phase : LabelInput
 environment : LabelInput
 internalEnergy : Height
 environmentTransferParts : PartsInput
 enthalpyEquivalentContent : Height
def stateField (input : LabelInput) (family : String) : Except String HeldLabel :=
 match input with
 | .held label => if Text.equal label.family family then .ok label
   else .error "enthalpy-equivalent state lost a held identity"
 | .other => .error "enthalpy-equivalent state lost a held identity"
def makeState (f : StateFields) : Except String EnthalpyEquivalentChemicalState := do
 let composition ← stateField f.composition "chemical-composition"
 let molecular ← stateField f.molecularState "molecular-state"
 let phase ← stateField f.phase "phase-identity"
 let environment ← stateField f.environment "held-environment"
 let internal ← match f.internalEnergy with
  | .ratio value => pure value
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "enthalpy-equivalent state requires exact positive content"
 let content ← match f.enthalpyEquivalentContent with
  | .ratio value => pure value
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "enthalpy-equivalent state requires exact positive content"
 let expected ← composeEnthalpyEquivalentContent (.ratio internal) f.environmentTransferParts
 if !InternalEnergyComposition.equalRatio content expected then
  throw "enthalpy-equivalent content does not match its retained parts"
 pure ⟨composition,molecular,phase,environment,internal,f.environmentTransferParts,content⟩
def enthalpyEquivalentState (composition molecular phase environment : LabelInput) (internal : Height) (parts : PartsInput) : Except String EnthalpyEquivalentChemicalState := do
 let content ← composeEnthalpyEquivalentContent internal parts
 makeState ⟨composition,molecular,phase,environment,internal,parts,.ratio content⟩
structure OrientedEnthalpyRelation where
 orientation : HeldLabel
 exactPositiveMagnitude : Height
def makeRelation (input : LabelInput) (magnitude : Height) : Except String OrientedEnthalpyRelation := do
 let orientation ← match input with
  | .held label =>
   if Text.equal label.family "enthalpy-state-orientation" then pure label
   else throw "enthalpy relation requires a held orientation"
  | .other => throw "enthalpy relation requires a held orientation"
 if Text.equal orientation.label "enthalpy-equivalent" then
  match magnitude with
  | .emptyOne | .otherEmptyOne _ => pure ⟨orientation,magnitude⟩
  | .ratio _ | .invalid => throw "equivalent states require structural EmptyOne"
 else if Text.equal orientation.label "enthalpy-rise" || Text.equal orientation.label "enthalpy-fall" then
  match magnitude with
  | .ratio _ => pure ⟨orientation,magnitude⟩
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "oriented enthalpy relation requires positive separation"
 else throw "unknown enthalpy orientation"
def equivalentOrientation : HeldLabel := ⟨"enthalpy-state-orientation","enthalpy-equivalent",rfl,rfl⟩
def riseOrientation : HeldLabel := ⟨"enthalpy-state-orientation","enthalpy-rise",rfl,rfl⟩
def fallOrientation : HeldLabel := ⟨"enthalpy-state-orientation","enthalpy-fall",rfl,rfl⟩
inductive StateInput where
 | state (value : EnthalpyEquivalentChemicalState)
 | other
def exactEnthalpyStateRelation (first second : StateInput) : Except String OrientedEnthalpyRelation :=
 match first,second with
 | .state first,.state second =>
  if !equalLabel first.composition second.composition || !equalLabel first.environment second.environment then
   .error "enthalpy comparison changed composition or held environment"
  else
   let a := fraction first.enthalpyEquivalentContent
   let b := fraction second.enthalpyEquivalentContent
   if a.numerator*b.denominator==b.numerator*a.denominator then .ok ⟨equivalentOrientation,.emptyOne⟩
   else if rise : a.numerator*b.denominator<b.numerator*a.denominator then
    .ok ⟨riseOrientation,.ratio (rawRatio (LeptonTake.heldRemainder b a rise))⟩
   else if fall : b.numerator*a.denominator<a.numerator*b.denominator then
    .ok ⟨fallOrientation,.ratio (rawRatio (LeptonTake.heldRemainder a b fall))⟩
   else .error "an SFT count must be a positive counted value"
 | .other,.other | .other,.state _ | .state _,.other => .error "enthalpy relation requires complete chemical states"
def equalPart (a b : EnvironmentTransferPart) : Bool := equalLabel a.identity b.identity && InternalEnergyComposition.equalRatio a.exactPositiveContent b.exactPositiveContent
def equalParts : List EnvironmentTransferPart → List EnvironmentTransferPart → Bool
 | [],[] => true
 | first::rest,next::tail => equalPart first next && equalParts rest tail
 | [],_::_ | _::_,[] => false
def appendEnvironmentPartPreservesState (internal : Height) (input : PartsInput) (extension : PartInput) : Except String Bool := do
 let prior ← composeEnthalpyEquivalentContent internal input
 let extension ← match extension with
  | .part value => pure value
  | .other => throw "'NoneType' object has no attribute 'identity'"
 let raw ← match input with
  | .tuple values => pure values
  | .emptyOne _ => throw "'EmptyOne' object is not iterable"
  | .other => throw "'NoneType' object is not iterable"
 let parts ← raw.mapM fun item => match item with
  | .part value => pure value
  | .other => throw "'NoneType' object has no attribute 'identity'"
 if parts.any (fun part => equalLabel part.identity extension.identity) then
  throw "environment successor requires a fresh held part"
 let extended := parts++[extension]
 let expected := rawRatio (AlphaRatio.add (fraction prior) (fraction extension.exactPositiveContent))
 let actual ← composeEnthalpyEquivalentContent internal (.tuple (extended.map PartInput.part))
 pure (equalParts (extended.take (extended.length-1)) parts && InternalEnergyComposition.equalRatio actual expected)
def firstPart : EnvironmentTransferPart := ⟨⟨"environment-transfer-part","first",rfl,rfl⟩,⟨⟨2,by decide⟩,⟨3,by decide⟩⟩⟩
def secondPart : EnvironmentTransferPart := ⟨⟨"environment-transfer-part","second",rfl,rfl⟩,⟨⟨5,by decide⟩,⟨4,by decide⟩⟩⟩
def thirdPart : EnvironmentTransferPart := ⟨⟨"environment-transfer-part","third",rfl,rfl⟩,⟨⟨7,by decide⟩,⟨5,by decide⟩⟩⟩
def parts : PartsInput := .tuple [.part firstPart,.part secondPart]
def state (molecular : HeldLabel) (internal : Ratio) (environmentParts : PartsInput) := enthalpyEquivalentState
 (.held ⟨"chemical-composition","held-composition",rfl,rfl⟩) (.held molecular)
 (.held ⟨"phase-identity","held-phase",rfl,rfl⟩) (.held ⟨"held-environment","held-environment",rfl,rfl⟩) (.ratio internal) environmentParts
def base := state ⟨"molecular-state","base",rfl,rfl⟩ ⟨⟨5,by decide⟩,⟨3,by decide⟩⟩ (.emptyOne "empty-One")
def loaded := state ⟨"molecular-state","loaded",rfl,rfl⟩ ⟨⟨5,by decide⟩,⟨3,by decide⟩⟩ parts
def higher := state ⟨"molecular-state","higher",rfl,rfl⟩ ⟨⟨8,by decide⟩,⟨3,by decide⟩⟩ parts
def absenceWitness : Except String Bool := do let b ← base; pure (InternalEnergyComposition.equalRatio b.enthalpyEquivalentContent b.internalEnergy)
def compositionWitness : Except String Bool := do let b ← loaded; pure (MolecularFormationEnergy.ratioPair b.enthalpyEquivalentContent==(43,12))
def orientationWitness : Except String Bool := do
 let a ← loaded
 let b ← higher
 let relation ← exactEnthalpyStateRelation (.state a) (.state b)
 pure (Text.equal relation.orientation.label "enthalpy-rise")
def equalityWitness : Except String Bool := do
 let a ← loaded
 let relation ← exactEnthalpyStateRelation (.state a) (.state a)
 pure (match relation.exactPositiveMagnitude with | .emptyOne | .otherEmptyOne _ => true | .ratio _ | .invalid => false)
def successorWitness := appendEnvironmentPartPreservesState (.ratio ⟨⟨5,by decide⟩,⟨3,by decide⟩⟩) parts (.part thirdPart)
theorem absence : absenceWitness=.ok true := rfl
theorem composition : compositionWitness=.ok true := rfl
theorem orientation : orientationWitness=.ok true := rfl
theorem structuralEquality : equalityWitness=.ok true := rfl
theorem successor : successorWitness=.ok true := rfl
end SFT.Chemistry.EnthalpyEquivalentState
