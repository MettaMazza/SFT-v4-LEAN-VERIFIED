import SFT.InformationScience.CompressionSupport
import SFT.InformationScience.NoiseTrace
namespace SFT.InformationScience.CodingSupport
open NoiseRelation QuantitySupport
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

def supportValid (labels positions : List String) : Bool :=
  !(decide (labels.length < 2)) && distinct labels && !positions.isEmpty

def completeSupport (labels positions : List String) : Except String (List NoiseRelation.Word) :=
  if supportValid labels positions then .ok (words labels positions.length)
  else .error "ValueError: code support requires distinct labels and nonempty positions"

def selectionValid (support held : List NoiseRelation.Word) : Bool :=
  !held.isEmpty && distinct held && held.all (has support)

def codebook (support held : List NoiseRelation.Word) : Except String (List NoiseRelation.Word) :=
  if selectionValid support held then .ok held
  else .error "ValueError: a codebook is a nonempty duplicate-free held support selection"

def differenceTrace (left right : NoiseRelation.Word) : Except String NoiseTrace.ErrorTrace :=
  if left.length = right.length then .ok (NoiseTrace.present (NoiseTrace.changedPositions 0 left right))
  else .error "ValueError: codewords require one common position carrier"

def repeated (label : String) (positions : List String) : NoiseRelation.Word := positions.map (fun _ => label)

def repetitionCode (labels positions : List String) : Except String (List NoiseRelation.Word) :=
  if labels.length < 2 || positions.isEmpty then
    .error "ValueError: repetition code requires a distinction and nonempty positions"
  else .ok (labels.map (fun label => repeated label positions))

theorem supportGuard (labels positions : List String) : supportValid labels positions = true ↔
    ¬ labels.length < 2 ∧ distinct labels = true ∧ positions.isEmpty = false := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have q := (andTrue _ _).mp p.1
    exact ⟨of_decide_eq_false ((notTrue _).mp q.1),q.2,(notTrue _).mp p.2⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(notTrue _).mpr (decide_eq_false h.1),h.2.1⟩,(notTrue _).mpr h.2.2⟩

theorem supportAdmission (labels positions : List String) (result : List NoiseRelation.Word) :
    completeSupport labels positions = .ok result ↔
      supportValid labels positions = true ∧ result = words labels positions.length := by
  unfold completeSupport
  cases h : supportValid labels positions with
  | false => constructor
             · intro h; cases h
             · intro h; cases h.1
  | true => constructor
            · intro h; exact ⟨rfl,(Except.ok.inj h).symm⟩
            · intro h; rw [h.2]; rfl

theorem completeMembership (labels positions : List String) (result : List NoiseRelation.Word)
    (h : completeSupport labels positions = .ok result) (word : NoiseRelation.Word) :
    word ∈ result ↔ word.length = positions.length ∧ ∀ label, label ∈ word → label ∈ labels := by
  rw [((supportAdmission _ _ _).mp h).2]
  exact wordCharacterization _ _ _

theorem completeDistinct (labels positions : List String) (result : List NoiseRelation.Word)
    (h : completeSupport labels positions = .ok result) : distinct result = true := by
  have p := (supportAdmission _ _ _).mp h
  rw [p.2]
  exact wordsDistinct labels ((supportGuard _ _).mp p.1).2.1 positions.length

theorem completeCount (labels positions : List String) (result : List NoiseRelation.Word)
    (h : completeSupport labels positions = .ok result) : result.length = labels.length ^ positions.length := by
  rw [((supportAdmission _ _ _).mp h).2]
  exact CompressionSupport.wordsCount _ _

theorem selectionGuard (support held : List NoiseRelation.Word) : selectionValid support held = true ↔
    held.isEmpty = false ∧ distinct held = true ∧ ∀ word, word ∈ held → word ∈ support := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have q := (andTrue _ _).mp p.1
    exact ⟨(notTrue _).mp q.1,q.2,fun word hm => (hasIff _ _).mp (allTrueAtMember _ _ p.2 word hm)⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(notTrue _).mpr h.1,h.2.1⟩,
      (allTrueIffMembers _ _).mpr (fun word hm => (hasIff _ _).mpr (h.2.2 word hm))⟩

theorem codebookAdmission (support held result : List NoiseRelation.Word) : codebook support held = .ok result ↔
    selectionValid support held = true ∧ result = held := by
  unfold codebook
  cases h : selectionValid support held with
  | false => constructor
             · intro h; cases h
             · intro h; cases h.1
  | true => constructor
            · intro h; exact ⟨rfl,(Except.ok.inj h).symm⟩
            · intro h; rw [h.2]; rfl

theorem admittedCodeword (labels positions : List String) (support held result : List NoiseRelation.Word)
    (hs : completeSupport labels positions = .ok support) (hc : codebook support held = .ok result)
    (word : NoiseRelation.Word) (hm : word ∈ result) :
    word.length = positions.length ∧ ∀ label, label ∈ word → label ∈ labels := by
  have p := (codebookAdmission _ _ _).mp hc
  rw [p.2] at hm
  exact (completeMembership _ _ _ hs word).mp (((selectionGuard _ _).mp p.1).2.2 word hm)

theorem commonPositionCarrier (labels positions : List String) (support held result : List NoiseRelation.Word)
    (hs : completeSupport labels positions = .ok support) (hc : codebook support held = .ok result)
    (left right : NoiseRelation.Word) (hl : left ∈ result) (hr : right ∈ result) : left.length = right.length :=
  ((admittedCodeword _ _ _ _ _ hs hc left hl).1).trans ((admittedCodeword _ _ _ _ _ hs hc right hr).1).symm

theorem differenceMatchesNoise (left right : NoiseRelation.Word) (same : left.length = right.length) :
    differenceTrace left right = NoiseTrace.errorTrace left right := by
  unfold differenceTrace NoiseTrace.errorTrace
  rw [if_pos same,if_pos same]

theorem differenceIdentity (word : NoiseRelation.Word) : differenceTrace word word = .ok .emptyOne := by
  rw [differenceMatchesNoise _ _ rfl]
  exact NoiseTrace.identityTrace word

theorem differenceEmptyMeaning (left right : NoiseRelation.Word) : differenceTrace left right = .ok .emptyOne ↔ left = right := by
  by_cases same : left.length = right.length
  · rw [differenceMatchesNoise _ _ same]; exact NoiseTrace.traceEmptyMeaning _ _
  · unfold differenceTrace; rw [if_neg same]
    constructor
    · intro h; cases h
    · intro h; cases h; exact False.elim (same rfl)

theorem differenceChangesMeaning (left right : NoiseRelation.Word) (rows : List NoiseTrace.PrintedCell) :
    differenceTrace left right = .ok (.changes rows) ↔
      left.length = right.length ∧ left ≠ right ∧ rows = (NoiseTrace.changedPositions 0 left right).map NoiseTrace.printCell := by
  by_cases same : left.length = right.length
  · rw [differenceMatchesNoise _ _ same]; exact NoiseTrace.traceChangesMeaning _ _ _
  · unfold differenceTrace; rw [if_neg same]
    constructor
    · intro h; cases h
    · intro h; exact False.elim (same h.1)

theorem repetitionAdmission (labels positions : List String) (result : List NoiseRelation.Word) :
    repetitionCode labels positions = .ok result ↔
      ¬ labels.length < 2 ∧ positions.isEmpty = false ∧ result = labels.map (fun label => repeated label positions) := by
  unfold repetitionCode
  cases a : decide (labels.length < 2) <;> cases b : positions.isEmpty
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { have no := of_decide_eq_true a; exact False.elim (h.1 no) }
  all_goals try { cases h.2.1 }
  · exact ⟨of_decide_eq_false a,rfl,(Except.ok.inj h).symm⟩
  · rw [h.2.2]; rfl

theorem repeatedLength (label : String) (positions : List String) : (repeated label positions).length = positions.length := by
  induction positions with
  | nil => rfl
  | cons p rest ih => exact congrArg Nat.succ ih

theorem repeatedLabels (label item : String) (positions : List String) (hm : item ∈ repeated label positions) : item = label := by
  obtain ⟨p,hp,eq⟩ := memMapPreimage (fun _ : String => label) item positions hm
  exact eq.symm

theorem repetitionInSupport (labels positions : List String) (support result : List NoiseRelation.Word)
    (hs : completeSupport labels positions = .ok support) (hr : repetitionCode labels positions = .ok result)
    (word : NoiseRelation.Word) (hm : word ∈ result) : word ∈ support := by
  have p := (repetitionAdmission _ _ _).mp hr
  rw [p.2.2] at hm
  obtain ⟨label,hl,eq⟩ := memMapPreimage (fun label => repeated label positions) word labels hm
  rw [← eq]
  apply (completeMembership _ _ _ hs _).mpr
  exact ⟨repeatedLength _ _,fun item hi => by rw [repeatedLabels _ _ _ hi]; exact hl⟩

theorem repeatedInjective (positions : List String) (nonempty : positions.isEmpty = false) (a b : String)
    (same : repeated a positions = repeated b positions) : a = b := by
  cases positions with
  | nil => cases nonempty
  | cons p rest => exact (List.cons.inj same).1

theorem repetitionDistinct (labels positions : List String) (unique : distinct labels = true)
    (nonempty : positions.isEmpty = false) : distinct (labels.map (fun label => repeated label positions)) = true :=
  SFT.Mathematics.DiscreteObjects.mapDistinct (fun label => repeated label positions)
    (fun a b eq => repeatedInjective positions nonempty a b eq) labels unique

end SFT.InformationScience.CodingSupport
