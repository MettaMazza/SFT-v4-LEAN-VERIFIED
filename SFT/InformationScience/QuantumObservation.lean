import SFT.InformationScience.QuantumUnits
namespace SFT.InformationScience.QuantumObservation
open QuantitySupport QuantityProfile
open SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation

inductive Closed where
  | emptyOne
  | branches : List Word → Closed
  deriving DecidableEq

structure Record where
  observedClass : String
  retainedBranches : List Word
  closedAlternatives : Closed
  reconstructionRecord : Observation
  deriving DecidableEq

def retained (support : List Word) (observation : Observation) (observed : String) : List Word :=
  support.filter (fun word => decide (image observation word = observed))

def closed (support members : List Word) : List Word := support.filter (fun word => !(has members word))

def presentClosed : List Word → Closed
  | [] => .emptyOne
  | first :: rest => .branches (first :: rest)

def buildRecord (support : List Word) (observation : Observation) (observed : String) : Record :=
  let members := retained support observation observed
  ⟨observed,members,presentClosed (closed support members),support.map (fun word => (word,image observation word))⟩

def observeSupport (support : List Word) (observation : Observation) (observed : String) : Except String Record :=
  if !observationValid support observation then
    .error "ValueError: support observation must classify every branch exactly once"
  else if (retained support observation observed).isEmpty then
    .error "ValueError: observed class is outside registered image support"
  else .ok (buildRecord support observation observed)

def reconstructSupport (record : Observation) : Except String (List Word) :=
  if record.isEmpty || !distinct (record.map Prod.fst) then
    .error "ValueError: reconstruction requires a total duplicate-free branch record"
  else .ok (record.map Prod.fst)

theorem observationMeaning (support : List Word) (observation : Observation) (observed : String) (record : Record) :
    observeSupport support observation observed = .ok record ↔
      observationValid support observation = true ∧ (retained support observation observed).isEmpty = false ∧
      record = buildRecord support observation observed := by
  unfold observeSupport
  cases hv : observationValid support observation <;> cases he : (retained support observation observed).isEmpty
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { cases h.1 }
  all_goals try { cases h.2.1 }
  · exact ⟨rfl,rfl,(Except.ok.inj h).symm⟩
  · rw [h.2.2]; rfl

theorem retainedMeaning (support : List Word) (observation : Observation) (observed : String) (word : Word) :
    word ∈ retained support observation observed ↔ word ∈ support ∧ image observation word = observed := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem closedMeaning (support members : List Word) (word : Word) :
    word ∈ closed support members ↔ word ∈ support ∧ ¬ word ∈ members := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    refine ⟨p.1,?_⟩
    intro hm
    have yes := (hasIff _ _).mpr hm
    rw [yes] at p
    cases p.2
  · intro h
    apply (filterMemberIff _ _ _).mpr
    refine ⟨h.1,?_⟩
    cases hm : has members word with
    | false => rfl
    | true => exact False.elim (h.2 ((hasIff _ _).mp hm))

theorem retainedClosedDisjoint (support : List Word) (observation : Observation) (observed : String) (word : Word)
    (hr : word ∈ retained support observation observed)
    (hc : word ∈ closed support (retained support observation observed)) : False :=
  ((closedMeaning _ _ _).mp hc).2 hr

theorem retainedClosedCover (support : List Word) (observation : Observation) (observed : String) (word : Word)
    (member : word ∈ support) :
    word ∈ retained support observation observed ∨ word ∈ closed support (retained support observation observed) := by
  cases hm : has (retained support observation observed) word with
  | true => exact Or.inl ((hasIff _ _).mp hm)
  | false =>
    apply Or.inr
    apply (closedMeaning _ _ _).mpr
    refine ⟨member,?_⟩
    intro hr
    have yes := (hasIff _ _).mpr hr
    rw [hm] at yes
    cases yes

theorem recordProjection (support : List Word) (observation : Observation) :
    (support.map (fun word => (word,image observation word))).map Prod.fst = support := by
  induction support with
  | nil => rfl
  | cons word rest ih => exact congrArg (List.cons word) ih

theorem reconstructMeaning (record : Observation) (support : List Word) :
    reconstructSupport record = .ok support ↔
      record.isEmpty = false ∧ distinct (record.map Prod.fst) = true ∧ support = record.map Prod.fst := by
  unfold reconstructSupport
  cases he : record.isEmpty <;> cases hd : distinct (record.map Prod.fst)
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { cases h.1 }
  all_goals try { cases h.2.1 }
  · exact ⟨rfl,rfl,(Except.ok.inj h).symm⟩
  · rw [h.2.2]; rfl

theorem reconstruction (support : List Word) (observation : Observation) (observed : String)
    (nonempty : support.isEmpty = false) (unique : distinct support = true) :
    reconstructSupport (buildRecord support observation observed).reconstructionRecord = .ok support := by
  apply (reconstructMeaning _ _).mpr
  refine ⟨?_,?_,(recordProjection _ _).symm⟩
  · cases support with
    | nil => cases nonempty
    | cons _ _ => rfl
  · change distinct ((support.map (fun word => (word,image observation word))).map Prod.fst) = true
    rw [recordProjection]
    exact unique

theorem observedReconstruction (support : List Word) (observation : Observation) (observed : String) (record : Record)
    (h : observeSupport support observation observed = .ok record)
    (nonempty : support.isEmpty = false) (unique : distinct support = true) :
    reconstructSupport record.reconstructionRecord = .ok support := by
  rw [((observationMeaning _ _ _ _).mp h).2.2]
  exact reconstruction _ _ _ nonempty unique

end SFT.InformationScience.QuantumObservation
