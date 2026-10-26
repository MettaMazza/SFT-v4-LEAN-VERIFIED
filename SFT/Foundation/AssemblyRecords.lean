import SFT.Foundation.AssemblySupport
import SFT.Foundation.FoldAssemblyTrace
namespace SFT.Foundation.AssemblyRecords
open FoldAssembly FoldAssemblyTrace AssemblySupport Count.Representation

def containsBy {α : Type} (eq : α → α → Bool) (x : α) : List α → Bool
  | [] => false
  | y :: ys => eq x y || containsBy eq x ys

def everyBy {α : Type} (p : α → Bool) : List α → Bool
  | [] => true
  | x :: xs => p x && everyBy p xs

theorem containsByIff {α : Type} (eq : α → α → Bool)
    (sound : ∀ a b, eq a b = true → a = b) (refl : ∀ a, eq a a = true)
    (x : α) (xs : List α) : containsBy eq x xs = true ↔ x ∈ xs := by
  induction xs with
  | nil => constructor <;> intro h <;> cases h
  | cons y ys ih =>
    constructor
    · intro h
      cases (orTrue _ _).mp h with
      | inl he =>
        have same := sound x y he
        cases same
        exact List.Mem.head _
      | inr ht => exact List.Mem.tail _ (ih.mp ht)
    · intro h
      cases h with
      | head => exact (orTrue _ _).mpr (Or.inl (refl x))
      | tail _ ht => exact (orTrue _ _).mpr (Or.inr (ih.mpr ht))

theorem everyByIff {α : Type} (p : α → Bool) (xs : List α) :
    everyBy p xs = true ↔ ∀ x, x ∈ xs → p x = true := by
  induction xs with
  | nil =>
    constructor
    · intro _ x hx; cases hx
    · intro _; rfl
  | cons x xs ih =>
    constructor
    · intro h y hy
      have parts := (andTrue _ _).mp h
      cases hy with
      | head => exact parts.1
      | tail _ ht => exact ih.mp parts.2 y ht
    · intro h
      exact (andTrue _ _).mpr ⟨h x (List.Mem.head _),ih.mpr (fun y hy => h y (List.Mem.tail _ hy))⟩

def coversBy {α : Type} (eq : α → α → Bool) (required proposed : List α) : Bool :=
  everyBy (fun x => containsBy eq x proposed) required

theorem coversByIff {α : Type} (eq : α → α → Bool)
    (sound : ∀ a b, eq a b = true → a = b) (refl : ∀ a, eq a a = true)
    (required proposed : List α) : coversBy eq required proposed = true ↔ ∀ x, x ∈ required → x ∈ proposed := by
  constructor
  · intro h x hx
    exact (containsByIff eq sound refl x proposed).mp ((everyByIff _ _).mp h x hx)
  · intro h
    exact (everyByIff _ _).mpr (fun x hx => (containsByIff eq sound refl x proposed).mpr (h x hx))

def sameTransition (a b : Transition) : Bool :=
  sameWord a.predecessor b.predecessor && (decide (a.label = b.label) && sameWord a.successor b.successor)

theorem sameTransitionSound (a b : Transition) (h : sameTransition a b = true) : a = b := by
  have parts := (andTrue _ _).mp h
  have tail := (andTrue _ _).mp parts.2
  have hp := sameWordSound _ _ parts.1
  have hl : a.label = b.label := of_decide_eq_true tail.1
  have hs := sameWordSound _ _ tail.2
  cases a with
  | mk p l s =>
    cases b with
    | mk q m t => cases hp; cases hl; cases hs; rfl

theorem sameTransitionRefl (t : Transition) : sameTransition t t = true :=
  (andTrue _ _).mpr ⟨sameWordRefl _,(andTrue _ _).mpr ⟨decide_eq_true rfl,sameWordRefl _⟩⟩

def sameReturn (a b : Word × Word) : Bool := sameWord a.1 b.1 && sameWord a.2 b.2

theorem sameReturnSound (a b : Word × Word) (h : sameReturn a b = true) : a = b := by
  have parts := (andTrue _ _).mp h
  have hc := sameWordSound _ _ parts.1
  have hp := sameWordSound _ _ parts.2
  cases a with
  | mk c p => cases b with
    | mk d q => cases hc; cases hp; rfl

theorem sameReturnRefl (r : Word × Word) : sameReturn r r = true :=
  (andTrue _ _).mpr ⟨sameWordRefl _,sameWordRefl _⟩

def completeTransitions (n : Nat) (ts : List Transition) : Bool := coversBy sameTransition (transitionTrace n) ts

def completeReturns (n : Nat) (rs : List (Word × Word)) : Bool := coversBy sameReturn (returnTrace n) rs

def generatedTransitionsOnly (n : Nat) (ts : List Transition) : Bool := coversBy sameTransition ts (transitionTrace n)

def generatedReturnsOnly (n : Nat) (rs : List (Word × Word)) : Bool := coversBy sameReturn rs (returnTrace n)

theorem completeTransitionsIff (n : Nat) (ts : List Transition) :
    completeTransitions n ts = true ↔ ∀ t, t ∈ transitionTrace n → t ∈ ts :=
  coversByIff sameTransition sameTransitionSound sameTransitionRefl _ _

theorem completeReturnsIff (n : Nat) (rs : List (Word × Word)) :
    completeReturns n rs = true ↔ ∀ r, r ∈ returnTrace n → r ∈ rs :=
  coversByIff sameReturn sameReturnSound sameReturnRefl _ _

theorem generatedTransitionsOnlyIff (n : Nat) (ts : List Transition) :
    generatedTransitionsOnly n ts = true ↔ ∀ t, t ∈ ts → t ∈ transitionTrace n :=
  coversByIff sameTransition sameTransitionSound sameTransitionRefl _ _

theorem generatedReturnsOnlyIff (n : Nat) (rs : List (Word × Word)) :
    generatedReturnsOnly n rs = true ↔ ∀ r, r ∈ rs → r ∈ returnTrace n :=
  coversByIff sameReturn sameReturnSound sameReturnRefl _ _

def transitionClass (b : Bool) : FoldAssemblyGrammar.Transitions := if b then .present else .absent

def returnClass (b : Bool) : FoldAssemblyGrammar.Returns := if b then .present else .absent

theorem transitionClassExact (b : Bool) : transitionClass b = .present ↔ b = true := by
  cases b <;> constructor <;> intro h <;> first | rfl | cases h

theorem returnClassExact (b : Bool) : returnClass b = .present ↔ b = true := by
  cases b <;> constructor <;> intro h <;> first | rfl | cases h

def recordExtra (ruleExtra transitionsGenerated returnsGenerated : Bool) : Bool :=
  ruleExtra || !(transitionsGenerated && returnsGenerated)

theorem notFalseIffTrue (b : Bool) : (!b) = false ↔ b = true := by
  cases b <;> constructor <;> intro h <;> first | rfl | cases h

theorem recordExtraFalseIff (ruleExtra tg rg : Bool) :
    recordExtra ruleExtra tg rg = false ↔ ruleExtra = false ∧ tg = true ∧ rg = true := by
  constructor
  · intro h
    have parts := (orFalse _ _).mp h
    have generated := (andTrue _ _).mp ((notFalseIffTrue _).mp parts.2)
    exact ⟨parts.1,generated.1,generated.2⟩
  · intro ⟨hr,ht,hg⟩
    exact (orFalse _ _).mpr ⟨hr,(notFalseIffTrue _).mpr ((andTrue _ _).mpr ⟨ht,hg⟩)⟩

def classifyRecords (n : Nat) (ws : List Word) (ts : List Transition) (rs : List (Word × Word))
    (coverage : FoldAssemblyGrammar.Coverage) (ruleExtra : Bool) : FoldAssemblyGrammar.Candidate :=
  classifySupport n ws coverage (transitionClass (completeTransitions n ts)) (returnClass (completeReturns n rs))
    (recordExtra ruleExtra (generatedTransitionsOnly n ts) (generatedReturnsOnly n rs))

theorem recordAcceptanceIff (n : Nat) (ws : List Word) (ts : List Transition) (rs : List (Word × Word))
    (coverage : FoldAssemblyGrammar.Coverage) (ruleExtra : Bool) :
    FoldAssemblyGrammar.survives (classifyRecords n ws ts rs coverage ruleExtra) = true ↔
    coverage = .complete ∧ (∀ w, w ∈ ws → w.length = n) ∧
    (∀ w, w ∈ supportAfterExtensions n → w ∈ ws) ∧ ws.Nodup ∧
    (∀ t, t ∈ transitionTrace n → t ∈ ts) ∧ (∀ r, r ∈ returnTrace n → r ∈ rs) ∧
    (∀ w, w ∈ ws → w ∈ supportAfterExtensions n) ∧ ruleExtra = false ∧
    (∀ t, t ∈ ts → t ∈ transitionTrace n) ∧ (∀ r, r ∈ rs → r ∈ returnTrace n) := by
  constructor
  · intro h
    obtain ⟨hc,hl,hs,hu,ht,hr,hw,he⟩ := (supportAcceptanceIff _ _ _ _ _ _).mp h
    have extra := (recordExtraFalseIff _ _ _).mp he
    exact ⟨hc,hl,hs,hu,(completeTransitionsIff _ _).mp ((transitionClassExact _).mp ht),
      (completeReturnsIff _ _).mp ((returnClassExact _).mp hr),hw,extra.1,
      (generatedTransitionsOnlyIff _ _).mp extra.2.1,(generatedReturnsOnlyIff _ _).mp extra.2.2⟩
  · intro ⟨hc,hl,hs,hu,ht,hr,hw,he,hgt,hgr⟩
    exact (supportAcceptanceIff _ _ _ _ _ _).mpr ⟨hc,hl,hs,hu,
      (transitionClassExact _).mpr ((completeTransitionsIff _ _).mpr ht),
      (returnClassExact _).mpr ((completeReturnsIff _ _).mpr hr),hw,
      (recordExtraFalseIff _ _ _).mpr ⟨he,(generatedTransitionsOnlyIff _ _).mpr hgt,
        (generatedReturnsOnlyIff _ _).mpr hgr⟩⟩

theorem canonicalRecordsAccepted (n : Nat) :
    FoldAssemblyGrammar.survives (classifyRecords n (supportAfterExtensions n)
      (transitionTrace n) (returnTrace n) .complete false) = true :=
  (recordAcceptanceIff _ _ _ _ _ _).mpr ⟨rfl,supportWordLength n,fun _ h => h,
    allFiniteSupportsUnique n,fun _ h => h,fun _ h => h,fun _ h => h,rfl,fun _ h => h,fun _ h => h⟩

theorem acceptedReturnsSound (n : Nat) (ws : List Word) (ts : List Transition) (rs : List (Word × Word))
    (coverage : FoldAssemblyGrammar.Coverage) (ruleExtra : Bool)
    (accepted : FoldAssemblyGrammar.survives (classifyRecords n ws ts rs coverage ruleExtra) = true)
    (child parent : Word) (present : (child,parent) ∈ rs) : returnWord child = some parent := by
  obtain ⟨_,_,_,_,_,_,_,_,_,generated⟩ := (recordAcceptanceIff _ _ _ _ _ _).mp accepted
  exact allReturnRecordsSound n child parent (generated (child,parent) present)

theorem acceptedTransitionsReturn (n : Nat) (ws : List Word) (ts : List Transition) (rs : List (Word × Word))
    (coverage : FoldAssemblyGrammar.Coverage) (ruleExtra : Bool)
    (accepted : FoldAssemblyGrammar.survives (classifyRecords n ws ts rs coverage ruleExtra) = true)
    (t : Transition) (present : t ∈ ts) : returnWord t.successor = some t.predecessor := by
  obtain ⟨_,_,_,_,_,_,_,_,generated,_⟩ := (recordAcceptanceIff _ _ _ _ _ _).mp accepted
  exact everyTransitionReturns n t (generated t present)

theorem missingTransitionRejected (n : Nat) (ws : List Word) (ts : List Transition) (rs : List (Word × Word))
    (coverage : FoldAssemblyGrammar.Coverage) (ruleExtra : Bool)
    (t : Transition) (required : t ∈ transitionTrace n) (missing : t ∉ ts) :
    FoldAssemblyGrammar.survives (classifyRecords n ws ts rs coverage ruleExtra) = false := by
  cases h : FoldAssemblyGrammar.survives (classifyRecords n ws ts rs coverage ruleExtra) with
  | false => rfl
  | true =>
    obtain ⟨_,_,_,_,retained,_,_,_,_,_⟩ := (recordAcceptanceIff _ _ _ _ _ _).mp h
    exact False.elim (missing (retained t required))

theorem missingReturnRejected (n : Nat) (ws : List Word) (ts : List Transition) (rs : List (Word × Word))
    (coverage : FoldAssemblyGrammar.Coverage) (ruleExtra : Bool)
    (r : Word × Word) (required : r ∈ returnTrace n) (missing : r ∉ rs) :
    FoldAssemblyGrammar.survives (classifyRecords n ws ts rs coverage ruleExtra) = false := by
  cases h : FoldAssemblyGrammar.survives (classifyRecords n ws ts rs coverage ruleExtra) with
  | false => rfl
  | true =>
    obtain ⟨_,_,_,_,_,retained,_,_,_,_⟩ := (recordAcceptanceIff _ _ _ _ _ _).mp h
    exact False.elim (missing (retained r required))

theorem incorrectReturnRejected (n : Nat) (ws : List Word) (ts : List Transition) (rs : List (Word × Word))
    (coverage : FoldAssemblyGrammar.Coverage) (ruleExtra : Bool)
    (child parent : Word) (present : (child,parent) ∈ rs) (incorrect : returnWord child ≠ some parent) :
    FoldAssemblyGrammar.survives (classifyRecords n ws ts rs coverage ruleExtra) = false := by
  cases h : FoldAssemblyGrammar.survives (classifyRecords n ws ts rs coverage ruleExtra) with
  | false => rfl
  | true => exact False.elim (incorrect (acceptedReturnsSound n ws ts rs coverage ruleExtra h child parent present))

end SFT.Foundation.AssemblyRecords
