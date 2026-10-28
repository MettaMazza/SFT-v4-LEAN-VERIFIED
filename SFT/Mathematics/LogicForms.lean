import SFT.Mathematics.DiscreteComposition
namespace SFT.Mathematics.LogicForms

inductive Orientation where
  | held
  | complementaryHeld
  deriving DecidableEq

structure Proposition where
  form : String
  orientation : Orientation
  canonical : form.isEmpty = false
  deriving DecidableEq

def makeProposition (form orientation : String) : Except String Proposition :=
  if empty : form.isEmpty then
    .error "a proposition requires a canonical form and one held orientation"
  else if orientation = "held" then .ok ⟨form,.held,by cases h : form.isEmpty with | false => rfl | true => exact False.elim (empty h)⟩
  else if orientation = "complementary-held" then .ok ⟨form,.complementaryHeld,by cases h : form.isEmpty with | false => rfl | true => exact False.elim (empty h)⟩
  else .error "a proposition requires a canonical form and one held orientation"

def orientationName : Orientation → String
  | .held => "held"
  | .complementaryHeld => "complementary-held"

structure ProofStep where
  premises : List Proposition
  conclusion : Proposition
  rule : String
  premisesNonempty : premises.isEmpty = false
  ruleNonempty : rule.isEmpty = false

def makeProofStep (premises : List Proposition) (conclusion : Proposition) (rule : String) : Except String ProofStep :=
  if empty : premises.isEmpty then .error "a proof step retains its nonempty premises and registered rule"
  else if noRule : rule.isEmpty then .error "a proof step retains its nonempty premises and registered rule"
  else .ok ⟨premises,conclusion,rule,
    by cases h : premises.isEmpty with | false => rfl | true => exact False.elim (empty h),
    by cases h : rule.isEmpty with | false => rfl | true => exact False.elim (noRule h)⟩

def flip : Orientation → Orientation
  | .held => .complementaryHeld
  | .complementaryHeld => .held

def denied (proposition : Proposition) : Proposition :=
  ⟨proposition.form,flip proposition.orientation,proposition.canonical⟩

def conjunction (left right : Proposition) : String × Proposition × Proposition :=
  ("joint-complete",left,right)

def disjunction (left right held : Proposition) : Except String (String × Proposition × (Proposition × Proposition)) :=
  if held = left ∨ held = right then .ok ("held-alternative",held,(left,right))
  else .error "a disjunction witness must hold one generated alternative"

theorem propositionFieldsDetermine (left right : Proposition) (form : left.form = right.form)
    (orientation : left.orientation = right.orientation) : left = right := by
  cases left
  cases right
  cases form
  cases orientation
  rfl

theorem flipTwice (orientation : Orientation) : flip (flip orientation) = orientation := by cases orientation <;> rfl

theorem denialInvolution (proposition : Proposition) : denied (denied proposition) = proposition := by
  apply propositionFieldsDetermine
  · rfl
  · exact flipTwice proposition.orientation

theorem denialPreservesForm (proposition : Proposition) : (denied proposition).form = proposition.form := rfl

theorem denialChangesOrientation (proposition : Proposition) : (denied proposition).orientation ≠ proposition.orientation := by
  change flip proposition.orientation ≠ proposition.orientation
  cases proposition.orientation <;> intro same <;> cases same

theorem denialDistinct (proposition : Proposition) : denied proposition ≠ proposition := by
  intro same
  exact denialChangesOrientation proposition (congrArg Proposition.orientation same)

theorem conjunctionRetainsBoth (left right : Proposition) :
    (conjunction left right).2.1 = left ∧ (conjunction left right).2.2 = right := ⟨rfl,rfl⟩

theorem disjunctionAdmitted (left right held : Proposition) (choice : held = left ∨ held = right) :
    disjunction left right held = .ok ("held-alternative",held,(left,right)) := by
  unfold disjunction
  rw [ite_eq_left choice]

theorem disjunctionRejected (left right held : Proposition) (noChoice : ¬ (held = left ∨ held = right)) :
    disjunction left right held = .error "a disjunction witness must hold one generated alternative" := by
  unfold disjunction
  rw [ite_eq_right noChoice]

theorem propositionRejectsEmpty (orientation : String) :
    makeProposition "" orientation = .error "a proposition requires a canonical form and one held orientation" := rfl

theorem propositionRoundTrip (proposition : Proposition) :
    makeProposition proposition.form (orientationName proposition.orientation) = .ok proposition := by
  cases proposition with
  | mk form orientation canonical =>
    unfold makeProposition
    split
    · rename_i empty
      rw [canonical] at empty
      cases empty
    · cases orientation <;> rfl

theorem stepRoundTrip (step : ProofStep) :
    makeProofStep step.premises step.conclusion step.rule = .ok step := by
  cases step with
  | mk premises conclusion rule nonempty registered =>
    unfold makeProofStep
    split
    · rename_i empty; rw [nonempty] at empty; cases empty
    · split
      · rename_i empty; rw [registered] at empty; cases empty
      · rfl

theorem stepRejectsEmptyPremises (conclusion : Proposition) (rule : String) :
    makeProofStep [] conclusion rule = .error "a proof step retains its nonempty premises and registered rule" := rfl

end SFT.Mathematics.LogicForms
