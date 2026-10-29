import SFT.Computation.ReversibilityResources
import SFT.Computation.CircuitResources
namespace SFT.Computation.ParallelResources
open SFT.Mathematics GraphOperations DiscreteObjects CombinatorialSelections
open SFT.Mathematics.GeometryTopology SFT.Mathematics.AlgebraOperations
open SFT.Foundation.Count.TraceDerivation

-- Readiness uses only the declared task graph and completed-task identities.
def Ready (graph : GeneratedGraph) (done : List String) (task : String) : Prop :=
  task ∈ graph.nodes ∧ ¬ task ∈ done ∧
    ∀ predecessor, (predecessor,task) ∈ graph.edges → predecessor ∈ done

def ready (graph : GeneratedGraph) (done : List String) (task : String) : Bool :=
  has graph.nodes task && !has done task &&
    graph.edges.all (fun edge => if edge.2 = task then has done edge.1 else true)

def readySet (graph : GeneratedGraph) (done : List String) : List String :=
  graph.nodes.filter (ready graph done)

theorem readyMeaning (graph : GeneratedGraph) (done : List String) (task : String) :
    ready graph done task = true ↔ Ready graph done task := by
  unfold ready Ready
  constructor
  · intro h
    have all := (andTrue _ _).mp h
    have first := (andTrue _ _).mp all.1
    refine ⟨(hasIff _ _).mp first.1,?_,?_⟩
    · intro held
      have yes := (hasIff _ _).mpr held
      rw [yes] at first
      cases first.2
    · intro predecessor edge
      have checked := allTrueAtMember _ _ all.2 (predecessor,task) edge
      dsimp only at checked
      rw [ite_eq_left rfl] at checked
      exact (hasIff _ _).mp checked
  · intro h
    apply (andTrue _ _).mpr
    refine ⟨(andTrue _ _).mpr ⟨(hasIff _ _).mpr h.1,?_⟩,?_⟩
    · cases flag : has done task with
      | false => rfl
      | true => exact False.elim (h.2.1 ((hasIff _ _).mp flag))
    · apply (allTrueIffMembers _ _).mpr
      intro edge held
      by_cases same : edge.2 = task
      · rw [ite_eq_left same]
        apply (hasIff _ _).mpr
        have row : (edge.1,task) ∈ graph.edges := by rw [← same]; exact held
        exact h.2.2 edge.1 row
      · rw [ite_eq_right same]

theorem completeReadySet (graph : GeneratedGraph) (done : List String) (task : String) :
    task ∈ readySet graph done ↔ Ready graph done task := by
  constructor
  · intro h; exact (readyMeaning _ _ _).mp ((filterMemberIff _ _ _).mp h).2
  · intro h; exact (filterMemberIff _ _ _).mpr ⟨h.1,(readyMeaning _ _ _).mpr h⟩

theorem readyIndependence (graph : GeneratedGraph) (done : List String) (left right : String)
    (one : Ready graph done left) (two : Ready graph done right) :
    ¬ (left,right) ∈ graph.edges := fun edge => one.2.1 (two.2.2 left edge)

def readyChoices (graph : GeneratedGraph) (done : List String) : List (List String) :=
  rawSelections (readySet graph done)

theorem completeReadyChoices (graph : GeneratedGraph) (done layer : List String) :
    layer ∈ readyChoices graph done ↔ HeldChoice (readySet graph done) layer :=
  generatedIffHeldChoice _ _

def synchronizationRows (graph : GeneratedGraph) (layer : List String) : List (String × String) :=
  graph.edges.filter fun edge => has layer edge.2

theorem completeSynchronization (graph : GeneratedGraph) (layer : List String) (edge : String × String) :
    edge ∈ synchronizationRows graph layer ↔ edge ∈ graph.edges ∧ edge.2 ∈ layer := by
  constructor
  · intro h
    have p := (filterMemberIff _ _ _).mp h
    exact ⟨p.1,(hasIff _ _).mp p.2⟩
  · intro h
    exact (filterMemberIff _ _ _).mpr ⟨h.1,(hasIff _ _).mpr h.2⟩

def workTrace : List (List String) → List String
 | [] => []
 | layer :: rest => layer ++ workTrace rest

inductive LayerSchedule (graph : GeneratedGraph) : List String → List (List String) → List String → Prop where
 | identity (done) : LayerSchedule graph done [] done
 | next (done layer : List String) (rest : List (List String)) (result : List String)
     (admitted : layer ∈ readyChoices graph done)
     (later : LayerSchedule graph (done ++ layer) rest result) :
     LayerSchedule graph done (layer :: rest) result

theorem workReconstruction (graph : GeneratedGraph) (done result : List String)
    (layers : List (List String)) (schedule : LayerSchedule graph done layers result) :
    result = done ++ workTrace layers := by
  induction schedule with
  | identity done =>
    change done = done ++ []
    induction done with
    | nil => rfl
    | cons item rest ih => exact congrArg (List.cons item) ih
  | next done layer rest result admitted later ih =>
    rw [ih]
    exact SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _

theorem layerIndependent (graph : GeneratedGraph) (done layer : List String)
    (ready : ∀ task, task ∈ layer → Ready graph done task) (left right : String)
    (one : left ∈ layer) (two : right ∈ layer) : ¬ (left,right) ∈ graph.edges :=
  readyIndependence _ _ _ _ (ready left one) (ready right two)

theorem synchronizationRetained (graph : GeneratedGraph) (done layer : List String)
    (ready : ∀ task, task ∈ layer → Ready graph done task) (edge : String × String)
    (row : edge ∈ synchronizationRows graph layer) : edge.1 ∈ done := by
  have parts := (completeSynchronization _ _ _).mp row
  exact (ready edge.2 parts.2).2.2 edge.1 parts.1

theorem serialSchedule (graph : GeneratedGraph) (start middle finish : List String)
    (first second : List (List String)) (one : LayerSchedule graph start first middle)
    (two : LayerSchedule graph middle second finish) :
    LayerSchedule graph start (first ++ second) finish := by
  induction one with
  | identity => exact two
  | next done layer rest middle admitted later ih => exact .next _ _ _ _ admitted (ih two)

theorem workComposition (first second : List (List String)) :
    workTrace (first ++ second) = workTrace first ++ workTrace second := by
  induction first with
  | nil => rfl
  | cons layer rest ih =>
    change layer ++ workTrace (rest ++ second) = _
    rw [ih]
    exact (SFT.Mathematics.ExactTraceArithmetic.appendAssociative _ _ _).symm

theorem workCost (trace occupied : List String) (ledger : ResourceRecord.Ledger)
    (recorded : ResourceRecord.resourceLedger trace occupied = .ok ledger) :
    ledger.timeTrace.map Prod.snd = trace ∧ ledger.spaceSupport = occupied ∧
      ledger.timeCount = trace.length ∧ ledger.spaceCount = occupied.length :=
  ResourceRecord.recordReconstructs _ _ _ recorded
theorem generatedLayerReady (graph : GeneratedGraph) (done layer : List String)
    (generated : layer ∈ readyChoices graph done) (task : String) (held : task ∈ layer) :
    Ready graph done task :=
  (completeReadySet _ _ _).mp (heldChoiceContained _ _
    ((completeReadyChoices _ _ _).mp generated) task held)

theorem generatedLayerIndependent (graph : GeneratedGraph) (done layer : List String)
    (generated : layer ∈ readyChoices graph done) (left right : String)
    (one : left ∈ layer) (two : right ∈ layer) : ¬ (left,right) ∈ graph.edges :=
  layerIndependent _ _ _ (generatedLayerReady _ _ _ generated) _ _ one two

theorem generatedSynchronization (graph : GeneratedGraph) (done layer : List String)
    (generated : layer ∈ readyChoices graph done) (edge : String × String)
    (row : edge ∈ synchronizationRows graph layer) : edge.1 ∈ done :=
  synchronizationRetained _ _ _ (generatedLayerReady _ _ _ generated) _ row

theorem completeWork (graph : GeneratedGraph) (layers : List (List String))
    (result : List String) (schedule : LayerSchedule graph [] layers result)
    (coverage : ∀ task, task ∈ result ↔ task ∈ graph.nodes) :
    ∀ task, task ∈ workTrace layers ↔ task ∈ graph.nodes := by
  have reconstructed := workReconstruction _ _ _ _ schedule
  change result = workTrace layers at reconstructed
  intro task
  rw [← reconstructed]
  exact coverage task

theorem fullSpan (graph : GeneratedGraph) (layers : List (List String)) (witness : List String)
    (ordered : HeldChoice (workTrace layers) witness) (valid : pathIsValid graph witness = true) :
    ∃ longest, CircuitResources.longestTrace graph (workTrace layers) = some longest ∧
      HeldChoice (workTrace layers) longest ∧ pathIsValid graph longest = true ∧
      ∀ path, HeldChoice (workTrace layers) path → pathIsValid graph path = true →
        path.length ≤ longest.length :=
  CircuitResources.completeLongestTrace _ _ _ ordered valid

theorem retainedLayerSuccessor (graph : GeneratedGraph) (start middle : List String)
    (layers : List (List String)) (layer : List String)
    (prior : LayerSchedule graph start layers middle)
    (generated : layer ∈ readyChoices graph middle) :
    LayerSchedule graph start (layers ++ [layer]) (middle ++ layer) :=
  serialSchedule _ _ _ _ _ _ prior (.next _ _ _ _ generated (.identity _))

theorem oneTaskLayer : LayerSchedule ⟨["held"],[]⟩ [] [["held"]] ["held"] :=
  .next [] ["held"] [] ["held"] (List.Mem.tail [] (List.Mem.head [])) (.identity _)
end SFT.Computation.ParallelResources
