import SFT.Chemistry.StateSymmetry
namespace SFT.Chemistry.StateSymmetryWitnesses
open SFT.Chemistry.StateSymmetry SFT.Physics.CapabilityValues

def sigma : Except String Signature := fromSource "H2" ⟨1,by decide⟩ "Σ" "g" "plus-fibre" "absence" "absence"
def pi : Except String Signature := fromSource "NO" ⟨2,by decide⟩ "Π" "absence" "absence" "absence" "r"
def sigmaClass : Bool :=
 match sigma >>= buildClass with
 | .ok c => Nat.beq (degeneracy c.signature).value 1
 | .error _ => false

def piClass : Bool :=
 match pi >>= buildClass with
 | .ok c => Nat.beq (degeneracy c.signature).value 4
 | .error _ => false

def distinctSignatures : Bool :=
 match sigma,pi with
 | .ok a,.ok b => !(equivalent a b)
 | .error _,_ | .ok _,.error _ => false

def badOrientation : Bool :=
 match fromSource "bad" ⟨1,by decide⟩ "Σ" "absence" "absence" "absence" "absence" with
 | .error _ => false
 | .ok s => match validate {s with orientationCount:=⟨2,by decide⟩} with
   | .ok _ => false
   | .error _ => true

def incompleteClass : Bool :=
 match pi,heldLabel "state-component" "one" with
 | .ok s,.ok label => match validateClass ⟨s,[label]⟩ with
   | .ok _ => false
   | .error _ => true
 | .error _,_ | .ok _,.error _ => false

theorem sigmaClassPassed : sigmaClass = true := rfl
theorem piClassPassed : piClass = true := rfl
theorem distinctSignaturesPassed : distinctSignatures = true := rfl
theorem badOrientationPassed : badOrientation = true := rfl
theorem incompleteClassPassed : incompleteClass = true := rfl
#print axioms sigma
#print axioms pi
#print axioms sigmaClass
#print axioms piClass
#print axioms distinctSignatures
#print axioms badOrientation
#print axioms incompleteClass
#print axioms sigmaClassPassed
#print axioms piClassPassed
#print axioms distinctSignaturesPassed
#print axioms badOrientationPassed
#print axioms incompleteClassPassed
end SFT.Chemistry.StateSymmetryWitnesses
