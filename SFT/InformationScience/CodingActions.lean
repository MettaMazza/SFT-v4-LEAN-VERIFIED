import SFT.InformationScience.CodingDecoding
namespace SFT.InformationScience.CodingActions
open NoiseRelation CodingImages CodingDecoding NoiseCorrection
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
abbrev Images := Word → List Word

def overlap (family : Images) (left right : Word) : Bool :=
  (family left).any (has (family right))
def detection (codes : List Word) (family : Images) : Bool :=
  codes.all (fun source => (family source).all (fun image => decide (image = source) || !has codes image))
def correction (codes : List Word) (family : Images) : Bool :=
  (codePairs codes).all (fun pair => !overlap family pair.1 pair.2)
def sourceClass (codes : List Word) (family : Images) (received : Word) : List Word :=
  codes.filter (fun source => has (family source) received)
def decode (codes : List Word) (family : Images) (received : Word) : CorrectionRecord :=
  record (sourceClass codes family received)
def extend (family added : Images) (source : Word) : List Word := family source ++ added source

def registeredImages (cells : List Cell) (source : Word) : List Word :=
  (cells.filter (fun row => decide (row.1 = source))).map (fun row => row.2.1)

theorem overlapMeaning (family : Images) (left right : Word) : overlap family left right = true ↔
    ∃ received, received ∈ family left ∧ received ∈ family right := by
  constructor
  · intro h
    obtain ⟨received,hl,hr⟩ := (anyTrueIff _ _).mp h
    exact ⟨received,hl,(hasIff _ _).mp hr⟩
  · intro ⟨received,hl,hr⟩
    exact (anyTrueIff _ _).mpr ⟨received,hl,(hasIff _ _).mpr hr⟩

theorem detectionMeaning (codes : List Word) (family : Images) : detection codes family = true ↔
    ∀ source, source ∈ codes → ∀ image, image ∈ family source → image = source ∨ ¬ image ∈ codes := by
  constructor
  · intro h source hs image hi
    have yes := allTrueAtMember _ _ (allTrueAtMember _ _ h source hs) image hi
    cases (orTrue _ _).mp yes with
    | inl eq => exact Or.inl (of_decide_eq_true eq)
    | inr outside =>
      apply Or.inr
      intro hm
      have found := (hasIff _ _).mpr hm
      have no := (notTrue _).mp outside
      rw [found] at no; cases no
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro source hs
    apply (allTrueIffMembers _ _).mpr
    intro image hi
    apply (orTrue _ _).mpr
    cases h source hs image hi with
    | inl eq => exact Or.inl (decide_eq_true eq)
    | inr outside =>
      apply Or.inr
      apply (notTrue _).mpr
      cases found : has codes image with
      | false => rfl
      | true => exact False.elim (outside ((hasIff _ _).mp found))

theorem correctionMeaning (codes : List Word) (family : Images) : correction codes family = true ↔
    ∀ pair, pair ∈ codePairs codes → ¬ ∃ received,
      received ∈ family pair.1 ∧ received ∈ family pair.2 := by
  constructor
  · intro h pair hp shared
    have no := (notTrue _).mp (allTrueAtMember _ _ h pair hp)
    have yes := (overlapMeaning _ _ _).mpr shared
    rw [no] at yes; cases yes
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro pair hp
    apply (notTrue _).mpr
    cases yes : overlap family pair.1 pair.2 with
    | false => rfl
    | true => exact False.elim (h pair hp ((overlapMeaning _ _ _).mp yes))

theorem classMembership (codes : List Word) (family : Images) (received source : Word) :
    source ∈ sourceClass codes family received ↔ source ∈ codes ∧ received ∈ family source := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    exact ⟨p.1,(hasIff _ _).mp p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(hasIff _ _).mpr h.2⟩

theorem decodeUniqueMeaning (codes : List Word) (family : Images) (received source : Word) :
    decode codes family received = .uniqueSource source ↔ sourceClass codes family received = [source] :=
  recordUnique _ _

theorem decodeClosed (codes : List Word) (family : Images) (received : Word)
    (notOne : (sourceClass codes family received).length ≠ 1) :
    decode codes family received = .closedSourceClass (sourceClass codes family received) := recordClosed _ notOne

theorem filterEmpty (p : Word → Bool) (codes : List Word)
    (absent : ∀ source, source ∈ codes → p source = false) : codes.filter p = [] := by
  induction codes with
  | nil => rfl
  | cons first rest ih =>
    rw [List.filter_cons_of_neg (p := p) (a := first) (by rw [absent first (List.Mem.head _)]; intro h; cases h)]
    exact ih (fun source hm => absent source (List.Mem.tail first hm))

theorem correctableClass (codes : List Word) (family : Images) (received : Word)
    (valid : correction codes family = true) :
    sourceClass codes family received = [] ∨ ∃ source, sourceClass codes family received = [source] := by
  induction codes with
  | nil => exact Or.inl rfl
  | cons first rest ih =>
    have separate := (correctionMeaning _ _).mp valid
    have restValid : correction rest family = true := by
      apply (correctionMeaning _ _).mpr
      intro pair hm
      exact separate pair (memAppendRight _ _ _ hm)
    cases belongs : has (family first) received with
    | false =>
      unfold sourceClass
      rw [List.filter_cons_of_neg (p := fun source => has (family source) received)
        (a := first) (by rw [belongs]; intro h; cases h)]
      exact ih restValid
    | true =>
      have others : sourceClass rest family received = [] := by
        apply filterEmpty
        intro source hs
        have hp : (first,source) ∈ codePairs (first::rest) :=
          memAppendLeft _ _ _ (memMap (fun next => (first,next)) source rest hs)
        cases other : has (family source) received with
        | false => rfl
        | true => exact False.elim (separate (first,source) hp
            ⟨received,(hasIff _ _).mp belongs,(hasIff _ _).mp other⟩)
      apply Or.inr
      refine ⟨first,?_⟩
      unfold sourceClass
      rw [List.filter_cons_of_pos (p := fun source => has (family source) received) (a := first) belongs]
      exact congrArg (List.cons first) others

theorem correctableDecode (codes : List Word) (family : Images) (source received : Word)
    (valid : correction codes family = true) (registered : source ∈ codes)
    (image : received ∈ family source) : decode codes family received = .uniqueSource source := by
  have hm := (classMembership _ _ _ _).mpr ⟨registered,image⟩
  cases correctableClass codes family received valid with
  | inl empty => rw [empty] at hm; cases hm
  | inr singleton =>
    obtain ⟨held,eq⟩ := singleton
    rw [eq] at hm
    cases hm with
    | head => exact (decodeUniqueMeaning _ _ _ _).mpr eq
    | tail _ h => cases h

theorem decodeRegistered (codes : List Word) (family : Images) (received source : Word)
    (h : decode codes family received = .uniqueSource source) :
    source ∈ codes ∧ received ∈ family source := by
  apply (classMembership _ _ _ _).mp
  rw [(decodeUniqueMeaning _ _ _ _).mp h]
  exact List.Mem.head []

theorem singleLabelDetection (codes : List Word) (labels : List String) :
    detection codes (fun source => singleLabelImages source labels) = detectableCode codes labels := rfl

theorem singleLabelCorrection (codes : List Word) (labels : List String) :
    correction codes (fun source => singleLabelImages source labels) = correctableCode codes labels := rfl

theorem singleLabelDecode (codes : List Word) (labels : List String) (received : Word) :
    decode codes (fun source => singleLabelImages source labels) received = decodeReceived codes labels received := rfl

theorem registeredMembership (cells : List Cell) (source image : Word) :
    image ∈ registeredImages cells source ↔ ∃ action, (source,image,action) ∈ cells := by
  constructor
  · intro h
    obtain ⟨row,hr,eq⟩ := memMapPreimage (fun row : Cell => row.2.1) image _ h
    have p := (filterMemberIff _ _ _).mp hr
    have same := of_decide_eq_true p.2
    cases row with
    | mk held pair => cases pair with
      | mk value action => cases same; cases eq; exact ⟨action,p.1⟩
  · intro ⟨action,h⟩
    apply memMap (fun row : Cell => row.2.1) (source,image,action) _
    exact (filterMemberIff _ _ _).mpr ⟨h,decide_eq_true rfl⟩

theorem extensionMembership (family added : Images) (source image : Word) :
    image ∈ extend family added source ↔ image ∈ family source ∨ image ∈ added source :=
  ⟨fun h => memAppendCases _ _ _ h,fun h => by
    cases h with
    | inl old => exact memAppendLeft _ _ _ old
    | inr new => exact memAppendRight _ _ _ new⟩

theorem detectionSuccessor (codes : List Word) (family added : Images) :
    detection codes (extend family added) = true ↔ detection codes family = true ∧ detection codes added = true := by
  constructor
  · intro h
    have p := (detectionMeaning _ _).mp h
    constructor
    · apply (detectionMeaning _ _).mpr
      intro source hs image hi
      exact p source hs image ((extensionMembership _ _ _ _).mpr (Or.inl hi))
    · apply (detectionMeaning _ _).mpr
      intro source hs image hi
      exact p source hs image ((extensionMembership _ _ _ _).mpr (Or.inr hi))
  · intro h
    have old := (detectionMeaning _ _).mp h.1
    have new := (detectionMeaning _ _).mp h.2
    apply (detectionMeaning _ _).mpr
    intro source hs image hi
    cases (extensionMembership _ _ _ _).mp hi with
    | inl prior => exact old source hs image prior
    | inr fresh => exact new source hs image fresh

def CrossDisjoint (codes : List Word) (left right : Images) : Prop :=
  ∀ pair, pair ∈ codePairs codes → ¬ ∃ image, image ∈ left pair.1 ∧ image ∈ right pair.2

theorem correctionSuccessor (codes : List Word) (family added : Images) :
    correction codes (extend family added) = true ↔ correction codes family = true ∧
      CrossDisjoint codes family added ∧ CrossDisjoint codes added family ∧ correction codes added = true := by
  constructor
  · intro h
    have no := (correctionMeaning _ _).mp h
    refine ⟨(correctionMeaning _ _).mpr ?_,?_,?_,(correctionMeaning _ _).mpr ?_⟩
    · intro pair hp ⟨image,hl,hr⟩
      exact no pair hp ⟨image,memAppendLeft _ _ _ hl,memAppendLeft _ _ _ hr⟩
    · intro pair hp ⟨image,hl,hr⟩
      exact no pair hp ⟨image,memAppendLeft _ _ _ hl,memAppendRight _ _ _ hr⟩
    · intro pair hp ⟨image,hl,hr⟩
      exact no pair hp ⟨image,memAppendRight _ _ _ hl,memAppendLeft _ _ _ hr⟩
    · intro pair hp ⟨image,hl,hr⟩
      exact no pair hp ⟨image,memAppendRight _ _ _ hl,memAppendRight _ _ _ hr⟩
  · intro h
    have old := (correctionMeaning _ _).mp h.1
    have new := (correctionMeaning _ _).mp h.2.2.2
    apply (correctionMeaning _ _).mpr
    intro pair hp ⟨image,hl,hr⟩
    cases (extensionMembership _ _ _ _).mp hl with
    | inl l => cases (extensionMembership _ _ _ _).mp hr with
      | inl r => exact old pair hp ⟨image,l,r⟩
      | inr r => exact h.2.1 pair hp ⟨image,l,r⟩
    | inr l => cases (extensionMembership _ _ _ _).mp hr with
      | inl r => exact h.2.2.1 pair hp ⟨image,l,r⟩
      | inr r => exact new pair hp ⟨image,l,r⟩

theorem classSuccessor (codes : List Word) (family added : Images) (source received : Word) :
    source ∈ sourceClass codes (extend family added) received ↔
      source ∈ codes ∧ (received ∈ family source ∨ received ∈ added source) := by
  constructor
  · intro h
    have p := (classMembership _ _ _ _).mp h
    exact ⟨p.1,(extensionMembership _ _ _ _).mp p.2⟩
  · intro h
    exact (classMembership _ _ _ _).mpr ⟨h.1,(extensionMembership _ _ _ _).mpr h.2⟩

def singletonAction (action : Word → Word) (source : Word) : List Word := [action source]

theorem singletonMember (a b : Word) (h : a ∈ [b]) : a = b := by
  cases h with
  | head => rfl
  | tail _ no => cases no

theorem singletonOverlap (action : Word → Word) (left right : Word) :
    overlap (singletonAction action) left right = true ↔ action left = action right := by
  constructor
  · intro h
    obtain ⟨image,hl,hr⟩ := (overlapMeaning _ _ _).mp h
    exact (singletonMember image (action left) hl).symm.trans (singletonMember image (action right) hr)
  · intro eq
    apply (overlapMeaning _ _ _).mpr
    refine ⟨action left,List.Mem.head [],?_⟩
    rw [eq]; exact List.Mem.head []

theorem singletonCorrection (codes : List Word) (action : Word → Word) :
    correction codes (singletonAction action) = true ↔
      ∀ pair, pair ∈ codePairs codes → action pair.1 ≠ action pair.2 := by
  constructor
  · intro h pair hp eq
    have no := (correctionMeaning _ _).mp h pair hp
    exact no ((overlapMeaning _ _ _).mp ((singletonOverlap _ _ _).mpr eq))
  · intro h
    apply (correctionMeaning _ _).mpr
    intro pair hp shared
    exact h pair hp ((singletonOverlap _ _ _).mp ((overlapMeaning _ _ _).mpr shared))

end SFT.InformationScience.CodingActions
