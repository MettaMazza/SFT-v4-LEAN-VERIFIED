import SFT.InformationScience.CompressionSupport
namespace CompressionSourceDomainDiagnostic
open SFT.InformationScience.CompressionSupport
abbrev Word := List String

def labels : List String := ["a","a"]
def positions : List String := ["p1","p2"]
def full : List Word := [["a","a"],["a","a"],["a","a"],["a","a"]]
def code (_ : Word) : Word := ["a"]

theorem sourceAccepts : fixedSupport labels positions = .ok full := rfl

theorem sourceCountCheckTrue : universalShorteningImpossible labels positions = .ok true := rfl

theorem everyGeneratedWord (word : Word) (h : word ∈ full) : word = ["a","a"] := by
  cases h with
  | head => rfl
  | tail _ h => cases h with
    | head => rfl
    | tail _ h => cases h with
      | head => rfl
      | tail _ h => cases h with
        | head => rfl
        | tail _ h => cases h

theorem injectiveOnGeneratedWords (a : Word) (ha : a ∈ full) (b : Word) (hb : b ∈ full)
    (_ : code a = code b) : a = b := (everyGeneratedWord a ha).trans (everyGeneratedWord b hb).symm

theorem everyCodeStrictlyShorter (word : Word) (h : word ∈ full) :
    code word ∈ shorterNonemptySupport labels positions ∧ (code word).length < word.length := by
  constructor
  · exact List.Mem.head _
  · rw [everyGeneratedWord word h]
    exact Nat.lt_succ_self 1

#print axioms sourceAccepts
#print axioms sourceCountCheckTrue
#print axioms everyGeneratedWord
#print axioms injectiveOnGeneratedWords
#print axioms everyCodeStrictlyShorter
end CompressionSourceDomainDiagnostic
