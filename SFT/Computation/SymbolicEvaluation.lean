import SFT.Computation.SymbolicValues
namespace SFT.Computation.SymbolicEvaluation
open NumericalError SymbolicValues SFT.Foundation.ExactOperations
open SFT.Mathematics.DiscreteObjects SFT.InformationScience.EncodingMaps

inductive Expr where
 | value : Option Number → Expr
 | name : String → Expr
 | join : Expr → Expr → Expr
 | outside : String → Expr

abbrev Environment := List (String × Number)

def evaluate (environment : Environment) (expression : Expr) : Except String Number :=
  if distinct (environment.map Prod.fst) then
    match expression with
    | .value value => match value with
      | none => .error "only exact positive parts are semantic values"
      | some number => match number with
        | .zero => .error "only exact positive parts are semantic values"
        | .negative _ => .error "only exact positive parts are semantic values"
        | .positive part => .ok (.positive part)
    | .name label => match lookupFirst environment label with
      | none => .error "unbound name"
      | some value => .ok value
    | .join left right => match evaluate environment left with
      | .error reason => .error reason
      | .ok a => match evaluate environment right with
        | .error reason => .error reason
        | .ok b => .ok (add a b)
    | .outside _ => .error "expression constructor is outside the generated syntax"
  else .error "binding identity occurs twice"

inductive Evaluation (environment : Environment) : Expr → Number → Prop where
 | value (part : PositiveFraction) : Evaluation environment (.value (some (.positive part))) (.positive part)
 | name (label : String) (value : Number) (bound : lookupFirst environment label = some value) :
     Evaluation environment (.name label) value
 | join (left right : Expr) (a b : Number) (first : Evaluation environment left a) (second : Evaluation environment right b) :
     Evaluation environment (.join left right) (add a b)

theorem duplicateEnvironment (environment : Environment) (expression : Expr)
    (duplicate : distinct (environment.map Prod.fst) = false) :
    evaluate environment expression = .error "binding identity occurs twice" := by
  unfold evaluate; rw [duplicate]; rfl

theorem replay (environment : Environment) (expression : Expr) (value : Number)
    (unique : distinct (environment.map Prod.fst) = true)
    (derivation : Evaluation environment expression value) : evaluate environment expression = .ok value := by
  induction derivation with
  | value part => unfold evaluate; rw [unique]; rfl
  | name label value bound => unfold evaluate; rw [unique]; dsimp only; rw [bound]; rfl
  | join left right a b first second il ir => unfold evaluate; rw [unique]; dsimp only; rw [il]; dsimp only; rw [ir]; rfl

theorem reconstruct (environment : Environment) (expression : Expr) (value : Number)
    (accepted : evaluate environment expression = .ok value) : Evaluation environment expression value := by
  induction expression generalizing value with
  | value number =>
    unfold evaluate at accepted
    split at accepted
    · cases number with
      | none => cases accepted
      | some number => cases number with
        | zero => cases accepted
        | negative part => cases accepted
        | positive part => cases accepted; exact .value _
    · cases accepted
  | name label =>
    unfold evaluate at accepted
    split at accepted
    · dsimp only at accepted
      cases bound : lookupFirst environment label with
      | none => rw [bound] at accepted; cases accepted
      | some number => rw [bound] at accepted; cases accepted; exact .name _ _ bound
    · cases accepted
  | join left right il ir =>
    unfold evaluate at accepted
    split at accepted
    · dsimp only at accepted
      cases first : evaluate environment left with
      | error reason => rw [first] at accepted; cases accepted
      | ok a =>
        rw [first] at accepted
        dsimp only at accepted
        cases second : evaluate environment right with
        | error reason => rw [second] at accepted; cases accepted
        | ok b => rw [second] at accepted; cases accepted; exact .join _ _ _ _ (il _ first) (ir _ second)
    · cases accepted
  | outside tag => unfold evaluate at accepted; split at accepted <;> cases accepted

theorem sourceAdmission (environment : Environment) (expression : Expr) (value : Number) :
    evaluate environment expression = .ok value ↔
      distinct (environment.map Prod.fst) = true ∧ Evaluation environment expression value := by
  constructor
  · intro accepted
    cases guard : distinct (environment.map Prod.fst) with
    | false => rw [duplicateEnvironment _ _ guard] at accepted; cases accepted
    | true => exact ⟨rfl,reconstruct _ _ _ accepted⟩
  · intro h; exact replay _ _ _ h.1 h.2

theorem nameProvenance (environment : Environment) (label : String) (value : Number)
    (accepted : evaluate environment (.name label) = .ok value) : (label,value) ∈ environment := by
  have derivation := reconstruct _ _ _ accepted
  cases derivation with
  | name label value bound => exact lookupRow _ _ _ bound

theorem literalPositivity (environment : Environment) (literal : Option Number) (value : Number)
    (accepted : evaluate environment (.value literal) = .ok value) :
    ∃ part : PositiveFraction, literal = some (.positive part) ∧ value = .positive part := by
  have derivation := reconstruct _ _ _ accepted
  cases derivation with
  | value part => exact ⟨part,rfl,rfl⟩

theorem joinReconstruction (environment : Environment) (left right : Expr) (value : Number)
    (accepted : evaluate environment (.join left right) = .ok value) :
    ∃ a b, evaluate environment left = .ok a ∧ evaluate environment right = .ok b ∧ value = add a b := by
  have h := (sourceAdmission _ _ _).mp accepted
  cases h.2 with
  | join left right a b first second => exact ⟨a,b,replay _ _ _ h.1 first,replay _ _ _ h.1 second,rfl⟩

end SFT.Computation.SymbolicEvaluation
