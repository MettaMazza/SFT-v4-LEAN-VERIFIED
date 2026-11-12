import SFT.Materials.DopingSupport
namespace SFT.Materials.CarrierMajority
open SFT.Physics.MechanicalLocation SFT.Mathematics.DiscreteObjects

-- Compare the complete retained gained/lost carrier counts. Balanced support
-- is held as absence of an imbalance, not selected as a majority class.
def select (occupation absence : Nat) : Option Held :=
 if absence < occupation then some .first
 else if occupation < absence then some .second else none

theorem occupationMajority (occupation absence : Nat) (excess : absence < occupation) :
 select occupation absence = some .first := by
 unfold select
 rw [if_pos excess]

theorem absenceMajority (occupation absence : Nat) (excess : occupation < absence) :
 select occupation absence = some .second := by
 unfold select
 rw [if_neg (Nat.lt_asymm excess),if_pos excess]

theorem balancedSupport (n : Nat) : select n n = none := by
 unfold select
 rw [if_neg (Nat.lt_irrefl n),if_neg (Nat.lt_irrefl n)]

theorem occupationExactly (occupation absence : Nat) :
 select occupation absence = some .first ↔ absence < occupation := by
 constructor
 · intro result
   by_cases h : absence < occupation
   · exact h
   · unfold select at result
     rw [if_neg h] at result
     by_cases k : occupation < absence
     · rw [if_pos k] at result; cases result
     · rw [if_neg k] at result; cases result
 · exact occupationMajority occupation absence

theorem absenceExactly (occupation absence : Nat) :
 select occupation absence = some .second ↔ occupation < absence := by
 constructor
 · intro result
   by_cases h : absence < occupation
   · have impossible := (occupationMajority occupation absence h).symm.trans result
     cases impossible
   · unfold select at result
     rw [if_neg h] at result
     by_cases k : occupation < absence
     · exact k
     · rw [if_neg k] at result; cases result
 · exact absenceMajority occupation absence

theorem imbalanceExhausted (occupation absence : Nat) (different : occupation ≠ absence) :
 select occupation absence = some .first ∨ select occupation absence = some .second := by
 cases Nat.lt_or_gt_of_ne different with
 | inl h => exact .inr (absenceMajority occupation absence h)
 | inr h => exact .inl (occupationMajority occupation absence h)

theorem majorityClassesExclusive (occupation absence : Nat)
 (first : select occupation absence = some .first) :
 select occupation absence ≠ some .second := by
 intro second
 exact Nat.lt_asymm ((occupationExactly _ _).mp first) ((absenceExactly _ _).mp second)

def orientation (before after : Collection) :=
 select (DopingSupport.gained before after).length (DopingSupport.lost before after).length

theorem completeDopedSupportClassification (before after : Collection)
 (imbalance : (DopingSupport.gained before after).length ≠ (DopingSupport.lost before after).length) :
 orientation before after = some .first ∨ orientation before after = some .second :=
 imbalanceExhausted _ _ imbalance

theorem occupationFromActualDifference (before after : Collection) :
 orientation before after = some .first ↔
 (DopingSupport.lost before after).length < (DopingSupport.gained before after).length :=
 occupationExactly _ _

theorem absenceFromActualDifference (before after : Collection) :
 orientation before after = some .second ↔
 (DopingSupport.gained before after).length < (DopingSupport.lost before after).length :=
 absenceExactly _ _

theorem swappingDifferenceReversesMajority (occupation absence : Nat) (held : Held)
 (result : select occupation absence = some held) :
 select absence occupation = some (opposite held) := by
 cases held with
 | first => exact absenceMajority _ _ ((occupationExactly _ _).mp result)
 | second => exact occupationMajority _ _ ((absenceExactly _ _).mp result)
end SFT.Materials.CarrierMajority
