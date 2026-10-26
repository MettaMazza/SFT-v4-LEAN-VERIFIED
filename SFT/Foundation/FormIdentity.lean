import SFT.Foundation.FormAcceptance
namespace SFT.Foundation.FormIdentity
open FormConstruction

/-! canonical_trace on all generated forms. Raw-input validation and exception
propagation are represented separately; this definition retains the exact output. -/
def canonicalTrace : Form → TupleValue
  | .one => .tuple [.text "One"]
  | .fold left right => .tuple [.text "Fold",.text "held-a",canonicalTrace left,
      .text "held-b",canonicalTrace right,.text "return"]

def Equivalent (left right : Form) : Prop := canonicalTrace left = canonicalTrace right

theorem oneTrace : canonicalTrace .one = .tuple [.text "One"] := rfl

theorem foldTrace (left right : Form) : canonicalTrace (.fold left right) =
    .tuple [.text "Fold",.text "held-a",canonicalTrace left,.text "held-b",canonicalTrace right,.text "return"] := rfl

theorem traceInjective (p q : Form) (h : canonicalTrace p = canonicalTrace q) : p = q := by
  induction p generalizing q with
  | one =>
    cases q with
    | one => rfl
    | fold left right =>
      have tags := (List.cons.inj (TupleValue.tuple.inj h)).1
      exact False.elim ((by decide : "One" ≠ "Fold") (TupleValue.text.inj tags))
  | fold left right ihl ihr =>
    cases q with
    | one =>
      have tags := (List.cons.inj (TupleValue.tuple.inj h)).1
      exact False.elim ((by decide : "Fold" ≠ "One") (TupleValue.text.inj tags))
    | fold a b =>
      have rest := (List.cons.inj (List.cons.inj (TupleValue.tuple.inj h)).2).2
      have el := (List.cons.inj rest).1
      have er := (List.cons.inj (List.cons.inj (List.cons.inj rest).2).2).1
      exact (congrArg (fun x => Form.fold x right) (ihl a el)).trans
        (congrArg (fun x => Form.fold a x) (ihr b er))

theorem equivalenceIffIdentity (left right : Form) : Equivalent left right ↔ left = right :=
  ⟨traceInjective left right,fun h => congrArg canonicalTrace h⟩

theorem equivalenceReflexive (form : Form) : Equivalent form form := rfl

theorem equivalenceSymmetric (left right : Form) (h : Equivalent left right) : Equivalent right left := h.symm

theorem equivalenceTransitive (a b c : Form) (ab : Equivalent a b) (bc : Equivalent b c) : Equivalent a c := ab.trans bc

theorem foldEquivalenceIffChildren (a b c d : Form) :
    Equivalent (.fold a b) (.fold c d) ↔ Equivalent a c ∧ Equivalent b d := by
  constructor
  · intro h
    have eq := Form.fold.inj (traceInjective _ _ h)
    exact ⟨congrArg canonicalTrace eq.1,congrArg canonicalTrace eq.2⟩
  · intro h
    have left := traceInjective _ _ h.1
    have right := traceInjective _ _ h.2
    cases left; cases right; rfl

theorem childSwapRejected : ¬ Equivalent leftDeep rightDeep := by
  intro h
  exact nonuniformFormsDistinct (traceInjective _ _ h)

theorem partialTraceRejected : canonicalTrace first ≠
    .tuple [.text "Fold",.text "held-a",.tuple [.text "One"],.text "return"] := by
  intro h
  have tail := (List.cons.inj (List.cons.inj (List.cons.inj (TupleValue.tuple.inj h)).2).2).2
  have label := (List.cons.inj tail).1
  exact False.elim ((by decide : "held-b" ≠ "return") (TupleValue.text.inj label))

def equivalentGenerated : Form → Form → Bool
  | .one, .one => true
  | .one, .fold _ _ => false
  | .fold _ _, .one => false
  | .fold a b, .fold c d => equivalentGenerated a c && equivalentGenerated b d

theorem generatedComparisonIffIdentity (left right : Form) : equivalentGenerated left right = true ↔ left = right := by
  induction left generalizing right with
  | one =>
    cases right with
    | one => exact ⟨fun _ => rfl, fun _ => rfl⟩
    | fold c d => constructor <;> intro h <;> cases h
  | fold a b iha ihb =>
    cases right with
    | one => constructor <;> intro h <;> cases h
    | fold c d =>
      constructor
      · intro h
        have pair : equivalentGenerated a c = true ∧ equivalentGenerated b d = true := by
          cases ha : equivalentGenerated a c <;> cases hb : equivalentGenerated b d
          all_goals first | exact ⟨rfl,rfl⟩ | (change (equivalentGenerated a c && equivalentGenerated b d) = true at h; rw [ha,hb] at h; cases h)
        have el := (iha c).mp pair.1
        have er := (ihb d).mp pair.2
        cases el; cases er; rfl
      · intro h
        have pair := Form.fold.inj h
        change (equivalentGenerated a c && equivalentGenerated b d) = true
        rw [(iha c).mpr pair.1,(ihb d).mpr pair.2]
        rfl

theorem generatedComparisonIffTrace (left right : Form) : equivalentGenerated left right = true ↔ Equivalent left right :=
  ⟨fun h => (equivalenceIffIdentity left right).mpr ((generatedComparisonIffIdentity left right).mp h),
   fun h => (generatedComparisonIffIdentity left right).mpr ((equivalenceIffIdentity left right).mp h)⟩

end SFT.Foundation.FormIdentity
