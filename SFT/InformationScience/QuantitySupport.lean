import SFT.InformationScience.EncodingExtension
namespace SFT.InformationScience.QuantitySupport
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations
open SFT.Mathematics.ExactTraceArithmetic
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
abbrev Word := List String

def emptyOne : Word := ["empty-One"]
def words (labels : List String) : Nat → List Word
  | 0 => [[]]
  | n+1 => labels.flatMap (fun label => (words labels n).map (List.cons label))

def completeWordSupport (labels positions : List String) : Except String (List Word) :=
  if labels.length < 2 || !distinct labels then
    .error "ValueError: information support requires at least one generated distinction"
  else if positions.isEmpty || !distinct positions then
    .error "ValueError: information depth requires a nonempty canonical position trace"
  else .ok (words labels positions.length)

def composeSupport (left right : List Word) : Except String (List Word) :=
  if left.isEmpty || right.isEmpty then
    .error "ValueError: information composition requires nonempty supports"
  else .ok (left.flatMap (fun a => right.map (fun b => a ++ b)))

theorem wordsSuccessorMember (labels : List String) (n : Nat) (word : Word) :
    word ∈ words labels (n+1) ↔ ∃ label, label ∈ labels ∧ ∃ tail, tail ∈ words labels n ∧ word = label :: tail := by
  constructor
  · intro h
    obtain ⟨label,hl,hm⟩ := memFlatMapOrigin _ _ _ h
    obtain ⟨tail,ht,eq⟩ := memMapPreimage (List.cons label) word _ hm
    exact ⟨label,hl,tail,ht,eq.symm⟩
  · intro ⟨label,hl,tail,ht,eq⟩
    cases eq
    exact memFlatMap _ _ label _ hl (memMap (List.cons label) tail _ ht)

theorem wordCharacterization (labels : List String) (n : Nat) (word : Word) :
    word ∈ words labels n ↔ word.length = n ∧ ∀ label, label ∈ word → label ∈ labels := by
  induction n generalizing word with
  | zero =>
    constructor
    · intro h; cases h with
      | head => exact ⟨rfl,fun _ h => by cases h⟩
      | tail _ h => cases h
    · intro h
      cases word with
      | nil => exact List.Mem.head []
      | cons _ _ => cases h.1
  | succ n ih =>
    constructor
    · intro h
      obtain ⟨label,hl,tail,ht,eq⟩ := (wordsSuccessorMember _ _ _).mp h
      cases eq
      have p := (ih tail).mp ht
      refine ⟨congrArg Nat.succ p.1,?_⟩
      intro x hx
      cases hx with
      | head => exact hl
      | tail _ hx => exact p.2 x hx
    · intro h
      cases word with
      | nil => cases h.1
      | cons label tail =>
        apply (wordsSuccessorMember _ _ _).mpr
        exact ⟨label,h.2 label (List.Mem.head _),tail,(ih tail).mpr
          ⟨Nat.succ.inj h.1,fun x hx => h.2 x (List.Mem.tail label hx)⟩,rfl⟩

theorem distinctRows (labels : List String) (tails : List Word)
    (hl : distinct labels = true) (ht : distinct tails = true) :
    distinct (labels.flatMap (fun label => tails.map (List.cons label))) = true := by
  induction labels with
  | nil => rfl
  | cons label rest ih =>
    have p := (distinctCons _ _).mp hl
    apply appendDistinct
    · exact mapDistinct (List.cons label) (fun _ _ eq => (List.cons.inj eq).2) tails ht
    · exact ih p.2
    · intro word first last
      obtain ⟨tail,_,eq⟩ := memMapPreimage (List.cons label) word _ first
      obtain ⟨other,ho,hm⟩ := memFlatMapOrigin _ _ _ last
      obtain ⟨suffix,_,eq2⟩ := memMapPreimage (List.cons other) word _ hm
      have same := (List.cons.inj (eq.trans eq2.symm)).1
      cases same
      exact (absentIff _ _).mp p.1 ho

theorem wordsDistinct (labels : List String) (unique : distinct labels = true) (n : Nat) :
    distinct (words labels n) = true := by
  induction n with
  | zero => rfl
  | succ n ih => exact distinctRows labels (words labels n) unique ih

theorem supportResult (labels positions : List String) (result : List Word)
    (h : completeWordSupport labels positions = .ok result) : result = words labels positions.length := by
  unfold completeWordSupport at h
  split at h
  · cases h
  · split at h
    · cases h
    · exact (Except.ok.inj h).symm

theorem supportAdmission (labels positions : List String) :
    (∃ result, completeWordSupport labels positions = .ok result) ↔
      ¬ labels.length < 2 ∧ distinct labels = true ∧ positions.isEmpty = false ∧ distinct positions = true := by
  unfold completeWordSupport
  cases small : decide (labels.length < 2) <;> cases unique : distinct labels <;>
    cases empty : positions.isEmpty <;> cases canonical : distinct positions
  all_goals constructor
  all_goals intro h
  all_goals try { obtain ⟨result,he⟩ := h; cases he }
  all_goals try { have no := h.2.1; cases no }
  all_goals try { have no := h.2.2.1; cases no }
  all_goals try { have no := h.2.2.2; cases no }
  all_goals try { exact ⟨words labels positions.length,rfl⟩ }
  all_goals try { exact False.elim (h.1 (of_decide_eq_true small)) }
  all_goals exact ⟨of_decide_eq_false small,rfl,rfl,rfl⟩

theorem admittedSupportDistinct (labels positions : List String) (result : List Word)
    (h : completeWordSupport labels positions = .ok result) : distinct result = true := by
  rw [supportResult _ _ _ h]
  exact wordsDistinct labels ((supportAdmission _ _).mp ⟨result,h⟩).2.1 _

theorem admittedWord (labels positions : List String) (result : List Word)
    (h : completeWordSupport labels positions = .ok result) (word : Word) :
    word ∈ result ↔ word.length = positions.length ∧ ∀ label, label ∈ word → label ∈ labels := by
  rw [supportResult _ _ _ h]; exact wordCharacterization _ _ _

theorem allowedAppend (labels : List String) (a b : Word)
    (ha : ∀ x, x ∈ a → x ∈ labels) (hb : ∀ x, x ∈ b → x ∈ labels) :
    ∀ x, x ∈ a ++ b → x ∈ labels := by
  intro x hx
  cases memAppendCases x a b hx with
  | inl h => exact ha x h
  | inr h => exact hb x h

theorem appendWord (labels : List String) (n m : Nat) (a b : Word)
    (ha : a ∈ words labels n) (hb : b ∈ words labels m) : a ++ b ∈ words labels (n+m) := by
  have pa := (wordCharacterization _ _ _).mp ha
  have pb := (wordCharacterization _ _ _).mp hb
  apply (wordCharacterization _ _ _).mpr
  exact ⟨by rw [appendLength,pa.1,pb.1],allowedAppend _ _ _ pa.2 pb.2⟩

theorem independentPosition (labels : List String) (n m : Nat) (before after : Word) (label : String)
    (hp : before ∈ words labels n) (hs : after ∈ words labels m) (hl : label ∈ labels) :
    before ++ label :: after ∈ words labels (n+(m+1)) := by
  have tail : label :: after ∈ words labels (m+1) :=
    (wordsSuccessorMember _ _ _).mpr ⟨label,hl,after,hs,rfl⟩
  exact appendWord _ _ _ _ _ hp tail

theorem cancelPrefix (before a b : Word) (h : before ++ a = before ++ b) : a = b := by
  induction before with
  | nil => exact h
  | cons first rest ih => exact ih (List.cons.inj h).2

theorem positionAlternativesDistinct (before after : Word) (a b : String) (different : a ≠ b) :
    before ++ a :: after ≠ before ++ b :: after := by
  intro eq
  exact different (List.cons.inj (cancelPrefix _ _ _ eq)).1

theorem compositionResult (left right result : List Word) (h : composeSupport left right = .ok result) :
    result = left.flatMap (fun a => right.map (fun b => a ++ b)) := by
  unfold composeSupport at h
  split at h
  · cases h
  · exact (Except.ok.inj h).symm

theorem compositionMembership (left right result : List Word) (h : composeSupport left right = .ok result)
    (word : Word) : word ∈ result ↔ ∃ a, a ∈ left ∧ ∃ b, b ∈ right ∧ word = a ++ b := by
  rw [compositionResult _ _ _ h]
  constructor
  · intro h
    obtain ⟨a,ha,hm⟩ := memFlatMapOrigin _ _ _ h
    obtain ⟨b,hb,eq⟩ := memMapPreimage (fun b => a ++ b) word _ hm
    exact ⟨a,ha,b,hb,eq.symm⟩
  · intro ⟨a,ha,b,hb,eq⟩
    cases eq
    exact memFlatMap _ _ _ _ ha (memMap (fun b => a ++ b) b _ hb)

def extendWords (labels : List String) (previous : List Word) : List Word :=
  previous.flatMap (fun word => labels.map (fun label => word ++ [label]))

theorem extendAppend (labels : List String) (a b : List Word) :
    extendWords labels (a ++ b) = extendWords labels a ++ extendWords labels b := by
  induction a with
  | nil => rfl
  | cons word rest ih =>
    change labels.map (fun label => word ++ [label]) ++ extendWords labels (rest ++ b) = _
    rw [ih]
    exact (appendAssociative _ _ _).symm

theorem prefixExtensions (labels : List String) (first : String) (word : Word) :
    labels.map (fun label => (first :: word) ++ [label]) =
      (labels.map (fun label => word ++ [label])).map (List.cons first) := by
  induction labels with
  | nil => rfl
  | cons label rest ih => exact congrArg (List.cons (first :: (word ++ [label]))) ih

theorem extendPrefixed (labels : List String) (first : String) (previous : List Word) :
    extendWords labels (previous.map (List.cons first)) =
      (extendWords labels previous).map (List.cons first) := by
  induction previous with
  | nil => rfl
  | cons word rest ih =>
    change labels.map (fun label => (first :: word) ++ [label]) ++
      extendWords labels (rest.map (List.cons first)) =
      (labels.map (fun label => word ++ [label]) ++ extendWords labels rest).map (List.cons first)
    rw [prefixExtensions,ih,mapAppend]

theorem extendRows (labels heads : List String) (tails : List Word) :
    extendWords labels (heads.flatMap (fun head => tails.map (List.cons head))) =
      heads.flatMap (fun head => (extendWords labels tails).map (List.cons head)) := by
  induction heads with
  | nil => rfl
  | cons head rest ih =>
    change extendWords labels (tails.map (List.cons head) ++ rest.flatMap (fun x => tails.map (List.cons x))) = _
    rw [extendAppend,extendPrefixed,ih]; rfl

theorem firstPositionWords (labels : List String) : words labels 1 = labels.map (fun label => [label]) := by
  induction labels with
  | nil => rfl
  | cons first rest ih => exact congrArg (List.cons [first]) ih

theorem positionSuccessorOrder (labels : List String) (n : Nat) :
    words labels (n+1) = extendWords labels (words labels n) := by
  induction n with
  | zero =>
    rw [firstPositionWords]
    change labels.map (fun label => [label]) = labels.map (fun label => [label]) ++ []
    exact (SymbolExtension.appendNil _).symm
  | succ n ih =>
    change labels.flatMap (fun label => (words labels (n+1)).map (List.cons label)) =
      extendWords labels (labels.flatMap (fun label => (words labels n).map (List.cons label)))
    rw [ih,extendRows]

end SFT.InformationScience.QuantitySupport
