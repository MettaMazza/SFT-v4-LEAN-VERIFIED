import SFT.InformationScience.ConservationReverse
namespace SFT.InformationScience.ConservationCardinality
open SFT.Mathematics.ProbabilityIndependence SFT.Mathematics.ProbabilityObservations
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation

theorem retainBound (seen items : List String) : (retainFirst seen items).length ≤ items.length := by
  induction items generalizing seen with
  | nil => exact Nat.le_refl _
  | cons first rest ih =>
    unfold retainFirst
    cases h : has seen first with
    | true => exact Nat.le_trans (ih seen) (Nat.le_succ _)
    | false => exact Nat.succ_le_succ (ih (seen ++ [first]))

theorem retainEqualDistinct (seen items : List String)
    (equal : (retainFirst seen items).length = items.length) :
    distinct items = true ∧ ∀ item, item ∈ items → ¬ item ∈ seen := by
  induction items generalizing seen with
  | nil => exact ⟨rfl,fun _ h => by cases h⟩
  | cons first rest ih =>
    unfold retainFirst at equal
    cases h : has seen first with
    | true =>
      rw [h] at equal
      change (retainFirst seen rest).length = rest.length+1 at equal
      have bound := retainBound seen rest
      rw [equal] at bound
      exact False.elim (Nat.not_succ_le_self _ bound)
    | false =>
      rw [h] at equal
      have tail := ih (seen ++ [first]) (Nat.succ.inj equal)
      constructor
      · apply (distinctCons _ _).mpr
        exact ⟨(absentIff _ _).mpr (fun hm => tail.2 first hm (memAppendRight _ _ _ (List.Mem.head []))),tail.1⟩
      · intro item hm
        cases hm with
        | head => intro old; have yes := (hasIff _ _).mpr old; rw [h] at yes; cases yes
        | tail _ ht => exact fun old => tail.2 item ht (memAppendLeft _ _ _ old)

theorem retainUnchanged (seen items : List String) (unique : distinct items = true)
    (fresh : ∀ item, item ∈ items → ¬ item ∈ seen) : retainFirst seen items = items := by
  induction items generalizing seen with
  | nil => rfl
  | cons first rest ih =>
    have parts := (distinctCons _ _).mp unique
    have unknown : has seen first = false := by
      cases h : has seen first with
      | false => rfl
      | true => exact False.elim (fresh first (List.Mem.head _) ((hasIff _ _).mp h))
    unfold retainFirst
    rw [unknown]
    apply congrArg (List.cons first)
    apply ih (seen ++ [first]) parts.2
    intro item hm old
    cases memAppendCases _ _ _ old with
    | inl prior => exact fresh item (List.Mem.tail _ hm) prior
    | inr new =>
      cases new with
      | head => exact (absentIff _ _).mp parts.1 hm
      | tail _ h => cases h

theorem labelCountIffDistinct (items : List String) :
    (firstLabels items).length = items.length ↔ distinct items = true := by
  constructor
  · intro h; exact (retainEqualDistinct [] items h).1
  · intro h
    have same := retainUnchanged [] items h (fun _ hm old => by cases old)
    exact congrArg List.length same

theorem sameLabelCount (left right : List String)
    (same : ∀ label, label ∈ left ↔ label ∈ right) :
    (firstLabels left).length = (firstLabels right).length := by
  apply Nat.le_antisymm
  · exact SFT.Mathematics.ProbabilityEvents.distinctSubsetLength _ _ (firstLabelsDistinct _) (fun label hm =>
      (firstLabelsMembership _ _).mpr ((same label).mp ((firstLabelsMembership _ _).mp hm)))
  · exact SFT.Mathematics.ProbabilityEvents.distinctSubsetLength _ _ (firstLabelsDistinct _) (fun label hm =>
      (firstLabelsMembership _ _).mpr ((same label).mpr ((firstLabelsMembership _ _).mp hm)))

theorem mapDistinctOn (source : List String) (f : String → String) (unique : distinct source = true)
    (injective : ∀ a, a ∈ source → ∀ b, b ∈ source → f a = f b → a = b) :
    distinct (source.map f) = true := by
  induction source with
  | nil => rfl
  | cons head rest ih =>
    have parts := (distinctCons _ _).mp unique
    apply (distinctCons _ _).mpr
    constructor
    · apply (absentIff _ _).mpr
      intro hm
      obtain ⟨other,ho,eq⟩ := memMapPreimage f (f head) rest hm
      have same := injective other (List.Mem.tail _ ho) head (List.Mem.head _) eq
      cases same
      exact (absentIff _ _).mp parts.1 ho
    · exact ih parts.2 (fun a ha b hb eq => injective a (List.Mem.tail _ ha) b (List.Mem.tail _ hb) eq)

theorem mapDistinctInjective (source : List String) (f : String → String)
    (unique : distinct (source.map f) = true) :
    ∀ a, a ∈ source → ∀ b, b ∈ source → f a = f b → a = b := by
  induction source with
  | nil => intro a h; cases h
  | cons head rest ih =>
    have parts := (distinctCons _ _).mp unique
    intro a ha b hb eq
    cases ha with
    | head =>
      cases hb with
      | head => rfl
      | tail _ hm =>
        have mem := memMap f b rest hm
        rw [← eq] at mem
        exact False.elim ((absentIff _ _).mp parts.1 mem)
    | tail _ ha =>
      cases hb with
      | head =>
        have mem := memMap f a rest ha
        rw [eq] at mem
        exact False.elim ((absentIff _ _).mp parts.1 mem)
      | tail _ hb => exact ih parts.2 a ha b hb eq

theorem imageMember (mapping : Observation) (state label : String) (h : image mapping state = some label) :
    (state,label) ∈ mapping := by
  induction mapping with
  | nil => cases h
  | cons row rest ih =>
    cases row with
    | mk key value =>
      change (match image rest state with | some v => some v | none => if key = state then some value else none) = _ at h
      cases tail : image rest state with
      | some v => rw [tail] at h; cases h; exact List.Mem.tail _ (ih tail)
      | none =>
        rw [tail] at h
        by_cases eq : key = state
        · rw [ite_eq_left eq] at h; cases eq; cases h; exact List.Mem.head _
        · rw [ite_eq_right eq] at h; cases h

theorem memberImage (mapping : Observation) (state label : String)
    (unique : distinct (mapping.map Prod.fst) = true) (hm : (state,label) ∈ mapping) :
    image mapping state = some label := by
  induction mapping with
  | nil => cases hm
  | cons row rest ih =>
    have parts := (distinctCons _ _).mp unique
    cases row with
    | mk key value =>
      cases hm with
      | head =>
        have noImage : image rest state = none := by
          cases h : image rest state with
          | none => rfl
          | some v =>
            have member := memMap Prod.fst (state,v) rest (imageMember _ _ _ h)
            exact False.elim ((absentIff _ _).mp parts.1 member)
        change (match image rest state with | some v => some v | none => if state = state then some label else none) = _
        rw [noImage,ite_eq_left rfl]
      | tail _ ht =>
        change (match image rest state with | some v => some v | none => if key = state then some value else none) = _
        rw [ih parts.2 ht]

theorem valuesCorrespond (source : List String) (mapping : Observation)
    (valid : ConservationLedger.validateTransformation source mapping = .ok mapping) (label : String) :
    label ∈ mapping.map Prod.snd ↔ label ∈ source.map (ConservationComposition.value mapping) := by
  have p := (ConservationLedger.validationMeaning _ _ _).mp valid
  have guards := (MutualObservation.mapMeaning _ _).mp p.2.1
  constructor
  · intro hm
    obtain ⟨row,hr,eq⟩ := memMapPreimage Prod.snd label mapping hm
    have state := ((keysMatchMeaning _ _).mp guards.2).1 row.1 (memMap Prod.fst row mapping hr)
    have hi := memberImage mapping row.1 row.2 guards.1 hr
    have result := memMap (ConservationComposition.value mapping) row.1 source state
    rw [ConservationComposition.valueExact _ _ _ hi,eq] at result
    exact result
  · intro hm
    obtain ⟨state,hs,eq⟩ := memMapPreimage (ConservationComposition.value mapping) label source hm
    have hi := ConservationComposition.sourceValue _ _ valid state hs
    have row := imageMember _ _ _ hi
    have result := memMap Prod.snd (state,ConservationComposition.value mapping state) mapping row
    rw [eq] at result
    exact result

theorem reversibleIffInjective (source : List String) (mapping : Observation)
    (valid : ConservationLedger.validateTransformation source mapping = .ok mapping) :
    ConservationReverse.isReversible source mapping = .ok true ↔
      ∀ a, a ∈ source → ∀ b, b ∈ source →
        ConservationComposition.value mapping a = ConservationComposition.value mapping b → a = b := by
  rw [ConservationReverse.reversibleAdmitted _ _ valid]
  have counts := sameLabelCount (mapping.map Prod.snd) (source.map (ConservationComposition.value mapping))
    (valuesCorrespond _ _ valid)
  have length : (source.map (ConservationComposition.value mapping)).length = source.length :=
    SFT.Foundation.CommonRefinement.mapLength _ _
  constructor
  · intro h
    have equal := of_decide_eq_true (Except.ok.inj h)
    rw [counts,← length] at equal
    exact mapDistinctInjective _ _ ((labelCountIffDistinct _).mp equal)
  · intro injective
    have sourceUnique := ((MutualObservation.supportMeaning _).mp ((ConservationLedger.validationMeaning _ _ _).mp valid).1).2
    have equal := (labelCountIffDistinct _).mpr (mapDistinctOn _ _ sourceUnique injective)
    rw [length,← counts] at equal
    exact congrArg Except.ok (decide_eq_true equal)

theorem oneMemberList (items : List String) (state : String) (unique : distinct items = true)
    (present : state ∈ items) (only : ∀ x, x ∈ items → x = state) : items = [state] := by
  cases items with
  | nil => cases present
  | cons head rest =>
    have eq := only head (List.Mem.head _)
    cases eq
    cases rest with
    | nil => rfl
    | cons other tail =>
      have eq := only other (List.Mem.tail _ (List.Mem.head _))
      cases eq
      exact False.elim ((absentIff _ _).mp ((distinctCons _ _).mp unique).1 (List.Mem.head _))

theorem injectiveIffSingletonFibres (source : List String) (mapping : Observation)
    (valid : ConservationLedger.validateTransformation source mapping = .ok mapping) :
    (∀ a, a ∈ source → ∀ b, b ∈ source →
      ConservationComposition.value mapping a = ConservationComposition.value mapping b → a = b) ↔
    (∀ label, label ∈ MutualObservation.labels source mapping → ∃ state, fibre source mapping label = [state]) := by
  constructor
  · intro injective label hl
    obtain ⟨state,hs,hi⟩ := (MutualObservation.labelsMeaning _ _ _).mp hl
    refine ⟨state,oneMemberList _ state ?_ ((fibreMembership _ _ _ _).mpr ⟨hs,hi⟩) ?_⟩
    · apply filterDistinct
      exact ((MutualObservation.supportMeaning _).mp ((ConservationLedger.validationMeaning _ _ _).mp valid).1).2
    · intro other hm
      have p := (fibreMembership _ _ _ _).mp hm
      apply injective other p.1 state hs
      rw [ConservationComposition.valueExact _ _ _ p.2,ConservationComposition.valueExact _ _ _ hi]
  · intro single a ha b hb eq
    have ia := ConservationComposition.sourceValue _ _ valid a ha
    have ib := ConservationComposition.sourceValue _ _ valid b hb
    have label := (MutualObservation.labelsMeaning _ _ _).mpr ⟨a,ha,ia⟩
    obtain ⟨state,hs⟩ := single _ label
    have am := (fibreMembership _ _ _ _).mpr ⟨ha,ia⟩
    have bm := (fibreMembership _ _ _ _).mpr ⟨hb,ib.trans (congrArg some eq.symm)⟩
    rw [hs] at am bm
    have ae : a = state := by cases am with | head => rfl | tail _ h => cases h
    have be : b = state := by cases bm with | head => rfl | tail _ h => cases h
    exact ae.trans be.symm

theorem reversibleIffSingletonFibres (source : List String) (mapping : Observation)
    (valid : ConservationLedger.validateTransformation source mapping = .ok mapping) :
    ConservationReverse.isReversible source mapping = .ok true ↔
    ∀ label, label ∈ MutualObservation.labels source mapping → ∃ state, fibre source mapping label = [state] :=
  (reversibleIffInjective _ _ valid).trans (injectiveIffSingletonFibres _ _ valid)

end SFT.InformationScience.ConservationCardinality
