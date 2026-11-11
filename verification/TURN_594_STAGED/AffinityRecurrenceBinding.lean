import SFT.Chemistry.AffinityTraceBinding
import SFT.Physics.QuantumPhysicalIdentity
namespace SFT.Chemistry.AffinityRecurrenceBinding
open AffinityTraceBinding
open SFT.Physics.QuantumPhysicalIdentity
open SFT.Foundation.Count.TraceDerivation

-- REDOX_BLUEPRINTS[0] supplies the pairwise comparison. The comparison axis
-- retains every registered support visit, and the ties axis compares the
-- complete resulting records. No ranking of names or trace values is added.
def endpoint (support : HeldLabel) (observations : List (String → HeldLabel))
    (atom : String) : EndpointTrace :=
  ⟨atom,support,observations.map (fun observe => observe atom)⟩

def physicalObservations (observations : List (String → HeldLabel)) :
    List (Pair String → HeldLabel) := observations.map (fun observe => fun pair => observe pair.left)

theorem physicalLedger (observations : List (String → HeldLabel)) (a b : String) :
    ledger (physicalObservations observations) (⟨a,b⟩ : Pair String) =
    observations.map (fun observe => observe a) := by
  induction observations with
  | nil => rfl
  | cons first rest ih => exact congrArg (List.cons (first a)) ih

theorem completeVisitsExactly (support : HeldLabel) (observations : List (String → HeldLabel))
    (a b : String) :
    sameTrace (endpoint support observations a) (endpoint support observations b) ↔
    indistinguishable (physicalObservations observations) (⟨a,b⟩ : Pair String) := by
  have full := fullLedgerExactly (physicalObservations observations) (⟨a,b⟩ : Pair String)
  change (ledger (physicalObservations observations) (⟨b,a⟩ : Pair String) =
    ledger (physicalObservations observations) (⟨a,b⟩ : Pair String) ↔ _) at full
  rw [physicalLedger,physicalLedger] at full
  constructor
  · intro same
    exact full.mp same.2.symm
  · intro same
    exact ⟨rfl,(full.mpr same).symm⟩

def bind (comparison : AffinityComparison.Comparison)
    (observations : List (String → HeldLabel)) : BoundComparison :=
  ⟨comparison,endpoint comparison.raw.sharedSupport observations comparison.raw.firstAtom,
    endpoint comparison.raw.sharedSupport observations comparison.raw.secondAtom,rfl,rfl,rfl,rfl⟩

theorem boundTraceExactly (comparison : AffinityComparison.Comparison)
    (observations : List (String → HeldLabel)) :
    sameTrace (bind comparison observations).first (bind comparison observations).second ↔
    indistinguishable (physicalObservations observations)
      (⟨comparison.raw.firstAtom,comparison.raw.secondAtom⟩ : Pair String) :=
  completeVisitsExactly _ _ _ _

theorem sourceComparisonUnchanged (comparison : AffinityComparison.Comparison)
    (observations : List (String → HeldLabel)) :
    (bind comparison observations).comparison = comparison := rfl

theorem completeObservationTie (comparison : AffinityComparison.Comparison)
    (observations : List (String → HeldLabel)) (traces : List EndpointTrace)
    (comparisons : List AffinityComparison.Comparison)
    (firstHeld : (bind comparison observations).first ∈ traces)
    (secondHeld : (bind comparison observations).second ∈ traces)
    (checked : cycleCheck traces comparisons = true) :
    AffinityClosure.Tied (edges traces comparisons) comparison.raw.firstAtom comparison.raw.secondAtom ↔
    indistinguishable (physicalObservations observations)
      (⟨comparison.raw.firstAtom,comparison.raw.secondAtom⟩ : Pair String) :=
  (exactTieClass traces comparisons checked _ _ firstHeld secondHeld).trans
    (boundTraceExactly comparison observations)

-- An appended registered visit is retained in full; it is not compressed into
-- a chosen rank or a selected observation.
theorem appendVisits (support : HeldLabel) (observations : List (String → HeldLabel))
    (next : String → HeldLabel) (atom : String) :
    (endpoint support (observations ++ [next]) atom).visits =
      (endpoint support observations atom).visits ++ [next atom] :=
  SFT.Mathematics.ExactTraceArithmetic.mapAppend _ _ _
end SFT.Chemistry.AffinityRecurrenceBinding
