import SFT.InformationScience.CodingSupport
namespace SFT.InformationScience.CodingImages
open NoiseRelation SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

def changedImages (labels : List String) : Word → List Word
  | [] => []
  | first :: rest =>
    ((labels.filter (fun label => decide (label ≠ first))).map (fun label => label :: rest)) ++
      ((changedImages labels rest).map (List.cons first))

def singleLabelImages (word : Word) (labels : List String) : List Word := word :: changedImages labels word

def errorImageFamily (codes : List Word) (labels : List String) : List (Word × List Word) :=
  codes.map (fun word => (word,singleLabelImages word labels))

theorem changedMembership (labels : List String) (word image : Word) : image ∈ changedImages labels word ↔
    ∃ before held after replacement, word = before ++ held :: after ∧
      replacement ∈ labels ∧ replacement ≠ held ∧ image = before ++ replacement :: after := by
  induction word generalizing image with
  | nil =>
    constructor
    · intro h; cases h
    · intro ⟨before,held,after,replacement,eq,_,_,_⟩
      cases before <;> cases eq
  | cons first rest ih =>
    constructor
    · intro h
      cases memAppendCases _ _ _ h with
      | inl head =>
        obtain ⟨replacement,hr,eq⟩ := memMapPreimage (fun label => label :: rest) image _ head
        have p := (filterMemberIff _ _ _).mp hr
        exact ⟨[],first,rest,replacement,rfl,p.1,of_decide_eq_true p.2,eq.symm⟩
      | inr tail =>
        obtain ⟨suffix,hs,eq⟩ := memMapPreimage (List.cons first) image _ tail
        obtain ⟨before,held,after,replacement,wordEq,member,diff,imageEq⟩ := (ih suffix).mp hs
        refine ⟨first::before,held,after,replacement,?_,member,diff,?_⟩
        · exact congrArg (List.cons first) wordEq
        · exact eq.symm.trans (congrArg (List.cons first) imageEq)
    · intro ⟨before,held,after,replacement,wordEq,member,diff,imageEq⟩
      cases before with
      | nil =>
        have p := List.cons.inj wordEq
        cases p.1; cases p.2; cases imageEq
        apply memAppendLeft
        apply memMap (fun label => label :: rest) replacement _
        exact (filterMemberIff _ _ _).mpr ⟨member,decide_eq_true diff⟩
      | cons pfx before =>
        have p := List.cons.inj wordEq
        cases p.1
        apply memAppendRight
        rw [imageEq]
        apply memMap (List.cons first) (before ++ replacement :: after) _
        exact (ih _).mpr ⟨before,held,after,replacement,p.2,member,diff,rfl⟩

theorem imagesMembership (labels : List String) (word image : Word) : image ∈ singleLabelImages word labels ↔
    image = word ∨ ∃ before held after replacement, word = before ++ held :: after ∧
      replacement ∈ labels ∧ replacement ≠ held ∧ image = before ++ replacement :: after := by
  constructor
  · intro h
    cases h with
    | head => exact Or.inl rfl
    | tail _ hm => exact Or.inr ((changedMembership _ _ _).mp hm)
  · intro h
    cases h with
    | inl eq => cases eq; exact List.Mem.head _
    | inr change => exact List.Mem.tail _ ((changedMembership _ _ _).mpr change)

theorem identityIncluded (word : Word) (labels : List String) : word ∈ singleLabelImages word labels := List.Mem.head _

theorem changedLength (labels : List String) (word image : Word) (h : image ∈ changedImages labels word) :
    image.length = word.length := by
  induction word generalizing image with
  | nil => cases h
  | cons first rest ih =>
    cases memAppendCases _ _ _ h with
    | inl head =>
      obtain ⟨label,_,eq⟩ := memMapPreimage (fun label => label :: rest) image _ head
      rw [← eq]; rfl
    | inr tail =>
      obtain ⟨suffix,hs,eq⟩ := memMapPreimage (List.cons first) image _ tail
      rw [← eq]
      exact congrArg Nat.succ (ih suffix hs)

theorem imageLength (word image : Word) (labels : List String) (h : image ∈ singleLabelImages word labels) :
    image.length = word.length := by
  cases h with
  | head => rfl
  | tail _ hm => exact changedLength _ _ _ hm

theorem changedDifferent (labels : List String) (word image : Word) (h : image ∈ changedImages labels word) : image ≠ word := by
  obtain ⟨before,held,after,replacement,wordEq,_,diff,imageEq⟩ := (changedMembership _ _ _).mp h
  intro eq
  rw [wordEq,imageEq] at eq
  have heads := List.cons.inj (QuantitySupport.cancelPrefix before _ _ eq)
  exact diff heads.1

theorem familyMembership (codes : List Word) (labels : List String) (source : Word) (images : List Word) :
    (source,images) ∈ errorImageFamily codes labels ↔ source ∈ codes ∧ images = singleLabelImages source labels := by
  constructor
  · intro h
    obtain ⟨word,hw,eq⟩ := memMapPreimage (fun word => (word,singleLabelImages word labels)) (source,images) codes h
    have same := congrArg Prod.fst eq
    cases same
    exact ⟨hw,(congrArg Prod.snd eq).symm⟩
  · intro h
    rw [h.2]
    exact memMap (fun word => (word,singleLabelImages word labels)) source codes h.1

theorem familyLength (codes : List Word) (labels : List String) : (errorImageFamily codes labels).length = codes.length := by
  induction codes with
  | nil => rfl
  | cons first rest ih => exact congrArg Nat.succ ih

theorem changedLabels (labels : List String) (word image : Word)
    (allowed : ∀ label, label ∈ word → label ∈ labels) (h : image ∈ changedImages labels word) :
    ∀ label, label ∈ image → label ∈ labels := by
  induction word generalizing image with
  | nil => cases h
  | cons first rest ih =>
    cases memAppendCases _ _ _ h with
    | inl head =>
      obtain ⟨replacement,hr,eq⟩ := memMapPreimage (fun label => label :: rest) image _ head
      have hm := ((filterMemberIff _ _ _).mp hr).1
      rw [← eq]
      intro label hl
      cases hl with
      | head => exact hm
      | tail _ ht => exact allowed label (List.Mem.tail first ht)
    | inr tail =>
      obtain ⟨suffix,hs,eq⟩ := memMapPreimage (List.cons first) image _ tail
      have suffixAllowed := ih suffix (fun label hm => allowed label (List.Mem.tail first hm)) hs
      rw [← eq]
      intro label hl
      cases hl with
      | head => exact allowed first (List.Mem.head rest)
      | tail _ ht => exact suffixAllowed label ht

theorem imageInCompleteSupport (labels positions : List String) (support : List Word)
    (valid : CodingSupport.completeSupport labels positions = .ok support) (word image : Word)
    (hw : word ∈ support) (hi : image ∈ singleLabelImages word labels) : image ∈ support := by
  have p := (CodingSupport.completeMembership _ _ _ valid word).mp hw
  apply (CodingSupport.completeMembership _ _ _ valid image).mpr
  refine ⟨(imageLength _ _ _ hi).trans p.1,?_⟩
  cases hi with
  | head => exact p.2
  | tail _ changed => exact changedLabels _ _ _ p.2 changed

end SFT.InformationScience.CodingImages
