import SFT.Physics.DimensionReferenceTransport
import SFT.Host.Canonical
namespace SFT.Physics.ReferenceRealization
open SFT.Physics.DimensionReferenceTransport
open SFT.Foundation.ExactOperations
-- measurement_laws.py REFERENCE_REALIZATION and CALIBRATION:
-- every exact comparison and its held source record remain in execution order.
structure Step (a b : Reference) where
  comparison : Comparison a b
  sourceIdentity : String
  record : SFT.Host.Canonical.Value

inductive Process : Reference → Reference → Type
  | first {a b} : Step a b → Process a b
  | append {a b c} : Process a b → Step b c → Process a c

def result {a b : Reference} : Process a b → Comparison a b
  | .first step => step.comparison
  | .append prior step => chain (result prior) step.comparison

structure Row where
  fromReference : String
  toReference : String
  sourceIdentity : String
  record : SFT.Host.Canonical.Value
  factor : PositiveFraction
  cumulative : PositiveFraction

def row {a b : Reference} (step : Step a b) (cumulative : PositiveFraction) : Row :=
  ⟨a.name,b.name,step.sourceIdentity,step.record,step.comparison.ratio,cumulative⟩

def trace {a b : Reference} : Process a b → List Row
  | .first step => [row step step.comparison.ratio]
  | .append prior step => trace prior ++ [row step (chain (result prior) step.comparison).ratio]

def records {a b : Reference} : Process a b → List (String × SFT.Host.Canonical.Value)
  | .first step => [(step.sourceIdentity,step.record)]
  | .append prior step => records prior ++ [(step.sourceIdentity,step.record)]

def length {a b : Reference} : Process a b → Nat
  | .first _ => 1
  | .append prior _ => length prior + 1

theorem mapAppendOne {A B : Type} (f : A → B) (xs : List A) (x : A) :
    (xs ++ [x]).map f = xs.map f ++ [f x] := by
  induction xs with
  | nil => rfl
  | cons a rest ih => exact congrArg (fun tail => f a :: tail) ih

theorem lengthAppendOne {A : Type} (xs : List A) (x : A) :
    (xs ++ [x]).length = xs.length + 1 := by
  induction xs with
  | nil => rfl
  | cons a rest ih =>
    change (rest ++ [x]).length + 1 = (rest.length + 1) + 1
    rw [ih]

theorem allRecordsRetained {a b : Reference} (p : Process a b) :
    (trace p).map (fun r => (r.sourceIdentity,r.record)) = records p := by
  induction p with
  | first step => rfl
  | append prior step ih =>
    change (trace prior ++ [_]).map _ = records prior ++ [_]
    rw [mapAppendOne,ih]
    rfl

theorem completeTraceLength {a b : Reference} (p : Process a b) :
    (trace p).length = length p := by
  induction p with
  | first step => rfl
  | append prior step ih =>
    change (trace prior ++ [_]).length = length prior + 1
    rw [lengthAppendOne,ih]

theorem positiveLength {a b : Reference} (p : Process a b) : 0 < length p := by
  cases p with
  | first step => exact Nat.zero_lt_succ 0
  | append prior step => exact Nat.zero_lt_succ _

theorem noNameOnlyRealization {a b : Reference} (p : Process a b) :
    trace p ≠ [] := by
  intro empty
  have count := completeTraceLength p
  rw [empty] at count
  have positive := positiveLength p
  rw [← count] at positive
  exact Nat.not_lt_zero _ positive

theorem successorRetainsPrior {a b c : Reference} (p : Process a b) (step : Step b c) :
    trace (.append p step) = trace p ++ [row step (chain (result p) step.comparison).ratio] := rfl

theorem successorComputesRatio {a b c : Reference} (p : Process a b) (step : Step b c) :
    (result (.append p step)).ratio =
      SFT.Mathematics.ExactRatioRelations.compose (result p).ratio step.comparison.ratio := rfl

theorem realizedDimension {a b : Reference} (p : Process a b) :
    SFT.Physics.DimensionComposition.SameDimension a.dimension b.dimension :=
  (result p).sameDimension

theorem realizedRatioPositive {a b : Reference} (p : Process a b) :
    0 < (result p).ratio.numerator := (result p).ratio.positive

theorem rowRetainsEndpoints {a b : Reference} (step : Step a b) (x : PositiveFraction) :
    (row step x).fromReference = a.name ∧ (row step x).toReference = b.name :=
  ⟨rfl,rfl⟩

theorem rowRetainsSource {a b : Reference} (step : Step a b) (x : PositiveFraction) :
    (row step x).sourceIdentity = step.sourceIdentity ∧ (row step x).record = step.record :=
  ⟨rfl,rfl⟩
end SFT.Physics.ReferenceRealization
