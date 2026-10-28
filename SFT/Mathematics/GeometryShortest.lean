import SFT.Mathematics.GeometryPaths
namespace SFT.Mathematics.GeometryTopology
open DiscreteObjects SFT.Foundation.Count.TraceDerivation

def QueueBound (queue : PathQueue) (node : String) (bound : Nat) : Prop :=
  ∃ item, item ∈ queue ∧ item.1 = node ∧ item.2.length ≤ bound

def QueueOrdered : PathQueue → Prop
  | [] => True
  | first :: rest => (∀ item, item ∈ rest → first.2.length ≤ item.2.length) ∧ QueueOrdered rest

def QueueWidth (queue : PathQueue) : Prop :=
  ∀ left right, left ∈ queue → right ∈ queue → right.2.length ≤ left.2.length + 1

def OriginCovered (origin : String) (visited : List String) (queue : PathQueue) : Prop :=
  origin ∈ visited ∨ QueueBound queue origin 1

def VisitedBound (edges : Boundary) (origin : String) (visited : List String) (queue : PathQueue) : Prop :=
  ∀ held, held ∈ visited → ∀ path, UndirectedTrace edges origin held path →
    ∀ node, ((held,node) ∈ edges ∨ (node,held) ∈ edges) →
      node ∈ visited ∨ QueueBound queue node (path.length + 1)

theorem neighborFromConnection (edges : Boundary) (held node : String)
    (edge : (held,node) ∈ edges ∨ (node,held) ∈ edges) :
    ∃ e, e ∈ edges ∧ edgeNeighbor e held = some node := by
  cases edge with
  | inl h =>
    refine ⟨(held,node),h,?_⟩
    unfold edgeNeighbor
    rw [ite_eq_left rfl]
  | inr h =>
    refine ⟨(node,held),h,?_⟩
    unfold edgeNeighbor
    by_cases same : node = held
    · cases same; rw [ite_eq_left rfl]
    · rw [ite_eq_right same,ite_eq_left rfl]

theorem connectionEnqueued (edges : Boundary) (held node : String) (visited : List String)
    (edge : (held,node) ∈ edges ∨ (node,held) ∈ edges) (absent : ¬ node ∈ visited) :
    node ∈ unvisitedNeighbors edges held visited :=
  (neighborsOccurrence edges held node visited).mpr ⟨neighborFromConnection edges held node edge,absent⟩

theorem frontierLower (edges : Boundary) (origin : String) (visited : List String) (queue : PathQueue)
    (root : OriginCovered origin visited queue) (closed : VisitedBound edges origin visited queue)
    (node : String) (path : List String) (trace : UndirectedTrace edges origin node path) :
    (¬ node ∈ visited) → ∃ item, item ∈ queue ∧ item.2.length ≤ path.length := by
  induction trace with
  | start =>
    intro absent
    cases root with
    | inl h => exact False.elim (absent h)
    | inr h => obtain ⟨item,hi,_,bound⟩ := h; exact ⟨item,hi,bound⟩
  | step held next priorPath prior edge ih =>
    intro absent
    by_cases seen : has visited held = true
    · cases closed held ((hasIff _ _).mp seen) priorPath prior next edge with
      | inl h => exact False.elim (absent h)
      | inr h =>
        obtain ⟨item,hi,_,bound⟩ := h
        exact ⟨item,hi,by simpa only [SFT.Foundation.CommonRefinement.appendLength,List.length_cons,List.length_nil] using bound⟩
    · obtain ⟨item,hi,bound⟩ := ih (fun h => seen ((hasIff _ _).mpr h))
      refine ⟨item,hi,?_⟩
      rw [SFT.Foundation.CommonRefinement.appendLength]
      exact Nat.le_trans bound (Nat.le_add_right _ _)

theorem frontierStrict (edges : Boundary) (origin : String) (visited : List String) (queue : PathQueue)
    (root : OriginCovered origin visited queue) (closed : VisitedBound edges origin visited queue)
    (target : String) (path : List String) (trace : UndirectedTrace edges origin target path)
    (absent : ¬ target ∈ visited) (notQueued : ∀ item, item ∈ queue → item.1 ≠ target) :
    ∃ item, item ∈ queue ∧ item.2.length + 1 ≤ path.length := by
  cases trace with
  | start =>
    cases root with
    | inl h => exact False.elim (absent h)
    | inr h => obtain ⟨item,hi,same,_⟩ := h; exact False.elim (notQueued item hi same)
  | step held next priorPath prior edge =>
    by_cases seen : has visited held = true
    · cases closed held ((hasIff _ _).mp seen) priorPath prior target edge with
      | inl h => exact False.elim (absent h)
      | inr h => obtain ⟨item,hi,same,_⟩ := h; exact False.elim (notQueued item hi same)
    · obtain ⟨item,hi,bound⟩ := frontierLower edges origin visited queue root closed held priorPath prior
        (fun h => seen ((hasIff _ _).mpr h))
      refine ⟨item,hi,?_⟩
      rw [SFT.Foundation.CommonRefinement.appendLength]
      exact Nat.add_le_add_right bound 1

theorem orderedHeadBound (first : String × List String) (rest : PathQueue)
    (ordered : QueueOrdered (first :: rest)) (item : String × List String) (member : item ∈ first :: rest) :
    first.2.length ≤ item.2.length := by
  cases member with
  | head => exact Nat.le_refl _
  | tail _ h => exact ordered.1 item h

theorem freshHeadMinimal (edges : Boundary) (origin : String) (visited : List String)
    (first : String × List String) (rest : PathQueue)
    (root : OriginCovered origin visited (first :: rest))
    (closed : VisitedBound edges origin visited (first :: rest)) (ordered : QueueOrdered (first :: rest))
    (fresh : ¬ first.1 ∈ visited) (path : List String) (trace : UndirectedTrace edges origin first.1 path) :
    first.2.length ≤ path.length := by
  obtain ⟨item,hi,bound⟩ := frontierLower edges origin visited (first::rest) root closed first.1 path trace fresh
  exact Nat.le_trans (orderedHeadBound first rest ordered item hi) bound

theorem skipRetainsBound (visited : List String) (first : String × List String) (rest : PathQueue)
    (seen : first.1 ∈ visited) (node : String) (bound : Nat)
    (covered : node ∈ visited ∨ QueueBound (first::rest) node bound) :
    node ∈ visited ∨ QueueBound rest node bound := by
  cases covered with
  | inl h => exact Or.inl h
  | inr h =>
    obtain ⟨item,hi,same,short⟩ := h
    cases hi with
    | head => exact Or.inl (same ▸ seen)
    | tail _ h => exact Or.inr ⟨item,h,same,short⟩

theorem expandRetainsBound (visited : List String) (first : String × List String) (rest extra : PathQueue)
    (node : String) (bound : Nat) (covered : node ∈ visited ∨ QueueBound (first::rest) node bound) :
    node ∈ visited ++ [first.1] ∨ QueueBound (rest ++ extra) node bound := by
  cases covered with
  | inl h => exact Or.inl (memAppendLeft _ _ _ h)
  | inr h =>
    obtain ⟨item,hi,same,short⟩ := h
    cases hi with
    | head => exact Or.inl (same ▸ memAppendRight _ _ _ (List.Mem.head []))
    | tail _ h => exact Or.inr ⟨item,memAppendLeft _ _ _ h,same,short⟩

theorem skipPreservesBounds (edges : Boundary) (origin : String) (visited : List String)
    (first : String × List String) (rest : PathQueue) (seen : first.1 ∈ visited)
    (root : OriginCovered origin visited (first::rest))
    (closed : VisitedBound edges origin visited (first::rest)) :
    OriginCovered origin visited rest ∧ VisitedBound edges origin visited rest :=
  ⟨skipRetainsBound visited first rest seen origin 1 root,
   fun held hv path trace node edge => skipRetainsBound visited first rest seen node _ (closed held hv path trace node edge)⟩

theorem expandPreservesBounds (edges : Boundary) (origin : String) (visited : List String)
    (first : String × List String) (rest : PathQueue)
    (root : OriginCovered origin visited (first::rest))
    (closed : VisitedBound edges origin visited (first::rest))
    (ordered : QueueOrdered (first::rest)) (fresh : ¬ first.1 ∈ visited) :
    OriginCovered origin (visited ++ [first.1]) (rest ++ extendQueue first.2 (unvisitedNeighbors edges first.1 (visited ++ [first.1]))) ∧
    VisitedBound edges origin (visited ++ [first.1]) (rest ++ extendQueue first.2 (unvisitedNeighbors edges first.1 (visited ++ [first.1]))) := by
  refine ⟨expandRetainsBound visited first rest _ origin 1 root,?_⟩
  intro held member path trace node edge
  cases memAppendCases held visited [first.1] member with
  | inl old => exact expandRetainsBound visited first rest _ node _ (closed held old path trace node edge)
  | inr new =>
    have same : held = first.1 := by cases new with
                                   | head => rfl
                                   | tail _ h => cases h
    cases same
    by_cases seen : has (visited ++ [first.1]) node = true
    · exact Or.inl ((hasIff _ _).mp seen)
    · refine Or.inr ⟨(node,first.2 ++ [node]),?_,rfl,?_⟩
      · apply memAppendRight
        exact memMap (fun n => (n,first.2 ++ [n])) node _
          (connectionEnqueued edges first.1 node _ edge (fun h => seen ((hasIff _ _).mpr h)))
      · change (first.2 ++ [node]).length ≤ path.length + 1
        rw [SFT.Foundation.CommonRefinement.appendLength]
        exact Nat.add_le_add_right (freshHeadMinimal edges origin visited first rest root closed ordered fresh path trace) 1

theorem extensionLength (path : List String) (nodes : List String) (item : String × List String)
    (member : item ∈ extendQueue path nodes) : item.2.length = path.length + 1 := by
  obtain ⟨node,_,same⟩ := memMapPreimage (fun n => (n,path ++ [n])) item nodes member
  cases same
  exact SFT.Foundation.CommonRefinement.appendLength path [node]

theorem orderedAppend (left right : PathQueue) (leftOrder : QueueOrdered left) (rightOrder : QueueOrdered right)
    (separated : ∀ a b, a ∈ left → b ∈ right → a.2.length ≤ b.2.length) : QueueOrdered (left ++ right) := by
  induction left with
  | nil => exact rightOrder
  | cons first rest ih =>
    refine ⟨?_,ih leftOrder.2 (fun a b ha hb => separated a b (List.Mem.tail first ha) hb)⟩
    intro item member
    cases memAppendCases item rest right member with
    | inl h => exact leftOrder.1 item h
    | inr h => exact separated first item (List.Mem.head rest) h

theorem extensionsOrdered (path : List String) (nodes : List String) : QueueOrdered (extendQueue path nodes) := by
  induction nodes with
  | nil => exact True.intro
  | cons node rest ih =>
    refine ⟨?_,ih⟩
    intro item member
    change (path ++ [node]).length ≤ item.2.length
    rw [extensionLength path rest item member,SFT.Foundation.CommonRefinement.appendLength]
    exact Nat.le_refl _

theorem expandPreservesOrder (first : String × List String) (rest : PathQueue) (nodes : List String)
    (ordered : QueueOrdered (first::rest)) (width : QueueWidth (first::rest)) :
    QueueOrdered (rest ++ extendQueue first.2 nodes) := by
  apply orderedAppend rest _ ordered.2 (extensionsOrdered first.2 nodes)
  intro a b ha hb
  rw [extensionLength first.2 nodes b hb]
  exact width first a (List.Mem.head rest) (List.Mem.tail first ha)

theorem expandPreservesWidth (first : String × List String) (rest : PathQueue) (nodes : List String)
    (ordered : QueueOrdered (first::rest)) (width : QueueWidth (first::rest)) :
    QueueWidth (rest ++ extendQueue first.2 nodes) := by
  intro a b ha hb
  cases memAppendCases a rest _ ha with
  | inl oldA =>
    cases memAppendCases b rest _ hb with
    | inl oldB => exact width a b (List.Mem.tail first oldA) (List.Mem.tail first oldB)
    | inr newB =>
      rw [extensionLength first.2 nodes b newB]
      exact Nat.add_le_add_right (ordered.1 a oldA) 1
  | inr newA =>
    rw [extensionLength first.2 nodes a newA]
    cases memAppendCases b rest _ hb with
    | inl oldB => exact Nat.le_trans (width first b (List.Mem.head rest) (List.Mem.tail first oldB)) (Nat.le_succ _)
    | inr newB => rw [extensionLength first.2 nodes b newB]; exact Nat.le_succ _

theorem pathLoopBound (edges : Boundary) (origin target : String) (state : PathState edges) :
    OriginCovered origin state.visited state.queue →
    VisitedBound edges origin state.visited state.queue →
    QueueOrdered state.queue → QueueWidth state.queue →
    (¬ target ∈ state.visited) →
    (∀ item, item ∈ state.queue → item.1 ≠ target) →
    ∀ path, UndirectedTrace edges origin target path →
      ∃ result, pathLoop edges target state = some result ∧ result.length ≤ path.length := by
  apply (pathOrder edges).wf.induction state
  intro current ih root closed ordered width absent notQueued path trace
  cases queue : current.queue with
  | nil =>
    obtain ⟨item,hi,_⟩ := frontierLower edges origin current.visited current.queue root closed target path trace absent
    rw [queue] at hi
    cases hi
  | cons first rest =>
    rw [queue] at root closed ordered width notQueued
    by_cases seen : has current.visited first.1 = true
    · have bounds := skipPreservesBounds edges origin current.visited first rest ((hasIff _ _).mp seen) root closed
      obtain ⟨result,found,short⟩ := ih (skipPathState edges current first rest queue)
        (skipPathDecreases edges current first rest queue) bounds.1 bounds.2 ordered.2
        (fun a b ha hb => width a b (List.Mem.tail first ha) (List.Mem.tail first hb)) absent
        (fun item h => notQueued item (List.Mem.tail first h)) path trace
      refine ⟨result,?_,short⟩
      rw [pathSkip edges target current first rest queue seen]
      exact found
    · have fresh : ¬ first.1 ∈ current.visited := fun h => seen ((hasIff _ _).mpr h)
      by_cases hit : has (unvisitedNeighbors edges first.1 (current.visited ++ [first.1])) target = true
      · refine ⟨first.2 ++ [target],pathHit edges target current first rest queue seen hit,?_⟩
        obtain ⟨item,hi,short⟩ := frontierStrict edges origin current.visited (first::rest) root closed target path trace absent notQueued
        rw [SFT.Foundation.CommonRefinement.appendLength]
        exact Nat.le_trans (Nat.add_le_add_right (orderedHeadBound first rest ordered item hi) 1) short
      · have bounds := expandPreservesBounds edges origin current.visited first rest root closed ordered fresh
        have nextAbsent : ¬ target ∈ current.visited ++ [first.1] := by
          intro h
          cases memAppendCases target current.visited [first.1] h with
          | inl old => exact absent old
          | inr new =>
            cases new with
            | head => exact notQueued first (List.Mem.head rest) rfl
            | tail _ h => cases h
        have nextNotQueued : ∀ item, item ∈ rest ++ extendQueue first.2 (unvisitedNeighbors edges first.1 (current.visited ++ [first.1])) → item.1 ≠ target := by
          intro item member same
          cases memAppendCases item rest _ member with
          | inl old => exact notQueued item (List.Mem.tail first old) same
          | inr new =>
            obtain ⟨node,hn,entry⟩ := memMapPreimage (fun n => (n,first.2 ++ [n])) item _ new
            cases entry
            change node = target at same
            cases same
            exact hit ((hasIff _ _).mpr hn)
        obtain ⟨result,found,short⟩ := ih (expandPathState edges current first rest queue)
          (expandPathDecreases edges current first rest queue seen) bounds.1 bounds.2
          (expandPreservesOrder first rest _ ordered width) (expandPreservesWidth first rest _ ordered width)
          nextAbsent nextNotQueued path trace
        refine ⟨result,?_,short⟩
        rw [pathExpand edges target current first rest queue seen hit]
        exact found

theorem initialPathBound (edges : Boundary) (origin target : String) (different : origin ≠ target)
    (path : List String) (trace : UndirectedTrace edges origin target path) :
    ∃ result, pathLoop edges target (initialPathState edges origin) = some result ∧ result.length ≤ path.length := by
  apply pathLoopBound edges origin target (initialPathState edges origin) ?_ ?_ ?_ ?_ ?_ ?_ path trace
  · exact Or.inr ⟨(origin,[origin]),List.Mem.head [],rfl,Nat.le_refl 1⟩
  · intro held h; cases h
  · exact ⟨(fun _ h => by cases h),True.intro⟩
  · intro left right hl hr
    cases hl with
    | head =>
      cases hr with
      | head => exact Nat.le_succ 1
      | tail _ h => cases h
    | tail _ h => cases h
  · intro h; cases h
  · intro item h
    cases h with
    | head => exact different
    | tail _ h => cases h

theorem pathDistanceComplete (nodes : List String) (edges : Boundary) (origin target : String)
    (admitted : (has nodes origin && has nodes target) = true) (different : origin ≠ target)
    (path : List String) (trace : UndirectedTrace edges origin target path) :
    ∃ result, pathDistance nodes edges origin target = .ok (some result) ∧ result.length ≤ path.length := by
  obtain ⟨result,found,short⟩ := initialPathBound edges origin target different path trace
  refine ⟨result,?_,short⟩
  unfold pathDistance
  rw [admitted]
  rw [ite_eq_right different,found]
  rfl

theorem pathDistanceShortest (nodes : List String) (edges : Boundary) (origin target : String)
    (admitted : (has nodes origin && has nodes target) = true) (different : origin ≠ target)
    (result : List String) (success : pathDistance nodes edges origin target = .ok (some result))
    (alternative : List String) (trace : UndirectedTrace edges origin target alternative) :
    result.length ≤ alternative.length := by
  obtain ⟨other,found,short⟩ := pathDistanceComplete nodes edges origin target admitted different alternative trace
  rw [success] at found
  cases found
  exact short

theorem pathDistanceNoneIff (nodes : List String) (edges : Boundary) (origin target : String)
    (admitted : (has nodes origin && has nodes target) = true) (different : origin ≠ target) :
    pathDistance nodes edges origin target = .ok none ↔ ¬ ∃ path, UndirectedTrace edges origin target path := by
  constructor
  · intro failed witness
    obtain ⟨path,trace⟩ := witness
    obtain ⟨result,found,_⟩ := pathDistanceComplete nodes edges origin target admitted different path trace
    rw [failed] at found
    cases found
  · intro noPath
    have resultShape : pathDistance nodes edges origin target = .ok (pathLoop edges target (initialPathState edges origin)) := by
      unfold pathDistance
      rw [admitted]
      rw [ite_eq_right different]
      rfl
    cases found : pathLoop edges target (initialPathState edges origin) with
    | none => rw [found] at resultShape; exact resultShape
    | some result =>
      rw [found] at resultShape
      exact False.elim (noPath ⟨result,pathDistanceTrace nodes edges origin target result different resultShape⟩)

end SFT.Mathematics.GeometryTopology


