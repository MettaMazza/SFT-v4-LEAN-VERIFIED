import SFT.Physics.CapabilityValues
namespace SFT.Chemistry.IsotopeExchange
open SFT.Host SFT.Physics.CapabilityValues
structure State where
 element : HeldLabel
 lightIsotope : HeldLabel
 heavyIsotope : HeldLabel
 carrierA : HeldLabel
 carrierB : HeldLabel
 lightA : PositiveCount
 heavyA : PositiveCount
 lightB : PositiveCount
 heavyB : PositiveCount

def sameLabel (a b : HeldLabel) : Bool := Text.equal a.family b.family && Text.equal a.label b.label
def construct (e l h a b : HeldLabel) (la ha lb hb : PositiveCount) : Except String State := do
 if !(Text.equal e.family "element" && Text.equal l.family "isotope" && Text.equal h.family "isotope" && Text.equal a.family "chemical-carrier" && Text.equal b.family "chemical-carrier") then
  throw "complete isotope-exchange state required"
 if sameLabel l h || sameLabel a b then throw "distinct isotopes and carriers required"
 return ⟨e,l,h,a,b,la,ha,lb,hb⟩
def quotient (s : State) : Nat × Nat :=
 let n := s.heavyB.value*s.lightA.value
 let d := s.lightB.value*s.heavyA.value
 let g := Nat.gcd n d
 (n/g,d/g)
def sameIdentities (a b : State) : Bool :=
 sameLabel a.element b.element && sameLabel a.lightIsotope b.lightIsotope && sameLabel a.heavyIsotope b.heavyIsotope && sameLabel a.carrierA b.carrierA && sameLabel a.carrierB b.carrierB
def conserved (a b : State) : Bool :=
 a.lightA.value+a.lightB.value==b.lightA.value+b.lightB.value &&
 a.heavyA.value+a.heavyB.value==b.heavyA.value+b.heavyB.value &&
 a.lightA.value+a.heavyA.value==b.lightA.value+b.heavyA.value &&
 a.lightB.value+a.heavyB.value==b.lightB.value+b.heavyB.value
def sameInventory (a b : State) : Bool := a.lightA.value==b.lightA.value && a.heavyA.value==b.heavyA.value && a.lightB.value==b.lightB.value && a.heavyB.value==b.heavyB.value
def exchangeTransition (before after : State) : Except String Value := do
 if !sameIdentities before after then throw "exchange identities changed"
 if !conserved before after then throw "isotope or carrier total not conserved"
 if sameInventory before after then return .emptyOne "empty-One"
 return .label (← heldLabel "exchange-orientation" (if after.heavyB.value>before.heavyB.value then "heavy-A-to-B" else "heavy-B-to-A"))
def eventBalance (forward reverse : PositiveCount) : Except String Value := do
 if forward.value==reverse.value then return .emptyOne "empty-One"
 if forward.value>reverse.value then
  return .pair (.label (← heldLabel "exchange-event-balance" "forward-excess")) (.count (← count (forward.value-reverse.value)))
 return .pair (.label (← heldLabel "exchange-event-balance" "reverse-excess")) (.count (← count (reverse.value-forward.value)))
def state (la ha lb hb : Nat) : Except String State := do
 construct (← heldLabel "element" "oxygen") (← heldLabel "isotope" "light") (← heldLabel "isotope" "heavy") (← heldLabel "chemical-carrier" "A") (← heldLabel "chemical-carrier" "B") (← count la) (← count ha) (← count lb) (← count hb)
def before : Except String State := state 4 2 3 1
def after : Except String State := state 5 1 2 2
def transitionLabel (v : Except String Value) (label : String) : Bool := match v with
 | .ok (.label l) => Text.equal l.label label
 | .ok (.emptyOne _) | .ok (.count _) | .ok (.ratio _ _) | .ok (.word _) | .ok (.pair _ _) | .ok (.table _) | .error _ => false
def identityWitness : Bool := match before with | .ok s => !sameLabel s.lightIsotope s.heavyIsotope | .error _ => false
def carriersWitness : Bool := match before with | .ok s => !sameLabel s.carrierA s.carrierB | .error _ => false
def inventoryWitness : Bool := match before with | .ok s => s.lightA.value>0 && s.heavyA.value>0 && s.lightB.value>0 && s.heavyB.value>0 | .error _ => false
def conservationWitness : Bool := transitionLabel (do exchangeTransition (← before) (← after)) "heavy-A-to-B"
def directionWitness : Bool := match (do eventBalance (← count 3) (← count 1)) with
 | .ok (.pair left _) => match left with
  | .label l => Text.equal l.label "forward-excess"
  | .emptyOne _ | .count _ | .ratio _ _ | .word _ | .pair _ _ | .table _ => false
 | .ok (.emptyOne _) | .ok (.count _) | .ok (.ratio _ _) | .ok (.label _) | .ok (.word _) | .ok (.table _) | .error _ => false
def quotientWitness : Bool := match before with | .ok s => (quotient s).1==2 && (quotient s).2==3 | .error _ => false
def equilibriumWitness : Bool := match (do eventBalance (← count 2) (← count 2)) with
 | .ok (.emptyOne _) => true
 | .ok (.count _) | .ok (.ratio _ _) | .ok (.label _) | .ok (.word _) | .ok (.pair _ _) | .ok (.table _) | .error _ => false
def successorWitness : Bool := transitionLabel (do exchangeTransition (← after) (← before)) "heavy-B-to-A"
theorem identityWitnessPassed : identityWitness = true := rfl
theorem carriersWitnessPassed : carriersWitness = true := rfl
theorem inventoryWitnessPassed : inventoryWitness = true := rfl
theorem conservationWitnessPassed : conservationWitness = true := rfl
theorem directionWitnessPassed : directionWitness = true := rfl
theorem quotientWitnessPassed : quotientWitness = true := rfl
theorem equilibriumWitnessPassed : equilibriumWitness = true := rfl
theorem successorWitnessPassed : successorWitness = true := rfl
end SFT.Chemistry.IsotopeExchange
