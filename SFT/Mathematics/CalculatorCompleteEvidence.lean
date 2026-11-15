import SFT.Mathematics.CalculatorCompleteMachine
import SFT.Mathematics.CalculatorCompleteJSON
namespace SFT.Mathematics.CalculatorCompleteEvidence
open SFT.Mathematics SFT.Physics SFT.Host
open CalculatorValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def calculatorClaimId : String := "SFT-MATH-SCIENTIFIC-CALCULATOR-006"
def calculatorDependency : String := "SFT-MATH-SCIENTIFIC-CALCULATOR-005"
def valueForm : Value → String
 | .scalar x => match x with
   | .emptyOne => "structural_empty_One"
   | .positive o _ => match o with
     | .forward => "forward_held_positive_rational"
     | .counter => "counter_held_positive_rational"
 | .interval _ => "certified_exact_rational_enclosure"
 | .complex _ => "typed_real_and_orthogonal_Fold_fibres"
def certificate : Value → List String
 | .interval x => x.certificate
 | .scalar _ => []
 | .complex _ => []
def scalarIsValid : FoldScalar.Scalar → Bool
 | .emptyOne => true
 | .positive o m =>
   let oriented := match o with | .forward => true | .counter => true
   oriented && decide (0<m.numerator) && decide (0<m.denominator)
inductive RuntimeInput where
 | value (x : Value)
 | other (isFloat : Bool)
def valueFormInput : RuntimeInput → Except String String
 | .value x => .ok (valueForm x)
 | .other _ => .error "unknown calculator value form"
def validateInput (input : RuntimeInput) : Except String Canonical.Value := do
 let (valid,enclosure,typed,noFloat) := match input with
  | .other isFloat => (false,false,false,!isFloat)
  | .value value => match value with
    | .scalar x => (scalarIsValid x,true,true,true)
    | .interval x => (scalarIsValid x.lower && scalarIsValid x.upper,!x.certificate.isEmpty,true,true)
    | .complex x => (scalarIsValid x.real && scalarIsValid x.orthogonal,true,true,true)
 if !(valid && enclosure && typed && noFloat) then throw "calculator returned a value that violates its exact SFT runtime type boundary"
 pure (.object [("recognized_exact_value_form",.boolean valid),("all_scalar_parts_are_empty_One_or_positive_Fractions",.boolean valid),("held_orientation_encodes_conventional_sign",.boolean valid),("nonrational_output_has_rational_enclosure_certificate",.boolean enclosure),("complex_correspondence_uses_typed_Fold_fibres",.boolean typed),("no_float_object_in_proof_value",.boolean noFloat)])
def validateValue (value : Value) : Except String Canonical.Value := validateInput (.value value)
structure CensusRow where
 claimId : String
 receiptHash : Canonical.Value := .null
 modelAdmitted : Bool := false
def receipt (rows : Option (List CensusRow)) (claimId : String) : Canonical.Value :=
 match rows with
 | none => .null
 | some rows => match rows.find? (fun row => Text.equal row.claimId claimId) with
   | none => .null
   | some row => row.receiptHash
def calculationEvidence (calculation : CalculatorMachine.Calculation) (census : Option (List CensusRow) := none) : Except String Canonical.Value := do
 let value := calculation.value
 let exactValue ← CalculatorProjection.valueText value 24
 let checks ← validateValue value
 pure (.object [
  ("kind",.text "SFT_calculator_evaluation_not_engine_admission"),
  ("calculator_claim_id",.text calculatorClaimId),("admitted_dependency",.text calculatorDependency),
  ("official_calculator_receipt_hash",receipt census calculatorClaimId),
  ("expression",.text calculation.expression),("status",.text "complete_generated_expression_consumed"),
  ("value_form",.text (valueForm value)),("exact_value",.text exactValue),
  ("certificate",.array ((certificate value).map Canonical.Value.text)),
  ("trace",.array (calculation.trace.map Canonical.Value.text)),
  ("resources",.object [("tokens_read",.integer (.ofNat calculation.tokensRead)),("operations_executed",.integer (.ofNat calculation.operationsExecuted))]),
  ("constraint_checks",checks),
  ("halt_policy",.text "invalid, unclosed or resource-exhausted expressions raise CalculatorHalt and return no value"),
  ("engine_admission_issued",.boolean false)])
def calculationEvidenceJSON (calculation : CalculatorMachine.Calculation) (census : Option (List CensusRow) := none) : Except String String :=
 (calculationEvidence calculation census).map CalculatorCompleteJSON.document
theorem neverIssuesAdmission (calculation : CalculatorMachine.Calculation) (rows : Option (List CensusRow))
 (out : Canonical.Value) (success : calculationEvidence calculation rows=.ok out) :
 CalculatorCompleteJSON.field out "engine_admission_issued"=.boolean false := by
 dsimp only [calculationEvidence] at success
 cases h : CalculatorProjection.valueText calculation.value 24 with
 | error e => rw [h] at success; cases success
 | ok text =>
  rw [h] at success
  dsimp only [Except.bind, Bind.bind, pure, Pure.pure] at success
  cases v : validateValue calculation.value with
  | error e => rw [v] at success; cases success
  | ok checks =>
   rw [v] at success
   cases success
   rfl
end SFT.Mathematics.CalculatorCompleteEvidence
