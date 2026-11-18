import SFT.Chemistry.FiniteMicrostateSupport
namespace SFT.Chemistry.TemperatureCorrespondence
open SFT.Host SFT.Physics.CapabilityValues SFT.Chemistry.DihedralTorsion
abbrev LabelInput := MolecularFormationEnergy.LabelInput
set_option maxHeartbeats 100000000
set_option maxRecDepth 30000
-- Source: sft/chemistry/temperature_correspondence_law_v1.py at
-- 76f1b34e9e9682989adcbb088797b4ae4ce4fcf1. PositiveRatio equality
-- compares stored positive counts, as the original frozen dataclass does.
structure ChemicalTemperatureContext where
 composition : HeldLabel
 phase : HeldLabel
 equilibriumReference : HeldLabel
 thermometricRoute : HeldLabel
 physicsTemperatureCarrier : Ratio
structure ContextFields where
 composition : LabelInput
 phase : LabelInput
 equilibriumReference : LabelInput
 thermometricRoute : LabelInput
 physicsTemperatureCarrier : Height
def contextField (input : LabelInput) (family : String) : Except String HeldLabel :=
 match input with
 | .other => .error "chemical temperature context lost a required held identity"
 | .held label => if Text.equal label.family family then .ok label
   else .error "chemical temperature context lost a required held identity"
def makeContext (fields : ContextFields) : Except String ChemicalTemperatureContext := do
 let composition ← contextField fields.composition "chemical-composition"
 let phase ← contextField fields.phase "phase-identity"
 let reference ← contextField fields.equilibriumReference "thermal-equilibrium-reference"
 let route ← contextField fields.thermometricRoute "thermometric-route"
 let carrier ← match fields.physicsTemperatureCarrier with
  | .ratio carrier => pure carrier
  | .emptyOne | .otherEmptyOne _ | .invalid =>
    throw "Chemistry must consume one exact positive Physics temperature carrier"
 pure ⟨composition,phase,reference,route,carrier⟩
structure CompositionTemperatureConsequence where
 composition : HeldLabel
 chemicalStateConsequence : HeldLabel
 physicsTemperatureCarrier : Ratio
def makeConsequence (composition consequence : LabelInput) (carrier : Height) :
 Except String CompositionTemperatureConsequence := do
 let composition ← match composition with
  | .other => throw "temperature consequence requires held chemical composition"
  | .held label =>
    if Text.equal label.family "chemical-composition" then pure label
    else throw "temperature consequence requires held chemical composition"
 let consequence ← match consequence with
  | .other => throw "temperature consequence requires a held chemical-state result"
  | .held label =>
    if Text.equal label.family "composition-dependent-temperature-consequence" then pure label
    else throw "temperature consequence requires a held chemical-state result"
 let carrier ← match carrier with
  | .ratio carrier => pure carrier
  | .emptyOne | .otherEmptyOne _ | .invalid =>
    throw "temperature consequence must retain the Physics carrier unchanged"
 pure ⟨composition,consequence,carrier⟩
inductive ContextInput where
 | context (value : ChemicalTemperatureContext)
 | other
def equalCarrier (a b : Ratio) : Bool :=
 a.numerator.value == b.numerator.value && a.denominator.value == b.denominator.value
def equalContext (a b : ChemicalTemperatureContext) : Bool :=
 equalLabel a.composition b.composition && equalLabel a.phase b.phase &&
 equalLabel a.equilibriumReference b.equilibriumReference &&
 equalLabel a.thermometricRoute b.thermometricRoute &&
 equalCarrier a.physicsTemperatureCarrier b.physicsTemperatureCarrier
def consumePhysicsTemperatureCarrier (input : ContextInput) : Except String Ratio :=
 match input with
 | .context context => .ok context.physicsTemperatureCarrier
 | .other => .error "chemical temperature correspondence requires a complete context"
def commonThermalEquilibriumCarrier (left right : ContextInput) : Except String Ratio :=
 match left,right with
 | .context left,.context right =>
   if !equalLabel left.equilibriumReference right.equilibriumReference then
    .error "contexts do not share the same held equilibrium reference"
   else if !equalCarrier left.physicsTemperatureCarrier right.physicsTemperatureCarrier then
    .error "equilibrium cannot admit route- or composition-specific temperature rescaling"
   else .ok left.physicsTemperatureCarrier
 | .other,.other | .other,.context _ | .context _,.other =>
   .error "thermal equilibrium requires two complete chemical contexts"
def attachCompositionConsequence (input : ContextInput) (consequence : LabelInput) :
 Except String CompositionTemperatureConsequence :=
 match input with
 | .other => .error "'NoneType' object has no attribute 'composition'"
 | .context context => makeConsequence (.held context.composition) consequence
   (.ratio context.physicsTemperatureCarrier)
inductive ContextsInput where
 | tuple (values : List ContextInput)
 | other
def equalContexts : List ChemicalTemperatureContext → List ChemicalTemperatureContext → Bool
 | [],[] => true
 | first::rest,next::tail => equalContext first next && equalContexts rest tail
 | [],_::_ | _::_,[] => false
def appendCompositionPreservesCommonCarrier (input : ContextsInput) (extension : ContextInput) :
 Except String Bool := do
 let raw ← match input with
  | .other | .tuple [] => throw "temperature correspondence requires nonempty finite context support"
  | .tuple (first::rest) => pure (first::rest)
 if raw.any (fun item => match item,extension with
   | .context a,.context b => equalContext a b
   | .other,.other => true
   | .other,.context _ | .context _,.other => false) then
  throw "composition extension must be new"
 let first ← match raw with
  | .context first::_ => pure first
  | .other::_ => throw "'NoneType' object has no attribute 'physics_temperature_carrier'"
  | [] => throw "temperature correspondence requires nonempty finite context support"
 let contexts ← raw.mapM fun item => match item with
  | .context value =>
   if !equalCarrier value.physicsTemperatureCarrier first.physicsTemperatureCarrier ||
     !equalLabel value.equilibriumReference first.equilibriumReference then
    throw "existing chemical contexts do not share one equilibrium carrier"
   else pure value
  | .other => throw "'NoneType' object has no attribute 'physics_temperature_carrier'"
 let extension ← match extension with
  | .context value => pure value
  | .other => throw "'NoneType' object has no attribute 'physics_temperature_carrier'"
 if !equalCarrier extension.physicsTemperatureCarrier first.physicsTemperatureCarrier ||
   !equalLabel extension.equilibriumReference first.equilibriumReference then
  throw "new composition attempted to rescale the common temperature carrier"
 let extended := contexts++[extension]
 pure (equalContexts (extended.take (extended.length-1)) contexts &&
  extended.all (fun item => equalCarrier item.physicsTemperatureCarrier first.physicsTemperatureCarrier))
theorem consumedCarrierUnchanged (context : ChemicalTemperatureContext) :
consumePhysicsTemperatureCarrier (.context context)=.ok context.physicsTemperatureCarrier := rfl
theorem equilibriumReturnsOriginalCarrier (left right : ChemicalTemperatureContext)
(reference : equalLabel left.equilibriumReference right.equilibriumReference=true)
(carrier : equalCarrier left.physicsTemperatureCarrier right.physicsTemperatureCarrier=true) :
commonThermalEquilibriumCarrier (.context left) (.context right)=.ok left.physicsTemperatureCarrier := by
 dsimp only [commonThermalEquilibriumCarrier]
 rw [reference,carrier]
 rfl
def argon : ChemicalTemperatureContext := ⟨⟨"chemical-composition","argon",rfl,rfl⟩,⟨"phase-identity","gas",rfl,rfl⟩,⟨"thermal-equilibrium-reference","held-common-reference",rfl,rfl⟩,⟨"thermometric-route","acoustic",rfl,rfl⟩,⟨⟨5,by decide⟩,⟨3,by decide⟩⟩⟩
def resistor : ChemicalTemperatureContext := ⟨⟨"chemical-composition","resistor-material",rfl,rfl⟩,⟨"phase-identity","condensed",rfl,rfl⟩,⟨"thermal-equilibrium-reference","held-common-reference",rfl,rfl⟩,⟨"thermometric-route","Johnson-noise",rfl,rfl⟩,⟨⟨5,by decide⟩,⟨3,by decide⟩⟩⟩
def water : ChemicalTemperatureContext := ⟨⟨"chemical-composition","water",rfl,rfl⟩,⟨"phase-identity","liquid",rfl,rfl⟩,⟨"thermal-equilibrium-reference","held-common-reference",rfl,rfl⟩,⟨"thermometric-route","contact-equilibrium",rfl,rfl⟩,⟨⟨5,by decide⟩,⟨3,by decide⟩⟩⟩
def mismatched : ChemicalTemperatureContext := ⟨⟨"chemical-composition","tampered",rfl,rfl⟩,⟨"phase-identity","gas",rfl,rfl⟩,⟨"thermal-equilibrium-reference","held-common-reference",rfl,rfl⟩,⟨"thermometric-route","tampered",rfl,rfl⟩,⟨⟨7,by decide⟩,⟨4,by decide⟩⟩⟩
def consequenceLabel : HeldLabel := ⟨"composition-dependent-temperature-consequence","argon-state-order",rfl,rfl⟩
theorem originalUnchangedWitness : consumePhysicsTemperatureCarrier (.context argon)=.ok argon.physicsTemperatureCarrier := rfl
theorem originalEquilibriumWitness : commonThermalEquilibriumCarrier (.context argon) (.context resistor)=.ok argon.physicsTemperatureCarrier := rfl
theorem originalConsequenceWitness : attachCompositionConsequence (.context argon) (.held consequenceLabel)=.ok ⟨argon.composition,consequenceLabel,argon.physicsTemperatureCarrier⟩ := rfl
theorem originalRescalingRejected : commonThermalEquilibriumCarrier (.context argon) (.context mismatched)=.error "equilibrium cannot admit route- or composition-specific temperature rescaling" := rfl
theorem originalAppendWitness : appendCompositionPreservesCommonCarrier (.tuple [.context argon,.context resistor]) (.context water)=.ok true := rfl
end SFT.Chemistry.TemperatureCorrespondence
