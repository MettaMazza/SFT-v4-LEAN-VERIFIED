import SFT.InformationScience.CodingImages
namespace SFT.InformationScience.CodingDecoding
open NoiseRelation CodingImages NoiseCorrection
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

def codePairs : List Word → List (Word × Word)
  | [] => []
  | first :: rest => rest.map (fun next => (first,next)) ++ codePairs rest

def overlap (labels : List String) (left right : Word) : Bool :=
  (singleLabelImages left labels).any (has (singleLabelImages right labels))

def detectableCode (codes : List Word) (labels : List String) : Bool :=
  codes.all (fun source => (singleLabelImages source labels).all (fun image => decide (image = source) || !has codes image))

def correctableCode (codes : List Word) (labels : List String) : Bool :=
  (codePairs codes).all (fun pair => !overlap labels pair.1 pair.2)

def sourceClass (codes : List Word) (labels : List String) (received : Word) : List Word :=
  codes.filter (fun source => has (singleLabelImages source labels) received)

def decodeReceived (codes : List Word) (labels : List String) (received : Word) : CorrectionRecord :=
  record (sourceClass codes labels received)

theorem overlapMeaning (labels : List String) (left right : Word) : overlap labels left right = true ↔
    ∃ received, received ∈ singleLabelImages left labels ∧ received ∈ singleLabelImages right labels := by
  constructor
  · intro h
    obtain ⟨received,hl,hr⟩ := (anyTrueIff _ _).mp h
    exact ⟨received,hl,(hasIff _ _).mp hr⟩
  · intro ⟨received,hl,hr⟩
    exact (anyTrueIff _ _).mpr ⟨received,hl,(hasIff _ _).mpr hr⟩

theorem orTrue (a b : Bool) : (a || b) = true ↔ a = true ∨ b = true := by
  cases a <;> cases b
  · constructor
    · intro h; cases h
    · intro h; cases h with | inl h => cases h | inr h => cases h
  · exact ⟨fun _ => Or.inr rfl,fun _ => rfl⟩
  · exact ⟨fun _ => Or.inl rfl,fun _ => rfl⟩
  · exact ⟨fun _ => Or.inl rfl,fun _ => rfl⟩

theorem detectionMeaning (codes : List Word) (labels : List String) : detectableCode codes labels = true ↔
    ∀ source, source ∈ codes → ∀ image, image ∈ singleLabelImages source labels → image = source ∨ ¬ image ∈ codes := by
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

theorem correctionMeaning (codes : List Word) (labels : List String) : correctableCode codes labels = true ↔
    ∀ pair, pair ∈ codePairs codes → ¬ ∃ received,
      received ∈ singleLabelImages pair.1 labels ∧ received ∈ singleLabelImages pair.2 labels := by
  constructor
  · intro h pair hp shared
    have no := (notTrue _).mp (allTrueAtMember _ _ h pair hp)
    have yes := (overlapMeaning _ _ _).mpr shared
    rw [no] at yes; cases yes
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro pair hp
    apply (notTrue _).mpr
    cases yes : overlap labels pair.1 pair.2 with
    | false => rfl
    | true => exact False.elim (h pair hp ((overlapMeaning _ _ _).mp yes))

theorem classMembership (codes : List Word) (labels : List String) (received source : Word) :
    source ∈ sourceClass codes labels received ↔ source ∈ codes ∧ received ∈ singleLabelImages source labels := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    exact ⟨p.1,(hasIff _ _).mp p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(hasIff _ _).mpr h.2⟩

theorem decodeUniqueMeaning (codes : List Word) (labels : List String) (received source : Word) :
    decodeReceived codes labels received = .uniqueSource source ↔ sourceClass codes labels received = [source] :=
  recordUnique _ _

theorem decodeClosed (codes : List Word) (labels : List String) (received : Word)
    (notOne : (sourceClass codes labels received).length ≠ 1) :
    decodeReceived codes labels received = .closedSourceClass (sourceClass codes labels received) := recordClosed _ notOne

theorem filterEmpty (p : Word → Bool) (codes : List Word)
    (absent : ∀ source, source ∈ codes → p source = false) : codes.filter p = [] := by
  induction codes with
  | nil => rfl
  | cons first rest ih =>
    rw [List.filter_cons_of_neg (p := p) (a := first) (by rw [absent first (List.Mem.head _)]; intro h; cases h)]
    exact ih (fun source hm => absent source (List.Mem.tail first hm))

theorem correctableClass (codes : List Word) (labels : List String) (received : Word)
    (valid : correctableCode codes labels = true) :
    sourceClass codes labels received = [] ∨ ∃ source, sourceClass codes labels received = [source] := by
  induction codes with
  | nil => exact Or.inl rfl
  | cons first rest ih =>
    have separate := (correctionMeaning _ _).mp valid
    have restValid : correctableCode rest labels = true := by
      apply (correctionMeaning _ _).mpr
      intro pair hm
      exact separate pair (memAppendRight _ _ _ hm)
    cases belongs : has (singleLabelImages first labels) received with
    | false =>
      unfold sourceClass
      rw [List.filter_cons_of_neg (p := fun source => has (singleLabelImages source labels) received)
        (a := first) (by rw [belongs]; intro h; cases h)]
      exact ih restValid
    | true =>
      have others : sourceClass rest labels received = [] := by
        apply filterEmpty
        intro source hs
        have hp : (first,source) ∈ codePairs (first::rest) :=
          memAppendLeft _ _ _ (memMap (fun next => (first,next)) source rest hs)
        cases other : has (singleLabelImages source labels) received with
        | false => rfl
        | true => exact False.elim (separate (first,source) hp
            ⟨received,(hasIff _ _).mp belongs,(hasIff _ _).mp other⟩)
      apply Or.inr
      refine ⟨first,?_⟩
      unfold sourceClass
      rw [List.filter_cons_of_pos (p := fun source => has (singleLabelImages source labels) received) (a := first) belongs]
      exact congrArg (List.cons first) others

theorem correctableDecode (codes : List Word) (labels : List String) (source received : Word)
    (valid : correctableCode codes labels = true) (registered : source ∈ codes)
    (image : received ∈ singleLabelImages source labels) : decodeReceived codes labels received = .uniqueSource source := by
  have hm := (classMembership _ _ _ _).mpr ⟨registered,image⟩
  cases correctableClass codes labels received valid with
  | inl empty => rw [empty] at hm; cases hm
  | inr singleton =>
    obtain ⟨held,eq⟩ := singleton
    rw [eq] at hm
    cases hm with
    | head => exact (decodeUniqueMeaning _ _ _ _).mpr eq
    | tail _ h => cases h

theorem decodeRegistered (codes : List Word) (labels : List String) (received source : Word)
    (h : decodeReceived codes labels received = .uniqueSource source) :
    source ∈ codes ∧ received ∈ singleLabelImages source labels := by
  apply (classMembership _ _ _ _).mp
  rw [(decodeUniqueMeaning _ _ _ _).mp h]
  exact List.Mem.head []

end SFT.InformationScience.CodingDecoding
