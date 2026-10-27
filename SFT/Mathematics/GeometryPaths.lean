import SFT.Mathematics.GeometryDimension
namespace SFT.Mathematics.GeometryTopology
open DiscreteObjects CombinatorialArrangements SFT.Foundation.Count.TraceDerivation

abbrev PathQueue := List (String × List String)

def edgeNeighbor (edge : String × String) (held : String) : Option String :=
  if edge.1 = held then some edge.2 else if edge.2 = held then some edge.1 else none

def unvisitedNeighbors (edges : Boundary) (held : String) (visited : List String) : List String :=
  match edges with
  | [] => []
  | edge :: rest =>
    let tail := unvisitedNeighbors rest held visited
    match edgeNeighbor edge held with
    | none => tail
    | some node => if has visited node then tail else node :: tail

theorem neighborEndpoint (edge : String × String) (held node : String)
    (found : edgeNeighbor edge held = some node) : node = edge.1 ∨ node = edge.2 := by
  unfold edgeNeighbor at found
  split at found
  · cases found; exact Or.inr rfl
  · split at found
    · cases found; exact Or.inl rfl
    · cases found

theorem neighborsSupported (edges : Boundary) (held node : String) (visited : List String)
    (member : node ∈ unvisitedNeighbors edges held visited) :
    ∃ edge, edge ∈ edges ∧ (node = edge.1 ∨ node = edge.2) := by
  induction edges with
  | nil => cases member
  | cons edge rest ih =>
    unfold unvisitedNeighbors at member
    cases found : edgeNeighbor edge held with
    | none =>
      rw [found] at member
      obtain ⟨e,he,same⟩ := ih member
      exact ⟨e,List.Mem.tail edge he,same⟩
    | some n =>
      rw [found] at member
      dsimp only at member
      split at member
      · obtain ⟨e,he,same⟩ := ih member
        exact ⟨e,List.Mem.tail edge he,same⟩
      · cases member with
        | head => exact ⟨edge,List.Mem.head rest,neighborEndpoint edge held node found⟩
        | tail _ hm =>
          obtain ⟨e,he,same⟩ := ih hm
          exact ⟨e,List.Mem.tail edge he,same⟩

def extendQueue (path : List String) (neighbors : List String) : PathQueue :=
  neighbors.map (fun node => (node,path ++ [node]))

structure PathState (edges : Boundary) where
  unseen : List String
  visited : List String
  queue : PathQueue
  queueCovered : ∀ item, item ∈ queue → item.1 ∈ unseen ∨ item.1 ∈ visited
  endpointsCovered : ∀ edge, edge ∈ edges →
    (edge.1 ∈ unseen ∨ edge.1 ∈ visited) ∧ (edge.2 ∈ unseen ∨ edge.2 ∈ visited)

def pathOrder (edges : Boundary) : WellFoundedRelation (PathState edges) :=
  invImage (fun state => (state.unseen.length,state.queue.length)) (Prod.lex Nat.lt_wfRel Nat.lt_wfRel)

def skipPathState (edges : Boundary) (state : PathState edges) (item : String × List String) (rest : PathQueue)
    (queue : state.queue = item :: rest) : PathState edges where
  unseen := state.unseen
  visited := state.visited
  queue := rest
  queueCovered := fun entry h => state.queueCovered entry (queue ▸ List.Mem.tail item h)
  endpointsCovered := state.endpointsCovered

def expandPathState (edges : Boundary) (state : PathState edges) (item : String × List String) (rest : PathQueue)
    (queue : state.queue = item :: rest) : PathState edges where
  unseen := remainder state.unseen item.1
  visited := state.visited ++ [item.1]
  queue := rest ++ extendQueue item.2 (unvisitedNeighbors edges item.1 (state.visited ++ [item.1]))
  queueCovered := by
    intro entry h
    apply GraphOperations.coverageAfterVisit
    cases memAppendCases entry rest _ h with
    | inl prior => exact state.queueCovered entry (queue ▸ List.Mem.tail item prior)
    | inr generated =>
      obtain ⟨node,hn,same⟩ := memMapPreimage (fun node => (node,item.2 ++ [node])) entry _ generated
      cases same
      obtain ⟨edge,he,which⟩ := neighborsSupported edges item.1 node _ hn
      cases which with
      | inl same => rw [same]; exact (state.endpointsCovered edge he).1
      | inr same => rw [same]; exact (state.endpointsCovered edge he).2
  endpointsCovered := fun edge he =>
    ⟨GraphOperations.coverageAfterVisit _ _ _ _ (state.endpointsCovered edge he).1,
     GraphOperations.coverageAfterVisit _ _ _ _ (state.endpointsCovered edge he).2⟩

theorem skipPathDecreases (edges : Boundary) (state : PathState edges) (item : String × List String) (rest : PathQueue)
    (queue : state.queue = item :: rest) :
    (pathOrder edges).rel (skipPathState edges state item rest queue) state := by
  apply Prod.Lex.right
  change rest.length < state.queue.length
  rw [queue]
  exact Nat.lt_succ_self _

theorem expandPathDecreases (edges : Boundary) (state : PathState edges) (item : String × List String) (rest : PathQueue)
    (queue : state.queue = item :: rest) (fresh : has state.visited item.1 ≠ true) :
    (pathOrder edges).rel (expandPathState edges state item rest queue) state := by
  apply Prod.Lex.left
  apply remainderShorter
  cases state.queueCovered item (queue ▸ List.Mem.head rest) with
  | inl h => exact h
  | inr h => exact False.elim (fresh ((hasIff _ _).mpr h))

def pathBody (edges : Boundary) (target : String) (state : PathState edges)
    (recur : (next : PathState edges) → (pathOrder edges).rel next state → Option (List String)) : Option (List String) :=
  match queue : state.queue with
  | [] => none
  | item :: rest =>
    if seen : has state.visited item.1 = true then
      recur (skipPathState edges state item rest queue) (skipPathDecreases edges state item rest queue)
    else
      if has (unvisitedNeighbors edges item.1 (state.visited ++ [item.1])) target then some (item.2 ++ [target])
      else recur (expandPathState edges state item rest queue) (expandPathDecreases edges state item rest queue seen)

def pathLoop (edges : Boundary) (target : String) : PathState edges → Option (List String) :=
  (pathOrder edges).wf.fix (pathBody edges target)

theorem pathLoopEquation (edges : Boundary) (target : String) (state : PathState edges) :
    pathLoop edges target state = pathBody edges target state (fun next _ => pathLoop edges target next) := by
  unfold pathLoop
  rw [WellFounded.fix_eq]

def initialPathState (edges : Boundary) (origin : String) : PathState edges where
  unseen := origin :: (edges.map Prod.fst ++ edges.map Prod.snd)
  visited := []
  queue := [(origin,[origin])]
  queueCovered := by
    intro item h
    cases h with
    | head => exact Or.inl (List.Mem.head _)
    | tail _ h => cases h
  endpointsCovered := fun edge he =>
    ⟨Or.inl (List.Mem.tail origin (memAppendLeft _ _ _ (memMap Prod.fst edge edges he))),
     Or.inl (List.Mem.tail origin (memAppendRight _ _ _ (memMap Prod.snd edge edges he)))⟩

def pathDistance (nodes : List String) (edges : Boundary) (origin target : String) : Except String (Option (List String)) :=
  if has nodes origin && has nodes target then
    if origin = target then .ok (some emptyOne)
    else .ok (pathLoop edges target (initialPathState edges origin))
  else .error "distance endpoints must belong to the generated carrier"

theorem pathDistanceIdentity (nodes : List String) (edges : Boundary) (origin : String)
    (present : has nodes origin = true) : pathDistance nodes edges origin origin = .ok (some emptyOne) := by
  unfold pathDistance
  rw [present]
  rw [ite_eq_left rfl]
  rfl

theorem pathDistanceInvalid (nodes : List String) (edges : Boundary) (origin target : String)
    (invalid : (has nodes origin && has nodes target) = false) :
    pathDistance nodes edges origin target = .error "distance endpoints must belong to the generated carrier" := by
  unfold pathDistance
  rw [invalid]
  rfl

theorem neighborsOccurrence (edges : Boundary) (held node : String) (visited : List String) :
    node ∈ unvisitedNeighbors edges held visited ↔
      (∃ edge, edge ∈ edges ∧ edgeNeighbor edge held = some node) ∧ ¬ node ∈ visited := by
  induction edges with
  | nil =>
    constructor
    · intro h; cases h
    · intro h; obtain ⟨edge,he,_⟩ := h.1; cases he
  | cons edge rest ih =>
    unfold unvisitedNeighbors
    cases found : edgeNeighbor edge held with
    | none =>
      dsimp only
      constructor
      · intro h; obtain ⟨⟨e,he,same⟩,absent⟩ := ih.mp h
        exact ⟨⟨e,List.Mem.tail edge he,same⟩,absent⟩
      · intro h; obtain ⟨e,he,same⟩ := h.1
        cases he with
        | head => rw [found] at same; cases same
        | tail _ he => exact ih.mpr ⟨⟨e,he,same⟩,h.2⟩
    | some n =>
      dsimp only
      by_cases seen : has visited n = true
      · rw [ite_eq_left seen]
        constructor
        · intro h; obtain ⟨⟨e,he,same⟩,absent⟩ := ih.mp h
          exact ⟨⟨e,List.Mem.tail edge he,same⟩,absent⟩
        · intro h; obtain ⟨e,he,same⟩ := h.1
          cases he with
          | head =>
            rw [found] at same
            cases same
            exact False.elim (h.2 ((hasIff _ _).mp seen))
          | tail _ he => exact ih.mpr ⟨⟨e,he,same⟩,h.2⟩
      · rw [ite_eq_right seen]
        constructor
        · intro h
          cases h with
          | head => exact ⟨⟨edge,List.Mem.head rest,found⟩,fun hv => seen ((hasIff _ _).mpr hv)⟩
          | tail _ h =>
            obtain ⟨⟨e,he,same⟩,absent⟩ := ih.mp h
            exact ⟨⟨e,List.Mem.tail edge he,same⟩,absent⟩
        · intro h; obtain ⟨e,he,same⟩ := h.1
          cases he with
          | head => rw [found] at same; cases same; exact List.Mem.head _
          | tail _ he => exact List.Mem.tail _ (ih.mpr ⟨⟨e,he,same⟩,h.2⟩)

theorem edgeNeighborConnects (edge : String × String) (held node : String)
    (found : edgeNeighbor edge held = some node) : edge = (held,node) ∨ edge = (node,held) := by
  cases edge with
  | mk left right =>
    unfold edgeNeighbor at found
    dsimp only at found
    split at found
    · rename_i same
      cases same; cases found; exact Or.inl rfl
    · split at found
      · rename_i same
        cases same; cases found; exact Or.inr rfl
      · cases found

theorem neighborsConnect (edges : Boundary) (held node : String) (visited : List String)
    (member : node ∈ unvisitedNeighbors edges held visited) : (held,node) ∈ edges ∨ (node,held) ∈ edges := by
  obtain ⟨edge,he,found⟩ := ((neighborsOccurrence edges held node visited).mp member).1
  cases edgeNeighborConnects edge held node found with
  | inl same => exact Or.inl (same ▸ he)
  | inr same => exact Or.inr (same ▸ he)

inductive UndirectedTrace (edges : Boundary) (origin : String) : String → List String → Prop where
  | start : UndirectedTrace edges origin origin [origin]
  | step (held next : String) (path : List String)
      (prior : UndirectedTrace edges origin held path)
      (edge : (held,next) ∈ edges ∨ (next,held) ∈ edges) :
      UndirectedTrace edges origin next (path ++ [next])

theorem pathEmpty (edges : Boundary) (target : String) (state : PathState edges)
    (queue : state.queue = []) : pathLoop edges target state = none := by
  cases state with
  | mk unseen visited items covered endpoints =>
    dsimp only at queue
    cases queue
    rw [pathLoopEquation]
    rfl

theorem pathSkip (edges : Boundary) (target : String) (state : PathState edges)
    (item : String × List String) (rest : PathQueue) (queue : state.queue = item :: rest)
    (seen : has state.visited item.1 = true) :
    pathLoop edges target state = pathLoop edges target (skipPathState edges state item rest queue) := by
  cases state with
  | mk unseen visited items covered endpoints =>
    dsimp only at queue
    cases queue
    rw [pathLoopEquation]
    unfold pathBody
    dsimp only
    rw [dite_eq_left seen]

theorem pathHit (edges : Boundary) (target : String) (state : PathState edges)
    (item : String × List String) (rest : PathQueue) (queue : state.queue = item :: rest)
    (fresh : has state.visited item.1 ≠ true)
    (hit : has (unvisitedNeighbors edges item.1 (state.visited ++ [item.1])) target = true) :
    pathLoop edges target state = some (item.2 ++ [target]) := by
  cases state with
  | mk unseen visited items covered endpoints =>
    dsimp only at queue
    cases queue
    rw [pathLoopEquation]
    unfold pathBody
    dsimp only
    rw [dite_eq_right fresh,ite_eq_left hit]

theorem pathExpand (edges : Boundary) (target : String) (state : PathState edges)
    (item : String × List String) (rest : PathQueue) (queue : state.queue = item :: rest)
    (fresh : has state.visited item.1 ≠ true)
    (miss : has (unvisitedNeighbors edges item.1 (state.visited ++ [item.1])) target ≠ true) :
    pathLoop edges target state = pathLoop edges target (expandPathState edges state item rest queue) := by
  cases state with
  | mk unseen visited items covered endpoints =>
    dsimp only at queue
    cases queue
    rw [pathLoopEquation]
    unfold pathBody
    dsimp only
    rw [dite_eq_right fresh,ite_eq_right miss]

theorem pathLoopTrace (edges : Boundary) (origin target : String) (state : PathState edges) :
    (∀ item, item ∈ state.queue → UndirectedTrace edges origin item.1 item.2) →
    ∀ result, pathLoop edges target state = some result → UndirectedTrace edges origin target result := by
  apply (pathOrder edges).wf.induction state
  intro current ih traces result success
  cases queue : current.queue with
  | nil => rw [pathEmpty edges target current queue] at success; cases success
  | cons item rest =>
    have first := traces item (queue ▸ List.Mem.head rest)
    by_cases seen : has current.visited item.1 = true
    · rw [pathSkip edges target current item rest queue seen] at success
      exact ih (skipPathState edges current item rest queue) (skipPathDecreases edges current item rest queue)
        (fun entry h => traces entry (queue ▸ List.Mem.tail item h)) result success
    · by_cases hit : has (unvisitedNeighbors edges item.1 (current.visited ++ [item.1])) target = true
      · rw [pathHit edges target current item rest queue seen hit] at success
        cases success
        exact UndirectedTrace.step item.1 target item.2 first
          (neighborsConnect edges item.1 target _ ((hasIff _ _).mp hit))
      · rw [pathExpand edges target current item rest queue seen hit] at success
        apply ih (expandPathState edges current item rest queue) (expandPathDecreases edges current item rest queue seen)
          ?_ result success
        intro entry h
        cases memAppendCases entry rest _ h with
        | inl h => exact traces entry (queue ▸ List.Mem.tail item h)
        | inr h =>
          obtain ⟨node,hn,same⟩ := memMapPreimage (fun node => (node,item.2 ++ [node])) entry _ h
          cases same
          exact UndirectedTrace.step item.1 node item.2 first (neighborsConnect edges item.1 node _ hn)

theorem pathDistanceTrace (nodes : List String) (edges : Boundary) (origin target : String) (result : List String)
    (different : origin ≠ target) (success : pathDistance nodes edges origin target = .ok (some result)) :
    UndirectedTrace edges origin target result := by
  unfold pathDistance at success
  split at success
  · have found : pathLoop edges target (initialPathState edges origin) = some result := Except.ok.inj success
    apply pathLoopTrace edges origin target (initialPathState edges origin) ?_ result found
    intro item h
    cases h with
    | head => exact UndirectedTrace.start
    | tail _ h => cases h
  · cases success

-- The source returns immediately at the first matching neighbor. Otherwise it
-- appends every extension in edge order, including repeated queue entries.
def scanNeighbors (target : String) (path : List String) : List String → Sum (List String) PathQueue
  | [] => .inr []
  | node :: rest =>
    if node = target then .inl (path ++ [node])
    else match scanNeighbors target path rest with
      | .inl result => .inl result
      | .inr pending => .inr ((node,path ++ [node]) :: pending)

def scanSourceEdges (target held : String) (path visited : List String) : Boundary → Sum (List String) PathQueue
  | [] => .inr []
  | edge :: rest =>
    match edgeNeighbor edge held with
    | none => scanSourceEdges target held path visited rest
    | some node =>
      if has visited node then scanSourceEdges target held path visited rest
      else if node = target then .inl (path ++ [node])
      else match scanSourceEdges target held path visited rest with
        | .inl result => .inl result
        | .inr pending => .inr ((node,path ++ [node]) :: pending)

theorem scanSourceNeighbors (target held : String) (path visited : List String) (edges : Boundary) :
    scanSourceEdges target held path visited edges = scanNeighbors target path (unvisitedNeighbors edges held visited) := by
  induction edges with
  | nil => rfl
  | cons edge rest ih =>
    unfold scanSourceEdges unvisitedNeighbors
    cases found : edgeNeighbor edge held with
    | none => exact ih
    | some node =>
      dsimp only
      by_cases seen : has visited node = true
      · rw [ite_eq_left seen,ite_eq_left seen]; exact ih
      · rw [ite_eq_right seen,ite_eq_right seen]
        unfold scanNeighbors
        rw [ih]

theorem scanNeighborsDecision (target : String) (path : List String) (neighbors : List String) :
    scanNeighbors target path neighbors =
      if has neighbors target then .inl (path ++ [target]) else .inr (extendQueue path neighbors) := by
  induction neighbors with
  | nil => rfl
  | cons node rest ih =>
    unfold scanNeighbors has
    by_cases same : node = target
    · rw [ite_eq_left same,ite_eq_left same]
      cases same
      rfl
    · rw [ite_eq_right same,ite_eq_right same,ih]
      cases hit : has rest target <;> rfl

theorem sourceScanDecision (target held : String) (path visited : List String) (edges : Boundary) :
    scanSourceEdges target held path visited edges =
      if has (unvisitedNeighbors edges held visited) target then .inl (path ++ [target])
      else .inr (extendQueue path (unvisitedNeighbors edges held visited)) :=
  (scanSourceNeighbors target held path visited edges).trans (scanNeighborsDecision target path _)

end SFT.Mathematics.GeometryTopology


