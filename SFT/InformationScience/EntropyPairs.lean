import SFT.InformationScience.EntropyLedger
namespace SFT.InformationScience.EntropyPairs
open EntropyPartition EntropyRefinement EncodingLoss
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations SFT.Mathematics.GeometryTopology
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.ProbabilityIndependence
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

theorem filteredPairMonotone (support : List String) (p q : String → Bool)
    (includes : ∀ state, state ∈ support → p state = true → q state = true)
    (pair : EntropyPartition.Pair) (hm : pair ∈ sourcePairs (support.filter p)) : pair ∈ sourcePairs (support.filter q) := by
  induction support with
  | nil => cases hm
  | cons first rest ih =>
    have tail : ∀ state, state ∈ rest → p state = true → q state = true :=
      fun state hs hp => includes state (List.Mem.tail first hs) hp
    cases hp : p first with
    | false =>
      rw [List.filter_cons_of_neg (by rw [hp]; intro h; cases h)] at hm
      have ht := ih tail hm
      cases hq : q first with
      | false => rw [List.filter_cons_of_neg (by rw [hq]; intro h; cases h)]; exact ht
      | true => rw [List.filter_cons_of_pos hq]; exact memAppendRight _ _ _ ht
    | true =>
      have hq := includes first (List.Mem.head _) hp
      rw [List.filter_cons_of_pos hp] at hm
      rw [List.filter_cons_of_pos hq]
      cases memAppendCases _ _ _ hm with
      | inr ht => exact memAppendRight _ _ _ (ih tail ht)
      | inl head =>
        obtain ⟨right,hr,eq⟩ := memMapPreimage (fun right => (first,right)) pair _ head
        have member := (filterMemberIff _ _ _).mp hr
        have kept := (filterMemberIff q rest right).mpr ⟨member.1,tail right member.1 member.2⟩
        rw [← eq]
        exact memAppendLeft _ _ _ (memMap (fun right => (first,right)) right _ kept)

theorem closedPairContainment (support : List String) (fine coarse : Observation) (fp cp : Partition)
    (hf : exactPartition support fine = .ok fp) (hc : exactPartition support coarse = .ok cp)
    (refined : refines support fine coarse = true) (pair : EntropyPartition.Pair)
    (hm : pair ∈ fp.flatMap (fun row => uncertaintyPairs (unresolvedPairs row.2))) :
    pair ∈ cp.flatMap (fun row => uncertaintyPairs (unresolvedPairs row.2)) := by
  obtain ⟨label,members,hr,hp⟩ := (closedMembership _ _ _ hf pair).mp hm
  obtain ⟨other,larger,ho,included⟩ := classContainment _ _ _ _ _ hf hc refined label members hr
  have fineRow := (partitionMembership _ _ _ hf _ _).mp hr
  have coarseRow := (partitionMembership _ _ _ hc _ _).mp ho
  apply (closedMembership _ _ _ hc pair).mpr
  refine ⟨other,larger,ho,?_⟩
  rw [fineRow.2] at hp
  rw [coarseRow.2]
  apply filteredPairMonotone support (belongs fine label) (belongs coarse other) _ pair hp
  intro state hs kept
  have member : state ∈ members := by
    rw [fineRow.2]
    exact (filterMemberIff _ _ _).mpr ⟨hs,kept⟩
  have big := included state member
  rw [coarseRow.2] at big
  exact ((filterMemberIff _ _ _).mp big).2

theorem sourcePairsUnique (support : List String) (unique : distinct support = true) : distinct (sourcePairs support) = true := by
  induction support with
  | nil => rfl
  | cons first rest ih =>
    have p := (distinctCons _ _).mp unique
    apply appendDistinct
    · exact mapDistinct (fun right => (first,right)) (fun _ _ eq => congrArg Prod.snd eq) rest p.2
    · exact ih p.2
    · intro pair head tail
      obtain ⟨right,_,eq⟩ := memMapPreimage (fun right => (first,right)) pair rest head
      cases eq
      exact (absentIff _ _).mp p.1 (pairSources _ _ _ tail).1

theorem classPairsUnique (support : List String) (observation : Observation) (labels : List String)
    (hs : distinct support = true) (hl : distinct labels = true) :
    distinct (labels.flatMap (fun label => sourcePairs (fibre support observation label))) = true := by
  induction labels with
  | nil => rfl
  | cons label rest ih =>
    have p := (distinctCons _ _).mp hl
    apply appendDistinct
    · exact sourcePairsUnique _ (filterDistinct _ _ hs)
    · exact ih p.2
    · intro pair head tail
      obtain ⟨other,ho,hp⟩ := memFlatMapOrigin _ _ _ tail
      have left := (pairSources _ _ _ head).1
      have right := (pairSources _ _ _ hp).1
      have same := fibreDisjoint _ _ _ _ _ left right
      cases same
      exact (absentIff _ _).mp p.1 ho

theorem flattenClassPairs (support : List String) (observation : Observation) (labels : List String) :
    (labels.map (fun label => (label,fibre support observation label))).flatMap
      (fun row => uncertaintyPairs (unresolvedPairs row.2)) =
      labels.flatMap (fun label => sourcePairs (fibre support observation label)) := by
  induction labels with
  | nil => rfl
  | cons label rest ih =>
    change uncertaintyPairs (unresolvedPairs (fibre support observation label)) ++
      (rest.map (fun label => (label,fibre support observation label))).flatMap
        (fun row => uncertaintyPairs (unresolvedPairs row.2)) = _
    rw [unresolvedContents,ih]; rfl

theorem closedPairsUnique (support : List String) (observation : Observation) (partition : Partition)
    (h : exactPartition support observation = .ok partition) :
    distinct (partition.flatMap (fun row => uncertaintyPairs (unresolvedPairs row.2))) = true := by
  have p := partitionResult _ _ _ h
  rw [p.2]
  change distinct ((firstLabels (observedValues observation support)).map
    (fun label => (label,fibre support observation label)) |>.flatMap
      (fun row => uncertaintyPairs (unresolvedPairs row.2))) = true
  rw [flattenClassPairs]
  exact classPairsUnique _ _ _ ((validityMeaning _ _).mp p.1).2.1 (firstLabelsDistinct _)

theorem pairFilterLength (p : EntropyPartition.Pair → Bool) (input : List EntropyPartition.Pair) :
    (input.filter p).length ≤ input.length := by
  induction input with
  | nil => exact Nat.le_refl _
  | cons pair rest ih =>
    change (match p pair with | true => pair :: rest.filter p | false => rest.filter p).length ≤ rest.length+1
    cases p pair with
    | false => exact Nat.le_trans ih (Nat.le_succ _)
    | true => exact Nat.succ_le_succ ih

theorem pairRemovalShorter (input : List EntropyPartition.Pair) (held : EntropyPartition.Pair)
    (hm : held ∈ input) : (input.filter (fun pair => decide (pair ≠ held))).length < input.length := by
  induction input with
  | nil => cases hm
  | cons first rest ih =>
    by_cases same : first = held
    · cases same
      have no : decide (held ≠ held) = false := decide_eq_false (fun h => h rfl)
      change (match decide (held ≠ held) with | true => held :: rest.filter (fun pair => decide (pair ≠ held)) | false => rest.filter (fun pair => decide (pair ≠ held))).length < rest.length+1
      rw [no]
      exact Nat.lt_succ_of_le (pairFilterLength _ _)
    · have ht : held ∈ rest := by
        cases hm with
        | head => exact False.elim (same rfl)
        | tail _ h => exact h
      change (match decide (first ≠ held) with | true => first :: rest.filter (fun pair => decide (pair ≠ held)) | false => rest.filter (fun pair => decide (pair ≠ held))).length < rest.length+1
      rw [decide_eq_true same]
      exact Nat.succ_lt_succ (ih ht)

theorem pairSubsetLength (held support : List EntropyPartition.Pair) (unique : distinct held = true)
    (contained : ∀ pair, pair ∈ held → pair ∈ support) : held.length ≤ support.length := by
  induction held generalizing support with
  | nil => exact Nat.zero_le _
  | cons first rest ih =>
    have parts := (distinctCons _ _).mp unique
    have shorter := pairRemovalShorter support first (contained first (List.Mem.head _))
    have bound := ih (support.filter (fun pair => decide (pair ≠ first))) parts.2 (by
      intro pair hm
      apply (filterMemberIff _ _ _).mpr
      refine ⟨contained pair (List.Mem.tail first hm),decide_eq_true ?_⟩
      intro same; cases same
      exact (absentIff _ _).mp parts.1 hm)
    exact Nat.succ_le_of_lt (Nat.lt_of_le_of_lt bound shorter)

theorem refinementPairCount (support : List String) (fine coarse : Observation) (fp cp : Partition)
    (hf : exactPartition support fine = .ok fp) (hc : exactPartition support coarse = .ok cp)
    (refined : refines support fine coarse = true) :
    (fp.flatMap (fun row => uncertaintyPairs (unresolvedPairs row.2))).length ≤
      (cp.flatMap (fun row => uncertaintyPairs (unresolvedPairs row.2))).length :=
  pairSubsetLength _ _ (closedPairsUnique _ _ _ hf) (fun pair hm => closedPairContainment _ _ _ _ _ hf hc refined pair hm)

end SFT.InformationScience.EntropyPairs
