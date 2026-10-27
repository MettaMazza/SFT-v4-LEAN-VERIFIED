import SFT.Mathematics.DiscreteComposition
import SFT.Mathematics.AlgebraProperties
namespace SFT.Mathematics.GraphOperations
open DiscreteObjects AlgebraOperations

abbrev Edge := String × String
structure GeneratedGraph where
  nodes : List String
  edges : List Edge
  deriving Repr, DecidableEq

def makeGraph (nodes : List String) (edges : List Edge) : Except String GeneratedGraph :=
  if nodes.isEmpty || !distinct nodes then
    .error "ValueError: graph nodes must be a nonempty canonical collection"
  else if !distinct edges then
    .error "ValueError: graph relation cannot repeat an edge"
  else if edges.any (fun edge => !has nodes edge.1 || !has nodes edge.2) then
    .error "ValueError: every edge endpoint must belong to the node carrier"
  else .ok ⟨nodes,edges⟩

def adjacentPairs : List String → List Edge
  | [] => []
  | _::[] => []
  | left::right::rest => (left,right)::adjacentPairs (right::rest)

def pathIsValid (graph : GeneratedGraph) (path : List String) : Bool :=
  !path.isEmpty && path.all (has graph.nodes) && (adjacentPairs path).all (has graph.edges)

def crossingCut (graph : GeneratedGraph) (held : List String) : Except String (List Edge) :=
  if held.isEmpty || held.any (fun node => !has graph.nodes node) then
    .error "ValueError: a cut requires a nonempty held node selection"
  else .ok (graph.edges.filter (fun edge => has held edge.1 != has held edge.2))

def internalBalance (incoming outgoing : List (List String)) : Bool :=
  !incoming.isEmpty && decide (incoming.length = outgoing.length) && distinct incoming && distinct outgoing

theorem graphConstructorResult (nodes : List String) (edges : List Edge) (graph : GeneratedGraph)
    (success : makeGraph nodes edges = .ok graph) : graph = ⟨nodes,edges⟩ := by
  unfold makeGraph at success
  split at success
  · cases success
  · split at success
    · cases success
    · split at success
      · cases success
      · exact (Except.ok.inj success).symm

theorem adjacentPairsZip (path : List String) : adjacentPairs path = path.zip path.tail := by
  induction path with
  | nil => rfl
  | cons left rest ih =>
    cases rest with
    | nil => rfl
    | cons right rest => exact congrArg (List.cons (left,right)) ih

theorem pathMeaning (graph : GeneratedGraph) (path : List String) :
    pathIsValid graph path = true ↔ path.isEmpty = false ∧
      (∀ node, node ∈ path → node ∈ graph.nodes) ∧
      (∀ edge, edge ∈ adjacentPairs path → edge ∈ graph.edges) := by
  have andCheck : ∀ a b : Bool, (a && b) = true ↔ a = true ∧ b = true := by
    intro a b; cases a <;> cases b <;> decide
  constructor
  · intro h
    have checks := (andCheck _ _).mp h
    have first := (andCheck _ _).mp checks.1
    refine ⟨?_, ?_, ?_⟩
    · cases e : path.isEmpty with
      | false => rfl
      | true => rw [e] at first; cases first.1
    · intro node member
      exact (hasIff _ _).mp (allTrueAtMember _ _ first.2 node member)
    · intro edge member
      exact (hasIff _ _).mp (allTrueAtMember _ _ checks.2 edge member)
  · intro h
    unfold pathIsValid
    rw [h.1]
    apply (andCheck _ _).mpr
    refine ⟨?_,(allTrueIffMembers _ _).mpr (fun edge member => (hasIff _ _).mpr (h.2.2 edge member))⟩
    change path.all (has graph.nodes) = true
    exact (allTrueIffMembers _ _).mpr (fun node member => (hasIff _ _).mpr (h.2.1 node member))

theorem emptyPathRejected (graph : GeneratedGraph) : pathIsValid graph [] = false := rfl

theorem identityPathIff (graph : GeneratedGraph) (node : String) :
    pathIsValid graph [node] = true ↔ node ∈ graph.nodes := by
  constructor
  · intro h; exact (pathMeaning graph [node]).mp h |>.2.1 node (List.Mem.head [])
  · intro h
    apply (pathMeaning graph [node]).mpr
    refine ⟨rfl, ?_, ?_⟩
    · intro other member
      cases member with
      | head => exact h
      | tail _ impossible => cases impossible
    · intro edge member; cases member

theorem cutResult (graph : GeneratedGraph) (held : List String) (result : List Edge)
    (success : crossingCut graph held = .ok result) :
    result = graph.edges.filter (fun edge => has held edge.1 != has held edge.2) := by
  unfold crossingCut at success
  split at success
  · cases success
  · exact (Except.ok.inj success).symm

theorem cutMembership (graph : GeneratedGraph) (held : List String) (result : List Edge)
    (success : crossingCut graph held = .ok result) (edge : Edge) :
    edge ∈ result ↔ edge ∈ graph.edges ∧ (has held edge.1 != has held edge.2) = true := by
  rw [cutResult graph held result success]
  exact filterMemberIff _ _ _

theorem balanceMeaning (incoming outgoing : List (List String)) :
    internalBalance incoming outgoing = true ↔ incoming.isEmpty = false ∧
      incoming.length = outgoing.length ∧ distinct incoming = true ∧ distinct outgoing = true := by
  have andCheck : ∀ a b : Bool, (a && b) = true ↔ a = true ∧ b = true := by
    intro a b; cases a <;> cases b <;> decide
  constructor
  · intro h
    have last := (andCheck _ _).mp h
    have middle := (andCheck _ _).mp last.1
    have first := (andCheck _ _).mp middle.1
    refine ⟨?_,of_decide_eq_true first.2,middle.2,last.2⟩
    cases e : incoming.isEmpty with
    | false => rfl
    | true => rw [e] at first; cases first.1
  · intro h
    unfold internalBalance
    rw [h.1,h.2.1,h.2.2.1,h.2.2.2]
    exact (andCheck _ _).mpr ⟨(andCheck _ _).mpr ⟨(andCheck _ _).mpr ⟨rfl,decide_eq_true rfl⟩,rfl⟩,rfl⟩

theorem adjacentPairsComposition (prefixNodes : List String) (node : String) (suffixNodes : List String) :
    adjacentPairs (prefixNodes ++ node::suffixNodes) =
      adjacentPairs (prefixNodes ++ [node]) ++ adjacentPairs (node::suffixNodes) := by
  induction prefixNodes with
  | nil => rfl
  | cons first rest ih =>
    cases rest with
    | nil => rfl
    | cons second rest => exact congrArg (List.cons (first,second)) ih

theorem pathCompositionIff (graph : GeneratedGraph) (prefixNodes suffixNodes : List String) (node : String) :
    pathIsValid graph (prefixNodes ++ node::suffixNodes) = true ↔
      pathIsValid graph (prefixNodes ++ [node]) = true ∧ pathIsValid graph (node::suffixNodes) = true := by
  have leftNonempty : (prefixNodes ++ [node]).isEmpty = false := by cases prefixNodes <;> rfl
  have wholeNonempty : (prefixNodes ++ node::suffixNodes).isEmpty = false := by cases prefixNodes <;> rfl
  have firstIn : ∀ item, item ∈ prefixNodes ++ [node] → item ∈ prefixNodes ++ node::suffixNodes := by
    intro item hi
    cases SFT.Foundation.Count.TraceDerivation.memAppendCases item prefixNodes [node] hi with
    | inl h => exact SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ h
    | inr h =>
      cases h with
      | head => exact SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ (List.Mem.head _)
      | tail _ h => cases h
  constructor
  · intro passed
    have meaning := (pathMeaning graph _).mp passed
    constructor
    · apply (pathMeaning graph _).mpr
      refine ⟨leftNonempty,fun item hi => meaning.2.1 item (firstIn item hi),?_⟩
      intro edge hi
      apply meaning.2.2 edge
      rw [adjacentPairsComposition]
      exact SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ hi
    · apply (pathMeaning graph _).mpr
      refine ⟨rfl,?_,?_⟩
      · intro item hi
        exact meaning.2.1 item (SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ hi)
      · intro edge hi
        apply meaning.2.2 edge
        rw [adjacentPairsComposition]
        exact SFT.Foundation.Count.TraceDerivation.memAppendRight _ _ _ hi
  · intro passed
    have left := (pathMeaning graph _).mp passed.1
    have right := (pathMeaning graph _).mp passed.2
    apply (pathMeaning graph _).mpr
    refine ⟨wholeNonempty,?_,?_⟩
    · intro item hi
      cases SFT.Foundation.Count.TraceDerivation.memAppendCases item prefixNodes (node::suffixNodes) hi with
      | inl h => exact left.2.1 item (SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ h)
      | inr h => exact right.2.1 item h
    · intro edge hi
      rw [adjacentPairsComposition] at hi
      cases SFT.Foundation.Count.TraceDerivation.memAppendCases edge _ _ hi with
      | inl h => exact left.2.2 edge h
      | inr h => exact right.2.2 edge h

end SFT.Mathematics.GraphOperations
