import SFT.Foundation.FoldAssembly

/-! form_grammar.py: the two finite source productions, preserving arbitrary
(nonuniform) left and right subforms and their held labels and return marker. -/
namespace SFT.Foundation.FormConstruction

inductive Form where
  | one
  | fold (left right : Form)

inductive TupleValue where
  | text (value : String)
  | tuple (values : List TupleValue)
  | list (values : List TupleValue)

def encode : Form → TupleValue
  | .one => .tuple [.text "One"]
  | .fold left right => .tuple [.text "Fold",.tuple [.text "held-a",encode left],
      .tuple [.text "held-b",encode right],.text "return"]

def leaves : Form → Nat
  | .one => 1
  | .fold left right => leaves left + leaves right

def folds : Form → Nat
  | .one => 0
  | .fold left right => folds left + folds right + 1

def leafPaths : Form → List (List String)
  | .one => [[]]
  | .fold left right => (leafPaths left).map (fun path => "held-a"::path) ++
      (leafPaths right).map (fun path => "held-b"::path)

theorem oneSourceTuple : encode .one = .tuple [.text "One"] := rfl

theorem foldSourceTuple (left right : Form) : encode (.fold left right) =
    .tuple [.text "Fold",.tuple [.text "held-a",encode left],
      .tuple [.text "held-b",encode right],.text "return"] := rfl

theorem everyFormHasLeaf (form : Form) : 0 < leaves form := by
  induction form with
  | one => exact Nat.zero_lt_succ 0
  | fold left right ihl ihr => exact Nat.add_pos_left ihl _

theorem leafCountIsFoldCountPlusOne (form : Form) : leaves form = folds form+1 := by
  induction form with
  | one => rfl
  | fold left right ihl ihr =>
    change leaves left+leaves right = (folds left+folds right+1)+1
    rw [ihl,ihr,Nat.add_assoc,← Nat.add_assoc 1 (folds right) 1,Nat.add_comm 1 (folds right),
      Nat.add_assoc (folds right) 1 1,← Nat.add_assoc,← Nat.add_assoc]

theorem generatedInduction (P : Form → Prop) (base : P .one)
    (step : ∀ left right, P left → P right → P (.fold left right)) : ∀ form, P form := by
  intro form
  induction form with
  | one => exact base
  | fold left right ihl ihr => exact step left right ihl ihr

def first : Form := .fold .one .one
def leftDeep : Form := .fold first .one
def rightDeep : Form := .fold .one first

def generatedExamples : List Form := [.one,first,leftDeep,rightDeep,.fold first first]

theorem nonuniformFormsDistinct : leftDeep ≠ rightDeep := by
  intro h
  have left := Form.fold.inj h
  exact Form.noConfusion left.1

theorem bothHeldLabelsRetained (left right : Form) :
    leafPaths (.fold left right) = (leafPaths left).map (fun path => "held-a"::path) ++
      (leafPaths right).map (fun path => "held-b"::path) := rfl

theorem noExtraProduction (form : Form) : form = .one ∨ ∃ left right, form = .fold left right := by
  cases form with
  | one => exact Or.inl rfl
  | fold left right => exact Or.inr ⟨left,right,rfl⟩

theorem encodingInjective (p q : Form) (h : encode p = encode q) : p = q := by
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
      have edges := (List.cons.inj (TupleValue.tuple.inj h)).2
      have firstEdge := (List.cons.inj edges).1
      have secondEdge := (List.cons.inj (List.cons.inj edges).2).1
      have el := (List.cons.inj (List.cons.inj (TupleValue.tuple.inj firstEdge)).2).1
      have er := (List.cons.inj (List.cons.inj (TupleValue.tuple.inj secondEdge)).2).1
      exact (congrArg (fun x => Form.fold x right) (ihl a el)).trans
        (congrArg (fun x => Form.fold a x) (ihr b er))

end SFT.Foundation.FormConstruction
