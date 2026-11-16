import SFT.Chemistry.StateEnergyOrder
namespace SFT.Chemistry.StateEnergyOrder
open SFT.Host SFT.Physics.CapabilityValues

def baseOrder : Except String ExactFiniteStateOrder :=
 buildExactStateOrder "molecule" ["ground","first-excited","second-excited"]
def groundWitness : Bool := match baseOrder with
 | .error _ => false
 | .ok order => match groundState order with
  | .error _ => false
  | .ok row => Text.equal row.stateIdentity.label "ground"
def excitationWitness : Bool := match baseOrder with
 | .error _ => false
 | .ok order => match order.states with
  | a::b::c::[] => match precedes a b,precedes b c with
   | .ok x,.ok y => x && y
   | .error _,_ => false
   | .ok _,.error _ => false
  | [] | _::[] | _::_::[] | _::_::_::_::_ => false

def controlRow (label : String) (nonempty : nonblank label = true) (position : OrderPosition) : OrderedMolecularState :=
 ⟨⟨"molecular-carrier","bad",by decide,by decide⟩,⟨"molecular-electronic-state",label,by decide,nonempty⟩,position,⟨"molecular-support",label,by decide,nonempty⟩⟩
def duplicateGroundTrial : Except String ExactFiniteStateOrder :=
 validOrder ⟨⟨"molecular-carrier","bad",by decide,by decide⟩,[controlRow "a" (by decide) (.emptyOne "empty-One"),controlRow "b" (by decide) (.emptyOne "empty-One")]⟩
def missingSuccessorTrial : Except String ExactFiniteStateOrder :=
 validOrder ⟨⟨"molecular-carrier","bad",by decide,by decide⟩,[controlRow "a" (by decide) (.emptyOne "empty-One"),controlRow "b" (by decide) (.count ⟨2,by decide⟩)]⟩
def rejected {α : Type} : Except String α → Bool
 | .error _ => true
 | .ok _ => false
def duplicateGroundWitness : Bool := rejected duplicateGroundTrial
def missingSuccessorWitness : Bool := rejected missingSuccessorTrial

theorem uniqueStructuralGroundPassed : groundWitness = true := rfl
theorem positiveExcitationOrderPassed : excitationWitness = true := rfl
theorem duplicateGroundRejected : duplicateGroundTrial = .error "finite molecular state order requires one structural least state" := rfl
theorem missingSuccessorRejected : missingSuccessorTrial = .error "excited states must exhaust the positive successor positions exactly once" := rfl

#print axioms baseOrder
#print axioms groundWitness
#print axioms excitationWitness
#print axioms controlRow
#print axioms duplicateGroundTrial
#print axioms missingSuccessorTrial
#print axioms rejected
#print axioms duplicateGroundWitness
#print axioms missingSuccessorWitness
#print axioms uniqueStructuralGroundPassed
#print axioms positiveExcitationOrderPassed
#print axioms duplicateGroundRejected
#print axioms missingSuccessorRejected
end SFT.Chemistry.StateEnergyOrder
