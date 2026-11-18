import SFT.Chemistry.MolecularFormationEnergy
namespace SFT.Chemistry.CrossPropertyMolecularVector
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
abbrev heldFamily := MolecularFormationEnergy.heldFamily
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
structure Projection where
 propertyFamily : HeldLabel
 generatingRelation : HeldLabel
 resultOrientation : HeldLabel
 exactResult : Height
structure ProjectionFields where
 propertyFamily : LabelInput
 generatingRelation : LabelInput
 resultOrientation : LabelInput
 exactResult : Height
def makeProjection (p : ProjectionFields) : Except String Projection := do
 let family ← match p.propertyFamily with
  | .other => throw "property projection requires a held property family"
  | .held value => if !Text.equal value.family "molecular-property-family" then
    throw "property projection requires a held property family" else pure value
 let relation ← match p.generatingRelation with
  | .other => throw "property projection requires its admitted generating relation"
  | .held value => if !Text.equal value.family "admitted-property-relation" then
    throw "property projection requires its admitted generating relation" else pure value
 let orientation ← match p.resultOrientation with
  | .other => throw "property projection requires a held result orientation"
  | .held value => if !Text.equal value.family "property-result-orientation" then
    throw "property projection requires a held result orientation" else pure value
 match p.exactResult with
 | .invalid => throw "property projection result must be exact positive or structural EmptyOne"
 | .emptyOne | .otherEmptyOne _ | .ratio _ => pure ⟨family,relation,orientation,p.exactResult⟩
structure Carrier where
 structuralCarrierId : HeldLabel
 constitution : HeldLabel
 stateIdentity : HeldLabel
 chargeIdentity : HeldLabel
 geometryAndSymmetry : HeldLabel
 observationCondition : HeldLabel
 applicablePropertyFamilies : List HeldLabel
structure CarrierFields where
 structuralCarrierId : LabelInput
 constitution : LabelInput
 stateIdentity : LabelInput
 chargeIdentity : LabelInput
 geometryAndSymmetry : LabelInput
 observationCondition : LabelInput
 applicablePropertyFamilies : List LabelInput
def carrierField (value : LabelInput) (family : String) : Except String HeldLabel :=
 match value with
 | .other => .error "cross-property carrier lost a required held field"
 | .held value => if Text.equal value.family family then .ok value else .error "cross-property carrier lost a required held field"
def makeCarrier (c : CarrierFields) : Except String Carrier := do
 let id ← carrierField c.structuralCarrierId "structural-molecular-carrier"
 let constitution ← carrierField c.constitution "molecular-constitution"
 let state ← carrierField c.stateIdentity "molecular-state"
 let charge ← carrierField c.chargeIdentity "held-charge-identity"
 let geometry ← carrierField c.geometryAndSymmetry "geometry-symmetry-carrier"
 let condition ← carrierField c.observationCondition "measurement-condition"
 if c.applicablePropertyFamilies.isEmpty then throw "cross-property carrier requires a nonempty property support"
 let families ← c.applicablePropertyFamilies.mapM fun value => match value with
  | .other => throw "cross-property carrier requires a nonempty property support"
  | .held label => if Text.equal label.family "molecular-property-family" then pure label
   else throw "cross-property carrier requires a nonempty property support"
 if !distinctAtoms families then throw "cross-property carrier duplicated a property family"
 pure ⟨id,constitution,state,charge,geometry,condition,families⟩
inductive CarrierInput where
 | carrier (value : Carrier)
 | other
inductive ProjectionsInput where
 | tuple (values : List Projection)
 | other
def sameSupport (a b : List HeldLabel) : Bool :=
 (a.all fun x => b.any (equalLabel x)) && (b.all fun x => a.any (equalLabel x))
def composeExactPropertyVector (carrier : CarrierInput) (projections : ProjectionsInput) : Except String (List Projection) := do
 let (c,values) ← match carrier,projections with
  | .carrier c,.tuple (first::rest) => pure (c,first::rest)
  | .other,_ | .carrier _,.other | .carrier _,.tuple [] =>
   throw "cross-property vector requires one carrier and nonempty projections"
 let labels := values.map Projection.propertyFamily
 if !distinctAtoms labels then throw "a property family may occur only once in one exact vector"
 if !sameSupport labels c.applicablePropertyFamilies then
  throw "projection support differs from the carrier's complete applicable support"
 pure values
def matching : List Projection → HeldLabel → List Projection
 | [],_ => []
 | first::rest,label => if equalLabel first.propertyFamily label then first::matching rest label else matching rest label
def projectExactProperty (vector : List Projection) (family : LabelInput) : Except String Projection :=
 let selected := match family with | .held label => matching vector label | .other => []
 match selected with
 | [item] => .ok item
 | [] | _::_::_ => .error "property projection is absent or non-unique"
def equalProjection (a b : Projection) : Bool :=
 equalLabel a.propertyFamily b.propertyFamily && equalLabel a.generatingRelation b.generatingRelation &&
 equalLabel a.resultOrientation b.resultOrientation && equalHeight a.exactResult b.exactResult
def extendCarrier (c : Carrier) (extension : Projection) : Except String Carrier :=
 makeCarrier ⟨.held c.structuralCarrierId,.held c.constitution,.held c.stateIdentity,.held c.chargeIdentity,
  .held c.geometryAndSymmetry,.held c.observationCondition,
  (c.applicablePropertyFamilies ++ [extension.propertyFamily]).map MolecularFormationEnergy.LabelInput.held⟩
def lawfulProjectionExtensionPreservesExisting (c : Carrier) (vector : List Projection) (extension : Projection) : Except String Bool := do
 if vector.any (fun item => equalLabel extension.propertyFamily item.propertyFamily) then
  throw "projection extension must add a new property family"
 let carrier ← extendCarrier c extension
 let extended ← composeExactPropertyVector (.carrier carrier) (.tuple (vector++[extension]))
 let retained ← vector.mapM fun item => do
  let projected ← projectExactProperty extended (.held item.propertyFamily)
  pure (equalProjection projected item)
 pure (retained.all id)
-- This is the original named projection under an append, for arbitrary
-- finite vectors. It reuses the unchanged matching relation and results.
theorem matchingAppendFresh (vector : List Projection) (extension : Projection) (family : HeldLabel)
 (fresh : equalLabel extension.propertyFamily family=false) :
 matching (vector++[extension]) family=matching vector family := by
 induction vector with
 | nil =>
  dsimp only [List.nil_append,matching]
  rw [fresh]
  rfl
 | cons first rest ih =>
  dsimp only [List.cons_append,matching]
  rw [ih]
theorem projectionAppendFresh (vector : List Projection) (extension : Projection) (family : HeldLabel)
 (fresh : equalLabel extension.propertyFamily family=false) :
 projectExactProperty (vector++[extension]) (.held family)=projectExactProperty vector (.held family) := by
 unfold projectExactProperty
 dsimp only
 rw [matchingAppendFresh vector extension family fresh]
theorem namedResultPreserved (vector : List Projection) (extension item : Projection)
 (fresh : equalLabel extension.propertyFamily item.propertyFamily=false)
 (selected : projectExactProperty vector (.held item.propertyFamily)=.ok item) :
 projectExactProperty (vector++[extension]) (.held item.propertyFamily)=.ok item :=
 (projectionAppendFresh vector extension item.propertyFamily fresh).trans selected
def lengthProjection : Projection :=
 ⟨⟨"molecular-property-family","bond-length",rfl,rfl⟩,⟨"admitted-property-relation","bond-length-law",rfl,rfl⟩,
  ⟨"property-result-orientation","exact-positive",rfl,rfl⟩,.ratio ⟨⟨3,by decide⟩,⟨2,by decide⟩⟩⟩
def vibrationProjection : Projection :=
 ⟨⟨"molecular-property-family","vibration",rfl,rfl⟩,⟨"admitted-property-relation","vibration-law",rfl,rfl⟩,
  ⟨"property-result-orientation","exact-positive",rfl,rfl⟩,.ratio ⟨⟨5,by decide⟩,⟨3,by decide⟩⟩⟩
def formationProjection : Projection :=
 ⟨⟨"molecular-property-family","formation",rfl,rfl⟩,⟨"admitted-property-relation","formation-law",rfl,rfl⟩,
  ⟨"property-result-orientation","exact-positive",rfl,rfl⟩,.ratio ⟨⟨7,by decide⟩,⟨4,by decide⟩⟩⟩
def witnessCarrier : Carrier :=
 ⟨⟨"structural-molecular-carrier","held-molecule",rfl,rfl⟩,⟨"molecular-constitution","held-constitution",rfl,rfl⟩,
  ⟨"molecular-state","held-state",rfl,rfl⟩,⟨"held-charge-identity","held-charge",rfl,rfl⟩,
  ⟨"geometry-symmetry-carrier","held-geometry-symmetry",rfl,rfl⟩,
  ⟨"measurement-condition","held-condition",rfl,rfl⟩,[lengthProjection.propertyFamily,vibrationProjection.propertyFamily]⟩
def witnessVector : List Projection := [lengthProjection,vibrationProjection]
theorem oneCarrierWitness : (composeExactPropertyVector (.carrier witnessCarrier) (.tuple witnessVector)).map List.length=.ok 2 := rfl
theorem namedProjectionWitness : projectExactProperty witnessVector (.held vibrationProjection.propertyFamily)=.ok vibrationProjection := rfl
theorem duplicateWitness : composeExactPropertyVector (.carrier witnessCarrier) (.tuple [lengthProjection,lengthProjection])=
 .error "a property family may occur only once in one exact vector" := rfl
theorem extensionWitness : lawfulProjectionExtensionPreservesExisting witnessCarrier witnessVector formationProjection=.ok true := rfl
end SFT.Chemistry.CrossPropertyMolecularVector
