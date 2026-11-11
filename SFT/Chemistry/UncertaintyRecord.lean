import SFT.Chemistry.AmountCount
import SFT.Physics.MeasurementUncertainty
namespace SFT.Chemistry.UncertaintyRecord
open SFT.Physics.MeasurementUncertainty
open SFT.Foundation.ExactOperations

-- V3 MEASUREMENT_IDENTITY_BATCH_2_SPECS[3]: comparison records are held
-- separately from candidate selection; the bound is registered before release.
structure Boundary where
 sourceIdentity : String
 methodIdentity : String
 intendedUse : String
 resultIdentity : String
 upperLimit : PositiveFraction

structure Record (Alternative : Type) where
 boundary : Boundary
 decisions : List (Decision Alternative)

variable {A : Type}
def alternatives (r : Record A) : List (Decision A) := retained r.decisions

def appendAlternative (r : Record A) (row : Decision A) : Record A :=
 ⟨r.boundary,r.decisions ++ [row]⟩

theorem allCompatibleRetained (r : Record A) (row : Decision A)
 (held : row ∈ r.decisions) (compatible : row.stillAdmissible = true) : row ∈ alternatives r :=
 allAdmissibleRetained r.decisions row held compatible

theorem alternativesExactly (r : Record A) (row : Decision A) :
 row ∈ alternatives r ↔ row ∈ r.decisions ∧ row.stillAdmissible = true :=
 exactSupport r.decisions row

theorem uniqueAlternativeClass (r : Record A) (first second : List (Decision A))
 (a : Retention r.decisions first) (b : Retention r.decisions second) : first = second :=
 noAlternativeSelection a b

theorem completeAlternativeSuccessor (r : Record A) (row : Decision A) :
 alternatives (appendAlternative r row) = alternatives r ++ retained [row] :=
 completeAppend r.decisions [row]

theorem compatibleSuccessor (r : Record A) (row : Decision A)
 (compatible : row.stillAdmissible = true) :
 alternatives (appendAlternative r row) = alternatives r ++ [row] := by
 rw [completeAlternativeSuccessor,retained,compatible,retained]
 rfl

theorem priorDecisionRetained (r : Record A) (new old : Decision A)
 (held : old ∈ r.decisions) : old ∈ (appendAlternative r new).decisions :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft old r.decisions [new] held

theorem priorAlternativeRetained (r : Record A) (new old : Decision A)
 (held : old ∈ alternatives r) : old ∈ alternatives (appendAlternative r new) := by
 rw [completeAlternativeSuccessor]
 exact SFT.Foundation.Count.TraceDerivation.memAppendLeft old (alternatives r) (retained [new]) held

theorem boundaryRetained (r : Record A) (row : Decision A) :
 (appendAlternative r row).boundary = r.boundary := rfl

theorem exactUpperLimitRetained (r : Record A) (row : Decision A) :
 (appendAlternative r row).boundary.upperLimit = r.boundary.upperLimit := rfl

theorem resultIdentityRetained (r : Record A) (row : Decision A) :
 (appendAlternative r row).boundary.resultIdentity = r.boundary.resultIdentity := rfl

theorem sourceMethodUseRetained (r : Record A) (row : Decision A) :
 (appendAlternative r row).boundary.sourceIdentity = r.boundary.sourceIdentity ∧
 (appendAlternative r row).boundary.methodIdentity = r.boundary.methodIdentity ∧
 (appendAlternative r row).boundary.intendedUse = r.boundary.intendedUse := ⟨rfl,rfl,rfl⟩

-- Acceptance after release is bound to the previously registered boundary.
def respectsRegistration (registered : Boundary) (r : Record A) : Prop := r.boundary = registered

theorem postReleaseChangeRejected (registered : Boundary) (r : Record A)
 (changed : r.boundary.upperLimit ≠ registered.upperLimit) : ¬ respectsRegistration registered r :=
 fun same => changed (congrArg Boundary.upperLimit same)

theorem resultRebindingRejected (registered : Boundary) (r : Record A)
 (changed : r.boundary.resultIdentity ≠ registered.resultIdentity) : ¬ respectsRegistration registered r :=
 fun same => changed (congrArg Boundary.resultIdentity same)

theorem useChangeRejected (registered : Boundary) (r : Record A)
 (changed : r.boundary.intendedUse ≠ registered.intendedUse) : ¬ respectsRegistration registered r :=
 fun same => changed (congrArg Boundary.intendedUse same)

theorem registrationPreserved (registered : Boundary) (r : Record A) (row : Decision A)
 (valid : respectsRegistration registered r) : respectsRegistration registered (appendAlternative r row) := valid

-- Every registered measurement record, including adverse rows, stays in order.
def appendResult (rows : List (Record A)) (r : Record A) : List (Record A) := rows ++ [r]

theorem allResultsRetained (rows : List (Record A)) (new old : Record A)
 (held : old ∈ rows) : old ∈ appendResult rows new :=
 SFT.Foundation.Count.TraceDerivation.memAppendLeft old rows [new] held

theorem newResultRetained (rows : List (Record A)) (new : Record A) : new ∈ appendResult rows new :=
 List.mem_append_right _ (List.Mem.head _)

theorem resultOrderRetained (rows : List (Record A)) (new : Record A) :
 EntityIdentity.priorCoordinates (appendResult rows new) = rows :=
 EntityIdentity.priorCoordinatesExact rows new

inductive History : Record A → Record A → Prop where
 | base (r : Record A) : History r r
 | next {first prior : Record A} (history : History first prior) (row : Decision A) :
   History first (appendAlternative prior row)

theorem historyBoundary {first last : Record A} (history : History first last) : last.boundary = first.boundary := by
 induction history with
 | base => rfl
 | next prior row ih => exact ih

theorem historyRetainsEveryDecision {first last : Record A} (history : History first last)
 (row : Decision A) (held : row ∈ first.decisions) : row ∈ last.decisions := by
 induction history with
 | base => exact held
 | next prior new ih => exact priorDecisionRetained _ new row ih

theorem historyRetainsEveryAlternative {first last : Record A} (history : History first last)
 (row : Decision A) (held : row ∈ alternatives first) : row ∈ alternatives last := by
 induction history with
 | base => exact held
 | next prior new ih => exact priorAlternativeRetained _ new row ih

theorem finiteHistoryCannotWiden {first last : Record A} (history : History first last) :
 last.boundary.upperLimit = first.boundary.upperLimit := congrArg Boundary.upperLimit (historyBoundary history)
end SFT.Chemistry.UncertaintyRecord
