import SFT.Mathematics.CombinatorialSelections
namespace SFT.Mathematics.CombinatorialSelections
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

theorem encodedFormNonempty (form : Form) : encodeEmpty form ≠ [] := by
  cases form with
  | nil => intro h; cases h
  | cons x xs => intro h; cases h

theorem encodeAppendNonempty (form : Form) (fresh : String) :
    encodeEmpty (form ++ [fresh]) = form ++ [fresh] := by
  cases form <;> rfl

theorem extensionEncodingCommutes (form : Form) (fresh : String) (ordinary : form ≠ emptyOne) :
    extendForm (encodeEmpty form) fresh = encodeEmpty (form ++ [fresh]) := by
  cases form with
  | nil => rfl
  | cons x xs =>
    change (if x::xs = emptyOne then [fresh] else (x::xs) ++ [fresh]) = (x::xs) ++ [fresh]
    rw [ite_eq_right ordinary]

theorem extensionEncodingIff (form : Form) (fresh : String) :
    extendForm (encodeEmpty form) fresh = encodeEmpty (form ++ [fresh]) ↔ form ≠ emptyOne := by
  constructor
  · intro equal same
    cases same
    have lengths := congrArg List.length equal
    change 1 = 2 at lengths
    exact Nat.noConfusion (Nat.succ.inj lengths)
  · exact extensionEncodingCommutes form fresh

theorem encodingInjectiveAwayMarker (left right : Form)
    (hl : left ≠ emptyOne) (hr : right ≠ emptyOne)
    (eq : encodeEmpty left = encodeEmpty right) : left = right := by
  cases left with
  | nil =>
    cases right with
    | nil => rfl
    | cons x xs => exact False.elim (hr eq.symm)
  | cons x xs =>
    cases right with
    | nil => exact False.elim (hl eq)
    | cons y ys => exact eq

theorem rawFormAvoidsMarker (items : List String) (form : Form)
    (absent : ¬ "empty-One" ∈ items) (member : form ∈ rawSelections items) : form ≠ emptyOne := by
  intro eq
  have witness : "empty-One" ∈ form := eq ▸ List.Mem.head []
  exact absent (rawSelectionContained items form member "empty-One" witness)

theorem mapDistinctWithin {α β : Type} [DecidableEq α] [DecidableEq β]
    (f : α → β) (xs : List α) (unique : distinct xs = true)
    (injective : ∀ a, a ∈ xs → ∀ b, b ∈ xs → f a = f b → a = b) :
    distinct (xs.map f) = true := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    have parts := (distinctCons x xs).mp unique
    apply (distinctCons (f x) (xs.map f)).mpr
    constructor
    · apply (absentIff _ _).mpr
      intro member
      obtain ⟨a,ha,eq⟩ := memMapPreimage f (f x) xs member
      have same := injective a (List.Mem.tail _ ha) x (List.Mem.head _) eq
      cases same
      exact (absentIff xs x).mp parts.1 ha
    · exact ih parts.2 (fun a ha b hb => injective a (List.Mem.tail _ ha) b (List.Mem.tail _ hb))

theorem encodedSelectionsDistinct (items : List String) (unique : distinct items = true)
    (absent : ¬ "empty-One" ∈ items) : distinct ((rawSelections items).map encodeEmpty) = true := by
  apply mapDistinctWithin encodeEmpty (rawSelections items) (rawSelectionsDistinct items unique)
  intro a ha b hb eq
  exact encodingInjectiveAwayMarker a b (rawFormAvoidsMarker items a absent ha)
    (rawFormAvoidsMarker items b absent hb) eq

theorem encodedExtensionMap (previous : List Form) (fresh : String)
    (ordinary : ∀ form, form ∈ previous → form ≠ emptyOne) :
    (previous.map (fun form => form ++ [fresh])).map encodeEmpty =
      (previous.map encodeEmpty).map (fun form => extendForm form fresh) := by
  induction previous with
  | nil => rfl
  | cons form rest ih =>
    change encodeEmpty (form ++ [fresh]) :: (rest.map (fun f => f ++ [fresh])).map encodeEmpty =
      extendForm (encodeEmpty form) fresh :: (rest.map encodeEmpty).map (fun f => extendForm f fresh)
    rw [extensionEncodingCommutes form fresh (ordinary form (List.Mem.head _))]
    exact congrArg (List.cons (encodeEmpty (form ++ [fresh])))
      (ih (fun f hf => ordinary f (List.Mem.tail _ hf)))

theorem encodedRawSuccessor (items : List String) (fresh : String)
    (absent : ¬ "empty-One" ∈ items) :
    (rawSelections (items ++ [fresh])).map encodeEmpty =
      (rawSelections items).map encodeEmpty ++
        ((rawSelections items).map encodeEmpty).map (fun form => extendForm form fresh) := by
  rw [rawSuccessor]
  change (rawSelections items ++ (rawSelections items).map (fun form => form ++ [fresh])).map encodeEmpty = _
  rw [ExactTraceArithmetic.mapAppend,encodedExtensionMap _ fresh
    (fun form member => rawFormAvoidsMarker items form absent member)]

theorem encodedFreshAbsent (items : List String) (fresh : String)
    (newLabel : ¬ fresh ∈ items) (notMarker : fresh ≠ "empty-One") :
    ((rawSelections items).map encodeEmpty).any (fun form => has form fresh) = false := by
  apply anyFalseOfMembers
  intro form member
  obtain ⟨raw,generated,eq⟩ := memMapPreimage encodeEmpty form (rawSelections items) member
  rw [← eq]
  apply (absentIff _ _).mpr
  intro hf
  cases raw with
  | nil =>
    cases hf with
    | head => exact notMarker rfl
    | tail _ impossible => cases impossible
  | cons x xs => exact newLabel (rawSelectionContained items (x::xs) generated fresh hf)

theorem encodedFreshRecurrence (items : List String) (fresh : String)
    (absent : ¬ "empty-One" ∈ items) (newLabel : ¬ fresh ∈ items)
    (notMarker : fresh ≠ "empty-One") :
    recurrenceExtend ((rawSelections items).map encodeEmpty) fresh =
      .ok ((rawSelections (items ++ [fresh])).map encodeEmpty) := by
  rw [recurrenceFresh _ fresh (encodedFreshAbsent items fresh newLabel notMarker),
    encodedRawSuccessor items fresh absent]

theorem acceptedSelectionsOutput (items : List String) (nonempty : items ≠ [])
    (unique : distinct items = true) : selections items = .ok ((rawSelections items).map encodeEmpty) := by
  cases items with
  | nil => exact False.elim (nonempty rfl)
  | cons x xs => unfold selections; rw [unique]; rfl

theorem selectionRecurrenceExact (items : List String) (fresh : String)
    (nonempty : items ≠ []) (unique : distinct items = true)
    (absent : ¬ "empty-One" ∈ items) (newLabel : ¬ fresh ∈ items)
    (notMarker : fresh ≠ "empty-One") :
    (selections items).bind (fun previous => recurrenceExtend previous fresh) = selections (items ++ [fresh]) := by
  have extendedUnique := freshAppendDistinct items fresh unique ((absentIff items fresh).mpr newLabel)
  have extendedNonempty : items ++ [fresh] ≠ [] := by
    intro eq
    have member : fresh ∈ items ++ [fresh] := memAppendRight _ _ _ (List.Mem.head _)
    rw [eq] at member
    cases member
  rw [acceptedSelectionsOutput items nonempty unique,
    acceptedSelectionsOutput (items ++ [fresh]) extendedNonempty extendedUnique]
  exact encodedFreshRecurrence items fresh absent newLabel notMarker

theorem encodedLiteralBehavior : selections ["empty-One"] = .ok [emptyOne,emptyOne] := rfl

end SFT.Mathematics.CombinatorialSelections
