import SFT.InformationScience.SymbolLedger
namespace SFT.InformationScience.SymbolExtension
open SymbolObservation SymbolLedger SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

theorem appendedLabels (observation : Observation) (fresh symbol : Symbol) (label : String) :
    labelsFor (observation ++ [(fresh,label)]) symbol =
      labelsFor observation symbol ++ (if fresh = symbol then [label] else []) := by
  induction observation with
  | nil =>
    change (if fresh = symbol then [label] else []) = _
    rfl
  | cons row rest ih =>
    cases row with
    | mk source value =>
      change (if source = symbol then value :: labelsFor (rest ++ [(fresh,label)]) symbol
        else labelsFor (rest ++ [(fresh,label)]) symbol) = _
      by_cases same : source = symbol
      · rw [ite_eq_left same,labelsFor,ite_eq_left same,ih]; rfl
      · rw [ite_eq_right same,labelsFor,ite_eq_right same,ih]

theorem appendNil {α : Type} (xs : List α) : xs ++ [] = xs := by
  induction xs with
  | nil => rfl
  | cons x xs ih => exact congrArg (List.cons x) ih

theorem oldLookupPreserved (observation : Observation) (fresh symbol : Symbol) (label : String)
    (different : fresh ≠ symbol) :
    observedLabel (observation ++ [(fresh,label)]) symbol = observedLabel observation symbol := by
  unfold observedLabel
  rw [appendedLabels,ite_eq_right different,appendNil]

theorem freshLookup (observation : Observation) (fresh : Symbol) (label : String)
    (absent : ¬ fresh ∈ observation.map Prod.fst) :
    observedLabel (observation ++ [(fresh,label)]) fresh = .ok label := by
  apply (observedExactlyOnce _ _ _).mpr
  rw [appendedLabels,labelsAbsent _ _ absent,ite_eq_left rfl]
  rfl

theorem successorLookup (alphabet : List Symbol) (observation : Observation)
    (valid : validateObservation alphabet observation = true) (fresh : Symbol) (label : String)
    (new : ¬ fresh ∈ alphabet) (held : label.isEmpty = false) (symbol : Symbol)
    (member : symbol ∈ alphabet ++ [fresh]) :
    ∃ result, observedLabel (observation ++ [(fresh,label)]) symbol = .ok result ∧ result.isEmpty = false := by
  have v := (validationMeaning _ _).mp valid
  have keys := (keysMeaning _ _).mp v.2.2.2.1
  cases memAppendCases _ _ _ member with
  | inl old =>
    have different : fresh ≠ symbol := by intro eq; cases eq; exact new old
    obtain ⟨result,hr,hn⟩ := validatedLookup _ _ valid symbol old
    exact ⟨result,(oldLookupPreserved _ _ _ _ different).trans hr,hn⟩
  | inr freshMember =>
    cases freshMember with
    | head =>
      have absent : ¬ fresh ∈ observation.map Prod.fst := fun hm => new (keys.1 fresh hm)
      exact ⟨label,freshLookup _ _ _ absent,held⟩
    | tail _ impossible => cases impossible

theorem priorDistinctionPreserved (observation : Observation) (fresh left right : Symbol) (label : String)
    (hl : fresh ≠ left) (hr : fresh ≠ right) :
    distinguishable (observation ++ [(fresh,label)]) left right = distinguishable observation left right := by
  unfold distinguishable
  rw [oldLookupPreserved _ _ _ _ hl,oldLookupPreserved _ _ _ _ hr]

end SFT.InformationScience.SymbolExtension
