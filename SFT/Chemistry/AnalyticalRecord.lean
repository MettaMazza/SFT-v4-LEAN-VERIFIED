import SFT.Chemistry.AnalyticalCalibration
import SFT.Chemistry.AnalyticalSelectivity
namespace SFT.Chemistry.AnalyticalRecord
open SFT.Foundation.Count.TraceDerivation SFT.Mathematics.DiscreteObjects
abbrev Value := SFT.Host.Canonical.Value
abbrev HeldLabel := SFT.Physics.CapabilityValues.HeldLabel

structure Observation (Alternative Response : Type) where
 response : Response
 uncertainty : UncertaintyRecord.Record Alternative
 source : Value
 resolution : Value

structure Derived (Alternative Response : Type) where
 inputs : List (Observation Alternative Response)
 operation : List Response → Response
 result : Observation Alternative Response
 exactResult : result.response=operation (inputs.map Observation.response)
 operationRecord : Value

structure Control where
 identity : HeldLabel
 passed : Bool
 tampered : Bool
 observation : Value
 source : Value

def adverse (control : Control) := !control.passed || control.tampered

structure Record (Alternative Response : Type) where
 measurand : HeldLabel
 purpose : HeldLabel
 calibration : AnalyticalCalibration.Map Alternative Response
 selectivity : AnalyticalSelectivity.Observation calibration.sample.portion Response
 conditions : Value
 selectivityConditions : selectivity.conditions=conditions
 raw : List (Observation Alternative Response)
 derived : List (Derived Alternative Response)
 provenance : ∀ row∈derived, ∀ input∈row.inputs, input∈raw++derived.map Derived.result
 controls : List Control
 falsification : HeldLabel

-- The projection retains both categories completely; it does not filter by outcome.
def observations {A R : Type} (record : Record A R) :=
 record.raw++record.derived.map Derived.result

def adverseControls {A R : Type} (record : Record A R) := record.controls.filter adverse

theorem everyRawRetained {A R : Type} (record : Record A R) (row : Observation A R)
 (held : row∈record.raw) : row∈observations record := memAppendLeft _ _ _ held

theorem everyDerivedRetained {A R : Type} (record : Record A R) (row : Derived A R)
 (held : row∈record.derived) : row.result∈observations record :=
 memAppendRight _ _ _ (memMap _ _ _ held)

theorem everyObservationAccounted {A R : Type} (record : Record A R) (row : Observation A R)
 (held : row∈observations record) : row∈record.raw ∨ ∃ derived∈record.derived,derived.result=row := by
 cases memAppendCases row record.raw (record.derived.map Derived.result) held with
 | inl raw => exact .inl raw
 | inr derived => exact .inr (memMapPreimage _ _ _ derived)

theorem derivedInputsRetained {A R : Type} (record : Record A R) (row : Derived A R)
 (held : row∈record.derived) (input : Observation A R) (used : input∈row.inputs) :
 input∈observations record := record.provenance row held input used

theorem derivedResultExact {A R : Type} (row : Derived A R) :
 row.result.response=row.operation (row.inputs.map Observation.response) := row.exactResult

theorem adverseExactly {A R : Type} (record : Record A R) (control : Control) :
 control∈adverseControls record ↔ control∈record.controls ∧ adverse control=true := filterMemberIff _ _ _

theorem failedControlRetained {A R : Type} (record : Record A R) (control : Control)
 (held : control∈record.controls) (failed : control.passed=false) : control∈adverseControls record := by
 apply (adverseExactly _ _).mpr
 refine ⟨held,?_⟩
 unfold adverse
 rw [failed]
 rfl

theorem tamperedControlRetained {A R : Type} (record : Record A R) (control : Control)
 (held : control∈record.controls) (tampered : control.tampered=true) : control∈adverseControls record := by
 apply (adverseExactly _ _).mpr
 refine ⟨held,?_⟩
 unfold adverse
 rw [tampered]
 cases control.passed <;> rfl

def appendRaw {A R : Type} (record : Record A R) (row : Observation A R) : Record A R :=
 {record with
  raw := record.raw++[row]
  provenance := by
   intro d hd input hi
   cases memAppendCases input record.raw (record.derived.map Derived.result) (record.provenance d hd input hi) with
   | inl raw => exact memAppendLeft _ _ _ (memAppendLeft _ _ _ raw)
   | inr derived => exact memAppendRight _ _ _ derived}

def appendDerived {A R : Type} (record : Record A R) (row : Derived A R)
 (inputsHeld : ∀ input∈row.inputs,input∈observations record) : Record A R :=
 {record with
  derived := record.derived++[row]
  provenance := by
   intro d hd input hi
   rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend]
   rw [←SFT.Mathematics.ExactTraceArithmetic.appendAssociative]
   apply memAppendLeft
   cases memAppendCases d record.derived [row] hd with
   | inl old => exact record.provenance d old input hi
   | inr fresh => cases fresh with
     | head => exact inputsHeld input hi
     | tail _ impossible => cases impossible}

def appendControl {A R : Type} (record : Record A R) (control : Control) : Record A R :=
 {record with controls := record.controls++[control]}

theorem rawSuccessorRetainsOld {A R : Type} (record : Record A R) (row prior : Observation A R)
 (held : prior∈observations record) : prior∈observations (appendRaw record row) := by
 cases everyObservationAccounted record prior held with
 | inl old => exact everyRawRetained _ _ (memAppendLeft _ _ _ old)
 | inr derived => obtain ⟨d,hd,equal⟩ := derived; exact equal ▸ everyDerivedRetained _ d hd

theorem newRawRetained {A R : Type} (record : Record A R) (row : Observation A R) :
 row∈observations (appendRaw record row) := everyRawRetained _ _ (memAppendRight _ _ _ (.head []))

theorem derivedSuccessor {A R : Type} (record : Record A R) (row : Derived A R)
 (inputsHeld : ∀ input∈row.inputs,input∈observations record) :
 observations (appendDerived record row inputsHeld)=observations record++[row.result] := by
 unfold observations appendDerived
 rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend]
 exact (SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _).symm

theorem controlSuccessor {A R : Type} (record : Record A R) (control : Control) :
 adverseControls (appendControl record control)=adverseControls record++([control].filter adverse) :=
 filterAppendExact _ _ _

theorem priorControlRetained {A R : Type} (record : Record A R) (control prior : Control)
 (held : prior∈record.controls) : prior∈(appendControl record control).controls := memAppendLeft _ _ _ held

theorem uncertaintyRetained {A R : Type} (record : Record A R) (row : Observation A R)
 (held : row∈record.raw) (alternative : SFT.Physics.MeasurementUncertainty.Decision A)
 (member : alternative∈row.uncertainty.decisions) (admissible : alternative.stillAdmissible=true) :
 alternative∈UncertaintyRecord.alternatives row.uncertainty :=
 UncertaintyRecord.allCompatibleRetained row.uncertainty alternative member admissible

theorem sourceBoundaryRetained {A R : Type} (record : Record A R) (control : Control) :
 (appendControl record control).measurand=record.measurand ∧
 (appendControl record control).calibration=record.calibration ∧
 (appendControl record control).falsification=record.falsification := ⟨rfl,rfl,rfl⟩

def base {A R : Type} (measurand purpose : HeldLabel) (calibration : AnalyticalCalibration.Map A R)
 (selectivity : AnalyticalSelectivity.Observation calibration.sample.portion R)
 (conditions : Value) (bound : selectivity.conditions=conditions)
 (measurement : Observation A R) (control : Control) (falsification : HeldLabel) : Record A R where
 measurand := measurand
 purpose := purpose
 calibration := calibration
 selectivity := selectivity
 conditions := conditions
 selectivityConditions := bound
 raw := [measurement]
 derived := []
 provenance := fun _ impossible => nomatch impossible
 controls := [control]
 falsification := falsification

theorem baseMeasurement {A R : Type} (measurand purpose : HeldLabel) (calibration : AnalyticalCalibration.Map A R)
 (selectivity : AnalyticalSelectivity.Observation calibration.sample.portion R)
 (conditions : Value) (bound : selectivity.conditions=conditions)
 (measurement : Observation A R) (control : Control) (falsification : HeldLabel) :
 observations (base measurand purpose calibration selectivity conditions bound measurement control falsification)=[measurement] := rfl

theorem baseUnfavorable {A R : Type} (measurand purpose : HeldLabel) (calibration : AnalyticalCalibration.Map A R)
 (selectivity : AnalyticalSelectivity.Observation calibration.sample.portion R)
 (conditions : Value) (bound : selectivity.conditions=conditions)
 (measurement : Observation A R) (control : Control) (falsification : HeldLabel) (failed : adverse control=true) :
 adverseControls (base measurand purpose calibration selectivity conditions bound measurement control falsification)=[control] := by
 unfold adverseControls base
 rw [List.filter_cons_of_pos failed]
 rfl

end SFT.Chemistry.AnalyticalRecord
