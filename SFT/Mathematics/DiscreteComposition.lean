import SFT.Mathematics.DiscreteComplement
namespace SFT.Mathematics.DiscreteObjects
open SFT.Foundation.CommonRefinement SFT.Foundation.Count.TraceDerivation

def composeRelations (first second : Relation) : Relation :=
  first.flatMap (fun p => (second.filter (fun q => decide (q.1 = p.2))).map (fun q => (p.1,q.2)))

theorem filterAppendExact {α : Type} (p : α → Bool) (xs ys : List α) :
    (xs ++ ys).filter p = xs.filter p ++ ys.filter p := by
  induction xs with
  | nil => rfl
  | cons x xs ih =>
    cases hp : p x with
    | false =>
      change ((x::(xs ++ ys)).filter p) = (x::xs).filter p ++ ys.filter p
      rw [List.filter_cons_of_neg (by rw [hp]; intro h; cases h),
        List.filter_cons_of_neg (by rw [hp]; intro h; cases h)]
      exact ih
    | true =>
      change ((x::(xs ++ ys)).filter p) = (x::xs).filter p ++ ys.filter p
      rw [List.filter_cons_of_pos hp,List.filter_cons_of_pos hp]
      exact congrArg (List.cons x) ih

theorem filterOriginRow (origin item : Form) (row : Relation) :
    ((row.map (fun q => (origin,q.2))).filter (fun p => decide (p.1 = item))) =
      if origin = item then row.map (fun q => (origin,q.2)) else [] := by
  induction row with
  | nil => split <;> rfl
  | cons q qs ih =>
    by_cases h : origin = item
    · rw [ite_eq_left h] at ih ⊢
      change ((origin,q.2)::qs.map (fun q => (origin,q.2))).filter _ = _
      rw [List.filter_cons_of_pos (p := fun p : Form × Form => decide (p.1 = item)) (a := (origin,q.2)) (decide_eq_true h)]
      exact congrArg (List.cons (origin,q.2)) ih
    · rw [ite_eq_right h] at ih ⊢
      change ((origin,q.2)::qs.map (fun q => (origin,q.2))).filter _ = _
      rw [List.filter_cons_of_neg (p := fun p : Form × Form => decide (p.1 = item)) (a := (origin,q.2)) (fun ht => h (of_decide_eq_true ht))]
      exact ih

theorem compositionOutgoing (first second : Relation) (item : Form) :
    (composeRelations first second).filter (fun p => decide (p.1 = item)) =
      composeRelations (first.filter (fun p => decide (p.1 = item))) second := by
  induction first with
  | nil => rfl
  | cons p ps ih =>
    change ((_ ++ composeRelations ps second).filter _) = _
    rw [filterAppendExact,filterOriginRow]
    by_cases h : p.1 = item
    · rw [ite_eq_left h,List.filter_cons_of_pos (p := fun p : Form × Form => decide (p.1 = item)) (a := p) (decide_eq_true h),ih]
      rfl
    · rw [ite_eq_right h,List.filter_cons_of_neg (p := fun p : Form × Form => decide (p.1 = item)) (a := p) (fun ht => h (of_decide_eq_true ht)),ih]
      rfl

theorem compositionMemberOrigin (first second : Relation) (pair : Form × Form)
    (h : pair ∈ composeRelations first second) :
    ∃ p, p ∈ first ∧ ∃ q, q ∈ second ∧ q.1 = p.2 ∧ pair = (p.1,q.2) := by
  obtain ⟨p,hp,row⟩ := memFlatMapOrigin _ first pair h
  obtain ⟨q,hq,eq⟩ := memMapPreimage (fun q : Form × Form => (p.1,q.2)) pair _ row
  have parts := (filterMemberIff _ second q).mp hq
  exact ⟨p,hp,q,parts.1,of_decide_eq_true parts.2,eq.symm⟩

theorem compositionRetainsLinkedPair (first second : Relation) (p q : Form × Form)
    (hp : p ∈ first) (hq : q ∈ second) (linked : q.1 = p.2) :
    (p.1,q.2) ∈ composeRelations first second := by
  apply memFlatMap _ first p _ hp
  apply memMap (fun q => (p.1,q.2)) q _
  exact (filterMemberIff _ second q).mpr ⟨hq,decide_eq_true linked⟩

theorem compositionTotalSingleValued (source middle : Collection) (first second : Relation)
    (firstTotal : isTotalSingleValued source first = true)
    (secondTotal : isTotalSingleValued middle second = true)
    (interface : ∀ pair, pair ∈ first → pair.2 ∈ middle) :
    isTotalSingleValued source (composeRelations first second) = true := by
  apply (totalSingleValuedIff source _).mpr
  intro item hi
  obtain ⟨p,hp⟩ := totalMapSingleRetainedPair source first firstTotal item hi
  have member : p ∈ first := by
    have retained : p ∈ first.filter (fun q => decide (q.1 = item)) := by
      rw [hp]; exact List.Mem.head _
    exact ((filterMemberIff _ first p).mp retained).1
  obtain ⟨q,hq⟩ := totalMapSingleRetainedPair middle second secondTotal p.2 (interface p member)
  rw [compositionOutgoing,hp]
  change (((second.filter (fun q : Form × Form => decide (q.1 = p.2))).map (fun q : Form × Form => (p.1,q.2))) ++ []).length = 1
  rw [hq]
  rfl

theorem generatedMapCompositionTotal (source middle : Collection) (first second : Relation)
    (firstAccepted : generatedRelation source middle first = .ok first)
    (firstTotal : isTotalSingleValued source first = true)
    (secondTotal : isTotalSingleValued middle second = true) :
    isTotalSingleValued source (composeRelations first second) = true :=
  compositionTotalSingleValued source middle first second firstTotal secondTotal
    (fun pair hp => (generatedRelationContained source middle first first firstAccepted pair hp).2)

theorem compositionEndpointSupport (source middle target : Collection) (first second : Relation)
    (firstAccepted : generatedRelation source middle first = .ok first)
    (secondAccepted : generatedRelation middle target second = .ok second)
    (pair : Form × Form) (h : pair ∈ composeRelations first second) :
    pair.1 ∈ source ∧ pair.2 ∈ target := by
  obtain ⟨p,hp,q,hq,linked,eq⟩ := compositionMemberOrigin first second pair h
  cases eq
  exact ⟨(generatedRelationContained source middle first first firstAccepted p hp).1,
    (generatedRelationContained middle target second second secondAccepted q hq).2⟩

theorem singletonRowsDistinct (relation : Relation)
    (rows : ∀ pair, pair ∈ relation → ∃ single,
      relation.filter (fun p => decide (p.1 = pair.1)) = [single]) : distinct relation = true := by
  induction relation with
  | nil => rfl
  | cons x xs ih =>
    apply (distinctCons x xs).mpr
    constructor
    · apply (absentIff xs x).mpr
      intro hx
      obtain ⟨single,he⟩ := rows x (List.Mem.head _)
      rw [List.filter_cons_of_pos (p := fun p : Form × Form => decide (p.1 = x.1))
        (a := x) (decide_eq_true rfl)] at he
      have empty : xs.filter (fun p => decide (p.1 = x.1)) = [] := congrArg List.tail he
      have retained := (filterMemberIff (fun p : Form × Form => decide (p.1 = x.1)) xs x).mpr
        ⟨hx,decide_eq_true rfl⟩
      rw [empty] at retained
      cases retained
    · apply ih
      intro pair hp
      obtain ⟨single,he⟩ := rows pair (List.Mem.tail _ hp)
      by_cases same : x.1 = pair.1
      · rw [List.filter_cons_of_pos (p := fun p : Form × Form => decide (p.1 = pair.1))
          (a := x) (decide_eq_true same)] at he
        have empty : xs.filter (fun p => decide (p.1 = pair.1)) = [] := congrArg List.tail he
        have retained := (filterMemberIff (fun p : Form × Form => decide (p.1 = pair.1)) xs pair).mpr
          ⟨hp,decide_eq_true rfl⟩
        rw [empty] at retained
        cases retained
      · rw [List.filter_cons_of_neg (p := fun p : Form × Form => decide (p.1 = pair.1))
          (a := x) (fun h => same (of_decide_eq_true h))] at he
        exact ⟨single,he⟩

theorem totalSupportedRelationDistinct (source : Collection) (relation : Relation)
    (total : isTotalSingleValued source relation = true)
    (supported : ∀ pair, pair ∈ relation → pair.1 ∈ source) : distinct relation = true :=
  singletonRowsDistinct relation (fun pair hp => totalMapSingleRetainedPair source relation total pair.1 (supported pair hp))

theorem generatedMapCompositionAccepted (source middle target : Collection) (first second : Relation)
    (firstAccepted : generatedRelation source middle first = .ok first)
    (secondAccepted : generatedRelation middle target second = .ok second)
    (firstTotal : isTotalSingleValued source first = true)
    (secondTotal : isTotalSingleValued middle second = true) :
    generatedRelation source target (composeRelations first second) = .ok (composeRelations first second) := by
  have endpoints := compositionEndpointSupport source middle target first second firstAccepted secondAccepted
  have total := generatedMapCompositionTotal source middle first second firstAccepted firstTotal secondTotal
  have unique := totalSupportedRelationDistinct source _ total (fun pair hp => (endpoints pair hp).1)
  have contained : (composeRelations first second).any (fun pair => !has (completePairs source target) pair) = false := by
    apply anyFalseOfMembers
    intro pair hp
    have member := (completePairIff source target pair.1 pair.2).mpr (endpoints pair hp)
    rw [(hasIff _ pair).mpr member]
    rfl
  unfold generatedRelation
  rw [contained,unique]
  rfl

end SFT.Mathematics.DiscreteObjects
