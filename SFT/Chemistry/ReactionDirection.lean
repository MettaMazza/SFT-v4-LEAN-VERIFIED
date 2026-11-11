import SFT.Chemistry.ReactionThermochemistry
import SFT.Chemistry.ReactionMechanism
namespace SFT.Chemistry.ReactionDirection
abbrev PositiveCount := SFT.Physics.CapabilityValues.PositiveCount
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel
structure Raw where
 forwardSupport : PositiveCount
 reverseSupport : PositiveCount
 selectedOrientation : HeldLabel

def admit (r : Raw) : Except String Raw :=
 if SFT.Host.Text.equal r.selectedOrientation.family "reaction-direction" then .ok r
 else .error "reaction direction must be held"
inductive Orientation where | forward | reverse
 deriving DecidableEq

def select (forward reverse : Nat) : Option Orientation :=
 if reverse < forward then some .forward
 else if forward < reverse then some .reverse else none

theorem forwardSelected (f r : Nat) (h : r<f) : select f r=some .forward := by
 unfold select
 split
 · rfl
 · rename_i no; exact False.elim (no h)
theorem reverseSelected (f r : Nat) (h : f<r) : select f r=some .reverse := by
 unfold select
 split
 · rename_i wrong; exact False.elim (Nat.lt_asymm h wrong)
 · rfl
theorem tieEmpty (n : Nat) : select n n=none := by
 unfold select
 split
 · rename_i wrong; exact False.elim (Nat.lt_irrefl _ wrong)
 · rfl

theorem forwardOnlyIf (f r : Nat) (h : select f r=some .forward) : r<f := by
 unfold select at h
 split at h
 · assumption
 · split at h <;> cases h

theorem reverseOnlyIf (f r : Nat) (h : select f r=some .reverse) : f<r := by
 unfold select at h
 split at h
 · cases h
 · split at h
   · assumption
   · cases h

theorem emptyOnlyIf (f r : Nat) (h : select f r=none) : f=r := by
 unfold select at h
 split at h
 · cases h
 · rename_i notForward
   split at h
   · cases h
   · rename_i notReverse
     exact Nat.le_antisymm (Nat.le_of_not_gt notForward) (Nat.le_of_not_gt notReverse)

structure Path where
 mechanism : ReactionMechanism.Mechanism
 steps : List ReactionMechanism.BoundStep
 completeSteps : steps.map ReactionMechanism.BoundStep.step=mechanism.raw.steps
 energy : List ReactionThermochemistry.Record
 completeEnergy : energy.map (fun r => r.reaction.trace)=
  steps.map (fun s => s.reaction.trace)
 distinctions : List HeldLabel
 support : PositiveCount
 completeSupport : distinctions.length=support.value
 conditions : HeldLabel
 energyConditions : ∀ r ∈ energy, r.raw.conditions=conditions

-- The source supplies complete condition-bound path support. No target value
-- or imported spontaneity equation enters the comparison.
structure Comparison where
 forward : Path
 reverse : Path
 sameConditions : forward.conditions=reverse.conditions
 forwardStart : String
 forwardEnd : String
 forwardChain : ReactionMechanism.Chain forwardStart forwardEnd forward.mechanism.raw.steps
 reverseChain : ReactionMechanism.Chain forwardEnd forwardStart reverse.mechanism.raw.steps

def direction (c : Comparison) := select c.forward.support.value c.reverse.support.value

theorem completeCensusDeterminesDirection (c : Comparison) :
 direction c=select c.forward.distinctions.length c.reverse.distinctions.length := by
 rw [c.forward.completeSupport,c.reverse.completeSupport]
 rfl

theorem completeForwardPreference (c : Comparison)
 (h : c.reverse.distinctions.length<c.forward.distinctions.length) : direction c=some .forward := by
 rw [completeCensusDeterminesDirection]
 exact forwardSelected _ _ h

theorem completeReversePreference (c : Comparison)
 (h : c.forward.distinctions.length<c.reverse.distinctions.length) : direction c=some .reverse := by
 rw [completeCensusDeterminesDirection]
 exact reverseSelected _ _ h

theorem completeTieEmpty (c : Comparison)
 (h : c.forward.distinctions.length=c.reverse.distinctions.length) : direction c=none := by
 rw [completeCensusDeterminesDirection,h]
 exact tieEmpty _

theorem retainedForwardEnergy (c : Comparison) (r : ReactionThermochemistry.Record)
 (_held : r∈c.forward.energy) :
 r.raw.outputSupport.value+r.ledger.released.length=r.raw.inputSupport.value+r.ledger.absorbed.length :=
 ReactionThermochemistry.completeReactionEnergyBalance r

theorem retainedReverseEnergy (c : Comparison) (r : ReactionThermochemistry.Record)
 (_held : r∈c.reverse.energy) :
 r.raw.outputSupport.value+r.ledger.released.length=r.raw.inputSupport.value+r.ledger.absorbed.length :=
 ReactionThermochemistry.completeReactionEnergyBalance r

theorem sameStrictOrderSameDirection (f r f' r' : Nat)
 (forwardOrder : (r<f) ↔ (r'<f')) (reverseOrder : (f<r) ↔ (f'<r')) :
 select f r=select f' r' := by
 by_cases hf : r<f
 · rw [forwardSelected _ _ hf,forwardSelected _ _ (forwardOrder.mp hf)]
 · by_cases hr : f<r
   · rw [reverseSelected _ _ hr,reverseSelected _ _ (reverseOrder.mp hr)]
   · have equal : f=r := Nat.le_antisymm (Nat.le_of_not_gt hf) (Nat.le_of_not_gt hr)
     have hf' : ¬ r'<f' := fun h => hf (forwardOrder.mpr h)
     have hr' : ¬ f'<r' := fun h => hr (reverseOrder.mpr h)
     have equal' : f'=r' := Nat.le_antisymm (Nat.le_of_not_gt hf') (Nat.le_of_not_gt hr')
     rw [equal,equal',tieEmpty,tieEmpty]

theorem changedDirectionRequiresChangedOrder (f r f' r' : Nat)
 (changed : select f r≠select f' r') :
 ¬ ((r<f ↔ r'<f') ∧ (f<r ↔ f'<r')) :=
 fun h => changed (sameStrictOrderSameDirection _ _ _ _ h.1 h.2)

def appendDistinction (p : Path) (d : HeldLabel) : Path where
 mechanism := p.mechanism
 steps := p.steps
 completeSteps := p.completeSteps
 energy := p.energy
 completeEnergy := p.completeEnergy
 distinctions := p.distinctions++[d]
 support := ⟨p.support.value+1,Nat.zero_lt_succ _⟩
 completeSupport := by
  rw [SFT.Foundation.CommonRefinement.appendLength,p.completeSupport]
  rfl
 conditions := p.conditions
 energyConditions := p.energyConditions

theorem successorRetainsEveryDistinction (p : Path) (d old : HeldLabel)
 (held : old∈p.distinctions) : old∈(appendDistinction p d).distinctions :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem successorKeepsEnergyAndConditions (p : Path) (d : HeldLabel) :
 (appendDistinction p d).energy=p.energy ∧ (appendDistinction p d).conditions=p.conditions := ⟨rfl,rfl⟩

theorem successorExactCount (p : Path) (d : HeldLabel) :
 (appendDistinction p d).support.value=p.support.value+1 := rfl

def originalRaw : Raw := ⟨⟨3,by decide⟩,⟨2,by decide⟩,⟨"reaction-direction","forward",rfl,rfl⟩⟩
theorem originalAdmitted : admit originalRaw=.ok originalRaw := rfl
theorem originalBase : select originalRaw.forwardSupport.value originalRaw.reverseSupport.value=some .forward := rfl
end SFT.Chemistry.ReactionDirection
