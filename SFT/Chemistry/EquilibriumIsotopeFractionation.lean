import SFT.Chemistry.IsotopeExchange
namespace SFT.Chemistry.EquilibriumIsotopeFractionation
open SFT.Host SFT.Physics.CapabilityValues
structure Partition where
 lightIsotope : HeldLabel
 heavyIsotope : HeldLabel
 phaseA : HeldLabel
 phaseB : HeldLabel
 lightA : PositiveCount
 heavyA : PositiveCount
 lightB : PositiveCount
 heavyB : PositiveCount

def construct (l h a b : HeldLabel) (la ha lb hb : PositiveCount) : Except String Partition := do
 if !(Text.equal l.family "isotope" && Text.equal h.family "isotope" && Text.equal a.family "chemical-phase" && Text.equal b.family "chemical-phase") then
  throw "complete equilibrium isotope partition required"
 if IsotopeExchange.sameLabel l h || IsotopeExchange.sameLabel a b then
  throw "distinct isotopes and phases required"
 return ⟨l,h,a,b,la,ha,lb,hb⟩
def normalized (n d : Nat) : Nat × Nat := let g := Nat.gcd n d; (n/g,d/g)
def ratioA (s : Partition) : Nat × Nat := normalized s.heavyA.value s.lightA.value
def ratioB (s : Partition) : Nat × Nat := normalized s.heavyB.value s.lightB.value
def factor (s : Partition) : Nat × Nat := normalized (s.heavyA.value*s.lightB.value) (s.lightA.value*s.heavyB.value)
def orientation (s : Partition) : Except String Value := do
 let left := s.heavyA.value*s.lightB.value
 let right := s.lightA.value*s.heavyB.value
 if left == right then return .emptyOne "empty-One"
 return .label (← heldLabel "fractionation-orientation" (if left > right then "phase-A-heavy-enriched" else "phase-B-heavy-enriched"))
def partition (la : Nat := 4) (ha : Nat := 2) (lb : Nat := 6) (hb : Nat := 1) : Except String Partition := do
 construct (← heldLabel "isotope" "light") (← heldLabel "isotope" "heavy") (← heldLabel "chemical-phase" "A") (← heldLabel "chemical-phase" "B") (← count la) (← count ha) (← count lb) (← count hb)
def identityWitness : Bool := match partition with
 | .ok s => !IsotopeExchange.sameLabel s.lightIsotope s.heavyIsotope
 | .error _ => false
def phasesWitness : Bool := match partition with
 | .ok s => !IsotopeExchange.sameLabel s.phaseA s.phaseB
 | .error _ => false
def inventoryWitness : Bool := match partition with
 | .ok s => s.lightA.value > 0 && s.heavyA.value > 0 && s.lightB.value > 0 && s.heavyB.value > 0
 | .error _ => false
def ratiosWitness : Bool := match partition with
 | .ok s => ratioA s == (1,2) && ratioB s == (1,6)
 | .error _ => false
def factorWitness : Bool := match partition with
 | .ok s => factor s == (3,1)
 | .error _ => false
def orientationWitness : Bool := IsotopeExchange.transitionLabel (do orientation (← partition)) "phase-A-heavy-enriched"
def coincidenceWitness : Bool := match partition 4 2 6 3 with
 | .ok s => match orientation s with
  | .ok (.emptyOne _) => factor s == (1,1)
  | .ok (.label _) | .ok (.count _) | .ok (.ratio _ _) | .ok (.word _) | .ok (.pair _ _) | .ok (.table _) | .error _ => false
 | .error _ => false
def extensionWitness : Bool := match partition 6 3 8 2 with
 | .ok s => factor s == (2,1)
 | .error _ => false
theorem identityWitnessPassed : identityWitness = true := rfl
theorem phasesWitnessPassed : phasesWitness = true := rfl
theorem inventoryWitnessPassed : inventoryWitness = true := rfl
theorem ratiosWitnessPassed : ratiosWitness = true := rfl
theorem factorWitnessPassed : factorWitness = true := rfl
theorem orientationWitnessPassed : orientationWitness = true := rfl
theorem coincidenceWitnessPassed : coincidenceWitness = true := rfl
theorem extensionWitnessPassed : extensionWitness = true := rfl
end SFT.Chemistry.EquilibriumIsotopeFractionation
