import SFT.Physics.MatterMassEnergy
namespace SFT.Physics.MatterAntiparticle
open MechanicalLocation SFT.Foundation.ExactOperations

structure Constituent where
  word : QuantumPhysicalState.Prepared
  inertial : PositiveFraction
  spin : QuantumPhysicalSpin.Action word
  transitionGrammar : List SFT.Host.Canonical.Value
  orientedLabels : List (String × Held)

def reverseLabels (labels : List (String × Held)) := labels.map (fun row => (row.1,opposite row.2))

def reverse (p : Constituent) : Constituent := {p with orientedLabels := reverseLabels p.orientedLabels}

theorem labelReversalTwice (labels : List (String × Held)) : reverseLabels (reverseLabels labels) = labels := by
  induction labels with
  | nil => rfl
  | cons row rest ih =>
    change (row.1,opposite (opposite row.2)) :: _ = row :: rest
    rw [oppositeTwice]
    exact congrArg (List.cons row) ih

theorem constituentReversalTwice (p : Constituent) : reverse (reverse p) = p := by
  change {p with orientedLabels := reverseLabels (reverseLabels p.orientedLabels)} = p
  rw [labelReversalTwice]

theorem identicalPositiveInertialSupport (p : Constituent) :
    (reverse p).inertial = p.inertial ∧ 0 < (reverse p).inertial.numerator := ⟨rfl,p.inertial.positive⟩

theorem sameWordSpinAndTransitionGrammar (p : Constituent) :
    (reverse p).word = p.word ∧ (reverse p).spin = p.spin ∧
      (reverse p).transitionGrammar = p.transitionGrammar := ⟨rfl,rfl,rfl⟩

theorem everyOrientedLabelReversed (p : Constituent) (name : String) (held : Held)
    (present : (name,held) ∈ p.orientedLabels) : (name,opposite held) ∈ (reverse p).orientedLabels :=
  SFT.Foundation.Count.TraceDerivation.memMap _ _ _ present

theorem allLabelIdentitiesRetained (p : Constituent) :
    (reverse p).orientedLabels.map Prod.fst = p.orientedLabels.map Prod.fst := by
  change (reverseLabels p.orientedLabels).map Prod.fst = p.orientedLabels.map Prod.fst
  induction p.orientedLabels with
  | nil => rfl
  | cons row rest ih => exact congrArg (List.cons row.1) ih

theorem noLabelAddedOrDeleted (p : Constituent) : (reverse p).orientedLabels.length = p.orientedLabels.length :=
  SFT.Foundation.CommonRefinement.mapLength _ _

theorem reversedHeldLabelIsDistinct (name : String) (held : Held) : (name,opposite held) ≠ (name,held) :=
  fun eq => QuantumPhysicalExclusion.oppositeNeverSame held (congrArg Prod.snd eq)
end SFT.Physics.MatterAntiparticle
