import SFT.Chemistry.MolecularFormationEnergy
namespace SFT.Chemistry.InternalEnergyComposition
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- Pinned source: internal_energy_composition_law_v1.py, commit
-- 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1.
structure InternalEnergyPart where
 partIdentity : HeldLabel
 exactPositiveContent : Ratio
def makePart (identity : LabelInput) (content : Height) : Except String InternalEnergyPart := do
 let label ← match identity with
  | .held label =>
    if Text.equal label.family "internal-energy-part" then pure label
    else throw "internal-energy part requires a held identity"
  | .other => throw "internal-energy part requires a held identity"
 match content with
 | .ratio value => pure ⟨label,value⟩
 | .emptyOne | .otherEmptyOne _ | .invalid => throw "internal-energy part requires exact positive content"
structure ChemicalInternalEnergyState where
 composition : HeldLabel
 molecularState : HeldLabel
 phase : HeldLabel
 environment : HeldLabel
 internalEnergy : Ratio
structure StateFields where
 composition : LabelInput
 molecularState : LabelInput
 phase : LabelInput
 environment : LabelInput
 internalEnergy : Height
def stateField (input : LabelInput) (family : String) : Except String HeldLabel :=
 match input with
 | .other => .error "internal-energy state lost a required held identity"
 | .held label => if Text.equal label.family family then .ok label
   else .error "internal-energy state lost a required held identity"
def makeState (f : StateFields) : Except String ChemicalInternalEnergyState := do
 let composition ← stateField f.composition "chemical-composition"
 let state ← stateField f.molecularState "molecular-state"
 let phase ← stateField f.phase "phase-identity"
 let environment ← stateField f.environment "held-environment"
 match f.internalEnergy with
 | .ratio value => pure ⟨composition,state,phase,environment,value⟩
 | .emptyOne | .otherEmptyOne _ | .invalid => throw "internal energy must be exact and positive"
structure OrientedInternalEnergyStep where
 orientation : HeldLabel
 exactPositiveMagnitude : Height
def makeStep (input : LabelInput) (magnitude : Height) : Except String OrientedInternalEnergyStep := do
 let label ← match input with
  | .held label =>
    if Text.equal label.family "internal-energy-transfer-orientation" then pure label
    else throw "internal-energy change requires a held orientation"
  | .other => throw "internal-energy change requires a held orientation"
 if Text.equal label.label "internal-energy-equal" then
  match magnitude with
  | .emptyOne | .otherEmptyOne _ => pure ⟨label,magnitude⟩
  | .ratio _ | .invalid => throw "equal internal-energy states require structural EmptyOne"
 else if Text.equal label.label "internal-energy-rise" || Text.equal label.label "internal-energy-fall" then
  match magnitude with
  | .ratio _ => pure ⟨label,magnitude⟩
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "oriented internal-energy change requires an exact positive magnitude"
 else throw "unknown internal-energy orientation"
inductive PartInput where
 | part (value : InternalEnergyPart)
 | other
inductive PartsInput where
 | tuple (values : List PartInput)
 | list (values : List PartInput)
 | other
def composeInternalEnergyParts (input : PartsInput) : Except String Ratio := do
 let raw ← match input with
  | .tuple (first::rest) => pure (first::rest)
  | .tuple [] | .list _ | .other => throw "internal-energy composition requires nonempty exact parts"
 let parts ← raw.mapM fun input => match input with
  | .part value => pure value
  | .other => throw "internal-energy composition requires nonempty exact parts"
 if !distinctAtoms (parts.map InternalEnergyPart.partIdentity) then
  throw "internal-energy composition duplicated a named part"
 match parts with
 | [] => throw "internal-energy composition requires nonempty exact parts"
 | first::rest => pure (rawRatio (rest.foldl
   (fun total part => AlphaRatio.add total (fraction part.exactPositiveContent))
   (fraction first.exactPositiveContent)))
def equalRatio (a b : Ratio) : Bool :=
 a.numerator.value==b.numerator.value && a.denominator.value==b.denominator.value
def equalPart (a b : InternalEnergyPart) : Bool :=
 equalLabel a.partIdentity b.partIdentity && equalRatio a.exactPositiveContent b.exactPositiveContent
def equalParts : List InternalEnergyPart → List InternalEnergyPart → Bool
 | [],[] => true
 | first::rest,next::tail => equalPart first next && equalParts rest tail
 | [],_::_ | _::_,[] => false
def equalOrientation : HeldLabel := ⟨"internal-energy-transfer-orientation","internal-energy-equal",rfl,rfl⟩
def riseOrientation : HeldLabel := ⟨"internal-energy-transfer-orientation","internal-energy-rise",rfl,rfl⟩
def fallOrientation : HeldLabel := ⟨"internal-energy-transfer-orientation","internal-energy-fall",rfl,rfl⟩
inductive StateInput where
 | state (value : ChemicalInternalEnergyState)
 | other
def exactInternalEnergyRelation (first second : StateInput) : Except String OrientedInternalEnergyStep :=
 match first,second with
 | .state first,.state second =>
  if !equalLabel first.composition second.composition || !equalLabel first.environment second.environment then
   .error "internal-energy comparison changed composition or declared environment"
  else if equalRatio first.internalEnergy second.internalEnergy then .ok ⟨equalOrientation,.emptyOne⟩
  else
   let a := fraction first.internalEnergy
   let b := fraction second.internalEnergy
   if rise : a.numerator*b.denominator<b.numerator*a.denominator then
    .ok ⟨riseOrientation,.ratio (rawRatio (LeptonTake.heldRemainder b a rise))⟩
   else if fall : b.numerator*a.denominator<a.numerator*b.denominator then
    .ok ⟨fallOrientation,.ratio (rawRatio (LeptonTake.heldRemainder a b fall))⟩
   else .error "an SFT count must be a positive counted value"
 | .other,.other | .other,.state _ | .state _,.other =>
   .error "internal-energy relation requires two complete chemical states"
inductive StepInput where
 | step (value : OrientedInternalEnergyStep)
 | other
inductive StepsInput where
 | tuple (values : List StepInput)
 | other
def composeOrientedInternalEnergySteps (input : StepsInput) : Except String OrientedInternalEnergyStep := do
 let raw ← match input with
  | .tuple (first::rest) => pure (first::rest)
  | .tuple [] | .other => throw "internal-energy path requires nonempty exact steps"
 let steps ← raw.mapM fun input => match input with
  | .step value => pure value
  | .other => throw "internal-energy path requires nonempty exact steps"
 let active := steps.filterMap fun step => match step.exactPositiveMagnitude with
  | .ratio r => some (step.orientation,r)
  | .emptyOne | .otherEmptyOne _ | .invalid => none
 match active with
 | [] => pure ⟨equalOrientation,.emptyOne⟩
 | first::rest =>
  if !(rest.all fun item => equalLabel item.1 first.1) then
   throw "opposed transfers require separate held path records, not signed cancellation"
  pure ⟨first.1,.ratio (rawRatio (rest.foldl (fun total item => AlphaRatio.add total (fraction item.2)) (fraction first.2)))⟩
def appendEnergyPartPreservesPriorComposition (input : PartsInput) (extension : PartInput) : Except String Bool := do
 let raw ← match input with
  | .tuple values | .list values => pure values
  | .other => throw "argument of type 'NoneType' is not iterable"
 if raw.any (fun item => match item,extension with
  | .part a,.part b => equalPart a b
  | .other,.other => true
  | .other,.part _ | .part _,.other => false) then
  throw "internal-energy successor must add a new named part"
 let extension ← match extension with
  | .part value => pure value
  | .other => throw "'NoneType' object has no attribute 'part_identity'"
 let parts ← raw.mapM fun item => match item with
  | .part value => pure value
  | .other => throw "'NoneType' object has no attribute 'part_identity'"
 if parts.any (fun item => equalLabel item.partIdentity extension.partIdentity) then
  throw "internal-energy successor must add a new named part"
 let prior ← composeInternalEnergyParts input
 let extended := parts++[extension]
 let expected := rawRatio (AlphaRatio.add (fraction prior) (fraction extension.exactPositiveContent))
 let actual ← composeInternalEnergyParts (.tuple (extended.map PartInput.part))
 pure (equalParts (extended.take (extended.length-1)) parts && equalRatio actual expected)
def firstState : ChemicalInternalEnergyState := ⟨⟨"chemical-composition","held-composition",rfl,rfl⟩,⟨"molecular-state","first",rfl,rfl⟩,⟨"phase-identity","held-phase",rfl,rfl⟩,⟨"held-environment","held-environment",rfl,rfl⟩,⟨⟨5,by decide⟩,⟨3,by decide⟩⟩⟩
def secondState : ChemicalInternalEnergyState := ⟨⟨"chemical-composition","held-composition",rfl,rfl⟩,⟨"molecular-state","second",rfl,rfl⟩,⟨"phase-identity","held-phase",rfl,rfl⟩,⟨"held-environment","held-environment",rfl,rfl⟩,⟨⟨8,by decide⟩,⟨3,by decide⟩⟩⟩
def thirdState : ChemicalInternalEnergyState := ⟨⟨"chemical-composition","held-composition",rfl,rfl⟩,⟨"molecular-state","third",rfl,rfl⟩,⟨"phase-identity","held-phase",rfl,rfl⟩,⟨"held-environment","held-environment",rfl,rfl⟩,⟨⟨14,by decide⟩,⟨3,by decide⟩⟩⟩
def firstPart : InternalEnergyPart := ⟨⟨"internal-energy-part","first-part",rfl,rfl⟩,⟨⟨2,by decide⟩,⟨3,by decide⟩⟩⟩
def secondPart : InternalEnergyPart := ⟨⟨"internal-energy-part","second-part",rfl,rfl⟩,⟨⟨5,by decide⟩,⟨4,by decide⟩⟩⟩
def extraPart : InternalEnergyPart := ⟨⟨"internal-energy-part","third-part",rfl,rfl⟩,⟨⟨7,by decide⟩,⟨5,by decide⟩⟩⟩
theorem exactPartsWitness : composeInternalEnergyParts (.tuple [.part firstPart,.part secondPart])=.ok ⟨⟨23,by decide⟩,⟨12,by decide⟩⟩ := rfl
theorem riseWitness : exactInternalEnergyRelation (.state firstState) (.state secondState)=.ok ⟨riseOrientation,.ratio ⟨⟨1,by decide⟩,⟨1,by decide⟩⟩⟩ := rfl
theorem pathWitness : (do
 let first ← exactInternalEnergyRelation (.state firstState) (.state secondState)
 let second ← exactInternalEnergyRelation (.state secondState) (.state thirdState)
 composeOrientedInternalEnergySteps (.tuple [.step first,.step second]))=
 exactInternalEnergyRelation (.state firstState) (.state thirdState) := rfl
theorem opposedPathRejected : (do
 let first ← exactInternalEnergyRelation (.state firstState) (.state secondState)
 let second ← exactInternalEnergyRelation (.state thirdState) (.state secondState)
 composeOrientedInternalEnergySteps (.tuple [.step first,.step second]))=
 .error "opposed transfers require separate held path records, not signed cancellation" := rfl
theorem appendPartWitness : appendEnergyPartPreservesPriorComposition (.tuple [.part firstPart,.part secondPart]) (.part extraPart)=.ok true := rfl
end SFT.Chemistry.InternalEnergyComposition
