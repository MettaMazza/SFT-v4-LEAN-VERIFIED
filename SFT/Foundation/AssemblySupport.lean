import SFT.Foundation.FoldAssemblyGrammar
/-! Source support/length/unique/extra relation fields interpreted on concrete
finite proposed word lists. Trace-coverage, transition and return fields remain
source relations supplied separately; they are not inferred from word lists. -/
namespace SFT.Foundation.AssemblySupport
open FoldAssembly Count.Representation

def sameWord (a b : Word) : Bool := decide (a = b)

theorem sameWordSound (a b : Word) (h : sameWord a b = true) : a = b := of_decide_eq_true h

theorem sameWordRefl (a : Word) : sameWord a a = true := decide_eq_true rfl

def containsWord (w : Word) : List Word → Bool
  | [] => false
  | x :: xs => sameWord w x || containsWord w xs

theorem containsWordIff (w : Word) (xs : List Word) : containsWord w xs = true ↔ w ∈ xs := by
  induction xs with
  | nil => constructor <;> intro h <;> cases h
  | cons x xs ih =>
    constructor
    · intro h
      cases (orTrue _ _).mp h with
      | inl eq =>
        have e := sameWordSound w x eq
        cases e
        exact List.Mem.head _
      | inr tail => exact List.Mem.tail _ (ih.mp tail)
    · intro h
      cases h with
      | head => exact (orTrue _ _).mpr (Or.inl (sameWordRefl w))
      | tail _ ht => exact (orTrue _ _).mpr (Or.inr (ih.mpr ht))

def everyWord (p : Word → Bool) : List Word → Bool
  | [] => true
  | x :: xs => p x && everyWord p xs

theorem everyWordIff (p : Word → Bool) (xs : List Word) :
    everyWord p xs = true ↔ ∀ w, w ∈ xs → p w = true := by
  induction xs with
  | nil =>
    constructor
    · intro _ w h; cases h
    · intro _; rfl
  | cons x xs ih =>
    constructor
    · intro h w hw
      have parts := (andTrue _ _).mp h
      cases hw with
      | head => exact parts.1
      | tail _ ht => exact ih.mp parts.2 w ht
    · intro h
      exact (andTrue _ _).mpr ⟨h x (List.Mem.head _),ih.mpr (fun w hw => h w (List.Mem.tail _ hw))⟩

def completeSupport (n : Nat) (ws : List Word) : Bool :=
  everyWord (fun w => containsWord w ws) (supportAfterExtensions n)

def generatedOnly (n : Nat) (ws : List Word) : Bool :=
  everyWord (fun w => containsWord w (supportAfterExtensions n)) ws

def lengthsAgree (n : Nat) (ws : List Word) : Bool := decide (∀ w, w ∈ ws → w.length = n)

def uniqueWords (ws : List Word) : Bool := decide ws.Nodup

theorem completeSupportIff (n : Nat) (ws : List Word) :
    completeSupport n ws = true ↔ ∀ w, w ∈ supportAfterExtensions n → w ∈ ws := by
  constructor
  · intro h w hw
    exact (containsWordIff w ws).mp ((everyWordIff _ _).mp h w hw)
  · intro h
    exact (everyWordIff _ _).mpr (fun w hw => (containsWordIff w ws).mpr (h w hw))

theorem generatedOnlyIff (n : Nat) (ws : List Word) :
    generatedOnly n ws = true ↔ ∀ w, w ∈ ws → w ∈ supportAfterExtensions n := by
  constructor
  · intro h w hw
    exact (containsWordIff w _).mp ((everyWordIff _ _).mp h w hw)
  · intro h
    exact (everyWordIff _ _).mpr (fun w hw => (containsWordIff w _).mpr (h w hw))

theorem lengthsAgreeIff (n : Nat) (ws : List Word) :
    lengthsAgree n ws = true ↔ ∀ w, w ∈ ws → w.length = n :=
  ⟨of_decide_eq_true,decide_eq_true⟩

theorem uniqueWordsIff (ws : List Word) : uniqueWords ws = true ↔ ws.Nodup :=
  ⟨of_decide_eq_true,decide_eq_true⟩

def lengthClass (b : Bool) : FoldAssemblyGrammar.Length := if b then .consistent else .inconsistent

def supportClass (b : Bool) : FoldAssemblyGrammar.Support := if b then .complete else .incomplete

def uniquenessClass (b : Bool) : FoldAssemblyGrammar.Uniqueness := if b then .unique else .duplicated

def extraClass (onlyGenerated ruleExtra : Bool) : FoldAssemblyGrammar.Extra :=
  if onlyGenerated && !ruleExtra then .noExtra else .hasExtra

theorem lengthClassExact (b : Bool) : lengthClass b = .consistent ↔ b = true := by
  cases b <;> constructor <;> intro h <;> first | rfl | cases h

theorem supportClassExact (b : Bool) : supportClass b = .complete ↔ b = true := by
  cases b <;> constructor <;> intro h <;> first | rfl | cases h

theorem uniquenessClassExact (b : Bool) : uniquenessClass b = .unique ↔ b = true := by
  cases b <;> constructor <;> intro h <;> first | rfl | cases h

theorem extraClassExact (onlyGenerated ruleExtra : Bool) :
    extraClass onlyGenerated ruleExtra = .noExtra ↔ onlyGenerated = true ∧ ruleExtra = false := by
  cases onlyGenerated with
  | false =>
    cases ruleExtra <;> constructor
    all_goals intro h
    all_goals first | cases h.1 | cases h
  | true =>
    cases ruleExtra with
    | false => exact ⟨fun _ => ⟨rfl,rfl⟩,fun _ => rfl⟩
    | true =>
      constructor
      · intro h; cases h
      · intro h; cases h.2

def classifySupport (n : Nat) (ws : List Word) (coverage : FoldAssemblyGrammar.Coverage)
    (transitions : FoldAssemblyGrammar.Transitions) (returns : FoldAssemblyGrammar.Returns)
    (ruleExtra : Bool) : FoldAssemblyGrammar.Candidate :=
  ⟨coverage,lengthClass (lengthsAgree n ws),supportClass (completeSupport n ws),
   uniquenessClass (uniqueWords ws),transitions,returns,extraClass (generatedOnly n ws) ruleExtra⟩

theorem supportAcceptanceIff (n : Nat) (ws : List Word) (coverage : FoldAssemblyGrammar.Coverage)
    (transitions : FoldAssemblyGrammar.Transitions) (returns : FoldAssemblyGrammar.Returns) (ruleExtra : Bool) :
    FoldAssemblyGrammar.survives (classifySupport n ws coverage transitions returns ruleExtra) = true ↔
    coverage = .complete ∧ (∀ w, w ∈ ws → w.length = n) ∧
    (∀ w, w ∈ supportAfterExtensions n → w ∈ ws) ∧ ws.Nodup ∧
    transitions = .present ∧ returns = .present ∧
    (∀ w, w ∈ ws → w ∈ supportAfterExtensions n) ∧ ruleExtra = false := by
  constructor
  · intro h
    obtain ⟨hc,hl,hs,hu,ht,hr,he⟩ := (FoldAssemblyGrammar.acceptanceIffExactCriteria _).mp h
    have extra := (extraClassExact _ _).mp he
    exact ⟨hc,(lengthsAgreeIff _ _).mp ((lengthClassExact _).mp hl),
      (completeSupportIff _ _).mp ((supportClassExact _).mp hs),
      (uniqueWordsIff _).mp ((uniquenessClassExact _).mp hu),ht,hr,
      (generatedOnlyIff _ _).mp extra.1,extra.2⟩
  · intro ⟨hc,hl,hs,hu,ht,hr,hg,he⟩
    exact (FoldAssemblyGrammar.acceptanceIffExactCriteria _).mpr ⟨hc,
      (lengthClassExact _).mpr ((lengthsAgreeIff _ _).mpr hl),
      (supportClassExact _).mpr ((completeSupportIff _ _).mpr hs),
      (uniquenessClassExact _).mpr ((uniqueWordsIff _).mpr hu),ht,hr,
      (extraClassExact _ _).mpr ⟨(generatedOnlyIff _ _).mpr hg,he⟩⟩

theorem canonicalSupportAccepted (n : Nat) :
    FoldAssemblyGrammar.survives (classifySupport n (supportAfterExtensions n) .complete .present .present false) = true :=
  (supportAcceptanceIff _ _ _ _ _ _).mpr ⟨rfl,supportWordLength n,fun _ h => h,
    allFiniteSupportsUnique n,rfl,rfl,fun _ h => h,rfl⟩

end SFT.Foundation.AssemblySupport
