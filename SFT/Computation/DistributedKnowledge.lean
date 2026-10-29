import SFT.Computation.CausalProvenance
import SFT.InformationScience.MutualExtension
namespace SFT.Computation.DistributedKnowledge
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Mathematics.ProbabilityObservations
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
open CausalClosure CausalTermination

structure Observer where
  identity : String
  observation : Observation

structure Model where
  executions : List String
  observers : List Observer

def admitted (m : Model) : Bool :=
  SFT.InformationScience.MutualObservation.supportValid m.executions &&
  m.observers.all (fun o => SFT.InformationScience.MutualObservation.mapValid m.executions o.observation)

def localClass (support : List String) (o : Observer) (actual : String) : List String :=
  support.filter (fun other => decide (image o.observation actual = image o.observation other))

def individual (support : List String) (o : Observer) (actual : String) (truth : List String) : Bool :=
  (localClass support o actual).all (has truth)

theorem localClassMeaning (support : List String) (o : Observer) (actual other : String) :
    other ∈ localClass support o actual ↔ other ∈ support ∧ image o.observation actual = image o.observation other := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h; exact ⟨p.1,of_decide_eq_true p.2⟩
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,decide_eq_true h.2⟩

theorem individualMeaning (support : List String) (o : Observer) (actual : String) (truth : List String) :
    individual support o actual truth = true ↔ ∀ other, other ∈ localClass support o actual → other ∈ truth := by
  constructor
  · intro h other held; exact (hasIff _ _).mp (allTrueAtMember _ _ h other held)
  · intro h; exact (allTrueIffMembers _ _).mpr (fun other held => (hasIff _ _).mpr (h other held))

theorem individualTruth (support : List String) (o : Observer) (actual : String) (truth : List String)
    (held : actual ∈ support) (known : individual support o actual truth = true) : actual ∈ truth :=
  (individualMeaning _ _ _ _).mp known actual ((localClassMeaning _ _ _ _).mpr ⟨held,rfl⟩)

theorem sameObservationKnowledge (support : List String) (o : Observer) (a b : String) (truth : List String)
    (same : image o.observation a = image o.observation b) :
    individual support o a truth = true ↔ individual support o b truth = true := by
  constructor
  · intro h; apply (individualMeaning _ _ _ _).mpr
    intro other held; have p := (localClassMeaning _ _ _ _).mp held
    exact (individualMeaning _ _ _ _).mp h other ((localClassMeaning _ _ _ _).mpr ⟨p.1,same.trans p.2⟩)
  · intro h; apply (individualMeaning _ _ _ _).mpr
    intro other held; have p := (localClassMeaning _ _ _ _).mp held
    exact (individualMeaning _ _ _ _).mp h other ((localClassMeaning _ _ _ _).mpr ⟨p.1,same.symm.trans p.2⟩)

theorem counterexampleRejects (support : List String) (o : Observer) (actual other : String) (truth : List String)
    (possible : other ∈ localClass support o actual) (falseThere : other ∉ truth) :
    individual support o actual truth ≠ true := fun h => falseThere ((individualMeaning _ _ _ _).mp h other possible)

def localEdges (m : Model) : List Edge :=
  (CausalTermination.pairCells m.executions).filter (fun edge => m.observers.any (fun o =>
    decide (image o.observation edge.1 = image o.observation edge.2)))

def identityEdges (m : Model) : List Edge := m.executions.map (fun e => (e,e))
def baseEdges (m : Model) : List Edge := identityEdges m ++ localEdges m

theorem pairSupportMeaning (support : List String) (a b : String) :
    (a,b) ∈ CausalTermination.pairCells support ↔ a ∈ support ∧ b ∈ support := by
  constructor
  · intro h
    obtain ⟨x,hx,inner⟩ := memFlatMapOrigin _ _ _ h
    obtain ⟨y,hy,eq⟩ := memMapPreimage _ _ _ inner
    have xa : x = a := congrArg Prod.fst eq
    have yb : y = b := congrArg Prod.snd eq
    exact ⟨xa ▸ hx,yb ▸ hy⟩
  · intro h; exact pairCellMember _ _ _ h.1 h.2

theorem localEdgeMeaning (m : Model) (a b : String) : (a,b) ∈ localEdges m ↔
    a ∈ m.executions ∧ b ∈ m.executions ∧
    ∃ o, o ∈ m.observers ∧ image o.observation a = image o.observation b := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h
    have q := (pairSupportMeaning _ _ _).mp p.1
    obtain ⟨o,held,same⟩ := (anyTrueIff _ _).mp p.2
    exact ⟨q.1,q.2,o,held,of_decide_eq_true same⟩
  · intro h
    obtain ⟨o,held,same⟩ := h.2.2
    exact (filterMemberIff _ _ _).mpr ⟨(pairSupportMeaning _ _ _).mpr ⟨h.1,h.2.1⟩,
      (anyTrueIff _ _).mpr ⟨o,held,decide_eq_true same⟩⟩

theorem baseSupported (m : Model) (edge : Edge) (held : edge ∈ baseEdges m) :
    edge.1 ∈ m.executions ∧ edge.2 ∈ m.executions := by
  cases memAppendCases _ _ _ held with
  | inl h =>
    obtain ⟨e,he,eq⟩ := memMapPreimage (fun e => (e,e)) edge m.executions h
    cases eq; exact ⟨he,he⟩
  | inr h =>
    have q := (filterMemberIff _ _ _).mp h
    exact (pairSupportMeaning _ _ _).mp q.1

-- Iterate the complete finite relation to its certified fixed point. Its
-- termination measure is missing held pairs, not an imposed depth cutoff.
def commonEdges (m : Model) : List Edge := closeRows (CausalTermination.pairCells m.executions) (baseEdges m)
def commonClass (m : Model) (actual : String) : List String :=
  m.executions.filter (fun other => has (commonEdges m) (actual,other))
def common (m : Model) (actual : String) (truth : List String) : Bool :=
  (commonClass m actual).all (has truth)

theorem commonReachability (m : Model) (a b : String) :
    (a,b) ∈ commonEdges m ↔ Path (baseEdges m) a b :=
  nativeExact _ _ (baseSupported m) _ _

theorem commonIteration (m : Model) : Rounds (CausalTermination.pairCells m.executions) (baseEdges m) (commonEdges m) :=
  nativeRounds _ _

theorem commonStable (m : Model) : Closed (commonEdges m) := nativeClosed _ _ (baseSupported m)

theorem commonClassMeaning (m : Model) (actual other : String) :
    other ∈ commonClass m actual ↔ other ∈ m.executions ∧ Path (baseEdges m) actual other := by
  constructor
  · intro h; have p := (filterMemberIff _ _ _).mp h
    exact ⟨p.1,(commonReachability _ _ _).mp ((hasIff _ _).mp p.2)⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(hasIff _ _).mpr ((commonReachability _ _ _).mpr h.2)⟩

theorem commonMeaning (m : Model) (actual : String) (truth : List String) : common m actual truth = true ↔
    ∀ other, other ∈ m.executions → Path (baseEdges m) actual other → other ∈ truth := by
  constructor
  · intro h other held path
    exact (hasIff _ _).mp (allTrueAtMember _ _ h other ((commonClassMeaning _ _ _).mpr ⟨held,path⟩))
  · intro h
    apply (allTrueIffMembers _ _).mpr
    intro other held; have p := (commonClassMeaning _ _ _).mp held
    exact (hasIff _ _).mpr (h other p.1 p.2)

theorem commonTruth (m : Model) (actual : String) (truth : List String)
    (held : actual ∈ m.executions) (known : common m actual truth = true) : actual ∈ truth :=
  (commonMeaning _ _ _).mp known actual held (.edge _ _ (memAppendLeft _ _ _
    (memMap (fun e => (e,e)) actual _ held)))

theorem commonImpliesIndividual (m : Model) (o : Observer) (observerHeld : o ∈ m.observers)
    (actual : String) (truth : List String) (held : actual ∈ m.executions)
    (known : common m actual truth = true) : individual m.executions o actual truth = true := by
  apply (individualMeaning _ _ _ _).mpr
  intro other possible; have p := (localClassMeaning _ _ _ _).mp possible
  exact (commonMeaning _ _ _).mp known other p.1 (.edge _ _ (memAppendRight _ _ _
    ((localEdgeMeaning _ _ _).mpr ⟨held,p.1,o,observerHeld,p.2⟩)))

theorem commonPathComposition (m : Model) (a b c : String)
    (first : (a,b) ∈ commonEdges m) (second : (b,c) ∈ commonEdges m) : (a,c) ∈ commonEdges m :=
  commonStable m a b c first second

theorem commonExtension (first second : Model)
    (retained : ∀ edge, edge ∈ baseEdges first → edge ∈ baseEdges second) (a b : String)
    (held : (a,b) ∈ commonEdges first) : (a,b) ∈ commonEdges second :=
  (commonReachability _ _ _).mpr (CausalOperations.pathTransport _ _ retained _ _
    ((commonReachability _ _ _).mp held))

def decision (m : Model) (actual : String) (truth : List String) : Option Bool :=
  if admitted m && has m.executions actual then some (common m actual truth) else none

theorem decisionBoundary (m : Model) (actual : String) (truth : List String) (result : Bool)
    (h : decision m actual truth = some result) : admitted m = true ∧ actual ∈ m.executions := by
  unfold decision at h
  cases valid : admitted m && has m.executions actual with
  | false => rw [valid] at h; cases h
  | true =>
    have p := (andTrue _ _).mp valid
    exact ⟨p.1,(hasIff _ _).mp p.2⟩

theorem admittedMaps (m : Model) (h : admitted m = true) (o : Observer) (held : o ∈ m.observers) :
    SFT.InformationScience.MutualObservation.validateObservation m.executions o.observation = .ok o.observation := by
  have p := (andTrue _ _).mp h
  exact (SFT.InformationScience.MutualObservation.validationMeaning _ _ _).mpr
    ⟨p.1,allTrueAtMember _ _ p.2 o held,rfl⟩

end SFT.Computation.DistributedKnowledge
