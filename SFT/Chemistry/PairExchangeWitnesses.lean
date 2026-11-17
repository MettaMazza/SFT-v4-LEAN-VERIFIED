import SFT.Chemistry.PairExchange
namespace SFT.Chemistry.PairExchangeWitnesses
open PairExchange StateSymmetry

def singlet := fromMultiplicity "H2" "singlet" ⟨1,by decide⟩
def triplet := fromMultiplicity "H2" "triplet" ⟨3,by decide⟩
def sameSupport := buildSameSupport "H2" "2s-sigma" "singlet" "triplet"
def singletSector : Bool := match singlet with
 | .error _ => false
 | .ok s => labelEqual s.spinExchange alternating && labelEqual s.spatialExchange preserving && labelEqual s.sameCellStatus sameCellAdmitted
def tripletSector : Bool := match triplet with
 | .error _ => false
 | .ok s => labelEqual s.spinExchange preserving && labelEqual s.spatialExchange alternating && labelEqual s.sameCellStatus sameCellExcluded
def alternatingTotal : Bool := match singlet,triplet with
 | .ok a,.ok b => labelEqual a.totalExchange b.totalExchange && labelEqual b.totalExchange alternating
 | .error _,_ | .ok _,.error _ => false
def sameSupportPair : Bool := match sameSupport with
 | .error _ => false
 | .ok p => !(labelEqual p.singlet.stateIdentity p.triplet.stateIdentity)
def sameCellControl : Bool := match triplet with
 | .error _ => false
 | .ok s => match occupancyCompatible s ⟨2,by decide⟩ with
  | .ok b => !b
  | .error _ => false
def thirdOccurrenceControl : Bool := match singlet with
 | .error _ => false
 | .ok s => match occupancyCompatible s ⟨3,by decide⟩ with
  | .error _ => true
  | .ok _ => false
theorem singletSectorPassed : singletSector = true := rfl
theorem tripletSectorPassed : tripletSector = true := rfl
theorem alternatingTotalPassed : alternatingTotal = true := rfl
theorem sameSupportPairPassed : sameSupportPair = true := rfl
theorem sameCellControlPassed : sameCellControl = true := rfl
theorem thirdOccurrenceControlPassed : thirdOccurrenceControl = true := rfl

#print axioms singlet
#print axioms triplet
#print axioms sameSupport
#print axioms singletSector
#print axioms tripletSector
#print axioms alternatingTotal
#print axioms sameSupportPair
#print axioms sameCellControl
#print axioms thirdOccurrenceControl
#print axioms singletSectorPassed
#print axioms tripletSectorPassed
#print axioms alternatingTotalPassed
#print axioms sameSupportPairPassed
#print axioms sameCellControlPassed
#print axioms thirdOccurrenceControlPassed
end SFT.Chemistry.PairExchangeWitnesses
