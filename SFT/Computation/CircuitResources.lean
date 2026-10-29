import SFT.Computation.CircuitGraph
import SFT.Computation.ExecutionResources
import SFT.Mathematics.CombinatorialSelections
import SFT.Mathematics.GraphExtension
namespace SFT.Computation.CircuitResources
open SFT.Mathematics GraphOperations DiscreteObjects CombinatorialSelections

-- Exhaust the original ordered-selection generator, retaining precisely
-- nonempty original graph paths in the declared dependency order.
def causalTraces (graph : GeneratedGraph) (order : List String) : List (List String) :=
  (rawSelections order).filter (pathIsValid graph)

theorem causalTraceMeaning (graph : GeneratedGraph) (order path : List String) :
    path ∈ causalTraces graph order ↔ HeldChoice order path ∧ pathIsValid graph path = true := by
  constructor
  · intro member
    have both := (filterMemberIff _ _ _).mp member
    exact ⟨(generatedIffHeldChoice _ _).mp both.1,both.2⟩
  · intro both
    exact (filterMemberIff _ _ _).mpr ⟨(generatedIffHeldChoice _ _).mpr both.1,both.2⟩

def longestFrom (best : List String) : List (List String) → List String
  | [] => best
  | path :: rest => longestFrom (if best.length ≤ path.length then path else best) rest

def longestTrace (graph : GeneratedGraph) (order : List String) : Option (List String) :=
  match causalTraces graph order with
  | [] => none
  | first :: rest => some (longestFrom first rest)

theorem longestFromMeaning (first : List String) (rest : List (List String)) :
    longestFrom first rest ∈ first :: rest ∧
      ∀ path, path ∈ first :: rest → path.length ≤ (longestFrom first rest).length := by
  induction rest generalizing first with
  | nil =>
    refine ⟨.head [],?_⟩
    intro path member
    cases member with
    | head => exact Nat.le_refl _
    | tail _ impossible => cases impossible
  | cons next rest ih =>
    by_cases le : first.length ≤ next.length
    · change longestFrom (if first.length ≤ next.length then next else first) rest ∈ first :: next :: rest ∧
        ∀ path, path ∈ first :: next :: rest → path.length ≤ (longestFrom (if first.length ≤ next.length then next else first) rest).length
      rw [ite_eq_left le]
      obtain ⟨member,bound⟩ := ih next
      refine ⟨.tail first member,?_⟩
      intro path held
      cases held with
      | head => exact Nat.le_trans le (bound next (.head _))
      | tail _ held => exact bound path held
    · change longestFrom (if first.length ≤ next.length then next else first) rest ∈ first :: next :: rest ∧
        ∀ path, path ∈ first :: next :: rest → path.length ≤ (longestFrom (if first.length ≤ next.length then next else first) rest).length
      rw [ite_eq_right le]
      obtain ⟨member,bound⟩ := ih first
      have reverse : next.length ≤ first.length := by
        cases Nat.le_total first.length next.length with
        | inl impossible => exact False.elim (le impossible)
        | inr reverse => exact reverse
      refine ⟨?_,?_⟩
      · have lift : ∀ path, path ∈ first :: rest → path ∈ first :: next :: rest := by
          intro path held
          cases held with
          | head => exact .head _
          | tail _ member => exact .tail first (.tail next member)
        exact lift _ member
      · intro path held
        cases held with
        | head => exact bound first (.head _)
        | tail _ held =>
          cases held with
          | head => exact Nat.le_trans reverse (bound first (.head _))
          | tail _ held => exact bound path (.tail first held)

theorem completeLongestTrace (graph : GeneratedGraph) (order witness : List String)
    (ordered : HeldChoice order witness) (valid : pathIsValid graph witness = true) :
    ∃ longest, longestTrace graph order = some longest ∧
      HeldChoice order longest ∧ pathIsValid graph longest = true ∧
      ∀ path, HeldChoice order path → pathIsValid graph path = true → path.length ≤ longest.length := by
  have member := (causalTraceMeaning _ _ _).mpr ⟨ordered,valid⟩
  cases traces : causalTraces graph order with
  | nil => rw [traces] at member; cases member
  | cons first rest =>
    obtain ⟨retained,bound⟩ := longestFromMeaning first rest
    have generated : longestFrom first rest ∈ causalTraces graph order := by rw [traces]; exact retained
    have sound := (causalTraceMeaning _ _ _).mp generated
    refine ⟨longestFrom first rest,?_,sound.1,sound.2,?_⟩
    · unfold longestTrace; rw [traces]
    · intro path orderProof pathProof
      have held := (causalTraceMeaning _ _ _).mpr ⟨orderProof,pathProof⟩
      rw [traces] at held
      exact bound path held

theorem longestRetainsWires (graph : GeneratedGraph) (order longest : List String)
    (found : longestTrace graph order = some longest) :
    (∀ gate, gate ∈ longest → gate ∈ graph.nodes) ∧
      (∀ wire, wire ∈ adjacentPairs longest → wire ∈ graph.edges) := by
  unfold longestTrace at found
  cases traces : causalTraces graph order with
  | nil => rw [traces] at found; cases found
  | cons first rest =>
    rw [traces] at found
    cases Option.some.inj found
    have member : longestFrom first rest ∈ causalTraces graph order := by
      rw [traces]; exact (longestFromMeaning _ _).1
    exact ((pathMeaning _ _).mp ((causalTraceMeaning _ _ _).mp member).2).2

def gateCount (graph : GeneratedGraph) : Nat := graph.nodes.length
def wireCount (graph : GeneratedGraph) : Nat := graph.edges.length

theorem registeredGateWireSupport (nodes : List String) (edges : List Edge)
    (admitted : makeGraph nodes edges = .ok ⟨nodes,edges⟩) :
    distinct nodes = true ∧ distinct edges = true ∧
      ∀ edge, edge ∈ edges → edge.1 ∈ nodes ∧ edge.2 ∈ nodes :=
  ((graphConstructorMeaning _ _).mp admitted).2

theorem sharedIdentityCount (nodes : List String) (first second : List Edge) :
    gateCount ⟨nodes,first⟩ = gateCount ⟨nodes,second⟩ := rfl

theorem gateSuccessor (nodes : List String) (fresh : String) (edges : List Edge) :
    gateCount ⟨nodes ++ [fresh],edges⟩ = gateCount ⟨nodes,edges⟩ + 1 :=
  InputExtent.appendCount _ _

theorem wireComposition (nodes : List String) (left right : List Edge) :
    wireCount ⟨nodes,left ++ right⟩ = wireCount ⟨nodes,left⟩ + wireCount ⟨nodes,right⟩ :=
  InputExtent.appendCount _ _

theorem retainedOrderedTrace (graph : GeneratedGraph) (order path : List String) (fresh : String)
    (prior : path ∈ causalTraces graph order) : path ∈ causalTraces graph (order ++ [fresh]) := by
  have retained := (causalTraceMeaning _ _ _).mp prior
  exact (causalTraceMeaning _ _ _).mpr ⟨.absent _ _ _ retained.1,retained.2⟩

theorem oneGateDepth : longestTrace ⟨["held"],[]⟩ ["held"] = some ["held"] := rfl
end SFT.Computation.CircuitResources
