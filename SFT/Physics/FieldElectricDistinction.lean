import SFT.Physics.FieldGravitation
namespace SFT.Physics.FieldElectricDistinction
open SFT.Foundation.ExactOperations

-- The original Fold distinction supplies both labels; no signed magnitude.
abbrev Held := MechanicalLocation.Held

structure Charge where
  amount : PositiveFraction
  held : Held

def reverse (q : Charge) : Charge := ⟨q.amount,MechanicalLocation.opposite q.held⟩

inductive Interaction where
  | equalHeld | oppositeHeld

def interaction (left right : Charge) : Interaction :=
  match left.held, right.held with
  | .first,.first => .equalHeld
  | .first,.second => .oppositeHeld
  | .second,.first => .oppositeHeld
  | .second,.second => .equalHeld

theorem twoFibresExhaust (q : Charge) : q.held = .first ∨ q.held = .second := by
  cases h : q.held
  · exact Or.inl rfl
  · exact Or.inr rfl

theorem fibresDistinct : (MechanicalLocation.Held.first : Held) ≠ .second := by intro h; cases h

theorem reversalRetainsAmount (q : Charge) : (reverse q).amount = q.amount := rfl

theorem reversedTwice (q : Charge) : reverse (reverse q) = q := by
  cases q with | mk amount held => cases held <;> rfl

theorem positiveSupport (q : Charge) : 0 < q.amount.numerator := q.amount.positive

theorem sameHeldClass (q : Charge) : interaction q q = .equalHeld := by
  cases q with | mk amount held => cases held <;> rfl

theorem oppositeHeldClass (q : Charge) : interaction q (reverse q) = .oppositeHeld := by
  cases q with | mk amount held => cases held <;> rfl

def reverseClass : Interaction → Interaction
  | .equalHeld => .oppositeHeld
  | .oppositeHeld => .equalHeld

theorem reversingOneChangesClass (q r : Charge) : interaction (reverse q) r = reverseClass (interaction q r) := by
  cases q with
  | mk a h => cases r with | mk b k => cases h <;> cases k <;> rfl

theorem reversingBothRetainsClass (q r : Charge) : interaction (reverse q) (reverse r) = interaction q r := by
  cases q with
  | mk a h => cases r with | mk b k => cases h <;> cases k <;> rfl

theorem closedChargeConservation {Node : Type} (network : MechanicalConservation.Network Node Charge) :
    MechanicalConservation.outgoingSupport network = MechanicalConservation.incomingSupport network :=
  MechanicalConservation.completeConservation network

theorem closedHeldLabelConservation {Node : Type} (network : MechanicalConservation.Network Node Charge) :
    (MechanicalConservation.outgoingSupport network).map Charge.held =
      (MechanicalConservation.incomingSupport network).map Charge.held :=
  congrArg (List.map Charge.held) (closedChargeConservation network)

end SFT.Physics.FieldElectricDistinction
