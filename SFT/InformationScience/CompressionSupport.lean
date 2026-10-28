import SFT.Mathematics.SelectionEncoding
import SFT.InformationScience.CompressionPrefix
namespace SFT.InformationScience.CompressionSupport
open CompressionDescription QuantitySupport SFT.Foundation.CommonRefinement
open SFT.Foundation.Count.TraceDerivation SFT.Mathematics.DiscreteObjects
open SFT.Mathematics.ExactTraceArithmetic SFT.Mathematics.GeometryTopology

def fixedSupport (labels positions : List String) : Except String (List CompressionDescription.Word) :=
  if labels.length < 2 || positions.isEmpty then .error "ValueError: support requires a distinction and nonempty positions"
  else .ok (words labels positions.length)

def shortThrough (labels : List String) : Nat → List CompressionDescription.Word
  | 0 => []
  | n+1 => shortThrough labels n ++ words labels (n+1)

def shorterNonemptySupport (labels positions : List String) : List CompressionDescription.Word :=
  shortThrough labels (positions.length-1)

def universalShorteningImpossible (labels positions : List String) : Except String Bool :=
  match fixedSupport labels positions with
  | .error e => .error e
  | .ok full => .ok (decide ((shorterNonemptySupport labels positions).length < full.length))

theorem fixedAdmission (labels positions : List String) (result : List CompressionDescription.Word) :
    fixedSupport labels positions = .ok result ↔
      ¬ labels.length < 2 ∧ positions.isEmpty = false ∧ result = words labels positions.length := by
  unfold fixedSupport
  cases a : decide (labels.length < 2) <;> cases b : positions.isEmpty
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { have no := of_decide_eq_true a; exact False.elim (h.1 no) }
  all_goals try { cases h.2.1 }
  · exact ⟨of_decide_eq_false a,rfl,(Except.ok.inj h).symm⟩
  · rw [h.2.2]; rfl

theorem wordCountProduct (labels : List String) (tail : List CompressionDescription.Word) :
    (labels.flatMap (fun label => tail.map (List.cons label))).length = labels.length * tail.length := by
  induction labels with
  | nil => exact (Nat.zero_mul _).symm
  | cons first rest ih =>
    change (tail.map (List.cons first) ++ rest.flatMap (fun label => tail.map (List.cons label))).length = (rest.length+1)*tail.length
    rw [appendLength,mapLength,ih,Nat.succ_mul,Nat.add_comm]

theorem wordsCount (labels : List String) (n : Nat) : (words labels n).length = labels.length ^ n := by
  induction n with
  | zero => rfl
  | succ n ih =>
    change (labels.flatMap (fun label => (words labels n).map (List.cons label))).length = _
    rw [wordCountProduct,ih,Nat.pow_succ,Nat.mul_comm]

theorem shortMembership (labels : List String) (n : Nat) (word : CompressionDescription.Word) :
    word ∈ shortThrough labels n ↔ ∃ width, 0 < width ∧ width ≤ n ∧ word ∈ words labels width := by
  induction n with
  | zero =>
    constructor
    · intro h; cases h
    · intro ⟨width,positive,bound,_⟩; exact False.elim (Nat.not_lt_of_ge bound positive)
  | succ n ih =>
    constructor
    · intro h
      cases memAppendCases _ _ _ h with
      | inl earlier => obtain ⟨width,hp,hb,hm⟩ := ih.mp earlier; exact ⟨width,hp,Nat.le_trans hb (Nat.le_succ n),hm⟩
      | inr last => exact ⟨n+1,Nat.zero_lt_succ _,Nat.le_refl _,last⟩
    · intro ⟨width,hp,hb,hm⟩
      cases Nat.eq_or_lt_of_le hb with
      | inl eq => cases eq; exact memAppendRight _ _ _ hm
      | inr lt => exact memAppendLeft _ _ _ (ih.mpr ⟨width,hp,Nat.le_of_lt_succ lt,hm⟩)

theorem shorterMeaning (labels positions : List String) (word : CompressionDescription.Word) :
    word ∈ shorterNonemptySupport labels positions ↔
      0 < word.length ∧ word.length < positions.length ∧ ∀ cell, cell ∈ word → cell ∈ labels := by
  constructor
  · intro h
    obtain ⟨width,hp,hb,hm⟩ := (shortMembership _ _ _).mp h
    have w := (wordCharacterization _ _ _).mp hm
    refine ⟨by rw [w.1]; exact hp,?_,w.2⟩
    rw [w.1]
    cases positions with
    | nil => exact False.elim (Nat.not_lt_of_ge hb hp)
    | cons _ rest => exact Nat.lt_succ_of_le hb
  · intro h
    apply (shortMembership _ _ _).mpr
    refine ⟨word.length,h.1,?_,(wordCharacterization _ _ _).mpr ⟨rfl,h.2.2⟩⟩
    cases positions with
    | nil => cases h.2.1
    | cons _ rest => exact Nat.le_of_lt_succ h.2.1

theorem shortCountBound (labels : List String) (atLeastTwo : 2 ≤ labels.length) (n : Nat) :
    (shortThrough labels n).length < (words labels (n+1)).length := by
  induction n with
  | zero =>
    change 0 < (words labels 1).length
    rw [wordsCount,Nat.pow_succ,Nat.pow_zero,Nat.one_mul]
    exact Nat.lt_of_lt_of_le (by decide : 0 < 2) atLeastTwo
  | succ n ih =>
    change (shortThrough labels n ++ words labels (n+1)).length < _
    rw [appendLength]
    have first := Nat.add_lt_add_right ih (words labels (n+1)).length
    have second : (words labels (n+1)).length + (words labels (n+1)).length ≤
        labels.length * (words labels (n+1)).length := by
      have h := Nat.mul_le_mul_right (words labels (n+1)).length atLeastTwo
      rw [Nat.two_mul] at h
      exact h
    have result := Nat.lt_of_lt_of_le first second
    change _ < (labels.flatMap (fun label => (words labels (n+1)).map (List.cons label))).length
    rw [wordCountProduct]
    exact result

theorem shorteningBoundary (labels positions : List String) (full : List CompressionDescription.Word)
    (h : fixedSupport labels positions = .ok full) :
    (shorterNonemptySupport labels positions).length < full.length := by
  have p := (fixedAdmission _ _ _).mp h
  rw [p.2.2]
  cases positions with
  | nil => cases p.2.1
  | cons first rest => exact shortCountBound labels (Nat.le_of_not_gt p.1) rest.length

theorem admittedShorteningResult (labels positions : List String) (full : List CompressionDescription.Word)
    (h : fixedSupport labels positions = .ok full) : universalShorteningImpossible labels positions = .ok true := by
  unfold universalShorteningImpossible
  rw [h]
  change Except.ok (decide ((shorterNonemptySupport labels positions).length < full.length)) = (Except.ok true : Except String Bool)
  rw [decide_eq_true (shorteningBoundary _ _ _ h)]

theorem wordFilterLength (p : CompressionDescription.Word → Bool) (input : List CompressionDescription.Word) :
    (input.filter p).length ≤ input.length := by
  induction input with
  | nil => exact Nat.le_refl _
  | cons pair rest ih =>
    change (match p pair with | true => pair :: rest.filter p | false => rest.filter p).length ≤ rest.length+1
    cases p pair with
    | false => exact Nat.le_trans ih (Nat.le_succ _)
    | true => exact Nat.succ_le_succ ih

theorem wordRemovalShorter (input : List CompressionDescription.Word) (held : CompressionDescription.Word)
    (hm : held ∈ input) : (input.filter (fun pair => decide (pair ≠ held))).length < input.length := by
  induction input with
  | nil => cases hm
  | cons first rest ih =>
    by_cases same : first = held
    · cases same
      have no : decide (held ≠ held) = false := decide_eq_false (fun h => h rfl)
      change (match decide (held ≠ held) with | true => held :: rest.filter (fun pair => decide (pair ≠ held)) | false => rest.filter (fun pair => decide (pair ≠ held))).length < rest.length+1
      rw [no]
      exact Nat.lt_succ_of_le (wordFilterLength _ _)
    · have ht : held ∈ rest := by
        cases hm with
        | head => exact False.elim (same rfl)
        | tail _ h => exact h
      change (match decide (first ≠ held) with | true => first :: rest.filter (fun pair => decide (pair ≠ held)) | false => rest.filter (fun pair => decide (pair ≠ held))).length < rest.length+1
      rw [decide_eq_true same]
      exact Nat.succ_lt_succ (ih ht)

theorem wordSubsetLength (held support : List CompressionDescription.Word) (unique : distinct held = true)
    (contained : ∀ pair, pair ∈ held → pair ∈ support) : held.length ≤ support.length := by
  induction held generalizing support with
  | nil => exact Nat.zero_le _
  | cons first rest ih =>
    have parts := (distinctCons _ _).mp unique
    have shorter := wordRemovalShorter support first (contained first (List.Mem.head _))
    have bound := ih (support.filter (fun pair => decide (pair ≠ first))) parts.2 (by
      intro pair hm
      apply (filterMemberIff _ _ _).mpr
      refine ⟨contained pair (List.Mem.tail first hm),decide_eq_true ?_⟩
      intro same; cases same
      exact (absentIff _ _).mp parts.1 hm)
    exact Nat.succ_le_of_lt (Nat.lt_of_le_of_lt bound shorter)


theorem noDistinctShortAssignment (labels positions : List String) (full : List CompressionDescription.Word)
    (h : fixedSupport labels positions = .ok full) (code : CompressionDescription.Word → CompressionDescription.Word)
    (uniqueCodes : distinct (full.map code) = true)
    (shortCodes : ∀ word, word ∈ full → code word ∈ shorterNonemptySupport labels positions) : False := by
  have upper := wordSubsetLength (full.map code) (shorterNonemptySupport labels positions) uniqueCodes (by
    intro word member
    obtain ⟨source,hs,eq⟩ := memMapPreimage code word full member
    rw [← eq]
    exact shortCodes source hs)
  rw [mapLength] at upper
  exact Nat.not_lt_of_ge upper (shorteningBoundary _ _ _ h)

theorem noInjectiveShortCode (labels positions : List String) (full : List CompressionDescription.Word)
    (h : fixedSupport labels positions = .ok full) (distinctLabels : distinct labels = true)
    (code : CompressionDescription.Word → CompressionDescription.Word)
    (injective : ∀ a, a ∈ full → ∀ b, b ∈ full → code a = code b → a = b)
    (shortCodes : ∀ word, word ∈ full → code word ∈ shorterNonemptySupport labels positions) : False := by
  have unique : distinct full = true := by
    rw [((fixedAdmission _ _ _).mp h).2.2]
    exact wordsDistinct _ distinctLabels _
  exact noDistinctShortAssignment _ _ _ h code
    (SFT.Mathematics.CombinatorialSelections.mapDistinctWithin code full unique injective) shortCodes

end SFT.InformationScience.CompressionSupport
