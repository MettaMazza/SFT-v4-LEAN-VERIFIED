import SFT.Computation.NameReplacement
import SFT.Computation.MeaningCorrespondence
import SFT.Mathematics.CategoryTypes
namespace SFT.Computation.StructuralTyping
open SymbolicEvaluation SymbolicContext NumericalError SymbolicValues
open SFT.Foundation.ExactOperations SFT.InformationScience.EncodingMaps
open SFT.Mathematics.DiscreteObjects

-- A proof realization of the declared positive semantic-value type, not a
-- replacement for evaluate_expression or an imported conventional calculus.
inductive Typed (env : Environment) : Expr → Prop where
 | value (part : PositiveFraction) : Typed env (.value (some (.positive part)))
 | name (label : String) (part : PositiveFraction)
     (bound : lookupFirst env label = some (.positive part)) : Typed env (.name label)
 | join (left right : Expr) (first : Typed env left) (second : Typed env right) : Typed env (.join left right)

def checks (env : Environment) : Expr → Bool
 | .value value => match value with
   | none => false
   | some number => match number with
     | .positive _ => true
     | .zero => false
     | .negative _ => false
 | .name label => match lookupFirst env label with
   | none => false
   | some number => match number with
     | .positive _ => true
     | .zero => false
     | .negative _ => false
 | .join left right => checks env left && checks env right
 | .outside _ => false

theorem formation (env : Environment) (e : Expr) (typed : Typed env e) : Generated e := by
  induction typed with
  | value part => exact .value part
  | name label part bound => exact .name label
  | join l r hl hr il ir => exact .join l r il ir

theorem checkSound (env : Environment) (e : Expr) (accepted : checks env e = true) : Typed env e := by
  induction e with
  | value v => cases v with
               | none => cases accepted
               | some n => cases n with
                 | zero => cases accepted
                 | negative p => cases accepted
                 | positive p => exact .value p
  | name label =>
    unfold checks at accepted
    cases h : lookupFirst env label with
    | none => rw [h] at accepted; cases accepted
    | some n =>
      rw [h] at accepted
      cases n with
      | zero => cases accepted
      | negative p => cases accepted
      | positive p => exact .name label p h
  | join l r il ir =>
    have h := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp accepted
    exact .join l r (il h.1) (ir h.2)
  | outside tag => cases accepted

theorem checkComplete (env : Environment) (e : Expr) (typed : Typed env e) : checks env e = true := by
  induction typed with
  | value p => rfl
  | name label p bound => unfold checks; rw [bound]
  | join l r hl hr il ir => change (checks env l && checks env r) = true; rw [il,ir]; rfl

theorem checkMeaning (env : Environment) (e : Expr) : checks env e = true ↔ Typed env e :=
  ⟨checkSound env e,checkComplete env e⟩

theorem preservesEvaluation (env : Environment) (e : Expr) (typed : Typed env e) :
    ∃ part : PositiveFraction, Evaluation env e (.positive part) := by
  induction typed with
  | value p => exact ⟨p,.value p⟩
  | name label p bound => exact ⟨p,.name label (.positive p) bound⟩
  | join l r hl hr il ir =>
    obtain ⟨a,pa⟩ := il; obtain ⟨b,pb⟩ := ir
    exact ⟨positiveSum a b,.join l r (.positive a) (.positive b) pa pb⟩

theorem completeTypedTrace (env : Environment) (e : Expr) (typed : Typed env e)
    (unique : distinct (env.map Prod.fst) = true) :
    ∃ part : PositiveFraction, evaluate env e = .ok (.positive part) ∧
      EvaluationTrace.Execution env e (.ok (.positive part)) (EvaluationTrace.run env e).2 := by
  obtain ⟨p,proof⟩ := preservesEvaluation env e typed
  have result := SymbolicEvaluation.replay _ _ _ unique proof
  have execution := EvaluationTrace.reconstruct env e
  rw [EvaluationTrace.resultCorrespondence,result] at execution
  exact ⟨p,result,execution⟩

theorem substitution (env : Environment) (target : String) (targetValue : Number)
    (replacement expression : Expr) (inserted : Typed env replacement)
    (original : Typed ((target,targetValue)::env) expression) :
    Typed env (NameReplacement.replace target replacement expression) := by
  induction original with
  | value p => exact .value p
  | name label part bound =>
    unfold NameReplacement.replace
    by_cases same : label = target
    · rw [ite_eq_left same]; exact inserted
    · rw [ite_eq_right same]
      have unchanged := NameReplacement.preservesOtherBinding env target label targetValue (fun h => same h.symm)
      exact .name label part (unchanged.symm.trans bound)
  | join l r hl hr il ir => exact .join _ _ il ir

theorem substitutionEvaluation (env : Environment) (target : String) (targetPart : PositiveFraction)
    (replacement expression : Expr) (inserted : Typed env replacement)
    (original : Typed ((target,.positive targetPart)::env) expression)
    (unique : distinct (env.map Prod.fst) = true) :
    ∃ part : PositiveFraction, evaluate env (NameReplacement.replace target replacement expression) = .ok (.positive part) ∧
      EvaluationTrace.Execution env (NameReplacement.replace target replacement expression) (.ok (.positive part))
        (EvaluationTrace.run env (NameReplacement.replace target replacement expression)).2 :=
  completeTypedTrace _ _ (substitution _ _ _ _ _ inserted original) unique

inductive Mismatch (env : Environment) : Expr → Prop where
 | absentLiteral : Mismatch env (.value none)
 | zeroLiteral : Mismatch env (.value (some .zero))
 | negativeLiteral (p) : Mismatch env (.value (some (.negative p)))
 | missingName (label) (h : lookupFirst env label = none) : Mismatch env (.name label)
 | zeroName (label) (h : lookupFirst env label = some .zero) : Mismatch env (.name label)
 | negativeName (label p) (h : lookupFirst env label = some (.negative p)) : Mismatch env (.name label)
 | outside (tag) : Mismatch env (.outside tag)
 | left (l r) (bad : Mismatch env l) : Mismatch env (.join l r)
 | right (l r) (bad : Mismatch env r) : Mismatch env (.join l r)

theorem mismatchRejects (env : Environment) (e : Expr) (bad : Mismatch env e) : checks env e = false := by
  induction bad with
  | absentLiteral => rfl
  | zeroLiteral => rfl
  | negativeLiteral => rfl
  | missingName label h => unfold checks; rw [h]
  | zeroName label h => unfold checks; rw [h]
  | negativeName label p h => unfold checks; rw [h]
  | outside => rfl
  | left l r h ih => change (checks env l && checks env r) = false; rw [ih]; rfl
  | right l r h ih => change (checks env l && checks env r) = false; rw [ih]; cases checks env l <;> rfl

theorem rejectedMismatch (env : Environment) (e : Expr) (rejected : checks env e = false) : Mismatch env e := by
  induction e with
  | value v => cases v with
               | none => exact .absentLiteral
               | some n => cases n with
                 | zero => exact .zeroLiteral
                 | negative p => exact .negativeLiteral p
                 | positive p => cases rejected
  | name label =>
    unfold checks at rejected
    cases h : lookupFirst env label with
    | none => exact .missingName label h
    | some n => cases n with
      | zero => exact .zeroName label h
      | negative p => exact .negativeName label p h
      | positive p => rw [h] at rejected; cases rejected
  | join l r il ir =>
    cases first : checks env l with
    | false => exact .left l r (il first)
    | true =>
      change (checks env l && checks env r) = false at rejected
      rw [first] at rejected
      exact .right l r (ir rejected)
  | outside tag => exact .outside tag

theorem exactMismatch (env : Environment) (e : Expr) : checks env e = false ↔ Mismatch env e :=
  ⟨rejectedMismatch env e,mismatchRejects env e⟩

theorem noTypedMismatch (env : Environment) (e : Expr) (typed : Typed env e) (bad : Mismatch env e) : False := by
  have h := (checkComplete _ _ typed).symm.trans (mismatchRejects _ _ bad)
  cases h

end SFT.Computation.StructuralTyping
