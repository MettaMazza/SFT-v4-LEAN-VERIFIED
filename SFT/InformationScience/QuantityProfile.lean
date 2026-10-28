import SFT.InformationScience.QuantityPairs
import SFT.Mathematics.ProbabilityIndependence
namespace SFT.InformationScience.QuantityProfile
open QuantitySupport QuantityPairs EncodingMaps
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations SFT.Mathematics.GeometryTopology
open SFT.Mathematics.ProbabilityIndependence
open SFT.Foundation.Count.TraceDerivation
abbrev Observation := List (Word × String)
structure Profile where
  supportTrace : List Word
  observationClasses : List String
  retainedDistinctions : List Pair
  closedDistinctions : List Pair

def observationValid (support : List Word) (observation : Observation) : Bool :=
  distinct (observation.map Prod.fst) &&
    (observation.map Prod.fst).all (has support) && support.all (has (observation.map Prod.fst))

def image (observation : Observation) (word : Word) : String := (lookupFirst observation word).getD ""

def retained (observation : Observation) (input : List Pair) : List Pair :=
  input.filter (fun pair => decide (image observation pair.1 ≠ image observation pair.2))

def closed (observation : Observation) (input : List Pair) : List Pair :=
  input.filter (fun pair => decide (image observation pair.1 = image observation pair.2))

def buildProfile (support : List Word) (observation : Observation) (input : List Pair) : Profile :=
  ⟨support,firstLabels (support.map (image observation)),retained observation input,closed observation input⟩

def informationProfile (support : List Word) (observation : Observation) : Except String Profile :=
  if !observationValid support observation then
    .error "ValueError: quantity requires one observation image for every support form"
  else match distinctionPairs support with
    | .error e => .error e
    | .ok input => .ok (buildProfile support observation input)

theorem observationMeaning (support : List Word) (observation : Observation) :
    observationValid support observation = true ↔ distinct (observation.map Prod.fst) = true ∧
      (∀ word, word ∈ observation.map Prod.fst → word ∈ support) ∧
      (∀ word, word ∈ support → word ∈ observation.map Prod.fst) := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have q := (andTrue _ _).mp p.1
    exact ⟨q.1,fun w hw => (hasIff _ _).mp (allTrueAtMember _ _ q.2 w hw),
      fun w hw => (hasIff _ _).mp (allTrueAtMember _ _ p.2 w hw)⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨h.1,
      (allTrueIffMembers _ _).mpr (fun w hw => (hasIff _ _).mpr (h.2.1 w hw))⟩,
      (allTrueIffMembers _ _).mpr (fun w hw => (hasIff _ _).mpr (h.2.2 w hw))⟩

theorem imageOfRow (support : List Word) (observation : Observation)
    (valid : observationValid support observation = true) (word : Word) (label : String)
    (row : (word,label) ∈ observation) : image observation word = label := by
  unfold image
  rw [lookupUnique _ _ _ ((observationMeaning _ _).mp valid).1 row]
  rfl

theorem imageExists (support : List Word) (observation : Observation)
    (valid : observationValid support observation = true) (word : Word) (member : word ∈ support) :
    ∃ label, lookupFirst observation word = some label ∧ (word,label) ∈ observation ∧ image observation word = label := by
  obtain ⟨label,hl⟩ := (lookupDefined _ _).mpr (((observationMeaning _ _).mp valid).2.2 word member)
  exact ⟨label,hl,lookupRow _ _ _ hl,by unfold image; rw [hl]; rfl⟩

theorem profileData (support : List Word) (observation : Observation) (result : Profile)
    (h : informationProfile support observation = .ok result) :
    observationValid support observation = true ∧ support.isEmpty = false ∧ distinct support = true ∧
      result = buildProfile support observation (pairs support) := by
  unfold informationProfile at h
  cases valid : observationValid support observation with
  | false => rw [valid] at h; cases h
  | true =>
    rw [valid] at h
    change (match distinctionPairs support with | .error e => .error e | .ok input => .ok (buildProfile support observation input) : Except String Profile) = .ok result at h
    cases hp : distinctionPairs support with
    | error e => rw [hp] at h; cases h
    | ok input =>
      rw [hp] at h
      cases h
      have p := acceptedPairs _ _ hp
      rw [p.2.2]
      exact ⟨rfl,p.1,p.2.1,rfl⟩

theorem profileExists (support : List Word) (observation : Observation)
    (valid : observationValid support observation = true) (nonempty : support.isEmpty = false)
    (unique : distinct support = true) :
    informationProfile support observation = .ok (buildProfile support observation (pairs support)) := by
  unfold informationProfile
  rw [valid,admittedPairs _ nonempty unique]
  rfl

theorem retainedMembership (observation : Observation) (input : List Pair) (pair : Pair) :
    pair ∈ retained observation input ↔ pair ∈ input ∧ image observation pair.1 ≠ image observation pair.2 := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem closedMembership (observation : Observation) (input : List Pair) (pair : Pair) :
    pair ∈ closed observation input ↔ pair ∈ input ∧ image observation pair.1 = image observation pair.2 := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem partitionDisjoint (observation : Observation) (input : List Pair) (pair : Pair)
    (hr : pair ∈ retained observation input) (hc : pair ∈ closed observation input) : False :=
  ((retainedMembership _ _ _).mp hr).2 ((closedMembership _ _ _).mp hc).2

theorem partitionComplete (observation : Observation) (input : List Pair) (pair : Pair) :
    pair ∈ input ↔ pair ∈ retained observation input ∨ pair ∈ closed observation input := by
  constructor
  · intro h
    by_cases same : image observation pair.1 = image observation pair.2
    · exact Or.inr ((closedMembership _ _ _).mpr ⟨h,same⟩)
    · exact Or.inl ((retainedMembership _ _ _).mpr ⟨h,same⟩)
  · intro h
    cases h with
    | inl h => exact ((retainedMembership _ _ _).mp h).1
    | inr h => exact ((closedMembership _ _ _).mp h).1

theorem classMembership (support : List Word) (observation : Observation) (label : String) :
    label ∈ (buildProfile support observation (pairs support)).observationClasses ↔
      ∃ word, word ∈ support ∧ image observation word = label := by
  constructor
  · intro h
    exact memMapPreimage (image observation) label support ((firstLabelsMembership _ _).mp h)
  · intro ⟨word,hw,eq⟩
    apply (firstLabelsMembership _ _).mpr
    rw [← eq]; exact memMap (image observation) word support hw

theorem classLabelsDistinct (support : List Word) (observation : Observation) :
    distinct (buildProfile support observation (pairs support)).observationClasses = true := firstLabelsDistinct _

theorem profilePartition (support : List Word) (observation : Observation) (result : Profile)
    (h : informationProfile support observation = .ok result) (pair : Pair) :
    (pair ∈ pairs support ↔ pair ∈ result.retainedDistinctions ∨ pair ∈ result.closedDistinctions) ∧
      ¬ (pair ∈ result.retainedDistinctions ∧ pair ∈ result.closedDistinctions) := by
  rw [(profileData _ _ _ h).2.2.2]
  exact ⟨partitionComplete _ _ _,fun h => partitionDisjoint _ _ _ h.1 h.2⟩

theorem fineRetainsPair (support : List Word) (observation : Observation) (unique : distinct support = true)
    (fine : ∀ a b, a ∈ support → b ∈ support → image observation a = image observation b → a = b)
    (pair : Pair) (hm : pair ∈ pairs support) : pair ∈ retained observation (pairs support) := by
  have ends := pairSources support pair.1 pair.2 hm
  exact (retainedMembership _ _ _).mpr ⟨hm,fun eq => pairDifferent _ unique _ _ hm
    (fine pair.1 pair.2 ends.1 ends.2 eq)⟩

theorem fineClosesNone (support : List Word) (observation : Observation) (unique : distinct support = true)
    (fine : ∀ a b, a ∈ support → b ∈ support → image observation a = image observation b → a = b)
    (pair : Pair) : ¬ pair ∈ closed observation (pairs support) := by
  intro h
  have member := ((closedMembership _ _ _).mp h).1
  exact partitionDisjoint _ _ _ (fineRetainsPair _ _ unique fine _ member) h

theorem coarseningPreservesClosed (fine coarse : Observation) (input : List Pair) (merge : String → String)
    (compatible : ∀ pair, pair ∈ input →
      image coarse pair.1 = merge (image fine pair.1) ∧ image coarse pair.2 = merge (image fine pair.2))
    (pair : Pair) (h : pair ∈ closed fine input) : pair ∈ closed coarse input := by
  have p := (closedMembership _ _ _).mp h
  have q := compatible pair p.1
  apply (closedMembership _ _ _).mpr
  refine ⟨p.1,?_⟩
  rw [q.1,q.2,p.2]

theorem coarseningOnlyLoses (fine coarse : Observation) (input : List Pair) (merge : String → String)
    (compatible : ∀ pair, pair ∈ input →
      image coarse pair.1 = merge (image fine pair.1) ∧ image coarse pair.2 = merge (image fine pair.2))
    (pair : Pair) (h : pair ∈ retained coarse input) : pair ∈ retained fine input := by
  have p := (retainedMembership _ _ _).mp h
  apply (retainedMembership _ _ _).mpr
  refine ⟨p.1,?_⟩
  intro eq
  have q := compatible pair p.1
  exact p.2 (q.1.trans ((congrArg merge eq).trans q.2.symm))

end SFT.InformationScience.QuantityProfile
