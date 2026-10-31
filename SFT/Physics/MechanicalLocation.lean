import SFT.Physics.MechanicalDuration
namespace SFT.Physics.MechanicalLocation
open SFT.Foundation.ExactOperations SFT.Host.Canonical
-- The source holds support identities and their observations; no absolute
-- background position or signed length is introduced.
structure Location (Support : Type) where
  referenceIdentity : String
  support : Support
  observation : Value

inductive Held where
  | first | second

def opposite : Held → Held
  | .first => .second
  | .second => .first

structure Displacement (Support : Type) where
  first : Location Support
  second : Location Support
  separation : PositiveFraction
  held : Held

def heldEndpoint {Support : Type} (d : Displacement Support) : Location Support :=
  match d.held with | .first => d.first | .second => d.second

def reverse {Support : Type} (d : Displacement Support) : Displacement Support :=
  {d with held := opposite d.held}

def swapDescription {Support : Type} (d : Displacement Support) : Displacement Support :=
  ⟨d.second,d.first,d.separation,opposite d.held⟩

theorem oppositeTwice (h : Held) : opposite (opposite h) = h := by cases h <;> rfl

theorem reverseTwice {Support : Type} (d : Displacement Support) : reverse (reverse d) = d := by
  cases d with | mk a b x h => cases h <;> rfl

theorem reversePreservesMagnitude {Support : Type} (d : Displacement Support) :
    (reverse d).separation = d.separation := rfl

theorem reversePreservesSourcePair {Support : Type} (d : Displacement Support) :
    (reverse d).first = d.first ∧ (reverse d).second = d.second := ⟨rfl,rfl⟩

theorem reverseChangesHeld {Support : Type} (d : Displacement Support) :
    (reverse d).held ≠ d.held := by
  cases d with | mk a b x held => cases held <;> intro h <;> cases h

theorem separationPositive {Support : Type} (d : Displacement Support) :
    0 < d.separation.numerator := d.separation.positive

theorem pairRetainsReferences {Support : Type} (a b : Location Support)
    (x : PositiveFraction) (h : Held) :
    (Displacement.mk a b x h).first.referenceIdentity = a.referenceIdentity ∧
    (Displacement.mk a b x h).second.referenceIdentity = b.referenceIdentity := ⟨rfl,rfl⟩

theorem pairRetainsObservations {Support : Type} (a b : Location Support)
    (x : PositiveFraction) (h : Held) :
    (Displacement.mk a b x h).first.observation = a.observation ∧
    (Displacement.mk a b x h).second.observation = b.observation := ⟨rfl,rfl⟩

theorem swapRetainsHeldEndpoint {Support : Type} (d : Displacement Support) :
    heldEndpoint (swapDescription d) = heldEndpoint d := by
  cases d with | mk a b x held => cases held <;> rfl

theorem swapRetainsMagnitude {Support : Type} (d : Displacement Support) :
    (swapDescription d).separation = d.separation := rfl

theorem swapTwice {Support : Type} (d : Displacement Support) :
    swapDescription (swapDescription d) = d := by
  cases d with | mk a b x h => cases h <;> rfl

theorem changedReferenceDistinguished {Support : Type} (a b : Location Support)
    (changed : a.referenceIdentity ≠ b.referenceIdentity) : a ≠ b :=
  fun equal => changed (congrArg Location.referenceIdentity equal)

theorem changedSupportDistinguished {Support : Type} (a b : Location Support)
    (changed : a.support ≠ b.support) : a ≠ b :=
  fun equal => changed (congrArg Location.support equal)

theorem fullLocationReconstruction {Support : Type} (a : Location Support) :
    (⟨a.referenceIdentity,a.support,a.observation⟩ : Location Support) = a := rfl
end SFT.Physics.MechanicalLocation
