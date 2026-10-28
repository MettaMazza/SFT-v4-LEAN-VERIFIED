import SFT.InformationScience.EntropyLedger
namespace SFT.InformationScience.MutualObservation
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.ProbabilityIndependence
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement

def supportValid (support : List String) : Bool := !support.isEmpty && distinct support

def mapValid (support : List String) (observation : Observation) : Bool :=
  distinct (observation.map Prod.fst) && keysMatch support observation

def validateObservation (support : List String) (observation : Observation) : Except String Observation :=
  if supportValid support then
    if mapValid support observation then .ok observation
    else .error "ValueError: an observation must classify every support form exactly once"
  else .error "ValueError: information incidence requires complete duplicate-free support"

def observationClasses (support : List String) (observation : Observation) : Except String (List (String × List String)) :=
  match validateObservation support observation with
  | .error e => .error e
  | .ok images => .ok (classRows support images)

def labels (support : List String) (observation : Observation) : List String :=
  firstLabels (observedValues observation support)

def jointMembers (support : List String) (left right : Observation) (a b : String) : List String :=
  support.filter (fun state => belongs left a state && belongs right b state)

def conditionalMembers (support : List String) (targetMap givenMap : Observation) (a b : String) : List String :=
  (fibre support givenMap a).filter (belongs targetMap b)

def labelPairs (support : List String) (left right : Observation) : List (String × String) :=
  (labels support left).flatMap (fun a => (labels support right).map (fun b => (a,b)))

theorem supportMeaning (support : List String) : supportValid support = true ↔
    support.isEmpty = false ∧ distinct support = true := by
  constructor
  · intro h; have p := (andTrue _ _).mp h; exact ⟨(notTrue _).mp p.1,p.2⟩
  · intro h; exact (andTrue _ _).mpr ⟨(notTrue _).mpr h.1,h.2⟩

theorem mapMeaning (support : List String) (observation : Observation) : mapValid support observation = true ↔
    distinct (observation.map Prod.fst) = true ∧ keysMatch support observation = true := andTrue _ _

theorem validationMeaning (support : List String) (observation result : Observation) :
    validateObservation support observation = .ok result ↔
      supportValid support = true ∧ mapValid support observation = true ∧ result = observation := by
  unfold validateObservation
  cases a : supportValid support <;> cases b : mapValid support observation
  all_goals constructor
  all_goals intro h
  all_goals try { cases h }
  all_goals try { cases h.1 }
  all_goals try { cases h.2.1 }
  · exact ⟨rfl,rfl,(Except.ok.inj h).symm⟩
  · rw [h.2.2]; rfl

theorem partitionValidity (support : List String) (observation result : Observation)
    (h : validateObservation support observation = .ok result) : EntropyPartition.partitionValid support observation = true := by
  have p := (validationMeaning _ _ _).mp h
  have s := (supportMeaning _).mp p.1
  have m := (mapMeaning _ _).mp p.2.1
  exact (EntropyPartition.validityMeaning _ _).mpr ⟨s.1,s.2,m.1,m.2⟩

theorem validationFromPartition (support : List String) (observation : Observation)
    (h : EntropyPartition.partitionValid support observation = true) : validateObservation support observation = .ok observation := by
  have p := (EntropyPartition.validityMeaning _ _).mp h
  exact (validationMeaning _ _ _).mpr ⟨(supportMeaning _).mpr ⟨p.1,p.2.1⟩,(mapMeaning _ _).mpr p.2.2,rfl⟩

theorem classesMeaning (support : List String) (observation : Observation) (rows : List (String × List String)) :
    observationClasses support observation = .ok rows ↔
      EntropyPartition.partitionValid support observation = true ∧ rows = classRows support observation := by
  unfold observationClasses
  cases hv : validateObservation support observation with
  | error e =>
    constructor
    · intro h; cases h
    · intro h; have yes := validationFromPartition _ _ h.1; rw [hv] at yes; cases yes
  | ok result =>
    have p := (validationMeaning _ _ _).mp hv
    rw [p.2.2]
    constructor
    · intro h; exact ⟨partitionValidity _ _ _ hv,(Except.ok.inj h).symm⟩
    · intro h; rw [h.2]

theorem classesPartition (support : List String) (observation : Observation) (rows : List (String × List String))
    (h : observationClasses support observation = .ok rows) : EntropyPartition.exactPartition support observation = .ok rows := by
  have p := (classesMeaning _ _ _).mp h
  rw [p.2]
  exact EntropyPartition.partitionExists _ _ p.1

theorem classMembership (support : List String) (observation : Observation) (rows : List (String × List String))
    (h : observationClasses support observation = .ok rows) (label : String) (members : List String) :
    (label,members) ∈ rows ↔ (∃ state, state ∈ support ∧ image observation state = some label) ∧
      members = fibre support observation label :=
  EntropyPartition.partitionMembership _ _ _ (classesPartition _ _ _ h) _ _

theorem classNonempty (support : List String) (observation : Observation) (rows : List (String × List String))
    (h : observationClasses support observation = .ok rows) (label : String) (members : List String)
    (hm : (label,members) ∈ rows) : ∃ state, state ∈ members :=
  EntropyPartition.partitionNonemptyClass _ _ _ (classesPartition _ _ _ h) _ _ hm

theorem classesCover (support : List String) (observation : Observation) (rows : List (String × List String))
    (h : observationClasses support observation = .ok rows) (state : String) (hm : state ∈ support) :
    ∃ label members, (label,members) ∈ rows ∧ state ∈ members :=
  EntropyPartition.partitionCovers _ _ _ (classesPartition _ _ _ h) _ hm

theorem classesDisjoint (support : List String) (observation : Observation) (rows : List (String × List String))
    (h : observationClasses support observation = .ok rows) (a b : String) (xs ys : List String)
    (hx : (a,xs) ∈ rows) (hy : (b,ys) ∈ rows) (state : String) (sx : state ∈ xs) (sy : state ∈ ys) : a = b :=
  EntropyPartition.partitionDisjoint _ _ _ (classesPartition _ _ _ h) _ _ _ _ hx hy _ sx sy

theorem labelsMeaning (support : List String) (observation : Observation) (label : String) :
    label ∈ labels support observation ↔ ∃ state, state ∈ support ∧ image observation state = some label := by
  constructor
  · intro h; exact (observedMembership _ _ _).mp ((firstLabelsMembership _ _).mp h)
  · intro h; exact (firstLabelsMembership _ _).mpr ((observedMembership _ _ _).mpr h)

theorem labelsDistinct (support : List String) (observation : Observation) : distinct (labels support observation) = true :=
  firstLabelsDistinct _

theorem jointMembership (support : List String) (left right : Observation) (a b state : String) :
    state ∈ jointMembers support left right a b ↔
      state ∈ support ∧ image left state = some a ∧ image right state = some b := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    have q := (andTrue _ _).mp p.2
    exact ⟨p.1,(belongsMeaning _ _ _).mp q.1,(belongsMeaning _ _ _).mp q.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(andTrue _ _).mpr
      ⟨(belongsMeaning _ _ _).mpr h.2.1,(belongsMeaning _ _ _).mpr h.2.2⟩⟩

theorem conditionalMembership (support : List String) (targetMap givenMap : Observation) (a b state : String) :
    state ∈ conditionalMembers support targetMap givenMap a b ↔
      state ∈ support ∧ image givenMap state = some a ∧ image targetMap state = some b := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    have q := (fibreMembership _ _ _ _).mp p.1
    exact ⟨q.1,q.2,(belongsMeaning _ _ _).mp p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨(fibreMembership _ _ _ _).mpr ⟨h.1,h.2.1⟩,(belongsMeaning _ _ _).mpr h.2.2⟩

theorem pairsMembership (support : List String) (left right : Observation) (a b : String) :
    (a,b) ∈ labelPairs support left right ↔ a ∈ labels support left ∧ b ∈ labels support right := by
  constructor
  · intro h
    obtain ⟨first,hf,hm⟩ := memFlatMapOrigin _ _ _ h
    obtain ⟨second,hs,eq⟩ := memMapPreimage (fun second => (first,second)) (a,b) _ hm
    cases eq; exact ⟨hf,hs⟩
  · intro h
    exact memFlatMap _ _ a _ h.1 (memMap (fun b => (a,b)) b _ h.2)

theorem conditionalCovers (support : List String) (targetMap givenMap : Observation)
    (valid : validateObservation support targetMap = .ok targetMap) (a state : String)
    (inside : state ∈ fibre support givenMap a) :
    ∃ b, b ∈ labels support targetMap ∧ state ∈ conditionalMembers support targetMap givenMap a b := by
  have p := (fibreMembership _ _ _ _).mp inside
  have mapOk := (mapMeaning _ _).mp ((validationMeaning _ _ _).mp valid).2.1
  obtain ⟨b,ht⟩ := admittedImage _ _ mapOk.2 state p.1
  exact ⟨b,(labelsMeaning _ _ _).mpr ⟨state,p.1,ht⟩,(conditionalMembership _ _ _ _ _ _).mpr ⟨p.1,p.2,ht⟩⟩

theorem conditionalDisjoint (support : List String) (targetMap givenMap : Observation) (a b c state : String)
    (hb : state ∈ conditionalMembers support targetMap givenMap a b)
    (hc : state ∈ conditionalMembers support targetMap givenMap a c) : b = c := by
  have p := ((conditionalMembership _ _ _ _ _ _).mp hb).2.2
  have q := ((conditionalMembership _ _ _ _ _ _).mp hc).2.2
  rw [p] at q; cases q; rfl

end SFT.InformationScience.MutualObservation
