import SFT.Physics.WaveDispersion
import SFT.Mathematics.LeastCommonReturn
namespace SFT.Physics.WaveResonance
open SFT.Mathematics.LeastCommonReturn

-- Both recurrences are retained on the same generated refinement clock.
structure Pair (Driver Supported Phase : Type) where
  driver : MechanicalDuration.Recurrence Driver
  supported : MechanicalDuration.Recurrence Supported
  driverPhase : Phase
  supportedPhase : Phase

variable {Driver Supported Phase : Type}
def driverCount (p : Pair Driver Supported Phase) := MechanicalEvents.count p.driver.path
def supportedCount (p : Pair Driver Supported Phase) := MechanicalEvents.count p.supported.path
def commonReturn (p : Pair Driver Supported Phase) := Nat.lcm (driverCount p) (supportedCount p)
def matchedAt (p : Pair Driver Supported Phase) (n : Nat) : Prop :=
  0 < n ∧ driverCount p ∣ n ∧ supportedCount p ∣ n ∧ p.driverPhase = p.supportedPhase

theorem returnPositive (p : Pair Driver Supported Phase) : 0 < commonReturn p :=
  SFT.Mathematics.LeastCommonReturn.returnPositive _ _ p.driver.hasTransition p.supported.hasTransition

theorem commonReturnMatches (p : Pair Driver Supported Phase) (aligned : p.driverPhase = p.supportedPhase) :
    matchedAt p (commonReturn p) :=
  ⟨returnPositive p,(returnsBoth _ _ p.supported.hasTransition).1,
    (returnsBoth _ _ p.supported.hasTransition).2,aligned⟩

theorem unmatchedPhasesExcluded (p : Pair Driver Supported Phase)
    (unmatched : p.driverPhase ≠ p.supportedPhase) (n : Nat) : ¬ matchedAt p n :=
  fun h => unmatched h.2.2.2

theorem leastMatchedReturn (p : Pair Driver Supported Phase) (n : Nat) (h : matchedAt p n) : commonReturn p ≤ n :=
  leastPositiveReturn _ _ _ p.supported.hasTransition h.1 h.2.1 h.2.2.1

theorem allMatchedReturnsRefine (p : Pair Driver Supported Phase) (n : Nat) (h : matchedAt p n) : commonReturn p ∣ n :=
  dividesEveryReturn _ _ _ p.supported.hasTransition h.1 h.2.1 h.2.2.1

theorem uniqueLeastReturn (p : Pair Driver Supported Phase) (n : Nat) (h : matchedAt p n)
    (least : ∀ k, matchedAt p k → n ≤ k) : n = commonReturn p :=
  Nat.le_antisymm (least _ (commonReturnMatches p h.2.2.2)) (leastMatchedReturn p n h)

def transfers (p : Pair Driver Supported Phase) (returns : List Nat) :=
  returns.map (fun n => (n,p.driver,p.supported,p.driverPhase,p.supportedPhase))

theorem completeTransferCount (p : Pair Driver Supported Phase) (returns : List Nat) :
    (transfers p returns).length = returns.length := by
  induction returns with
  | nil => rfl
  | cons n rest ih => exact congrArg Nat.succ ih

theorem everyTransferAligned (p : Pair Driver Supported Phase) (returns : List Nat)
    (matched : ∀ n ∈ returns, matchedAt p n) :
    ∀ row ∈ transfers p returns, row.2.2.2.1 = row.2.2.2.2 := by
  intro row member
  obtain ⟨n,hn,eq⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ member
  cases eq
  exact (matched n hn).2.2.2

theorem successorRetainsTransfers (p : Pair Driver Supported Phase) (returns : List Nat) (n : Nat) :
    transfers p (returns ++ [n]) = transfers p returns ++ [(n,p.driver,p.supported,p.driverPhase,p.supportedPhase)] :=
  ReferenceRealization.mapAppendOne _ _ _
end SFT.Physics.WaveResonance
