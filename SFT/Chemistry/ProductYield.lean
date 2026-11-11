import SFT.Chemistry.ExactComposition
namespace SFT.Chemistry.ProductYield
open SFT.Foundation.ExactPartCarrier SFT.Foundation.ExactOperations

def exactYield (productPart : Part) : Part := productPart

theorem exactYieldRetained (productPart : Part) : exactYield productPart = productPart := rfl
theorem exactYieldPositive (productPart : Part) : 0 < (exactYield productPart).numerator := productPart.positive
theorem exactYieldBounded (productPart : Part) : (exactYield productPart).numerator ≤ (exactYield productPart).denominator := productPart.throughOne

structure Record where
 product : String
 process : String
 reference : String
 observed : Part
 history : List Part

def initial (product process reference : String) (observed : Part) : Record :=
 ⟨product,process,reference,exactYield observed,[observed]⟩

def sumNumerator (a b : Part) := a.numerator*b.denominator + b.numerator*a.denominator
def sumDenominator (a b : Part) := a.denominator*b.denominator

theorem sumPositive (a b : Part) : 0 < sumNumerator a b :=
 Nat.lt_of_lt_of_le (Nat.mul_pos a.positive (denominatorPositive b)) (Nat.le_add_right _ _)

def aggregate (a b : Part) (bounded : sumNumerator a b ≤ sumDenominator a b) : Part :=
 normalizePart (sumNumerator a b) (sumDenominator a b) (sumPositive a b) bounded

def appendObservation (record : Record) (observation : Part)
 (bounded : sumNumerator record.observed observation ≤ sumDenominator record.observed observation) : Record :=
 {record with observed := aggregate record.observed observation bounded, history := record.history++[observation]}

theorem aggregateExact (a b : Part) (bounded : sumNumerator a b ≤ sumDenominator a b) :
 (aggregate a b bounded).numerator * sumDenominator a b =
 sumNumerator a b * (aggregate a b bounded).denominator :=
 (normalizedValuePreserved _ _ (sumPositive a b) (Nat.mul_pos (denominatorPositive a) (denominatorPositive b))).symm

theorem provenanceRetained (record : Record) (observation : Part) (bounded) :
 (appendObservation record observation bounded).product = record.product ∧
 (appendObservation record observation bounded).process = record.process ∧
 (appendObservation record observation bounded).reference = record.reference := ⟨rfl,rfl,rfl⟩

theorem completeHistoryRetained (record : Record) (observation old : Part) (bounded)
 (held : old ∈ record.history) : old ∈ (appendObservation record observation bounded).history :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem newObservationRetained (record : Record) (observation : Part) (bounded) :
 observation ∈ (appendObservation record observation bounded).history :=
 SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (.head _)

def outcome (observed : Option Part) : Option Part := observed.map exactYield

theorem emptyOutcome : outcome none = none := rfl
theorem presentOutcome (observed : Part) : outcome (some observed) = some observed := rfl

inductive History : Record → Record → Prop where
 | initial (record : Record) : History record record
 | step {first previous : Record} (prior : History first previous) (observation : Part)
   (bounded : sumNumerator previous.observed observation ≤ sumDenominator previous.observed observation) :
   History first (appendObservation previous observation bounded)

theorem allFiniteProvenance {first last : Record} (history : History first last) :
 last.product = first.product ∧ last.process = first.process ∧ last.reference = first.reference := by
 induction history with
 | initial => exact ⟨rfl,rfl,rfl⟩
 | step prior observation bounded ih => exact ih

theorem allFinitePositive {first last : Record} (_history : History first last) : 0 < last.observed.numerator := last.observed.positive
end SFT.Chemistry.ProductYield
