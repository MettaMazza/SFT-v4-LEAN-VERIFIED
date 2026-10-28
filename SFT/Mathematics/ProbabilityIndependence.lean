import SFT.Mathematics.ProbabilityEvents
namespace SFT.Mathematics.ProbabilityIndependence
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

def retainFirst (seen : List String) : List String → List String
  | [] => []
  | label :: rest => if has seen label then retainFirst seen rest
    else label :: retainFirst (seen ++ [label]) rest

def firstLabels (items : List String) : List String := retainFirst [] items

def pairSupport (left right : List String) : List (String × String) :=
  left.flatMap (fun a => right.map (fun b => (a,b)))

def pairsEqual : List (String × String) → List (String × String) → Bool
  | [], other => match other with | [] => true | _ :: _ => false
  | a :: rest, other => match other with
    | [] => false
    | b :: tail => decide (a.1 = b.1) && decide (a.2 = b.2) && pairsEqual rest tail

def jointHeld (joint : List (String × String)) (left right : List String) : List (String × String) :=
  joint.filter (fun pair => has left pair.1 && has right pair.2)

def independent (joint : List (String × String)) (left right : List String) : Except String Bool :=
  let leftSupport := firstLabels (joint.map Prod.fst)
  let rightSupport := firstLabels (joint.map Prod.snd)
  if left.isEmpty || right.isEmpty then
    .error "independence weight requires nonempty held events; empty cases remain empty One"
  else if !pairsEqual joint (pairSupport leftSupport rightSupport) then .ok false
  else if joint.isEmpty then .error "Fraction(0, 0)"
  else .ok ((jointHeld joint left right).length * leftSupport.length * rightSupport.length ==
    left.length * right.length * joint.length)

theorem pairsEqualIff (left right : List (String × String)) : pairsEqual left right = true ↔ left = right := by
  induction left generalizing right with
  | nil => cases right with
    | nil => exact ⟨fun _ => rfl,fun _ => rfl⟩
    | cons b tail => constructor <;> intro h <;> cases h
  | cons a rest ih =>
    cases right with
    | nil => constructor <;> intro h <;> cases h
    | cons b tail =>
      constructor
      · intro h
        have parts := (GeometryTopology.andTrue _ _).mp h
        have headParts := (GeometryTopology.andTrue _ _).mp parts.1
        have hfst := of_decide_eq_true headParts.1
        have hsnd := of_decide_eq_true headParts.2
        have same : a = b := Prod.ext hfst hsnd
        cases same
        exact congrArg (List.cons a) ((ih tail).mp parts.2)
      · intro h
        cases h
        change (decide (a.1 = a.1) && decide (a.2 = a.2) && pairsEqual rest rest) = true
        rw [(ih rest).mpr rfl]
        rw [show decide (a.1 = a.1) = true from decide_eq_true rfl,
          show decide (a.2 = a.2) = true from decide_eq_true rfl]
        rfl

theorem retainFirstMembership (seen items : List String) (label : String) :
    label ∈ retainFirst seen items ↔ label ∈ items ∧ ¬ label ∈ seen := by
  induction items generalizing seen with
  | nil => constructor <;> intro h; cases h; cases h.1
  | cons first rest ih =>
    unfold retainFirst
    cases known : has seen first with
    | true =>
      constructor
      · intro h; have p := (ih seen).mp h; exact ⟨List.Mem.tail first p.1,p.2⟩
      · intro h
        cases h.1 with
        | head => exact False.elim (h.2 ((hasIff _ _).mp known))
        | tail _ hr => exact (ih seen).mpr ⟨hr,h.2⟩
    | false =>
      constructor
      · intro h
        cases h with
        | head =>
          refine ⟨List.Mem.head rest,?_⟩
          intro hv; have yes := (hasIff _ _).mpr hv; rw [known] at yes; cases yes
        | tail _ hr =>
          have p := (ih (seen ++ [first])).mp hr
          exact ⟨List.Mem.tail first p.1,fun hv => p.2 (memAppendLeft _ _ _ hv)⟩
      · intro h
        cases h.1 with
        | head => exact List.Mem.head _
        | tail _ hr =>
          by_cases same : label = first
          · cases same; exact List.Mem.head _
          · apply List.Mem.tail
            apply (ih (seen ++ [first])).mpr
            refine ⟨hr,?_⟩
            intro hv
            cases memAppendCases label seen [first] hv with
            | inl old => exact h.2 old
            | inr new => cases new with
              | head => exact same rfl
              | tail _ h => cases h

theorem firstLabelsMembership (items : List String) (label : String) :
    label ∈ firstLabels items ↔ label ∈ items :=
  ⟨fun h => ((retainFirstMembership [] items label).mp h).1,
   fun h => (retainFirstMembership [] items label).mpr ⟨h,fun h => by cases h⟩⟩

theorem retainFirstDistinct (seen items : List String) : distinct (retainFirst seen items) = true := by
  induction items generalizing seen with
  | nil => rfl
  | cons first rest ih =>
    change distinct (if has seen first then retainFirst seen rest else first :: retainFirst (seen ++ [first]) rest) = true
    cases known : has seen first with
    | true => exact ih seen
    | false =>
      apply (distinctCons _ _).mpr
      refine ⟨(absentIff _ _).mpr ?_,ih (seen ++ [first])⟩
      intro member
      have p := (retainFirstMembership (seen ++ [first]) rest first).mp member
      exact p.2 (memAppendRight _ _ _ (List.Mem.head []))

theorem firstLabelsDistinct (items : List String) : distinct (firstLabels items) = true := retainFirstDistinct [] items

theorem pairSupportMembership (left right : List String) (a b : String) :
    (a,b) ∈ pairSupport left right ↔ a ∈ left ∧ b ∈ right := by
  constructor
  · intro h
    obtain ⟨x,hx,hm⟩ := SFT.Foundation.CommonRefinement.memFlatMapOrigin _ _ _ h
    obtain ⟨y,hy,same⟩ := memMapPreimage (fun y => (x,y)) (a,b) right hm
    cases same
    exact ⟨hx,hy⟩
  · intro h
    apply SFT.Foundation.CommonRefinement.memFlatMap _ _ a _ h.1
    exact memMap (fun y => (a,y)) b right h.2

theorem pairSupportCardinality (left right : List String) :
    (pairSupport left right).length = right.length * left.length := by
  induction left with
  | nil => rfl
  | cons a rest ih =>
    change ((right.map (fun b => (a,b))) ++ pairSupport rest right).length = right.length * (rest.length+1)
    rw [SFT.Foundation.CommonRefinement.appendLength,SFT.Foundation.CommonRefinement.mapLength,ih,Nat.mul_succ]
    exact Nat.add_comm _ _

theorem jointHeldMembership (joint : List (String × String)) (left right : List String) (pair : String × String) :
    pair ∈ jointHeld joint left right ↔ pair ∈ joint ∧ pair.1 ∈ left ∧ pair.2 ∈ right := by
  constructor
  · intro member
    have parts := (filterMemberIff _ _ _).mp member
    have both := (GeometryTopology.andTrue _ _).mp parts.2
    exact ⟨parts.1,(hasIff _ _).mp both.1,(hasIff _ _).mp both.2⟩
  · intro parts
    exact (filterMemberIff _ _ _).mpr ⟨parts.1,
      (GeometryTopology.andTrue _ _).mpr ⟨(hasIff _ _).mpr parts.2.1,(hasIff _ _).mpr parts.2.2⟩⟩

theorem independentRejectsEmptyEvent (joint : List (String × String)) (left right : List String)
    (empty : (left.isEmpty || right.isEmpty) = true) :
    independent joint left right = .error "independence weight requires nonempty held events; empty cases remain empty One" := by
  unfold independent
  rw [empty]
  rfl

theorem independentRejectsIncompleteProduct (joint : List (String × String)) (left right : List String)
    (events : (left.isEmpty || right.isEmpty) = false)
    (incomplete : pairsEqual joint (pairSupport (firstLabels (joint.map Prod.fst)) (firstLabels (joint.map Prod.snd))) = false) :
    independent joint left right = .ok false := by
  unfold independent
  dsimp only
  rw [events,incomplete]
  rfl

theorem filterPairRow (a : String) (items left right : List String) :
    ((items.map (fun b => (a,b))).filter (fun p => has left p.1 && has right p.2)) =
      if has left a then (items.filter (has right)).map (fun b => (a,b)) else [] := by
  induction items with
  | nil => cases has left a <;> rfl
  | cons b rest ih =>
    change ((a,b) :: rest.map (fun b => (a,b))).filter _ = _
    cases ha : has left a <;> cases hb : has right b
    · rw [List.filter_cons_of_neg (by rw [ha,hb]; intro h; cases h)]
      rw [ha] at ih; exact ih
    · rw [List.filter_cons_of_neg (by rw [ha,hb]; intro h; cases h)]
      rw [ha] at ih; exact ih
    · rw [List.filter_cons_of_neg (by rw [ha,hb]; intro h; cases h),
        List.filter_cons_of_neg (by rw [hb]; intro h; cases h)]
      rw [ha] at ih; exact ih
    · rw [List.filter_cons_of_pos (by rw [ha,hb]; rfl),List.filter_cons_of_pos hb]
      rw [ha] at ih; exact congrArg (List.cons (a,b)) ih

theorem jointHeldProduct (supportLeft supportRight left right : List String) :
    jointHeld (pairSupport supportLeft supportRight) left right =
      pairSupport (supportLeft.filter (has left)) (supportRight.filter (has right)) := by
  induction supportLeft with
  | nil => rfl
  | cons a rest ih =>
    change ((supportRight.map (fun b => (a,b))) ++ pairSupport rest supportRight).filter _ = _
    rw [filterAppendExact,filterPairRow]
    cases ha : has left a
    · rw [List.filter_cons_of_neg (by rw [ha]; intro h; cases h)]
      exact ih
    · rw [List.filter_cons_of_pos ha]
      exact congrArg (List.append ((supportRight.filter (has right)).map (fun b => (a,b)))) ih

theorem jointHeldProductCardinality (supportLeft supportRight left right : List String) :
    (jointHeld (pairSupport supportLeft supportRight) left right).length =
      (supportRight.filter (has right)).length * (supportLeft.filter (has left)).length := by
  rw [jointHeldProduct,pairSupportCardinality]

theorem selectedCardinality (support held : List String)
    (supportUnique : distinct support = true) (heldUnique : distinct held = true)
    (contained : ∀ a, a ∈ held → a ∈ support) :
    (support.filter (has held)).length = held.length := by
  apply Nat.le_antisymm
  · apply ProbabilityEvents.distinctSubsetLength
    · exact filterDistinct _ _ supportUnique
    · intro a h
      exact (hasIff _ _).mp ((filterMemberIff _ _ _).mp h).2
  · apply ProbabilityEvents.distinctSubsetLength
    · exact heldUnique
    · intro a h
      exact (filterMemberIff _ _ _).mpr ⟨contained a h,(hasIff _ _).mpr h⟩

theorem admittedProductCount (supportLeft supportRight left right : List String)
    (lu : distinct supportLeft = true) (ru : distinct supportRight = true)
    (le : distinct left = true) (re : distinct right = true)
    (lc : ∀ a, a ∈ left → a ∈ supportLeft) (rc : ∀ a, a ∈ right → a ∈ supportRight) :
    (jointHeld (pairSupport supportLeft supportRight) left right).length = right.length * left.length := by
  rw [jointHeldProductCardinality,selectedCardinality supportRight right ru re rc,
    selectedCardinality supportLeft left lu le lc]

theorem completeProductFactorization (joint : List (String × String)) (left right : List String)
    (complete : joint = pairSupport (firstLabels (joint.map Prod.fst)) (firstLabels (joint.map Prod.snd)))
    (le : distinct left = true) (re : distinct right = true)
    (lc : ∀ a, a ∈ left → a ∈ firstLabels (joint.map Prod.fst))
    (rc : ∀ a, a ∈ right → a ∈ firstLabels (joint.map Prod.snd)) :
    (jointHeld joint left right).length * (firstLabels (joint.map Prod.fst)).length *
      (firstLabels (joint.map Prod.snd)).length = left.length * right.length * joint.length := by
  have held := admittedProductCount _ _ left right (firstLabelsDistinct _) (firstLabelsDistinct _) le re lc rc
  have count := pairSupportCardinality (firstLabels (joint.map Prod.fst)) (firstLabels (joint.map Prod.snd))
  have jointCount : joint.length = (firstLabels (joint.map Prod.snd)).length * (firstLabels (joint.map Prod.fst)).length :=
    (congrArg List.length complete).trans count
  have heldCount : (jointHeld joint left right).length = right.length * left.length :=
    (congrArg (fun pairs => (jointHeld pairs left right).length) complete).trans held
  rw [heldCount,jointCount,Nat.mul_comm right.length left.length,
    Nat.mul_comm (firstLabels (joint.map Prod.snd)).length (firstLabels (joint.map Prod.fst)).length,
    SFT.Foundation.FractionReduction.mulAssoc]

theorem natBeqSelf (n : Nat) : (n == n) = true := by
  induction n with
  | zero => rfl
  | succ n ih => exact ih

theorem independentAdmittedProduct (joint : List (String × String)) (left right : List String)
    (events : (left.isEmpty || right.isEmpty) = false) (nonempty : joint.isEmpty = false)
    (complete : joint = pairSupport (firstLabels (joint.map Prod.fst)) (firstLabels (joint.map Prod.snd)))
    (le : distinct left = true) (re : distinct right = true)
    (lc : ∀ a, a ∈ left → a ∈ firstLabels (joint.map Prod.fst))
    (rc : ∀ a, a ∈ right → a ∈ firstLabels (joint.map Prod.snd)) :
    independent joint left right = .ok true := by
  have product := (pairsEqualIff _ _).mpr complete
  have factor := completeProductFactorization joint left right complete le re lc rc
  unfold independent
  dsimp only
  rw [events,product,nonempty]
  change Except.ok (_ == _) = Except.ok true
  rw [factor]
  exact congrArg Except.ok (natBeqSelf _)

theorem independentEmptyJoint (left right : List String)
    (events : (left.isEmpty || right.isEmpty) = false) :
    independent [] left right = .error "Fraction(0, 0)" := by
  unfold independent
  rw [events]
  rfl

theorem independentCompleteDecision (joint : List (String × String)) (left right : List String)
    (events : (left.isEmpty || right.isEmpty) = false) (nonempty : joint.isEmpty = false)
    (complete : joint = pairSupport (firstLabels (joint.map Prod.fst)) (firstLabels (joint.map Prod.snd))) :
    independent joint left right = .ok ((jointHeld joint left right).length *
      (firstLabels (joint.map Prod.fst)).length * (firstLabels (joint.map Prod.snd)).length ==
      left.length * right.length * joint.length) := by
  have product := (pairsEqualIff _ _).mpr complete
  unfold independent
  dsimp only
  rw [events,product,nonempty]
  rfl

end SFT.Mathematics.ProbabilityIndependence

