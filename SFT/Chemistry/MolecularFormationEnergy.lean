import SFT.Chemistry.IntermolecularBinding
namespace SFT.Chemistry.MolecularFormationEnergy
open SFT.Host SFT.Physics SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
set_option maxRecDepth 30000
set_option maxHeartbeats 100000000
inductive StatesInput where
 | tuple (states : List Height)
 | other
inductive LabelInput where
 | held (value : HeldLabel)
 | other
structure Relation where
 orientation : HeldLabel
 magnitude : Height
def orientation (label : String) (nonempty : nonblank label=true) : HeldLabel :=
 ⟨"formation-state-orientation",label,rfl,nonempty⟩
def equalOrientation := orientation "product-reference-equal" rfl
def aboveOrientation := orientation "product-above-reference" rfl
def belowOrientation := orientation "product-below-reference" rfl
def exactReferenceStateComposition (input : StatesInput) : Except String Ratio := do
 let states ← match input with
  | .other | .tuple [] => throw "formation reference requires at least one exact constituent state"
  | .tuple (first::rest) => pure (first::rest)
 let ratios ← states.mapM fun state => match state with
  | .ratio r => pure (fraction r)
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "every formation reference constituent must be exact and positive"
 match ratios with
 | [] => throw "formation reference requires at least one exact constituent state"
 | first::rest => pure (rawRatio (rest.foldl AlphaRatio.add first))
def exactFormationStateRelation (product reference : Height) : Except String Relation :=
 match product,reference with
 | .ratio p,.ratio r =>
  let a := fraction p
  let b := fraction r
  if a.numerator*b.denominator=b.numerator*a.denominator then
   .ok ⟨equalOrientation,.emptyOne⟩
  else if above : b.numerator*a.denominator<a.numerator*b.denominator then
   .ok ⟨aboveOrientation,.ratio (rawRatio (LeptonTake.heldRemainder a b above))⟩
  else if below : a.numerator*b.denominator<b.numerator*a.denominator then
   .ok ⟨belowOrientation,.ratio (rawRatio (LeptonTake.heldRemainder b a below))⟩
  else .error "formation relation requires two exact positive states"
 | .emptyOne,_ | .otherEmptyOne _,_ | .invalid,_ => .error "formation relation requires two exact positive states"
 | .ratio _,.emptyOne | .ratio _,.otherEmptyOne _ | .ratio _,.invalid => .error "formation relation requires two exact positive states"
def sharedStateExtensionPreservesFormationRelation (product reference shared : Height) : Except String Bool := do
 let extra ← match shared with
  | .ratio r => pure (fraction r)
  | .emptyOne | .otherEmptyOne _ | .invalid => throw "shared formation extension must be exact and positive"
 let original ← exactFormationStateRelation product reference
 match product,reference with
 | .ratio p,.ratio r =>
  let extended ← exactFormationStateRelation (.ratio (rawRatio (AlphaRatio.add (fraction p) extra)))
   (.ratio (rawRatio (AlphaRatio.add (fraction r) extra)))
  pure (equalLabel extended.orientation original.orientation && equalHeight extended.magnitude original.magnitude)
 | .emptyOne,_ | .otherEmptyOne _,_ | .invalid,_ => throw "formation relation requires two exact positive states"
 | .ratio _,.emptyOne | .ratio _,.otherEmptyOne _ | .ratio _,.invalid => throw "formation relation requires two exact positive states"
def repeatedFormationRelation (product reference : Height) (repetition : CountInput) : Except String Relation := do
 let k ← match repetition with
  | .count k => pure k
  | .other => throw "formation repetition requires a positive count"
 let p ← match product with
  | .ratio r => pure (fraction r)
  | .emptyOne | .otherEmptyOne _ => throw "'EmptyOne' object has no attribute 'fraction'"
  | .invalid => throw "'NoneType' object has no attribute 'fraction'"
 let r ← match reference with
  | .ratio r => pure (fraction r)
  | .emptyOne | .otherEmptyOne _ => throw "'EmptyOne' object has no attribute 'fraction'"
  | .invalid => throw "'NoneType' object has no attribute 'fraction'"
 let k := AlphaRatio.whole k.value k.positive
 exactFormationStateRelation (.ratio (rawRatio (BoundaryGrowth.multiply p k)))
  (.ratio (rawRatio (BoundaryGrowth.multiply r k)))
structure Carrier where
 productIdentity : LabelInput
 productState : LabelInput
 constituentIdentities : List LabelInput
 constituentReferenceStates : List LabelInput
 referenceStateConvention : LabelInput
 temperatureReference : LabelInput
 phaseIdentity : LabelInput
 energyUnit : LabelInput
def heldFamily (value : LabelInput) (family : String) : Bool := match value with
 | .held label => Text.equal label.family family
 | .other => false
def validateCarrier (c : Carrier) : Except String Carrier := do
 if c.constituentIdentities.isEmpty || c.constituentIdentities.length != c.constituentReferenceStates.length then
  throw "formation carrier requires one reference state per constituent"
 if !(c.constituentIdentities.all fun value => heldFamily value "chemical-constituent") then
  throw "formation carrier lost a constituent identity"
 if !(c.constituentReferenceStates.all fun value => heldFamily value "constituent-reference-state") then
  throw "formation carrier lost a constituent reference state"
 if !([(c.productIdentity,"molecular-product"),(c.productState,"molecular-product-state"),
  (c.referenceStateConvention,"thermochemical-reference-state-convention"),(c.temperatureReference,"temperature-reference"),
  (c.phaseIdentity,"phase-identity"),(c.energyUnit,"held-energy-unit")].all fun (value,family) => heldFamily value family) then
  throw "formation carrier lost a required held field"
 pure c
-- These branches are the source comparison itself, for arbitrary retained states.
theorem equalStates (p r : Ratio)
 (same : (fraction p).numerator*(fraction r).denominator=(fraction r).numerator*(fraction p).denominator) :
 exactFormationStateRelation (.ratio p) (.ratio r)=.ok ⟨equalOrientation,.emptyOne⟩ := by
 unfold exactFormationStateRelation
 dsimp only
 rw [if_pos same]
theorem productAbove (p r : Ratio)
 (above : (fraction r).numerator*(fraction p).denominator<(fraction p).numerator*(fraction r).denominator) :
 exactFormationStateRelation (.ratio p) (.ratio r)=
 .ok ⟨aboveOrientation,.ratio (rawRatio (LeptonTake.heldRemainder (fraction p) (fraction r) above))⟩ := by
 unfold exactFormationStateRelation
 dsimp only
 rw [if_neg (Ne.symm (Nat.ne_of_lt above)),dif_pos above]
theorem productBelow (p r : Ratio)
 (below : (fraction p).numerator*(fraction r).denominator<(fraction r).numerator*(fraction p).denominator) :
 exactFormationStateRelation (.ratio p) (.ratio r)=
 .ok ⟨belowOrientation,.ratio (rawRatio (LeptonTake.heldRemainder (fraction r) (fraction p) below))⟩ := by
 unfold exactFormationStateRelation
 dsimp only
 rw [if_neg (Nat.ne_of_lt below),dif_neg (Nat.not_lt_of_ge (Nat.le_of_lt below)),dif_pos below]
theorem aboveSeparationReassembles (p r : Ratio)
 (above : (fraction r).numerator*(fraction p).denominator<(fraction p).numerator*(fraction r).denominator) :
 ((fraction p).numerator*(fraction r).denominator-(fraction r).numerator*(fraction p).denominator)+
 (fraction r).numerator*(fraction p).denominator=(fraction p).numerator*(fraction r).denominator :=
 LeptonTake.heldPartReassembles (fraction p) (fraction r) above
theorem belowSeparationReassembles (p r : Ratio)
 (below : (fraction p).numerator*(fraction r).denominator<(fraction r).numerator*(fraction p).denominator) :
 ((fraction r).numerator*(fraction p).denominator-(fraction p).numerator*(fraction r).denominator)+
 (fraction p).numerator*(fraction r).denominator=(fraction r).numerator*(fraction p).denominator :=
 LeptonTake.heldPartReassembles (fraction r) (fraction p) below
def reference : Height := .ratio ⟨⟨29,by decide⟩,⟨6,by decide⟩⟩
def productBelowState : Height := .ratio ⟨⟨4,by decide⟩,⟨1,by decide⟩⟩
def productAboveState : Height := .ratio ⟨⟨6,by decide⟩,⟨1,by decide⟩⟩
def shared : Height := .ratio ⟨⟨11,by decide⟩,⟨5,by decide⟩⟩
def ratioPair (r : Ratio) : Nat × Nat := (r.numerator.value,r.denominator.value)
def relationValue (r : Relation) : String × Option (Nat × Nat) :=
 (r.orientation.label,match r.magnitude with | .ratio v => some (ratioPair v) | .emptyOne | .otherEmptyOne _ | .invalid => none)
theorem compositionWitness : (exactReferenceStateComposition (.tuple [IntermolecularBinding.firstConstituent,
 IntermolecularBinding.secondConstituent])).map ratioPair=.ok (29,6) := rfl
theorem belowWitness : (exactFormationStateRelation productBelowState reference).map relationValue=
 .ok ("product-below-reference",some (5,6)) := rfl
theorem aboveWitness : (exactFormationStateRelation productAboveState reference).map relationValue=
 .ok ("product-above-reference",some (7,6)) := rfl
theorem equalityWitness : (exactFormationStateRelation reference reference).map relationValue=
 .ok ("product-reference-equal",none) := rfl
theorem extensionWitness : sharedStateExtensionPreservesFormationRelation productBelowState reference shared=.ok true := rfl
theorem repetitionWitness : (repeatedFormationRelation productBelowState reference (.count ⟨3,by decide⟩)).map relationValue=
 .ok ("product-below-reference",some (5,2)) := rfl
end SFT.Chemistry.MolecularFormationEnergy
