import SFT.Materials.StressStrainRecord
import SFT.Materials.ElasticRecovery
namespace SFT.Materials.ElasticModulus
open SFT.Mathematics.FoldScalar SFT.Foundation.ExactOperations

def ratio (stress strain : Scalar) : Option Scalar :=
 match strain with
 | .emptyOne => none
 | .positive direction magnitude =>
  match stress with
  | .emptyOne => some .emptyOne
  | .positive orientation load =>
   some (.positive (productOrientation orientation direction) (quotientMagnitude load magnitude))

theorem exactPositiveResponse (a b : Orientation) (stress strain : PositiveFraction) :
 ratio (.positive a stress) (.positive b strain) =
 some (.positive (productOrientation a b) (quotientMagnitude stress strain)) := rfl

theorem exactMagnitude (stress strain : PositiveFraction) :
 (stress.numerator * strain.denominator) * (quotientMagnitude stress strain).denominator =
 (quotientMagnitude stress strain).numerator * (stress.denominator * strain.numerator) :=
 quotientExact stress strain

theorem emptyStrainHasNoQuotient (stress : Scalar) : ratio stress .emptyOne = none := rfl

theorem sameDirections (direction : Orientation) (stress strain : PositiveFraction) :
 ratio (.positive direction stress) (.positive direction strain) =
 some (.positive .forward (quotientMagnitude stress strain)) := by
 cases direction <;> rfl

structure Row (State Composition : Type) where
 measurement : StressStrainRecord.Record State
 recovery : ElasticRecovery.Row Composition

def response {S C : Type} (row : Row S C) :=
 ratio (StressStrainRecord.stress row.measurement) (StressStrainRecord.strain row.measurement)

structure Window (State Composition : Type) where
 rows : List (Row State Composition)
 materialReference : MaterialCarrier.Record Composition
 firstReference : String
 secondReference : String
 direction : SFT.Physics.MechanicalLocation.Held
 conditions : SFT.Host.Canonical.Value
 declaredRange : SFT.Host.Canonical.Value
 materialBound : ∀ row, row ∈ rows →
  row.recovery.path.sourceState row.recovery.original = materialReference
 firstBound : ∀ row, row ∈ rows →
  row.measurement.reference.first.referenceIdentity = firstReference
 secondBound : ∀ row, row ∈ rows →
  row.measurement.reference.second.referenceIdentity = secondReference
 directionBound : ∀ row, row ∈ rows → row.measurement.reference.held = direction
 conditionsBound : ∀ row, row ∈ rows → row.measurement.conditions = conditions

def responses {S C : Type} (window : Window S C) :=
 window.rows.map (fun row => (row,response row))

theorem originalMaterialRecovered {S C : Type} (window : Window S C) (row : Row S C)
 (held : row ∈ window.rows) :
 ElasticRecovery.release row.recovery.path row.recovery.loaded = some window.materialReference := by
 rw [ElasticRecovery.canonicalStateReturns row.recovery.path row.recovery.original row.recovery.loaded
  row.recovery.held row.recovery.displaced,window.materialBound row held]

theorem sameReferenceDirectionConditions {S C : Type} (window : Window S C) (row : Row S C)
 (held : row ∈ window.rows) :
 row.measurement.reference.first.referenceIdentity = window.firstReference ∧
 row.measurement.reference.second.referenceIdentity = window.secondReference ∧
 row.measurement.reference.held = window.direction ∧
 row.measurement.conditions = window.conditions :=
 ⟨window.firstBound row held,window.secondBound row held,window.directionBound row held,window.conditionsBound row held⟩

theorem everyResponseRowRetained {S C : Type} (window : Window S C) :
 (responses window).map Prod.fst = window.rows := by
 unfold responses
 induction window.rows with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons head) ih

def record {S C : Type} (window : Window S C) := (window,responses window)

theorem linearRangeRetained {S C : Type} (window : Window S C) :
 (record window).1.declaredRange = window.declaredRange := rfl

def records {S C : Type} (windows : List (Window S C)) := windows.map record

theorem base {S C : Type} (window : Window S C) : records [window] = [record window] := rfl

theorem successor {S C : Type} (windows : List (Window S C)) (next : Window S C) :
 records (windows ++ [next]) = records windows ++ [record next] := by
 induction windows with
 | nil => rfl
 | cons head rest ih => exact congrArg (List.cons (record head)) ih

end SFT.Materials.ElasticModulus
