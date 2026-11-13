import SFT.Physics.MatterExchangeSpin
import SFT.Physics.SuperconductivityRecurrenceProofs
namespace SFT.Materials.PairedCarrier
open SFT.Physics.MechanicalLocation SFT.Physics.QuantumPhysicalIdentity

-- Original SC-PAIR: retain both opposed fermionic labels. An alternating
-- constituent action is the already derived opposite held orientation.
def pair (label : Held) : Pair Held := ⟨label,opposite label⟩

theorem opposedDistinct (label : Held) : (pair label).left ≠ (pair label).right := by
 intro same
 exact SFT.Physics.QuantumPhysicalExclusion.oppositeNeverSame label same.symm

theorem completeOpposedPairs (p : Pair Held) (opposed : p.right = opposite p.left) :
 p = pair .first ∨ p = pair .second := by
 cases p with
 | mk left right => cases left <;> cases right
                    · cases opposed
                    · exact Or.inl rfl
                    · exact Or.inr rfl
                    · cases opposed

def support (label : Held) : List Held := [(pair label).left,(pair label).right]

theorem pairHasTwoLabels (label : Held) : (support label).length = 2 := rfl

theorem noSingletonHoldsBoth (label single : Held) :
 ¬ (label ∈ [single] ∧ opposite label ∈ [single]) := by
 intro h
 have only : ∀ a b : Held, a ∈ [b] → a = b := by
  intro a b member
  cases member with
  | head => rfl
  | tail _ absent => cases absent
 have left : label = single := only _ _ h.1
 have right : opposite label = single := only _ _ h.2
 exact SFT.Physics.QuantumPhysicalExclusion.oppositeNeverSame label (right.trans left.symm)

def actions : Nat → Held → Held
 | 0,label => label
 | n+1,label => opposite (actions n label)

theorem oneActionAlternates (label : Held) : actions 1 label = opposite label := rfl

theorem oneActionNotClosed (label : Held) : actions 1 label ≠ label :=
 SFT.Physics.QuantumPhysicalExclusion.oppositeNeverSame label

theorem twoActionsClose (label : Held) : actions 2 label = label := by
 cases label <;> rfl

theorem compositeClass (label : Held) :
 SFT.Physics.MatterExchange.classify label (actions 2 label) = .preserving :=
 (SFT.Physics.MatterExchange.preservingExactly _ _).mpr (twoActionsClose label)

-- Every finite successor appends a whole paired recurrence.
def pairedActions : Nat → Held → Held
 | 0,label => label
 | n+1,label => actions 2 (pairedActions n label)

theorem everyPairedRecurrenceCloses (n : Nat) (label : Held) :
 pairedActions n label = label := by
 induction n with
 | zero => rfl
 | succ n ih => exact (twoActionsClose (pairedActions n label)).trans ih

theorem exchangeRetainsOpposition (label : Held) :
 exchange (pair label) = pair (opposite label) := by
 cases label <;> rfl

theorem exchangeReturnsCompletePair (label : Held) :
 exchange (exchange (pair label)) = pair label := exchangeTwice _

def records (labels : List Held) := labels.map pair

theorem base (label : Held) : records [label] = [pair label] := rfl

theorem successor (labels : List Held) (next : Held) :
 records (labels ++ [next]) = records labels ++ [pair next] := by
 induction labels with
 | nil => rfl
 | cons headLabel rest ih => exact congrArg (List.cons (pair headLabel)) ih

end SFT.Materials.PairedCarrier
