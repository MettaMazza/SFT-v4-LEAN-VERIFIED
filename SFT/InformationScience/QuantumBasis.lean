import SFT.InformationScience.QuantumSupport
namespace SFT.InformationScience.QuantumBasis
open QuantitySupport QuantumSupport
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

def basisName (word : Word) : String := SFT.Host.Text.append "basis:" (SFT.Host.Text.intercalate ":" word)
def basisRows (support : List Word) : List (Word × String) := support.map (fun word => (word,basisName word))
def basisCorrespondence (support : List Word) : Except String (List (Word × String)) :=
  if support.isEmpty || !distinct support then .error "ValueError: basis correspondence requires canonical complete support"
  else .ok (basisRows support)

theorem basisMeaning (support : List Word) (rows : List (Word × String)) :
    basisCorrespondence support = .ok rows ↔ support.isEmpty = false ∧ distinct support = true ∧ rows = basisRows support := by
  unfold basisCorrespondence
  cases empty : support.isEmpty <;> cases unique : distinct support
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { cases h.1 }
  all_goals try { cases h.2.1 }
  · exact ⟨rfl,rfl,(Except.ok.inj h).symm⟩
  · rw [h.2.2]; rfl

theorem rowMembership (support : List Word) (word : Word) (name : String) :
    (word,name) ∈ basisRows support ↔ word ∈ support ∧ name = basisName word := by
  constructor
  · intro h
    obtain ⟨original,member,equal⟩ := memMapPreimage _ _ _ h
    cases equal
    exact ⟨member,rfl⟩
  · intro ⟨member,equal⟩
    cases equal
    exact memMap _ word support member

theorem recoverSupport (support : List Word) : (basisRows support).map Prod.fst = support := by
  induction support with
  | nil => rfl
  | cons word rest ih => exact congrArg (List.cons word) ih

theorem rowInjection (left right : Word) (h : (left,basisName left) = (right,basisName right)) : left = right :=
  congrArg Prod.fst h

theorem uniqueRows (support : List Word) (unique : distinct support = true) : distinct (basisRows support) = true :=
  mapDistinct (fun word => (word,basisName word)) (fun _ _ h => rowInjection _ _ h) support unique

theorem outputLength (support : List Word) : (basisRows support).length = support.length :=
  SFT.Foundation.CommonRefinement.mapLength _ _

-- Exact source-domain witness: delimiter-containing labels are admitted.
theorem delimiterSupportAccepted :
    completeFoldSupport ["a","a:a"] ["p","q"] =
      .ok [["a","a"],["a","a:a"],["a:a","a"],["a:a","a:a"]] := rfl

theorem delimiterNamesEqual : basisName ["a","a:a"] = basisName ["a:a","a"] := rfl

theorem delimiterWordsDifferent : (["a","a:a"] : Word) ≠ ["a:a","a"] := by decide

theorem delimiterBasisAccepted :
    basisCorrespondence [["a","a"],["a","a:a"],["a:a","a"],["a:a","a:a"]] =
      .ok [(["a","a"],"basis:a:a"),(["a","a:a"],"basis:a:a:a"),
        (["a:a","a"],"basis:a:a:a"),(["a:a","a:a"],"basis:a:a:a:a")] := rfl

end SFT.InformationScience.QuantumBasis
