import SFT.Computation.NameScope
namespace SFT.Computation.NameReplacement
open SymbolicEvaluation SymbolicContext NumericalError
open SFT.InformationScience.EncodingMaps
open SFT.Mathematics.DiscreteObjects

-- Structural replacement in the registered value/name/join grammar. Names
-- compare by their original canonical string identity; no alias is supplied.
def replace (target : String) (replacement : Expr) : Expr → Expr
 | .value value => .value value
 | .name label => if label = target then replacement else .name label
 | .join left right => .join (replace target replacement left) (replace target replacement right)
 | .outside tag => .outside tag

inductive Replacement (target : String) (replacement : Expr) : Expr → Expr → Prop where
 | value (v) : Replacement target replacement (.value v) (.value v)
 | same : Replacement target replacement (.name target) replacement
 | other (label) : label ≠ target → Replacement target replacement (.name label) (.name label)
 | join (left right a b) : Replacement target replacement left a → Replacement target replacement right b →
     Replacement target replacement (.join left right) (.join a b)
 | outside (tag) : Replacement target replacement (.outside tag) (.outside tag)

theorem reconstruction (target : String) (replacement expression output : Expr)
    (proof : Replacement target replacement expression output) : replace target replacement expression = output := by
  induction proof with
  | value => rfl
  | same => change (if target = target then replacement else _) = replacement; rw [ite_eq_left rfl]
  | other label different => change (if label = target then replacement else _) = _; rw [ite_eq_right different]
  | join left right a b hl hr il ir => change Expr.join (replace target replacement left) (replace target replacement right) = _; rw [il,ir]
  | outside => rfl

theorem derivation (target : String) (replacement expression : Expr) :
    Replacement target replacement expression (replace target replacement expression) := by
  induction expression with
  | value v => exact .value v
  | name label =>
    unfold replace
    by_cases same : label = target
    · cases same; rw [ite_eq_left rfl]; exact .same
    · rw [ite_eq_right same]; exact .other _ same
  | join left right il ir => exact .join _ _ _ _ il ir
  | outside tag => exact .outside tag

theorem exactReplacement (target : String) (replacement expression output : Expr) :
    replace target replacement expression = output ↔ Replacement target replacement expression output := by
  constructor
  · intro same; cases same; exact derivation _ _ _
  · exact reconstruction _ _ _ _

theorem preservesFormation (target : String) (replacement expression : Expr)
    (inserted : Generated replacement) (original : Generated expression) : Generated (replace target replacement expression) := by
  induction original with
  | value p => exact .value p
  | name label =>
    unfold replace
    by_cases h : label = target
    · rw [ite_eq_left h]; exact inserted
    · rw [ite_eq_right h]; exact .name label
  | join a b ha hb ia ib => exact .join _ _ ia ib

theorem sourceEvaluation (environment : Environment) (target : String) (replacement expression : Expr) (value targetValue : Number)
    (held : lookupFirst environment target = some targetValue)
    (replacementValue : Evaluation environment replacement targetValue)
    (original : Evaluation environment expression value) :
    Evaluation environment (replace target replacement expression) value := by
  induction original with
  | value p => exact .value p
  | name label value bound =>
    unfold replace
    by_cases same : label = target
    · cases same; rw [ite_eq_left rfl]
      have sameValue := Option.some.inj (held.symm.trans bound)
      cases sameValue
      exact replacementValue
    · rw [ite_eq_right same]; exact .name _ _ bound
  | join a b x y ha hb ia ib => exact .join _ _ _ _ ia ib

theorem nativeValuePreserved (environment : Environment) (target : String) (replacement expression : Expr) (value targetValue : Number)
    (held : lookupFirst environment target = some targetValue)
    (replacementAccepted : evaluate environment replacement = .ok targetValue)
    (originalAccepted : evaluate environment expression = .ok value) :
    evaluate environment (replace target replacement expression) = .ok value := by
  have original := (sourceAdmission _ _ _).mp originalAccepted
  exact SymbolicEvaluation.replay _ _ _ original.1
    (sourceEvaluation _ _ _ _ _ _ held (SymbolicEvaluation.reconstruct _ _ _ replacementAccepted) original.2)

theorem insertedScopeResolved (environment : Environment) (target : String) (replacement expression : Expr) (value targetValue : Number)
    (held : lookupFirst environment target = some targetValue)
    (replacementAccepted : evaluate environment replacement = .ok targetValue)
    (originalAccepted : evaluate environment expression = .ok value) :
    ∀ path row, row ∈ NameScope.ledger environment path (replace target replacement expression) →
      ∃ found, row.value = some found ∧ lookupFirst environment row.label = some found :=
  NameScope.successfulScope _ _ _ (nativeValuePreserved _ _ _ _ _ _ held replacementAccepted originalAccepted)

theorem identity (target : String) (expression : Expr) : replace target (.name target) expression = expression := by
  induction expression with
  | value => rfl
  | name label => unfold replace; by_cases h : label = target
                  · rw [ite_eq_left h,h]
                  · rw [ite_eq_right h]
  | join a b ia ib => change Expr.join (replace target (.name target) a) (replace target (.name target) b) = _; rw [ia,ib]
  | outside => rfl

theorem composition (environment : Environment) (firstName secondName : String) (first second expression : Expr)
    (a b value : Number) (firstHeld : lookupFirst environment firstName = some a)
    (secondHeld : lookupFirst environment secondName = some b)
    (firstAccepted : evaluate environment first = .ok a) (secondAccepted : evaluate environment second = .ok b)
    (original : evaluate environment expression = .ok value) :
    evaluate environment (replace secondName second (replace firstName first expression)) = .ok value :=
  nativeValuePreserved _ _ _ _ _ _ secondHeld secondAccepted
    (nativeValuePreserved _ _ _ _ _ _ firstHeld firstAccepted original)

-- The original environment guard admits a new held binder precisely through
-- duplicate-free canonical identities; it does not silently overwrite an alias.
theorem freshBinder {Value : Type} (environment : List (String × Value)) (name : String) (value : Value)
    (admitted : distinct (((name,value)::environment).map Prod.fst) = true) :
    ¬ name ∈ environment.map Prod.fst := by
  have h := (distinctCons _ _).mp admitted
  exact (absentIff _ _).mp h.1

theorem freshLookup (environment : Environment) (name : String) (value : Number) :
    lookupFirst ((name,value)::environment) name = some value := by
  change (if name = name then some value else lookupFirst environment name) = _
  rw [ite_eq_left rfl]

theorem preservesOtherBinding (environment : Environment) (name other : String) (value : Number)
    (different : name ≠ other) :
    lookupFirst ((name,value)::environment) other = lookupFirst environment other := by
  change (if name = other then some value else lookupFirst environment other) = _
  rw [ite_eq_right different]

theorem freshConstruction (environment : Environment) (name : String) (value : Number)
    (unique : distinct (environment.map Prod.fst) = true)
    (fresh : ¬ name ∈ environment.map Prod.fst) :
    distinct (((name,value)::environment).map Prod.fst) = true :=
  (distinctCons _ _).mpr ⟨(absentIff _ _).mpr fresh,unique⟩

theorem dischargeBinding (environment : Environment) (target : String) (replacement expression : Expr) (value targetValue : Number)
    (inserted : Evaluation environment replacement targetValue)
    (original : Evaluation ((target,targetValue)::environment) expression value) :
    Evaluation environment (replace target replacement expression) value := by
  induction original with
  | value p => exact .value p
  | name label value bound =>
    unfold replace
    by_cases same : label = target
    · cases same; rw [ite_eq_left rfl]
      have source := freshLookup environment target targetValue
      have equal := Option.some.inj (source.symm.trans bound)
      cases equal
      exact inserted
    · rw [ite_eq_right same]
      have unchanged := preservesOtherBinding environment target label targetValue (fun equal => same equal.symm)
      exact .name _ _ (unchanged.symm.trans bound)
  | join a b x y ha hb ia ib => exact .join _ _ _ _ ia ib

theorem nativeDischarge (environment : Environment) (target : String) (replacement expression : Expr) (value targetValue : Number)
    (inserted : evaluate environment replacement = .ok targetValue)
    (original : evaluate ((target,targetValue)::environment) expression = .ok value) :
    evaluate environment (replace target replacement expression) = .ok value := by
  have p := (sourceAdmission _ _ _).mp inserted
  exact SymbolicEvaluation.replay _ _ _ p.1
    (dischargeBinding _ _ _ _ _ _ p.2 (SymbolicEvaluation.reconstruct _ _ _ original))

theorem openReplacementScope (environment : Environment) (target : String) (replacement expression : Expr) (value targetValue : Number)
    (inserted : evaluate environment replacement = .ok targetValue)
    (original : evaluate ((target,targetValue)::environment) expression = .ok value) :
    ∀ path row, row ∈ NameScope.ledger environment path (replace target replacement expression) →
      ∃ found, row.value = some found ∧ lookupFirst environment row.label = some found :=
  NameScope.successfulScope _ _ _ (nativeDischarge _ _ _ _ _ _ inserted original)

theorem joinSuccessor (target : String) (replacement left right : Expr) :
    replace target replacement (.join left right) = .join (replace target replacement left) (replace target replacement right) := rfl

theorem originalPayload (target : String) (replacement : Expr) (payload : Option Number) :
    replace target replacement (.value payload) = .value payload := rfl

theorem originalAdmissionRequiresFresh (environment : Environment) (target : String) (targetValue value : Number)
    (expression : Expr) (accepted : evaluate ((target,targetValue)::environment) expression = .ok value) :
    ¬ target ∈ environment.map Prod.fst :=
  freshBinder environment target targetValue ((sourceAdmission _ _ _).mp accepted).1

end SFT.Computation.NameReplacement
