import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.StateSymmetry
open SFT.Host SFT.Physics.CapabilityValues

inductive AxisRank where
 | emptyOne : String → AxisRank
 | count : PositiveCount → AxisRank
inductive OptionalLabel where
 | emptyOne : String → OptionalLabel
 | held : HeldLabel → OptionalLabel
structure Signature where
 molecularCarrier : HeldLabel
 multiplicity : PositiveCount
 axisRank : AxisRank
 orientationCount : PositiveCount
 inversion : OptionalLabel
 reflection : OptionalLabel
 axisComponent : OptionalLabel
 componentKind : OptionalLabel

def rightFamily (value : OptionalLabel) (family : String) : Bool :=
 match value with
 | .emptyOne _ => true
 | .held label => Text.equal label.family family

def validate (s : Signature) : Except String Signature := do
 if !Text.equal s.molecularCarrier.family "molecular-carrier" then
  throw "symmetry signature requires one molecule"
 match s.axisRank with
 | .emptyOne identity =>
  if Text.equal identity "empty-One" && !(Nat.beq s.orientationCount.value 1) then
   throw "axis-invariant support has one retained orientation"
 | .count _ =>
  if !(Nat.beq s.orientationCount.value 2) then
   throw "positive axis recurrence has the complementary orientation pair"
 if !(rightFamily s.inversion "inversion-symmetry" && rightFamily s.reflection "reflection-symmetry" &&
  rightFamily s.axisComponent "axis-component" && rightFamily s.componentKind "component-kind") then
  throw "held symmetry label has the wrong family"
 pure s

def degeneracy (s : Signature) : PositiveCount :=
 ⟨s.multiplicity.value*s.orientationCount.value,Nat.mul_pos s.multiplicity.positive s.orientationCount.positive⟩

def labelEqual (a b : HeldLabel) : Bool := Text.equal a.family b.family && Text.equal a.label b.label

def optionalEqual : OptionalLabel → OptionalLabel → Bool
 | .emptyOne a,.emptyOne b => Text.equal a b
 | .held a,.held b => labelEqual a b
 | .emptyOne _,.held _ | .held _,.emptyOne _ => false

def axisEqual : AxisRank → AxisRank → Bool
 | .emptyOne a,.emptyOne b => Text.equal a b
 | .count a,.count b => Nat.beq a.value b.value
 | .emptyOne _,.count _ | .count _,.emptyOne _ => false

def equivalent (a b : Signature) : Bool :=
 labelEqual a.molecularCarrier b.molecularCarrier && Nat.beq a.multiplicity.value b.multiplicity.value &&
 axisEqual a.axisRank b.axisRank && Nat.beq a.orientationCount.value b.orientationCount.value &&
 optionalEqual a.inversion b.inversion && optionalEqual a.reflection b.reflection &&
 optionalEqual a.axisComponent b.axisComponent && optionalEqual a.componentKind b.componentKind

structure EquivalenceClass where
 signature : Signature
 occurrences : List HeldLabel

def uniqueLabels : List HeldLabel → Bool
 | [] => true
 | x::xs => !(xs.any (labelEqual x)) && uniqueLabels xs

def validateClass (c : EquivalenceClass) : Except String EquivalenceClass := do
 if !(Nat.beq c.occurrences.length (degeneracy c.signature).value) then
  throw "equivalence-class support must equal the forced positive degeneracy count"
 if !uniqueLabels c.occurrences || !(c.occurrences.all (fun x => Text.equal x.family "state-component")) then
  throw "state components must be unique retained occurrences"
 pure c

def buildClass (s : Signature) : Except String EquivalenceClass := do
 let occurrences ← (List.range (degeneracy s).value).mapM fun i =>
  heldLabel "state-component" (Text.append "component-" (toString (i+1)))
 validateClass ⟨s,occurrences⟩

def axisFromSymbol (symbol : String) : Except String AxisRank :=
 if Text.equal symbol "Σ" then .ok (.emptyOne "empty-One")
 else if Text.equal symbol "Π" then .ok (.count ⟨1,by decide⟩)
 else if Text.equal symbol "Δ" then .ok (.count ⟨2,by decide⟩)
 else if Text.equal symbol "Φ" then .ok (.count ⟨3,by decide⟩)
 else .error "source term symbol is outside the declared comparison grammar"

def optionalFromSource (family label : String) : Except String OptionalLabel :=
 if Text.equal label "absence" then .ok (.emptyOne "empty-One")
 else do pure (.held (← heldLabel family label))

def fromSource (molecule : String) (multiplicity : PositiveCount)
 (symbol inversion reflection component kind : String) : Except String Signature := do
 let axis ← axisFromSymbol symbol
 let carrier ← heldLabel "molecular-carrier" molecule
 let orientations : PositiveCount := match axis with
  | .emptyOne _ => ⟨1,by decide⟩
  | .count _ => ⟨2,by decide⟩
 let inversion ← optionalFromSource "inversion-symmetry" inversion
 let reflection ← optionalFromSource "reflection-symmetry" reflection
 let component ← optionalFromSource "axis-component" component
 let kind ← optionalFromSource "component-kind" kind
 validate ⟨carrier,multiplicity,axis,orientations,inversion,reflection,component,kind⟩

theorem degeneracyProduct (s : Signature) :
 (degeneracy s).value = s.multiplicity.value*s.orientationCount.value := rfl

theorem multiplicitySuccessor (m orientations : Nat) :
 (m+1)*orientations = m*orientations+orientations := Nat.succ_mul m orientations

#print axioms rightFamily
#print axioms validate
#print axioms degeneracy
#print axioms labelEqual
#print axioms optionalEqual
#print axioms axisEqual
#print axioms equivalent
#print axioms uniqueLabels
#print axioms validateClass
#print axioms buildClass
#print axioms axisFromSymbol
#print axioms optionalFromSource
#print axioms fromSource
#print axioms degeneracyProduct
#print axioms multiplicitySuccessor
end SFT.Chemistry.StateSymmetry
