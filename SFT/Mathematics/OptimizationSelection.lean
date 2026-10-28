import SFT.Mathematics.ProbabilityObservations
namespace SFT.Mathematics.OptimizationSelection
open DiscreteObjects AlgebraOperations GeometryTopology SFT.Foundation.Count.TraceDerivation

abbrev Verdicts := List (String × Bool)
abbrev Preference := List (String × String)

def verdict (rows : Verdicts) (candidate : String) : Option Bool :=
  match rows with
  | [] => none
  | (key,value)::rest => match verdict rest candidate with
    | some result => some result
    | none => if key = candidate then some value else none

def allowed (rows : Verdicts) (candidate : String) : Bool :=
  match verdict rows candidate with
  | none => false
  | some result => result

def verdictKeysMatch (candidates : List String) (rows : Verdicts) : Bool :=
  (rows.map Prod.fst).all (has candidates) && candidates.all (has (rows.map Prod.fst))

def feasibleCarrier (candidates : List String) (rows : Verdicts) : Except String (List String) :=
  if candidates.isEmpty || !distinct candidates then
    .error "optimization requires a complete canonical candidate carrier"
  else if !verdictKeysMatch candidates rows then
    .error "every candidate must have one source-bound feasibility verdict"
  else .ok (candidates.filter (allowed rows))

def preferenceValid (feasible : List String) (preferred : Preference) : Bool :=
  preferred.all (fun pair => has feasible pair.1 && has feasible pair.2 && !decide (pair.1 = pair.2))

def retained (feasible : List String) (preferred : Preference) : List String :=
  feasible.filter (fun candidate => !has (preferred.map Prod.snd) candidate)

def undominated (feasible : List String) (preferred : Preference) : Except String (List String) :=
  if feasible.isEmpty then .error "an admitted optimization instance requires a nonempty feasible carrier"
  else if !preferenceValid feasible preferred then .error "preference cells must remain inside the feasible carrier"
  else .ok (retained feasible preferred)

inductive Optimum where
  | unique (candidate : String)
  | retainedClass (tag : String) (candidates : List String)

def classifyOptimum : List String → Optimum
  | [] => .retainedClass "retained-equivalence-class" []
  | candidate :: rest => match rest with
    | [] => .unique candidate
    | next :: tail => .retainedClass "retained-equivalence-class" (candidate :: next :: tail)

def exactOptimum (feasible : List String) (preferred : Preference) : Except String Optimum :=
  match undominated feasible preferred with
  | .error e => .error e
  | .ok held => .ok (classifyOptimum held)

def respectsConstraints (candidate : String) (constraints : List (String × List String)) : Bool :=
  constraints.all (fun row => has row.2 candidate)

theorem verdictLastWins (rows : Verdicts) (key : String) (value : Bool) :
    verdict (rows ++ [(key,value)]) key = some value := by
  induction rows with
  | nil => change (if key = key then some value else none) = some value; rw [ite_eq_left rfl]
  | cons pair rest ih =>
    cases pair with
    | mk k v =>
      change (match verdict (rest ++ [(key,value)]) key with | some r => some r | none => if k = key then some v else none) = _
      rw [ih]

theorem allowedMeaning (rows : Verdicts) (candidate : String) :
    allowed rows candidate = true ↔ verdict rows candidate = some true := by
  unfold allowed
  cases h : verdict rows candidate with
  | none => constructor <;> intro h <;> cases h
  | some v => cases v <;> constructor <;> intro h <;> first | rfl | cases h

theorem verdictKeysMeaning (candidates : List String) (rows : Verdicts) :
    verdictKeysMatch candidates rows = true ↔
      (∀ key, key ∈ rows.map Prod.fst → key ∈ candidates) ∧
      (∀ key, key ∈ candidates → key ∈ rows.map Prod.fst) := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    exact ⟨fun key hk => (hasIff _ _).mp (allTrueAtMember _ _ p.1 key hk),
      fun key hk => (hasIff _ _).mp (allTrueAtMember _ _ p.2 key hk)⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(allTrueIffMembers _ _).mpr (fun key hk => (hasIff _ _).mpr (h.1 key hk)),
      (allTrueIffMembers _ _).mpr (fun key hk => (hasIff _ _).mpr (h.2 key hk))⟩

theorem feasibleMembership (candidates : List String) (rows : Verdicts) (candidate : String) :
    candidate ∈ candidates.filter (allowed rows) ↔ candidate ∈ candidates ∧ verdict rows candidate = some true := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,(allowedMeaning _ _).mp p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(allowedMeaning _ _).mpr h.2⟩

theorem feasibleAdmitted (candidates : List String) (rows : Verdicts)
    (canonical : (candidates.isEmpty || !distinct candidates) = false)
    (keys : verdictKeysMatch candidates rows = true) :
    feasibleCarrier candidates rows = .ok (candidates.filter (allowed rows)) := by
  unfold feasibleCarrier
  rw [canonical,keys]
  rfl

theorem feasibleRejectsCarrier (candidates : List String) (rows : Verdicts)
    (bad : (candidates.isEmpty || !distinct candidates) = true) :
    feasibleCarrier candidates rows = .error "optimization requires a complete canonical candidate carrier" := by
  unfold feasibleCarrier
  rw [bad]
  rfl

theorem feasibleRejectsVerdicts (candidates : List String) (rows : Verdicts)
    (canonical : (candidates.isEmpty || !distinct candidates) = false)
    (keys : verdictKeysMatch candidates rows = false) :
    feasibleCarrier candidates rows = .error "every candidate must have one source-bound feasibility verdict" := by
  unfold feasibleCarrier
  rw [canonical,keys]
  rfl

theorem preferenceMeaning (feasible : List String) (preferred : Preference) :
    preferenceValid feasible preferred = true ↔
      ∀ pair, pair ∈ preferred → pair.1 ∈ feasible ∧ pair.2 ∈ feasible ∧ pair.1 ≠ pair.2 := by
  constructor
  · intro h pair member
    have a := (andTrue _ _).mp (allTrueAtMember _ _ h pair member)
    have b := (andTrue _ _).mp a.1
    refine ⟨(hasIff _ _).mp b.1,(hasIff _ _).mp b.2,?_⟩
    intro same
    rw [decide_eq_true same] at a
    cases a.2
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro pair member
    have p := h pair member
    apply (andTrue _ _).mpr
    refine ⟨(andTrue _ _).mpr ⟨(hasIff _ _).mpr p.1,(hasIff _ _).mpr p.2.1⟩,?_⟩
    rw [decide_eq_false p.2.2]
    rfl

theorem dominatedMembership (preferred : Preference) (candidate : String) :
    candidate ∈ preferred.map Prod.snd ↔ ∃ better, (better,candidate) ∈ preferred := by
  constructor
  · intro h
    obtain ⟨pair,member,same⟩ := memMapPreimage _ _ _ h
    cases pair with
    | mk better worse => cases same; exact ⟨better,member⟩
  · intro ⟨better,member⟩
    exact memMap Prod.snd (better,candidate) preferred member

theorem retainedMembership (feasible : List String) (preferred : Preference) (candidate : String) :
    candidate ∈ retained feasible preferred ↔ candidate ∈ feasible ∧ ∀ better, ¬ (better,candidate) ∈ preferred := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    have absent := (absentIff _ _).mp ((notTrue _).mp p.2)
    exact ⟨p.1,fun better member => absent ((dominatedMembership _ _).mpr ⟨better,member⟩)⟩
  · intro h
    apply (filterMemberIff _ _ _).mpr
    refine ⟨h.1,?_⟩
    have absent : ¬ candidate ∈ preferred.map Prod.snd := by
      intro member
      obtain ⟨better,pair⟩ := (dominatedMembership _ _).mp member
      exact h.2 better pair
    rw [(absentIff _ _).mpr absent]
    rfl

theorem eliminatedWitness (feasible : List String) (preferred : Preference) (candidate : String)
    (valid : preferenceValid feasible preferred = true) (member : candidate ∈ feasible)
    (eliminated : ¬ candidate ∈ retained feasible preferred) :
    ∃ better, better ∈ feasible ∧ (better,candidate) ∈ preferred ∧ better ≠ candidate := by
  cases h : has (preferred.map Prod.snd) candidate with
  | false =>
    have retainedMember : candidate ∈ retained feasible preferred :=
      (filterMemberIff _ _ _).mpr ⟨member,by rw [h]; rfl⟩
    exact False.elim (eliminated retainedMember)
  | true =>
    obtain ⟨better,pair⟩ := (dominatedMembership _ _).mp ((hasIff _ _).mp h)
    have p := (preferenceMeaning _ _).mp valid (better,candidate) pair
    exact ⟨better,p.1,pair,p.2.2⟩

theorem undominatedAdmitted (feasible : List String) (preferred : Preference)
    (nonempty : feasible.isEmpty = false) (valid : preferenceValid feasible preferred = true) :
    undominated feasible preferred = .ok (retained feasible preferred) := by
  unfold undominated
  rw [nonempty,valid]
  rfl

theorem classifyUniqueIff (held : List String) (candidate : String) :
    classifyOptimum held = .unique candidate ↔ held = [candidate] := by
  cases held with
  | nil => constructor <;> intro h <;> cases h
  | cons first rest =>
    cases rest with
    | nil => constructor
             · intro h; cases h; rfl
             · intro h; cases h; rfl
    | cons next tail => constructor <;> intro h <;> cases h

theorem exactOptimumResult (feasible : List String) (preferred : Preference) (held : List String)
    (result : undominated feasible preferred = .ok held) : exactOptimum feasible preferred = .ok (classifyOptimum held) := by
  unfold exactOptimum
  rw [result]

theorem constraintsMeaning (candidate : String) (constraints : List (String × List String)) :
    respectsConstraints candidate constraints = true ↔ ∀ row, row ∈ constraints → candidate ∈ row.2 := by
  constructor
  · intro h row member
    exact (hasIff _ _).mp (allTrueAtMember _ _ h row member)
  · intro h
    exact (allTrueIffMembers _ _).mpr (fun row member => (hasIff _ _).mpr (h row member))

end SFT.Mathematics.OptimizationSelection
