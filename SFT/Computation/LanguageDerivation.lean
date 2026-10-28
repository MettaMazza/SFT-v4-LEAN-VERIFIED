import SFT.Computation.StateWords
namespace SFT.Computation.LanguageDerivation
open SFT.InformationScience.QuantitySupport
open SFT.Computation.StateWords
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

-- The two source production clauses: empty frontier and append a held symbol.
inductive Derivation (alphabet : List String) : Nat → Word → Prop
 | seed : Derivation alphabet 0 []
 | append {depth word} (prior : Derivation alphabet depth word) (symbol : String)
     (held : symbol ∈ alphabet) : Derivation alphabet (depth+1) (word ++ [symbol])

theorem derivationSound (alphabet : List String) (depth : Nat) (word : Word)
    (h : Derivation alphabet depth word) : word ∈ words alphabet depth := by
  induction h with
  | seed => exact List.Mem.head []
  | append prior symbol held ih =>
    rw [positionSuccessorOrder]
    exact memFlatMap _ _ _ _ ih (memMap _ symbol alphabet held)

theorem derivationComplete (alphabet : List String) (depth : Nat) (word : Word)
    (h : word ∈ words alphabet depth) : Derivation alphabet depth word := by
  induction depth generalizing word with
  | zero => cases h with
    | head => exact .seed
    | tail _ h => cases h
  | succ depth ih =>
    rw [positionSuccessorOrder] at h
    obtain ⟨prior,member,extension⟩ := memFlatMapOrigin _ _ _ h
    obtain ⟨symbol,held,eq⟩ := memMapPreimage _ _ _ extension
    cases eq
    exact .append (ih prior member) symbol held

theorem exactMembershipCertificate (alphabet : List String) (depth : Nat) (word : Word) :
    word ∈ words alphabet depth ↔ Derivation alphabet depth word :=
  ⟨derivationComplete alphabet depth word,derivationSound alphabet depth word⟩

theorem derivationDepth (alphabet : List String) (depth : Nat) (word : Word)
    (h : Derivation alphabet depth word) : word.length = depth :=
  ((wordCharacterization _ _ _).mp (derivationSound _ _ _ h)).1

theorem derivationCarrier (alphabet : List String) (depth : Nat) (word : Word)
    (h : Derivation alphabet depth word) : ∀ symbol, symbol ∈ word → symbol ∈ alphabet :=
  ((wordCharacterization _ _ _).mp (derivationSound _ _ _ h)).2

theorem generatedCertificate (alphabet positions : List String) (result : List Word)
    (h : generatedWords alphabet positions = .ok result) (word : Word) :
    word ∈ result ↔ word = ["empty-One"] ∨ ∃ depth, 0 < depth ∧ depth ≤ positions.length ∧ Derivation alphabet depth word := by
  constructor
  · intro member
    cases (generatedMembership _ _ _ h word).mp member with
    | inl marker => exact Or.inl marker
    | inr p =>
      obtain ⟨depth,positive,bound,length,letters⟩ := p
      exact Or.inr ⟨depth,positive,bound,derivationComplete _ _ _ ((wordCharacterization _ _ _).mpr ⟨length,letters⟩)⟩
  · intro certificate
    apply (generatedMembership _ _ _ h word).mpr
    cases certificate with
    | inl marker => exact Or.inl marker
    | inr p =>
      obtain ⟨depth,positive,bound,proof⟩ := p
      exact Or.inr ⟨depth,positive,bound,derivationDepth _ _ _ proof,derivationCarrier _ _ _ proof⟩

theorem appendCertificate (alphabet : List String) (depth : Nat) (word : Word)
    (h : Derivation alphabet depth word) (symbol : String) (held : symbol ∈ alphabet) :
    Derivation alphabet (depth+1) (word ++ [symbol]) := .append h symbol held

theorem productionPredecessor (alphabet : List String) (depth : Nat) (word : Word)
    (h : Derivation alphabet (depth+1) word) :
    ∃ prior symbol, Derivation alphabet depth prior ∧ symbol ∈ alphabet ∧ word = prior ++ [symbol] := by
  have member := derivationSound _ _ _ h
  rw [positionSuccessorOrder] at member
  obtain ⟨prior,hp,hm⟩ := memFlatMapOrigin _ _ _ member
  obtain ⟨symbol,held,eq⟩ := memMapPreimage _ _ _ hm
  exact ⟨prior,symbol,derivationComplete _ _ _ hp,held,eq.symm⟩



theorem composeDerivations (alphabet : List String) (leftDepth rightDepth : Nat) (left right : Word)
    (hl : Derivation alphabet leftDepth left) (hr : Derivation alphabet rightDepth right) :
    Derivation alphabet (leftDepth + rightDepth) (left ++ right) := by
  induction hr with
  | seed =>
    rw [SFT.InformationScience.SymbolExtension.appendNil]
    exact hl
  | @append depth word prior symbol held ih =>
    have result := Derivation.append ih symbol held
    rw [SFT.Mathematics.ExactTraceArithmetic.appendAssociative] at result
    exact result

end SFT.Computation.LanguageDerivation
