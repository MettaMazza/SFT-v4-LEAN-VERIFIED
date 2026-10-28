import SFT.InformationScience.ChannelComposition
import SFT.InformationScience.EntropyExtension
import SFT.Mathematics.DiscreteComposition
namespace SFT.InformationScience.ChannelExtension
open ChannelRelation ChannelSelections ChannelCapacity
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
open SFT.Mathematics.ExactTraceArithmetic

def freshRows (fresh : String) (targets : List String) : List Cell := targets.map (fun target => (fresh,target))
def extend (channel : FiniteChannel) (fresh : String) (targets : List String) : FiniteChannel :=
  ⟨channel.inputs ++ [fresh],channel.outputs,channel.relation ++ freshRows fresh targets⟩

theorem supportAppend (first second : List Cell) (source : String) :
    rawSupport (first ++ second) source = rawSupport first source ++ rawSupport second source := by
  unfold rawSupport
  rw [filterAppendExact,mapAppend]

theorem freshRowsSupport (fresh source : String) (targets : List String) :
    rawSupport (freshRows fresh targets) source = if fresh = source then targets else [] := by
  induction targets with
  | nil => by_cases same : fresh = source
           · rw [ite_eq_left same]; rfl
           · rw [ite_eq_right same]; rfl
  | cons first rest ih =>
    by_cases same : fresh = source
    · rw [ite_eq_left same] at ih ⊢
      change (List.map Prod.snd (((fresh,first)::freshRows fresh rest).filter (fun row => decide (row.1 = source)))) = _
      rw [List.filter_cons_of_pos (p := fun row : Cell => decide (row.1 = source)) (a := (fresh,first)) (decide_eq_true same)]
      exact congrArg (List.cons first) ih
    · rw [ite_eq_right same] at ih ⊢
      change (List.map Prod.snd (((fresh,first)::freshRows fresh rest).filter (fun row => decide (row.1 = source)))) = _
      rw [List.filter_cons_of_neg (p := fun row : Cell => decide (row.1 = source)) (a := (fresh,first)) (fun h => same (of_decide_eq_true h))]
      exact ih

theorem supportAbsent (relation : List Cell) (source : String)
    (absent : ∀ target, ¬ (source,target) ∈ relation) : rawSupport relation source = [] := by
  induction relation with
  | nil => rfl
  | cons row rest ih =>
    cases row with
    | mk held target =>
      have different : held ≠ source := by intro eq; cases eq; exact absent target (List.Mem.head _)
      change (((held,target)::rest).filter (fun row => decide (row.1 = source))).map Prod.snd = []
      rw [List.filter_cons_of_neg (p := fun row : Cell => decide (row.1 = source)) (a := (held,target)) (fun h => different (of_decide_eq_true h))]
      exact ih (fun target hm => absent target (List.Mem.tail _ hm))

theorem oldSupport (channel : FiniteChannel) (fresh source : String) (targets : List String)
    (different : fresh ≠ source) : rawSupport (extend channel fresh targets).relation source = rawSupport channel.relation source := by
  change rawSupport (channel.relation ++ freshRows fresh targets) source = _
  rw [supportAppend,freshRowsSupport,ite_eq_right different,SymbolExtension.appendNil]

theorem newSupport (channel : FiniteChannel) (fresh : String) (targets : List String)
    (valid : makeChannel channel.inputs channel.outputs channel.relation = .ok channel)
    (new : ¬ fresh ∈ channel.inputs) : rawSupport (extend channel fresh targets).relation fresh = targets := by
  have p := (constructorMeaning _ _ _ _).mp valid
  have absent : rawSupport channel.relation fresh = [] := by
    apply supportAbsent
    intro target hm
    exact new (((insideMeaning _ _ _).mp p.2.2.1 (fresh,target) hm).1)
  change rawSupport (channel.relation ++ freshRows fresh targets) fresh = _
  rw [supportAppend,absent,freshRowsSupport,ite_eq_left rfl]
  rfl

theorem extensionAdmitted (channel : FiniteChannel) (fresh : String) (targets : List String)
    (valid : makeChannel channel.inputs channel.outputs channel.relation = .ok channel)
    (new : ¬ fresh ∈ channel.inputs) (nonempty : targets.isEmpty = false)
    (uniqueTargets : distinct targets = true) (insideTargets : ∀ target, target ∈ targets → target ∈ channel.outputs) :
    makeChannel (extend channel fresh targets).inputs (extend channel fresh targets).outputs
      (extend channel fresh targets).relation = .ok (extend channel fresh targets) := by
  have p := (constructorMeaning _ _ _ _).mp valid
  have carriers := (carriersMeaning _ _).mp p.1
  apply (constructorMeaning _ _ _ _).mpr
  refine ⟨?_,?_,?_,?_,rfl⟩
  · apply (carriersMeaning _ _).mpr
    refine ⟨?_,carriers.2.1,EntropyExtension.freshDistinct _ _ carriers.2.2.1 new,carriers.2.2.2⟩
    change (channel.inputs ++ [fresh]).isEmpty = false
    cases channel.inputs <;> rfl
  · apply appendDistinct _ _ p.2.1
    · exact mapDistinct (fun target => (fresh,target)) (fun a b eq => congrArg Prod.snd eq) _ uniqueTargets
    · intro row old added
      obtain ⟨target,ht,eq⟩ := memMapPreimage (fun target => (fresh,target)) row targets added
      have input := ((insideMeaning _ _ _).mp p.2.2.1 row old).1
      rw [← eq] at input
      exact new input
  · apply (insideMeaning _ _ _).mpr
    intro row hm
    cases memAppendCases _ _ _ hm with
    | inl old =>
      have endpoints := (insideMeaning _ _ _).mp p.2.2.1 row old
      exact ⟨memAppendLeft _ _ _ endpoints.1,endpoints.2⟩
    | inr added =>
      obtain ⟨target,ht,eq⟩ := memMapPreimage (fun target => (fresh,target)) row targets added
      cases eq
      exact ⟨memAppendRight _ _ _ (List.Mem.head []),insideTargets target ht⟩
  · apply (totalMeaning _ _).mpr
    intro source hm
    cases memAppendCases _ _ _ hm with
    | inl old =>
      obtain ⟨target,ht⟩ := (totalMeaning _ _).mp p.2.2.2.1 source old
      exact ⟨target,memAppendLeft _ _ _ ht⟩
    | inr added =>
      cases added with
      | head =>
        cases targets with
        | nil => cases nonempty
        | cons first rest => exact ⟨first,memAppendRight _ _ _ (List.Mem.head _)⟩
      | tail _ impossible => cases impossible

theorem oldOverlap (channel : FiniteChannel) (fresh left right : String) (targets : List String)
    (hl : fresh ≠ left) (hr : fresh ≠ right) :
    overlap (extend channel fresh targets).relation left right = overlap channel.relation left right := by
  unfold overlap
  rw [oldSupport _ _ _ _ hl,oldSupport _ _ _ _ hr]

theorem freshOverlap (channel : FiniteChannel) (fresh old : String) (targets : List String)
    (valid : makeChannel channel.inputs channel.outputs channel.relation = .ok channel)
    (new : ¬ fresh ∈ channel.inputs) (held : old ∈ channel.inputs) :
    overlap (extend channel fresh targets).relation old fresh = (rawSupport channel.relation old).any (has targets) := by
  have different : fresh ≠ old := by intro eq; cases eq; exact new held
  unfold overlap
  rw [oldSupport _ _ _ _ different,newSupport _ _ _ valid new]

theorem priorCode (channel : FiniteChannel) (fresh : String) (targets held : List String)
    (new : ¬ fresh ∈ channel.inputs) (covered : ∀ item, item ∈ held → item ∈ channel.inputs) :
    distinguishableCode (extend channel fresh targets) held = true ↔ distinguishableCode channel held = true := by
  have different : ∀ item, item ∈ held → fresh ≠ item := by
    intro item hm eq; cases eq; exact new (covered fresh hm)
  constructor
  · intro h
    have p := (codeMeaning _ _).mp h
    apply (codeMeaning _ _).mpr
    refine ⟨p.1,p.2.1,covered,?_⟩
    intro pair hm
    have endpoints := EncodingLoss.pairSources held pair.1 pair.2 hm
    have no := p.2.2.2 pair hm
    rw [oldOverlap _ _ _ _ _ (different pair.1 endpoints.1) (different pair.2 endpoints.2)] at no
    exact no
  · intro h
    have p := (codeMeaning _ _).mp h
    apply (codeMeaning _ _).mpr
    refine ⟨p.1,p.2.1,fun item hm => memAppendLeft _ _ _ (covered item hm),?_⟩
    intro pair hm
    have endpoints := EncodingLoss.pairSources held pair.1 pair.2 hm
    rw [oldOverlap _ _ _ _ _ (different pair.1 endpoints.1) (different pair.2 endpoints.2)]
    exact p.2.2.2 pair hm

theorem appendCode (channel : FiniteChannel) (fresh : String) (targets held : List String)
    (new : ¬ fresh ∈ channel.inputs) (prior : distinguishableCode channel held = true) :
    distinguishableCode (extend channel fresh targets) (held ++ [fresh]) = true ↔
      ∀ old, old ∈ held → overlap (extend channel fresh targets).relation old fresh = false := by
  have p := (codeMeaning _ _).mp prior
  have freshHeld : ¬ fresh ∈ held := fun hm => new (p.2.2.1 fresh hm)
  constructor
  · intro h old hm
    have pairs := ((codeMeaning _ _).mp h).2.2.2
    apply pairs (old,fresh)
    rw [EntropyExtension.pairSuccessorOrder]
    exact (EntropyExtension.pairSuccessorMembership _ _ _).mpr (Or.inr ⟨old,hm,rfl⟩)
  · intro separate
    apply (codeMeaning _ _).mpr
    refine ⟨?_,EntropyExtension.freshDistinct _ _ p.2.1 freshHeld,?_,?_⟩
    · cases held <;> rfl
    · intro item hm
      cases memAppendCases _ _ _ hm with
      | inl old => exact memAppendLeft _ _ _ (p.2.2.1 item old)
      | inr added => exact memAppendRight _ _ _ added
    · intro pair hm
      rw [EntropyExtension.pairSuccessorOrder] at hm
      cases (EntropyExtension.pairSuccessorMembership _ _ _).mp hm with
      | inl old =>
        have endpoints := EncodingLoss.pairSources held pair.1 pair.2 old
        have dl : fresh ≠ pair.1 := by intro eq; rw [← eq] at endpoints; exact freshHeld endpoints.1
        have dr : fresh ≠ pair.2 := by intro eq; rw [← eq] at endpoints; exact freshHeld endpoints.2
        rw [oldOverlap _ _ _ _ _ dl dr]
        exact p.2.2.2 pair old
      | inr added => obtain ⟨old,ho,eq⟩ := added; cases eq; exact separate old ho

theorem chosenAppendSplit (carrier held : List String) (fresh : String)
    (h : Chosen held (carrier ++ [fresh])) :
    Chosen held carrier ∨ ∃ prior, Chosen prior carrier ∧ held = prior ++ [fresh] := by
  induction carrier generalizing held with
  | nil =>
    cases h with
    | skip _ last => cases last; exact Or.inl .empty
    | take _ last => cases last; exact Or.inr ⟨[],.empty,rfl⟩
  | cons first rest ih =>
    cases h with
    | skip _ tail =>
      cases ih _ tail with
      | inl old => exact Or.inl (.skip first old)
      | inr added => obtain ⟨prior,hp,eq⟩ := added; exact Or.inr ⟨prior,.skip first hp,eq⟩
    | take _ tail =>
      cases ih _ tail with
      | inl old => exact Or.inl (.take first old)
      | inr added => obtain ⟨prior,hp,eq⟩ := added; exact Or.inr ⟨first::prior,.take first hp,congrArg (List.cons first) eq⟩

theorem appendLeftDistinct (left right : List String) (h : distinct (left ++ right) = true) : distinct left = true := by
  induction left with
  | nil => rfl
  | cons first rest ih =>
    have p := (distinctCons _ _).mp h
    apply (distinctCons _ _).mpr
    exact ⟨(absentIff _ _).mpr (fun hm => (absentIff _ _).mp p.1 (memAppendLeft _ _ _ hm)),ih p.2⟩

theorem appendCodePrior (channel : FiniteChannel) (fresh : String) (targets held : List String)
    (new : ¬ fresh ∈ channel.inputs) (covered : ∀ item, item ∈ held → item ∈ channel.inputs)
    (nonempty : held.isEmpty = false)
    (valid : distinguishableCode (extend channel fresh targets) (held ++ [fresh]) = true) :
    distinguishableCode channel held = true := by
  have p := (codeMeaning _ _).mp valid
  apply (codeMeaning _ _).mpr
  refine ⟨nonempty,appendLeftDistinct _ _ p.2.1,covered,?_⟩
  intro pair hm
  have extended : pair ∈ EncodingLoss.sourcePairs (held ++ [fresh]) := by
    rw [EntropyExtension.pairSuccessorOrder]
    exact (EntropyExtension.pairSuccessorMembership _ _ _).mpr (Or.inl hm)
  have no := p.2.2.2 pair extended
  have endpoints := EncodingLoss.pairSources held pair.1 pair.2 hm
  have dl : fresh ≠ pair.1 := by intro eq; have old := covered pair.1 endpoints.1; rw [← eq] at old; exact new old
  have dr : fresh ≠ pair.2 := by intro eq; have old := covered pair.2 endpoints.2; rw [← eq] at old; exact new old
  rw [oldOverlap _ _ _ _ _ dl dr] at no
  exact no

theorem chosenAppendOld (carrier held : List String) (fresh : String) (h : Chosen held carrier) :
    Chosen held (carrier ++ [fresh]) := by
  induction h with
  | empty => exact emptyChosen _
  | skip first h ih => exact .skip first ih
  | take first h ih => exact .take first ih

theorem chosenAppendNew (carrier held : List String) (fresh : String) (h : Chosen held carrier) :
    Chosen (held ++ [fresh]) (carrier ++ [fresh]) := by
  induction h with
  | empty => exact .take fresh .empty
  | skip first h ih => exact .skip first ih
  | take first h ih => exact .take first ih

theorem candidateAlternatives (channel : FiniteChannel) (fresh : String) (targets selection : List String)
    (new : ¬ fresh ∈ channel.inputs) :
    selection ∈ codeCandidates (extend channel fresh targets) ↔
      selection ∈ codeCandidates channel ∨ selection = [fresh] ∨
        ∃ prior, prior ∈ codeCandidates channel ∧ selection = prior ++ [fresh] ∧
          ∀ old, old ∈ prior → overlap (extend channel fresh targets).relation old fresh = false := by
  constructor
  · intro h
    have p := (candidatesMeaning _ _).mp h
    cases chosenAppendSplit channel.inputs selection fresh p.1 with
    | inl old =>
      exact Or.inl ((candidatesMeaning _ _).mpr ⟨old,(priorCode _ _ _ _ new (chosenContained _ _ old)).mp p.2⟩)
    | inr added =>
      obtain ⟨prior,hp,eq⟩ := added
      cases prior with
      | nil => exact Or.inr (Or.inl eq)
      | cons first rest =>
        have valid : distinguishableCode (extend channel fresh targets) ((first::rest) ++ [fresh]) = true := by rw [← eq]; exact p.2
        have original := appendCodePrior _ _ _ _ new (chosenContained _ _ hp) rfl valid
        exact Or.inr (Or.inr ⟨first::rest,(candidatesMeaning _ _).mpr ⟨hp,original⟩,eq,(appendCode _ _ _ _ new original).mp valid⟩)
  · intro h
    apply (candidatesMeaning _ _).mpr
    cases h with
    | inl old =>
      have p := (candidatesMeaning _ _).mp old
      exact ⟨chosenAppendOld _ _ _ p.1,(priorCode _ _ _ _ new (chosenContained _ _ p.1)).mpr p.2⟩
    | inr added =>
      cases added with
      | inl singleton =>
        cases singleton
        exact ⟨singletonChosen _ _ (memAppendRight _ _ _ (List.Mem.head [])),singletonCode _ _ (memAppendRight _ _ _ (List.Mem.head []))⟩
      | inr extended =>
        obtain ⟨prior,hp,eq,separate⟩ := extended
        cases eq
        have p := (candidatesMeaning _ _).mp hp
        exact ⟨chosenAppendNew _ _ _ p.1,(appendCode _ _ _ _ new p.2).mpr separate⟩

end SFT.InformationScience.ChannelExtension
