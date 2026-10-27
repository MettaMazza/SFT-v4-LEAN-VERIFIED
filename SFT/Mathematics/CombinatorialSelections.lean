import SFT.Mathematics.DiscreteInduction
import SFT.Mathematics.DiscreteComplement
import SFT.Foundation.FoldAssembly
import SFT.Foundation.CommonRefinement
namespace SFT.Mathematics.CombinatorialSelections
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

-- The source uses tuples of string labels, including the literal empty-One label.
def rawStep (previous : List Form) (item : String) : List Form :=
  previous ++ previous.map (fun selection => selection ++ [item])

def rawRun (previous : List Form) : List String → List Form
  | [] => previous
  | item::rest => rawRun (rawStep previous item) rest

def rawSelections (items : List String) : List Form := rawRun [[]] items

def encodeEmpty : Form → Form
  | [] => emptyOne
  | x::xs => x::xs

def selections (items : List String) : Except String (List Form) :=
  if items.isEmpty || !distinct items then
    .error "ValueError: selections require a nonempty unique generated carrier"
  else .ok ((rawSelections items).map encodeEmpty)

def extendForm (form : Form) (fresh : String) : Form :=
  if form = emptyOne then [fresh] else form ++ [fresh]

def recurrenceExtend (previous : List Form) (fresh : String) : Except String (List Form) :=
  if previous.any (fun form => has form fresh) then
    .error "ValueError: recurrence extension requires a fresh label"
  else .ok (previous ++ previous.map (fun form => extendForm form fresh))

inductive HeldChoice : List String → Form → Prop where
  | base : HeldChoice [] []
  | absent (items : List String) (form : Form) (fresh : String)
      (prior : HeldChoice items form) : HeldChoice (items ++ [fresh]) form
  | held (items : List String) (form : Form) (fresh : String)
      (prior : HeldChoice items form) : HeldChoice (items ++ [fresh]) (form ++ [fresh])

theorem rawRunAppend (items rest : List String) (previous : List Form) :
    rawRun previous (items ++ rest) = rawRun (rawRun previous items) rest := by
  induction items generalizing previous with
  | nil => rfl
  | cons item items ih => exact ih (rawStep previous item)

theorem rawSuccessor (items : List String) (fresh : String) :
    rawSelections (items ++ [fresh]) = rawStep (rawSelections items) fresh :=
  rawRunAppend items [fresh] [[]]

theorem absentRetained (previous : List Form) (fresh : String) (form : Form)
    (member : form ∈ previous) : form ∈ rawStep previous fresh :=
  memAppendLeft _ _ _ member

theorem heldRetained (previous : List Form) (fresh : String) (form : Form)
    (member : form ∈ previous) : form ++ [fresh] ∈ rawStep previous fresh :=
  memAppendRight _ _ _ (memMap _ _ _ member)

theorem rawStepMembership (previous : List Form) (fresh : String) (form : Form) :
    form ∈ rawStep previous fresh ↔
    form ∈ previous ∨ ∃ prior, prior ∈ previous ∧ prior ++ [fresh] = form := by
  constructor
  · intro h
    cases memAppendCases form previous _ h with
    | inl h => exact Or.inl h
    | inr h => exact Or.inr (memMapPreimage _ _ _ h)
  · intro h
    cases h with
    | inl h => exact absentRetained previous fresh form h
    | inr h =>
      obtain ⟨prior,member,eq⟩ := h
      rw [← eq]
      exact heldRetained previous fresh prior member

theorem everyHeldChoiceGenerated (items : List String) (form : Form)
    (choice : HeldChoice items form) : form ∈ rawSelections items := by
  induction choice with
  | base => exact List.Mem.head _
  | absent items form fresh _ ih =>
    rw [rawSuccessor]
    exact absentRetained _ _ _ ih
  | held items form fresh _ ih =>
    rw [rawSuccessor]
    exact heldRetained _ _ _ ih

theorem everyGeneratedFormHasChoice (items : List String) :
    ∀ form, form ∈ rawSelections items → HeldChoice items form := by
  apply snocInduction (fun items => ∀ form, form ∈ rawSelections items → HeldChoice items form)
  · intro form member
    cases member with
    | head => exact HeldChoice.base
    | tail _ impossible => cases impossible
  · intro prior fresh ih form member
    rw [rawSuccessor] at member
    cases (rawStepMembership _ _ _).mp member with
    | inl h => exact HeldChoice.absent prior form fresh (ih form h)
    | inr h =>
      obtain ⟨before,hm,eq⟩ := h
      rw [← eq]
      exact HeldChoice.held prior before fresh (ih before hm)

theorem generatedIffHeldChoice (items : List String) (form : Form) :
    form ∈ rawSelections items ↔ HeldChoice items form :=
  ⟨everyGeneratedFormHasChoice items form,everyHeldChoiceGenerated items form⟩

theorem heldChoiceContained (items : List String) (form : Form)
    (choice : HeldChoice items form) : ∀ label, label ∈ form → label ∈ items := by
  induction choice with
  | base => intro label h; cases h
  | absent items form fresh _ ih =>
    intro label h
    exact memAppendLeft _ _ _ (ih label h)
  | held items form fresh _ ih =>
    intro label h
    cases memAppendCases label form [fresh] h with
    | inl h => exact memAppendLeft _ _ _ (ih label h)
    | inr h => exact memAppendRight _ _ _ h

theorem rawSelectionContained (items : List String) (form : Form)
    (generated : form ∈ rawSelections items) : ∀ label, label ∈ form → label ∈ items :=
  heldChoiceContained items form (everyGeneratedFormHasChoice items form generated)

theorem freshPartitionsDisjoint (items : List String) (fresh : String)
    (freshness : ¬ fresh ∈ items) (old : Form) (generated : old ∈ rawSelections items)
    (before : Form) : old ≠ before ++ [fresh] := by
  intro eq
  have member : fresh ∈ old := eq ▸ memAppendRight fresh before [fresh] (List.Mem.head _)
  exact freshness (rawSelectionContained items old generated fresh member)

theorem successorTraceCount (previous : List Form) (fresh : String) :
    (rawStep previous fresh).length = previous.length + previous.length := by
  unfold rawStep
  rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.mapLength]

theorem rawSelectionCountSuccessor (items : List String) (fresh : String) :
    (rawSelections (items ++ [fresh])).length =
      (rawSelections items).length + (rawSelections items).length := by
  rw [rawSuccessor,successorTraceCount]

theorem rawSelectionsDistinct (items : List String) (unique : distinct items = true) :
    distinct (rawSelections items) = true := by
  have all : ∀ xs : List String, distinct xs = true → distinct (rawSelections xs) = true := by
    apply snocInduction (fun xs : List String => distinct xs = true → distinct (rawSelections xs) = true)
    · intro _; rfl
    · intro prior fresh ih hd
      have parts := distinctSnocParts prior fresh hd
      have old := ih parts.1
      rw [rawSuccessor]
      unfold rawStep
      apply appendDistinct
      · exact old
      · exact mapDistinct (fun f : Form => f ++ [fresh])
          (fun a b eq => (SFT.Foundation.FoldAssembly.appendInjective a b fresh fresh eq).1) _ old
      · intro form member other
        obtain ⟨before,_,eq⟩ := memMapPreimage _ _ _ other
        exact freshPartitionsDisjoint prior fresh ((absentIff prior fresh).mp parts.2)
          form member before eq.symm
  exact all items unique

theorem encodedCountPreserved (items : List String) :
    ((rawSelections items).map encodeEmpty).length = (rawSelections items).length :=
  SFT.Foundation.CommonRefinement.mapLength encodeEmpty (rawSelections items)

theorem emptyInputRejected : selections [] =
    .error "ValueError: selections require a nonempty unique generated carrier" := rfl

theorem singletonSelections (label : String) : selections [label] = .ok [emptyOne,[label]] := rfl

theorem exactThreeSelections : selections ["a","b","c"] = .ok
    [emptyOne,["a"],["b"],["a","b"],["c"],["a","c"],["b","c"],["a","b","c"]] := rfl

theorem emptyRecurrenceAccepted (fresh : String) : recurrenceExtend [] fresh = .ok [] := rfl

theorem recurrenceFresh (previous : List Form) (fresh : String)
    (h : previous.any (fun form => has form fresh) = false) :
    recurrenceExtend previous fresh = .ok (previous ++ previous.map (fun form => extendForm form fresh)) := by
  unfold recurrenceExtend
  rw [h]
  rfl

theorem recurrenceExistingRejected (previous : List Form) (fresh : String)
    (h : previous.any (fun form => has form fresh) = true) :
    recurrenceExtend previous fresh = .error "ValueError: recurrence extension requires a fresh label" := by
  unfold recurrenceExtend
  rw [h]
  rfl

theorem exactFreshExtension : recurrenceExtend [emptyOne,["a"],["b"],["a","b"]] "c" =
    selections ["a","b","c"] := rfl

end SFT.Mathematics.CombinatorialSelections
