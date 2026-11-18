import SFT.Chemistry.BondDissociationEnergy
import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.DihedralTorsion
open SFT.Host SFT.Physics.CapabilityValues
open SFT.Foundation.ExactOperations SFT.Physics SFT.Physics.BoundaryGrowth
inductive CountInput where
 | count (value : PositiveCount)
 | other
-- Raw positive counts preserve PositiveRatio's stored fields. Arithmetic uses
-- its exact fraction; constructor equality remains equality of stored fields.
structure Ratio where
 numerator : PositiveCount
 denominator : PositiveCount
inductive Height where
 | emptyOne
 | ratio (value : Ratio)
 | otherEmptyOne (identity : String)
 | invalid

def rawRatio (value : PositiveFraction) : Ratio :=
 ⟨⟨value.numerator,value.positive⟩,⟨value.denominator,Nat.pos_of_ne_zero value.denominatorNonzero⟩⟩
def fraction (value : Ratio) : PositiveFraction :=
 normalizePositive value.numerator.value value.denominator.value value.numerator.positive value.denominator.positive

def generatedCoordinate (position sectors : CountInput) : Except String Height :=
 match position,sectors with
 | .count p,.count n =>
  if p.value > n.value+1 then .error "dihedral position exceeds the complete registered recurrence"
  else if p.value=1 then .ok .emptyOne
  else if h : 0 < p.value-1 then
   .ok (.ratio ⟨⟨p.value-1,h⟩,n⟩)
  else .error "dihedral position and sector support must be positive generated counts"
 | .other,.other => .error "dihedral position and sector support must be positive generated counts"
 | .other,.count _ => .error "dihedral position and sector support must be positive generated counts"
 | .count _,.other => .error "dihedral position and sector support must be positive generated counts"
def barrierTake (higher lower : Height) : Except String Ratio :=
 match higher with
 | .emptyOne | .otherEmptyOne _ | .invalid => .error "a torsional barrier must be an exact positive height"
 | .ratio high =>
  match lower with
  | .emptyOne => .ok high
  | .otherEmptyOne _ | .invalid => .error "barrier Take requires a strictly lower retained state"
  | .ratio low =>
   let h := fraction high
   let l := fraction low
   if ordered : l.numerator*h.denominator < h.numerator*l.denominator then
    .ok (rawRatio (LeptonTake.heldRemainder h l ordered))
   else .error "barrier Take requires a strictly lower retained state"
def equalLabel (a b : HeldLabel) : Bool := Text.equal a.family b.family && Text.equal a.label b.label
def equalHeight : Height → Height → Bool
 | .emptyOne,.emptyOne => true
 | .emptyOne,.otherEmptyOne identity => Text.equal identity "empty-One"
 | .otherEmptyOne identity,.emptyOne => Text.equal identity "empty-One"
 | .otherEmptyOne a,.otherEmptyOne b => Text.equal a b
 | .ratio a,.ratio b => a.numerator.value==b.numerator.value && a.denominator.value==b.denominator.value
 | .emptyOne,.ratio _ | .emptyOne,.invalid | .ratio _,.emptyOne | .ratio _,.otherEmptyOne _ | .ratio _,.invalid
 | .otherEmptyOne _,.ratio _ | .otherEmptyOne _,.invalid | .invalid,.emptyOne | .invalid,.ratio _
 | .invalid,.otherEmptyOne _ | .invalid,.invalid => false
-- Identity tests in _less are distinct from EmptyOne's dataclass equality.
def less : Height → Height → Except String Bool
 | .emptyOne,.emptyOne => .ok false
 | .emptyOne,.ratio _ | .emptyOne,.otherEmptyOne _ | .emptyOne,.invalid => .ok true
 | .ratio _,.emptyOne | .otherEmptyOne _,.emptyOne | .invalid,.emptyOne => .ok false
 | .ratio a,.ratio b => .ok (a.numerator.value*b.denominator.value < b.numerator.value*a.denominator.value)
 | .otherEmptyOne _,.ratio _ | .otherEmptyOne _,.otherEmptyOne _ | .otherEmptyOne _,.invalid
 | .ratio _,.otherEmptyOne _ => .error "'EmptyOne' object has no attribute 'fraction'"
 | .ratio _,.invalid | .invalid,.ratio _ | .invalid,.otherEmptyOne _ | .invalid,.invalid =>
  .error "invalid torsion height has no exact fraction"
structure Carrier where
 molecule : HeldLabel
 molecularState : HeldLabel
 orderedAtoms : List HeldLabel
 rotorType : HeldLabel
 orientation : HeldLabel
def distinctAtoms : List HeldLabel → Bool
 | [] => true
 | first::rest => !(rest.any (equalLabel first)) && distinctAtoms rest
def validateCarrier (carrier : Carrier) : Except String Carrier := do
 if !Text.equal carrier.molecule.family "molecular-carrier" || !Text.equal carrier.molecularState.family "molecular-state" then
  throw "dihedral carrier must retain molecule and molecular state"
 if carrier.orderedAtoms.length != 4 || !(carrier.orderedAtoms.all fun atom => Text.equal atom.family "ordered-torsion-atom") then
  throw "dihedral carrier requires exactly four ordered atom labels"
 if !distinctAtoms carrier.orderedAtoms then throw "dihedral carrier atom positions must remain distinguishable"
 if !Text.equal carrier.rotorType.family "rotor-type" || !Text.equal carrier.orientation.family "held-orientation" then
  throw "rotor type and orientation must remain held"
 pure carrier
def equalLabels : List HeldLabel → List HeldLabel → Bool
 | [],[] => true
 | a::as,b::bs => equalLabel a b && equalLabels as bs
 | [],_::_ | _::_,[] => false
def equalCarrier (a b : Carrier) : Bool :=
 equalLabel a.molecule b.molecule && equalLabel a.molecularState b.molecularState &&
 equalLabels a.orderedAtoms b.orderedAtoms && equalLabel a.rotorType b.rotorType && equalLabel a.orientation b.orientation
structure Node where
 carrier : Carrier
 position : PositiveCount
 coordinate : Height
 height : Height
 record : HeldLabel
def validHeight : Height → Bool
 | .emptyOne | .ratio _ | .otherEmptyOne _ => true
 | .invalid => false
def validateNode (node : Node) : Except String Node := do
 if !validHeight node.coordinate then throw "torsion coordinate must be EmptyOne or an exact positive part"
 if !validHeight node.height then throw "torsion height must be EmptyOne or an exact positive ratio"
 if !Text.equal node.record.family "torsion-record" then throw "torsion node must retain its source record"
 pure node

theorem initialCoordinate (n : PositiveCount) :
 generatedCoordinate (.count ⟨1,by decide⟩) (.count n) = .ok .emptyOne := by
 dsimp only [generatedCoordinate]
 rw [ite_eq_right (Nat.not_lt_of_ge (Nat.succ_le_succ (Nat.zero_le n.value)))]
 rfl
theorem generatedSuccessor (p n : PositiveCount) (within : p.value ≤ n.value+1)
 (positiveStep : 0 < p.value-1) :
 generatedCoordinate (.count p) (.count n) =
 .ok (.ratio ⟨⟨p.value-1,positiveStep⟩,n⟩) := by
 have different : p.value ≠ 1 := by
  intro same
  rw [same] at positiveStep
  cases positiveStep
 dsimp only [generatedCoordinate]
 rw [ite_eq_right (Nat.not_lt_of_ge within),ite_eq_right different,dite_eq_left positiveStep]
theorem recurrentCoordinate (n : PositiveCount) :
 generatedCoordinate (.count ⟨n.value+1,Nat.zero_lt_succ n.value⟩) (.count n) =
 .ok (.ratio ⟨n,n⟩) :=
 generatedSuccessor ⟨n.value+1,Nat.zero_lt_succ n.value⟩ n (Nat.le_refl _) n.positive

theorem takeEmpty (higher : Ratio) : barrierTake (.ratio higher) .emptyOne = .ok higher := rfl
theorem barrierTakeExact (higher lower : Ratio)
 (ordered : (fraction lower).numerator*(fraction higher).denominator <
  (fraction higher).numerator*(fraction lower).denominator) :
 barrierTake (.ratio higher) (.ratio lower) =
 .ok (rawRatio (LeptonTake.heldRemainder (fraction higher) (fraction lower) ordered)) := by
 dsimp only [barrierTake]
 rw [dite_eq_left ordered]
theorem barrierMagnitude (higher lower : Ratio)
 (ordered : (fraction lower).numerator*(fraction higher).denominator <
  (fraction higher).numerator*(fraction lower).denominator) :
 ((fraction higher).numerator*(fraction lower).denominator-(fraction lower).numerator*(fraction higher).denominator)*
 (LeptonTake.heldRemainder (fraction higher) (fraction lower) ordered).denominator =
 (LeptonTake.heldRemainder (fraction higher) (fraction lower) ordered).numerator *
 ((fraction higher).denominator*(fraction lower).denominator) :=
 LeptonTake.remainderValue (fraction higher) (fraction lower) ordered
end SFT.Chemistry.DihedralTorsion
