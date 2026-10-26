import SFT.Foundation.FoldControls
import SFT.Foundation.CommonRefinement
/-! Exact fold_assembly.py finite word construction. Nat is the source host
nonnegative extension index; the empty list is the structural empty One word. -/
namespace SFT.Foundation.FoldAssembly
open Count.TraceDerivation CommonRefinement

@[reducible]
def Word :=  List String

def labels : List String := ["held-a","held-b"]

def appendLabel (word : Word) (label : String) : Word := word ++ [label]

def extend (words : List Word) : List Word :=
  words.flatMap fun word => labels.map (appendLabel word)

def supportAfterExtensions : Nat → List Word
  | 0 => [[]]
  | n+1 => extend (supportAfterExtensions n)

def checkedSupport (extensions : Int) : Option (List Word) :=
  match extensions with
  | .ofNat n => some (supportAfterExtensions n)
  | .negSucc _ => none

-- Return is defined at successor words; the empty source word has no predecessor.
def returnWord : Word → Option Word
  | [] => none
  | [_] => some []
  | x :: y :: xs => (returnWord (y :: xs)).map (List.cons x)

def lastLabel : Word → Option String
  | [] => none
  | [x] => some x
  | _ :: y :: xs => lastLabel (y :: xs)

theorem appendReturns (w : Word) (label : String) : returnWord (appendLabel w label) = some w := by
  induction w with
  | nil => rfl
  | cons x xs ih =>
    cases xs with
    | nil => rfl
    | cons y ys => exact congrArg (fun r => r.map (List.cons x)) ih

theorem appendedLabelRetained (w : Word) (label : String) : lastLabel (appendLabel w label) = some label := by
  induction w with
  | nil => rfl
  | cons x xs ih => cases xs with
    | nil => rfl
    | cons y ys => exact ih

theorem appendInjective (w v : Word) (a b : String) (h : appendLabel w a = appendLabel v b) :
    w = v ∧ a = b := by
  have hw := congrArg returnWord h
  rw [appendReturns,appendReturns] at hw
  have hl := congrArg lastLabel h
  rw [appendedLabelRetained,appendedLabelRetained] at hl
  exact ⟨Option.some.inj hw,Option.some.inj hl⟩

theorem heldLabelsDistinct : ("held-a" : String) ≠ "held-b" := by
  intro h
  have bad : true = false := congrArg (fun s => SFT.Host.Text.equal "held-a" s) h
  cases bad

theorem branchesDistinct (w : Word) : appendLabel w "held-a" ≠ appendLabel w "held-b" :=
  fun h => heldLabelsDistinct (appendInjective _ _ _ _ h).2

theorem bothBranchesReturn (w : Word) :
    returnWord (appendLabel w "held-a") = some w ∧
    returnWord (appendLabel w "held-b") = some w :=
  ⟨appendReturns _ _,appendReturns _ _⟩

theorem successorMembership (words : List Word) (w : Word) :
    w ∈ extend words ↔ ∃ p, p ∈ words ∧ ∃ label, label ∈ labels ∧ appendLabel p label = w := by
  constructor
  · intro h
    obtain ⟨p,hp,row⟩ := memFlatMapOrigin (fun p => labels.map (appendLabel p)) words w h
    obtain ⟨label,hl,eq⟩ := memMapPreimage (appendLabel p) w labels row
    exact ⟨p,hp,label,hl,eq⟩
  · intro ⟨p,hp,label,hl,eq⟩
    cases eq
    exact memFlatMap _ words p _ hp (memMap (appendLabel p) label labels hl)

theorem everySuccessorReturns (words : List Word) (w : Word) (h : w ∈ extend words) :
    ∃ p, p ∈ words ∧ returnWord w = some p := by
  obtain ⟨p,hp,label,_,eq⟩ := (successorMembership words w).mp h
  cases eq
  exact ⟨p,hp,appendReturns _ _⟩

theorem returnPredecessorUnique (w p q : Word)
    (hp : returnWord w = some p) (hq : returnWord w = some q) : p = q :=
  Option.some.inj (hp.symm.trans hq)

theorem bothBranchesGenerated (words : List Word) (w : Word) (h : w ∈ words) :
    appendLabel w "held-a" ∈ extend words ∧ appendLabel w "held-b" ∈ extend words :=
  ⟨(successorMembership _ _).mpr ⟨w,h,"held-a",List.Mem.head _,rfl⟩,
   (successorMembership _ _).mpr ⟨w,h,"held-b",List.Mem.tail _ (List.Mem.head _),rfl⟩⟩

theorem appendLabelLength (w : Word) (label : String) : (appendLabel w label).length = w.length + 1 :=
  appendLength w [label]

theorem successorLength (words : List Word) (n : Nat)
    (h : ∀ w, w ∈ words → w.length = n) (v : Word) (hv : v ∈ extend words) : v.length = n+1 := by
  obtain ⟨w,hw,label,_,eq⟩ := (successorMembership words v).mp hv
  cases eq
  exact (appendLabelLength w label).trans (congrArg (fun k => k+1) (h w hw))

theorem supportWordLength (n : Nat) (w : Word) (h : w ∈ supportAfterExtensions n) : w.length = n := by
  induction n generalizing w with
  | zero => cases h with
    | head => rfl
    | tail _ h => cases h
  | succ n ih => exact successorLength _ n ih w h

theorem allFiniteSuccessorsReturn (n : Nat) (w : Word) (h : w ∈ supportAfterExtensions (n+1)) :
    ∃ p, p ∈ supportAfterExtensions n ∧ returnWord w = some p :=
  everySuccessorReturns _ _ h

theorem negativeExtensionRejected (n : Nat) : checkedSupport (.negSucc n) = none := rfl

theorem nonnegativeExtensionPreserved (n : Nat) : checkedSupport (.ofNat n) = some (supportAfterExtensions n) := rfl

theorem disjointAppendNodup {α : Type} (xs ys : List α) (hx : xs.Nodup) (hy : ys.Nodup)
    (disjoint : ∀ x, x ∈ xs → x ∉ ys) : (xs ++ ys).Nodup := by
  induction xs with
  | nil => exact hy
  | cons x xs ih =>
    cases hx with
    | cons fresh tail =>
      constructor
      · intro y hy eq
        cases eq
        cases memAppendCases x xs ys hy with
        | inl old => exact fresh x old rfl
        | inr other => exact disjoint x (List.Mem.head _) other
      · exact ih tail (fun a h => disjoint a (List.Mem.tail _ h))

theorem branchRowNodup (w : Word) : (labels.map (appendLabel w)).Nodup := by
  constructor
  · intro y hy eq
    cases hy with
    | head => exact branchesDistinct w eq
    | tail _ h => cases h
  · constructor
    · intro y hy; cases hy
    · exact List.Pairwise.nil

theorem extendPreservesUniqueness (words : List Word) (h : words.Nodup) : (extend words).Nodup := by
  induction words with
  | nil => exact List.Pairwise.nil
  | cons w ws ih =>
    cases h with
    | cons fresh rest =>
      apply disjointAppendNodup (labels.map (appendLabel w)) (extend ws) (branchRowNodup w) (ih rest)
      intro child inRow inTail
      obtain ⟨label,_,rowEq⟩ := memMapPreimage (appendLabel w) child labels inRow
      obtain ⟨other,otherMem,otherLabel,_,tailEq⟩ := (successorMembership ws child).mp inTail
      have parentEq := (appendInjective w other label otherLabel (rowEq.trans tailEq.symm)).1
      cases parentEq
      exact fresh w otherMem rfl

theorem allFiniteSupportsUnique (n : Nat) : (supportAfterExtensions n).Nodup := by
  induction n with
  | zero =>
    constructor
    · intro y hy; cases hy
    · exact List.Pairwise.nil
  | succ n ih => exact extendPreservesUniqueness _ ih

inductive GeneratedWord : Nat → Word → Prop where
  | base : GeneratedWord 0 []
  | step {n : Nat} {w : Word} {label : String} :
      GeneratedWord n w → label ∈ labels → GeneratedWord (n+1) (appendLabel w label)

theorem generatedWordRetained {n : Nat} {w : Word} (h : GeneratedWord n w) :
    w ∈ supportAfterExtensions n := by
  induction h with
  | base => exact List.Mem.head _
  | @step n w label previous inLabels ih =>
    exact (successorMembership _ _).mpr ⟨w,ih,label,inLabels,rfl⟩

theorem retainedWordGenerated (n : Nat) (w : Word) (h : w ∈ supportAfterExtensions n) :
    GeneratedWord n w := by
  induction n generalizing w with
  | zero => cases h with
    | head => exact GeneratedWord.base
    | tail _ h => cases h
  | succ n ih =>
    obtain ⟨p,hp,label,hl,eq⟩ := (successorMembership _ _).mp h
    cases eq
    exact GeneratedWord.step (ih p hp) hl

theorem exactFiniteSupport (n : Nat) (w : Word) :
    w ∈ supportAfterExtensions n ↔ GeneratedWord n w :=
  ⟨retainedWordGenerated n w,generatedWordRetained⟩

theorem prependGenerated {n : Nat} {w : Word} (label : String) (hl : label ∈ labels)
    (h : GeneratedWord n w) : GeneratedWord (n+1) (label :: w) := by
  induction h with
  | base => exact GeneratedWord.step GeneratedWord.base hl
  | @step n w last previous inLabels ih => exact GeneratedWord.step ih inLabels

theorem allowedWordGenerated (w : Word) (h : ∀ label, label ∈ w → label ∈ labels) :
    GeneratedWord w.length w := by
  induction w with
  | nil => exact GeneratedWord.base
  | cons label ws ih =>
    exact prependGenerated label (h label (List.Mem.head _))
      (ih (fun other hm => h other (List.Mem.tail _ hm)))

theorem generatedWordOnlyHeldLabels {n : Nat} {w : Word} (h : GeneratedWord n w) :
    ∀ label, label ∈ w → label ∈ labels := by
  induction h with
  | base => intro label hm; cases hm
  | @step n w last previous inLabels ih =>
    intro label hm
    cases memAppendCases label w [last] hm with
    | inl before => exact ih label before
    | inr final => cases final with
      | head => exact inLabels
      | tail _ impossible => cases impossible

theorem supportIffLengthAndHeldLabels (n : Nat) (w : Word) :
    w ∈ supportAfterExtensions n ↔ w.length = n ∧ (∀ label, label ∈ w → label ∈ labels) := by
  constructor
  · intro h
    exact ⟨supportWordLength n w h,generatedWordOnlyHeldLabels (retainedWordGenerated n w h)⟩
  · intro ⟨len,allowed⟩
    have gen := allowedWordGenerated w allowed
    rw [len] at gen
    exact generatedWordRetained gen

theorem outsideLabelExcludesWord (n : Nat) (w : Word) (label : String)
    (outside : label ∉ labels) (present : label ∈ w) : w ∉ supportAfterExtensions n := by
  intro h
  exact outside (((supportIffLengthAndHeldLabels n w).mp h).2 label present)

theorem wrongLengthExcludesWord (n : Nat) (w : Word) (wrong : w.length ≠ n) :
    w ∉ supportAfterExtensions n := fun h => wrong (supportWordLength n w h)

theorem repeatingGeneratedWordBreaksUniqueness (n : Nat) (w : Word)
    (present : w ∈ supportAfterExtensions n) : ¬ (w :: supportAfterExtensions n).Nodup := by
  intro h
  cases h with
  | cons fresh _ => exact fresh w present rfl

theorem omittingGeneratedWordBreaksCompleteness (n : Nat) (w : Word) (proposed : List Word)
    (required : GeneratedWord n w) (absent : w ∉ proposed) :
    ¬ (∀ v, GeneratedWord n v → v ∈ proposed) :=
  fun complete => absent (complete w required)

end SFT.Foundation.FoldAssembly
