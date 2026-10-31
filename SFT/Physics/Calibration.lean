import SFT.Physics.ReferenceRealization
import SFT.Physics.MeasurementUncertainty
namespace SFT.Physics.Calibration
open SFT.Physics.DimensionReferenceTransport
open SFT.Physics.ReferenceRealization
open SFT.Physics.MeasurementUncertainty

structure ComparisonRecord (a b : Reference) where
  step : Step a b
  alternatives : List (Decision SFT.Host.Canonical.Value)

inductive Chain : Reference → Reference → Type
  | first {a b} : ComparisonRecord a b → Chain a b
  | append {a b c} : Chain a b → ComparisonRecord b c → Chain a c

def operational {a b : Reference} : Chain a b → Process a b
  | .first record => .first record.step
  | .append prior record => .append (operational prior) record.step

def ledgers {a b : Reference} : Chain a b → List (List (Decision SFT.Host.Canonical.Value))
  | .first record => [record.alternatives]
  | .append prior record => ledgers prior ++ [record.alternatives]

def uncertainty {a b : Reference} (p : Chain a b) :=
  (ledgers p).map retained

theorem mapLength {A B : Type} (f : A → B) (xs : List A) :
    (xs.map f).length = xs.length := by
  induction xs with
  | nil => rfl
  | cons a rest ih => exact congrArg Nat.succ ih

theorem oneLedgerPerComparison {a b : Reference} (p : Chain a b) :
    (ledgers p).length = ReferenceRealization.length (operational p) := by
  induction p with
  | first record => rfl
  | append prior record ih =>
    change (ledgers prior ++ [_]).length = ReferenceRealization.length (operational prior) + 1
    rw [lengthAppendOne,ih]

theorem completeHistoryAlignment {a b : Reference} (p : Chain a b) :
    (uncertainty p).length = (trace (operational p)).length :=
  (mapLength _ _).trans ((oneLedgerPerComparison p).trans (completeTraceLength _).symm)

theorem successorRetainsLedgers {a b c : Reference} (p : Chain a b)
    (record : ComparisonRecord b c) :
    ledgers (.append p record) = ledgers p ++ [record.alternatives] := rfl

theorem successorRetainsSupport {a b c : Reference} (p : Chain a b)
    (record : ComparisonRecord b c) :
    uncertainty (.append p record) = uncertainty p ++ [retained record.alternatives] :=
  mapAppendOne _ _ _

theorem everyRecordHeld {a b : Reference} (p : Chain a b) :
    (trace (operational p)).map (fun r => (r.sourceIdentity,r.record)) =
      ReferenceRealization.records (operational p) :=
  allRecordsRetained _

theorem exactComposedRatio {a b c : Reference} (p : Chain a b)
    (record : ComparisonRecord b c) :
    (result (operational (.append p record))).ratio =
      SFT.Mathematics.ExactRatioRelations.compose (result (operational p)).ratio
        record.step.comparison.ratio := rfl

theorem calibrationPreservesDimension {a b : Reference} (p : Chain a b) :
    SFT.Physics.DimensionComposition.SameDimension a.dimension b.dimension :=
  realizedDimension (operational p)

theorem calibrationPositive {a b : Reference} (p : Chain a b) :
    0 < (result (operational p)).ratio.numerator :=
  realizedRatioPositive (operational p)

theorem noComparisonOmitted {a b : Reference} (p : Chain a b) :
    (trace (operational p)).length = (ledgers p).length :=
  (completeHistoryAlignment p).symm.trans (mapLength _ _)
end SFT.Physics.Calibration
