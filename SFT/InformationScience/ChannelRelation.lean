import SFT.Mathematics.SelectionEncoding
import SFT.InformationScience.EncodingLoss
import SFT.Mathematics.GeometryTopology
namespace SFT.InformationScience.ChannelRelation
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations SFT.Mathematics.GeometryTopology
open SFT.Foundation.Count.TraceDerivation
abbrev Cell := String × String
structure FiniteChannel where
  inputs : List String
  outputs : List String
  relation : List Cell

def carriersValid (inputs outputs : List String) : Bool :=
  !inputs.isEmpty && !outputs.isEmpty && distinct inputs && distinct outputs

def inside (inputs outputs : List String) (relation : List Cell) : Bool :=
  relation.all (fun row => has inputs row.1 && has outputs row.2)

def total (inputs : List String) (relation : List Cell) : Bool :=
  inputs.all (fun source => relation.any (fun row => decide (row.1 = source)))

def makeChannel (inputs outputs : List String) (relation : List Cell) : Except String FiniteChannel :=
  if carriersValid inputs outputs then
    if distinct relation then
      if inside inputs outputs relation then
        if total inputs relation then .ok ⟨inputs,outputs,relation⟩
        else .error "ValueError: every input requires at least one possible output"
      else .error "ValueError: every channel cell must remain inside its carriers"
    else .error "ValueError: channel relation cannot duplicate transport cells"
  else .error "ValueError: a channel requires complete nonempty canonical carriers"

def rawSupport (relation : List Cell) (source : String) : List String :=
  (relation.filter (fun row => decide (row.1 = source))).map Prod.snd

def outputSupport (channel : FiniteChannel) (source : String) : Except String (List String) :=
  if has channel.inputs source then .ok (rawSupport channel.relation source)
  else .error "ValueError: source is outside channel input support"

def overlap (relation : List Cell) (left right : String) : Bool :=
  (rawSupport relation left).any (has (rawSupport relation right))

def confusable (channel : FiniteChannel) (left right : String) : Except String Bool :=
  match outputSupport channel left with
  | .error e => .error e
  | .ok first => match outputSupport channel right with
    | .error e => .error e
    | .ok second => .ok (first.any (has second))

def distinguishableCode (channel : FiniteChannel) (held : List String) : Bool :=
  !held.isEmpty && distinct held && held.all (has channel.inputs) &&
    (EncodingLoss.sourcePairs held).all (fun pair => !overlap channel.relation pair.1 pair.2)

theorem carriersMeaning (inputs outputs : List String) : carriersValid inputs outputs = true ↔
    inputs.isEmpty = false ∧ outputs.isEmpty = false ∧ distinct inputs = true ∧ distinct outputs = true := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have q := (andTrue _ _).mp p.1
    have t := (andTrue _ _).mp q.1
    exact ⟨(notTrue _).mp t.1,(notTrue _).mp t.2,q.2,p.2⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(notTrue _).mpr h.1,(notTrue _).mpr h.2.1⟩,h.2.2.1⟩,h.2.2.2⟩

theorem insideMeaning (inputs outputs : List String) (relation : List Cell) :
    inside inputs outputs relation = true ↔ ∀ row, row ∈ relation → row.1 ∈ inputs ∧ row.2 ∈ outputs := by
  constructor
  · intro h row hm
    have p := (andTrue _ _).mp (allTrueAtMember _ _ h row hm)
    exact ⟨(hasIff _ _).mp p.1,(hasIff _ _).mp p.2⟩
  · intro h
    exact (allTrueIffMembers _ _).mpr (fun row hm => (andTrue _ _).mpr ⟨(hasIff _ _).mpr (h row hm).1,(hasIff _ _).mpr (h row hm).2⟩)

theorem totalMeaning (inputs : List String) (relation : List Cell) : total inputs relation = true ↔
    ∀ source, source ∈ inputs → ∃ target, (source,target) ∈ relation := by
  constructor
  · intro h source hm
    obtain ⟨row,hr,eq⟩ := (anyTrueIff _ _).mp (allTrueAtMember _ _ h source hm)
    have same := of_decide_eq_true eq
    cases row with
    | mk held target => cases same; exact ⟨target,hr⟩
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro source hm
    obtain ⟨target,hr⟩ := h source hm
    exact (anyTrueIff _ _).mpr ⟨(source,target),hr,decide_eq_true rfl⟩

theorem constructorMeaning (inputs outputs : List String) (relation : List Cell) (channel : FiniteChannel) :
    makeChannel inputs outputs relation = .ok channel ↔
      carriersValid inputs outputs = true ∧ distinct relation = true ∧ inside inputs outputs relation = true ∧
      total inputs relation = true ∧ channel = ⟨inputs,outputs,relation⟩ := by
  unfold makeChannel
  cases a : carriersValid inputs outputs <;> cases b : distinct relation <;>
    cases c : inside inputs outputs relation <;> cases d : total inputs relation
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { cases h.1 }
  all_goals try { cases h.2.1 }
  all_goals try { cases h.2.2.1 }
  all_goals try { cases h.2.2.2.1 }
  · exact ⟨rfl,rfl,rfl,rfl,(Except.ok.inj h).symm⟩
  · rw [h.2.2.2.2]; rfl

theorem supportMembership (relation : List Cell) (source target : String) :
    target ∈ rawSupport relation source ↔ (source,target) ∈ relation := by
  constructor
  · intro h
    obtain ⟨row,hr,eq⟩ := memMapPreimage Prod.snd target _ h
    have p := (filterMemberIff _ _ _).mp hr
    have same := of_decide_eq_true p.2
    cases row with
    | mk held value => cases same; cases eq; exact p.1
  · intro h
    apply memMap Prod.snd (source,target) _
    exact (filterMemberIff _ _ _).mpr ⟨h,decide_eq_true rfl⟩

theorem outputMeaning (channel : FiniteChannel) (source : String) (result : List String) :
    outputSupport channel source = .ok result ↔ source ∈ channel.inputs ∧ result = rawSupport channel.relation source := by
  unfold outputSupport
  cases h : has channel.inputs source with
  | false =>
    constructor
    · intro eq; cases eq
    · intro p; have yes := (hasIff _ _).mpr p.1; rw [h] at yes; cases yes
  | true =>
    constructor
    · intro eq; exact ⟨(hasIff _ _).mp h,(Except.ok.inj eq).symm⟩
    · intro p; rw [p.2]; rfl

theorem admittedSupportNonempty (inputs outputs : List String) (relation : List Cell) (channel : FiniteChannel)
    (h : makeChannel inputs outputs relation = .ok channel) (source : String) (hs : source ∈ channel.inputs) :
    ∃ target, target ∈ rawSupport channel.relation source := by
  have p := (constructorMeaning _ _ _ _).mp h
  rw [p.2.2.2.2] at hs ⊢
  obtain ⟨target,ht⟩ := (totalMeaning _ _).mp p.2.2.2.1 source hs
  exact ⟨target,(supportMembership _ _ _).mpr ht⟩

theorem admittedSupportInside (inputs outputs : List String) (relation : List Cell) (channel : FiniteChannel)
    (h : makeChannel inputs outputs relation = .ok channel) (source target : String)
    (ht : target ∈ rawSupport channel.relation source) : target ∈ channel.outputs := by
  have p := (constructorMeaning _ _ _ _).mp h
  rw [p.2.2.2.2] at ht ⊢
  exact ((insideMeaning _ _ _).mp p.2.2.1 (source,target) ((supportMembership _ _ _).mp ht)).2

theorem overlapMeaning (relation : List Cell) (left right : String) : overlap relation left right = true ↔
    ∃ target, (left,target) ∈ relation ∧ (right,target) ∈ relation := by
  constructor
  · intro h
    obtain ⟨target,hl,hr⟩ := (anyTrueIff _ _).mp h
    exact ⟨target,(supportMembership _ _ _).mp hl,(supportMembership _ _ _).mp ((hasIff _ _).mp hr)⟩
  · intro ⟨target,hl,hr⟩
    exact (anyTrueIff _ _).mpr ⟨target,(supportMembership _ _ _).mpr hl,(hasIff _ _).mpr ((supportMembership _ _ _).mpr hr)⟩

theorem overlapSymmetric (relation : List Cell) (left right : String) : overlap relation left right = overlap relation right left := by
  have forward : ∀ a b, overlap relation a b = true → overlap relation b a = true := by
    intro a b h
    obtain ⟨target,ha,hb⟩ := (overlapMeaning _ _ _).mp h
    exact (overlapMeaning _ _ _).mpr ⟨target,hb,ha⟩
  cases a : overlap relation left right <;> cases b : overlap relation right left
  · rfl
  · have no := forward right left b; rw [a] at no; cases no
  · have no := forward left right a; rw [b] at no; cases no
  · rfl

theorem confusableResult (channel : FiniteChannel) (left right : String)
    (hl : left ∈ channel.inputs) (hr : right ∈ channel.inputs) :
    confusable channel left right = .ok (overlap channel.relation left right) := by
  have a := (outputMeaning channel left _).mpr ⟨hl,rfl⟩
  have b := (outputMeaning channel right _).mpr ⟨hr,rfl⟩
  unfold confusable; rw [a,b]; rfl

theorem codeMeaning (channel : FiniteChannel) (held : List String) : distinguishableCode channel held = true ↔
    held.isEmpty = false ∧ distinct held = true ∧ (∀ item, item ∈ held → item ∈ channel.inputs) ∧
      ∀ pair, pair ∈ EncodingLoss.sourcePairs held → overlap channel.relation pair.1 pair.2 = false := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have q := (andTrue _ _).mp p.1
    have t := (andTrue _ _).mp q.1
    exact ⟨(notTrue _).mp t.1,t.2,fun item hm => (hasIff _ _).mp (allTrueAtMember _ _ q.2 item hm),
      fun pair hm => (notTrue _).mp (allTrueAtMember _ _ p.2 pair hm)⟩
  · intro h
    apply (andTrue _ _).mpr
    refine ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(notTrue _).mpr h.1,h.2.1⟩,?_⟩,?_⟩
    · exact (allTrueIffMembers _ _).mpr (fun item hm => (hasIff _ _).mpr (h.2.2.1 item hm))
    · exact (allTrueIffMembers _ _).mpr (fun pair hm => (notTrue _).mpr (h.2.2.2 pair hm))

theorem codeDisjoint (channel : FiniteChannel) (held : List String) (h : distinguishableCode channel held = true)
    (left right : String) (pair : (left,right) ∈ EncodingLoss.sourcePairs held) :
    ¬ ∃ target, target ∈ rawSupport channel.relation left ∧ target ∈ rawSupport channel.relation right := by
  intro ⟨target,hl,hr⟩
  have yes := (overlapMeaning _ _ _).mpr ⟨target,(supportMembership _ _ _).mp hl,(supportMembership _ _ _).mp hr⟩
  have no := ((codeMeaning _ _).mp h).2.2.2 (left,right) pair
  rw [no] at yes
  cases yes

theorem singletonCode (channel : FiniteChannel) (source : String) (h : source ∈ channel.inputs) :
    distinguishableCode channel [source] = true := by
  apply (codeMeaning _ _).mpr
  refine ⟨rfl,rfl,?_,?_⟩
  · intro held hm
    cases hm with
    | head => exact h
    | tail _ impossible => cases impossible
  · intro pair hm; cases hm

theorem rawSupportDistinct (relation : List Cell) (unique : distinct relation = true) (source : String) :
    distinct (rawSupport relation source) = true := by
  apply SFT.Mathematics.CombinatorialSelections.mapDistinctWithin
    Prod.snd (relation.filter (fun row => decide (row.1 = source))) (filterDistinct _ _ unique)
  intro a ha b hb eq
  have sa := of_decide_eq_true ((filterMemberIff _ _ _).mp ha).2
  have sb := of_decide_eq_true ((filterMemberIff _ _ _).mp hb).2
  cases a with
  | mk x y => cases b with
    | mk z w => cases sa; cases sb; cases eq; rfl

theorem admittedSelfConfusable (inputs outputs : List String) (relation : List Cell) (channel : FiniteChannel)
    (h : makeChannel inputs outputs relation = .ok channel) (source : String) (hs : source ∈ channel.inputs) :
    confusable channel source source = .ok true := by
  obtain ⟨target,ht⟩ := admittedSupportNonempty _ _ _ _ h source hs
  have row := (supportMembership _ _ _).mp ht
  have yes := (overlapMeaning _ _ _).mpr ⟨target,row,row⟩
  rw [confusableResult _ _ _ hs hs,yes]

end SFT.InformationScience.ChannelRelation
