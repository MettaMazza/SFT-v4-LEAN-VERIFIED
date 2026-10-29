import SFT.Computation.CausalTermination
namespace SFT.Computation.CausalOperations
open CausalClosure CausalTermination
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.GeometryTopology

def edgeLE (left right : Edge) : Bool :=
  if left.1 = right.1 then SFT.Host.Text.le left.2 right.2 else SFT.Host.Text.le left.1 right.1

def insertEdge (edge : Edge) : List Edge → List Edge
 | [] => [edge]
 | head :: tail => if edgeLE edge head then edge :: head :: tail else head :: insertEdge edge tail

def sortedSet : List Edge → List Edge
 | [] => []
 | edge :: rest => let tail := sortedSet rest
                   if has tail edge then tail else insertEdge edge tail

theorem insertMember (edge item : Edge) (rows : List Edge) : item ∈ insertEdge edge rows ↔ item = edge ∨ item ∈ rows := by
  induction rows with
  | nil =>
    constructor
    · intro h; cases h with
      | head => exact Or.inl rfl
      | tail _ h => cases h
    · intro h; cases h with
      | inl h => cases h; exact List.Mem.head _
      | inr h => cases h
  | cons head tail ih =>
    unfold insertEdge
    cases check : edgeLE edge head with
    | true =>
      constructor
      · intro h; cases h with
        | head => exact Or.inl rfl
        | tail _ h => exact Or.inr h
      · intro h; cases h with
        | inl h => cases h; exact List.Mem.head _
        | inr h => exact List.Mem.tail _ h
    | false =>
      constructor
      · intro h; cases h with
        | head => exact Or.inr (List.Mem.head _)
        | tail _ h => cases ih.mp h with
          | inl eq => exact Or.inl eq
          | inr held => exact Or.inr (List.Mem.tail _ held)
      · intro h; cases h with
        | inl eq => exact List.Mem.tail _ (ih.mpr (Or.inl eq))
        | inr held => cases held with
          | head => exact List.Mem.head _
          | tail _ h => exact List.Mem.tail _ (ih.mpr (Or.inr h))

theorem sortedSetMember (rows : List Edge) (edge : Edge) : edge ∈ sortedSet rows ↔ edge ∈ rows := by
  induction rows with
  | nil => exact ⟨fun h => h,fun h => h⟩
  | cons head rest ih =>
    change edge ∈ (if has (sortedSet rest) head then sortedSet rest else insertEdge head (sortedSet rest)) ↔ _
    cases check : has (sortedSet rest) head with
    | true =>
      constructor
      · intro h; exact List.Mem.tail _ (ih.mp h)
      · intro h; cases h with
        | head => exact (hasIff _ _).mp check
        | tail _ h => exact ih.mpr h
    | false =>
      constructor
      · intro h; cases (insertMember _ _ _).mp h with
        | inl same => cases same; exact List.Mem.head _
        | inr held => exact List.Mem.tail _ (ih.mp held)
      · intro h; apply (insertMember _ _ _).mpr
        cases h with
        | head => exact Or.inl rfl
        | tail _ h => exact Or.inr (ih.mpr h)

def escapes (events : List String) (rows : List Edge) : Bool :=
  rows.any (fun edge => !has events edge.1 || !has events edge.2)

def hasCycle (rows : List Edge) : Bool := rows.any (fun edge => decide (edge.1 = edge.2))

-- Guard order and error strings are the literal source order. Repeated input
-- edges are set-normalised, whereas repeated event identities are rejected.
def causalClosure (events : List String) (edges : List Edge) : Except String (List Edge) :=
  if !distinct events then .error "ValueError: events must contain unique generated identities"
  else let initial := sortedSet edges
       if escapes events initial then .error "ValueError: causal edge escapes the event carrier"
       else let result := closeRows (pairCells events) initial
            if hasCycle result then .error "ValueError: causal cycle violates the partial-order boundary"
            else .ok (sortedSet result)

theorem escapesMeaning (events : List String) (rows : List Edge) : escapes events rows = false ↔
    ∀ edge, edge ∈ rows → edge.1 ∈ events ∧ edge.2 ∈ events := by
  constructor
  · intro h edge held
    have absent := anyFalseAtMember _ _ h edge held
    cases a : has events edge.1 <;> cases b : has events edge.2
    all_goals try { rw [a,b] at absent; cases absent }
    exact ⟨(hasIff _ _).mp a,(hasIff _ _).mp b⟩
  · intro h
    cases value : escapes events rows with
    | false => rfl
    | true =>
      obtain ⟨edge,held,escaped⟩ := (anyTrueIff _ _).mp value
      have p := h edge held
      rw [(hasIff _ _).mpr p.1,(hasIff _ _).mpr p.2] at escaped
      cases escaped

theorem cycleMeaning (rows : List Edge) : hasCycle rows = true ↔ ∃ state, (state,state) ∈ rows := by
  constructor
  · intro h
    obtain ⟨edge,held,same⟩ := (anyTrueIff _ _).mp h
    obtain ⟨left,right⟩ := edge
    have eq : left = right := of_decide_eq_true same
    cases eq
    exact ⟨left,held⟩
  · intro ⟨state,held⟩; exact (anyTrueIff _ _).mpr ⟨(state,state),held,decide_eq_true rfl⟩

theorem closureAdmission (events : List String) (edges result : List Edge) : causalClosure events edges = .ok result ↔
    distinct events = true ∧ escapes events (sortedSet edges) = false ∧
    hasCycle (closeRows (pairCells events) (sortedSet edges)) = false ∧
    result = sortedSet (closeRows (pairCells events) (sortedSet edges)) := by
  unfold causalClosure
  dsimp only
  cases unique : distinct events <;> cases escaped : escapes events (sortedSet edges) <;>
    cases cyclic : hasCycle (closeRows (pairCells events) (sortedSet edges))
  all_goals try { constructor; intro h; cases h; intro h; cases h.1 }
  all_goals try { constructor; intro h; cases h; intro h; cases h.2.1 }
  all_goals try { constructor; intro h; cases h; intro h; cases h.2.2.1 }
  constructor
  · intro h; exact ⟨rfl,rfl,rfl,(Except.ok.inj h).symm⟩
  · intro h; rw [h.2.2.2]; rfl

theorem insertDistinct (edge : Edge) (rows : List Edge)
    (unique : distinct rows = true) (absent : ¬ edge ∈ rows) : distinct (insertEdge edge rows) = true := by
  induction rows with
  | nil => rfl
  | cons head tail ih =>
    have parts := (andTrue _ _).mp unique
    have tailAbsent : ¬ edge ∈ tail := fun held => absent (List.Mem.tail _ held)
    have headAbsent : ¬ head ∈ tail := by
      intro member
      have yes := (hasIff _ _).mpr member
      have no := parts.1
      rw [yes] at no
      cases no
    change distinct (if edgeLE edge head then edge :: head :: tail else head :: insertEdge edge tail) = true
    cases order : edgeLE edge head with
    | true =>
      apply (andTrue _ _).mpr
      refine ⟨?_,unique⟩
      cases held : has (head :: tail) edge with
      | false => rfl
      | true => exact False.elim (absent ((hasIff _ _).mp held))
    | false =>
      apply (andTrue _ _).mpr
      refine ⟨?_,ih parts.2 tailAbsent⟩
      cases held : has (insertEdge edge tail) head with
      | false => rfl
      | true =>
        cases (insertMember _ _ _).mp ((hasIff _ _).mp held) with
        | inl same =>
          have present : edge ∈ head :: tail := same ▸ List.Mem.head tail
          exact False.elim (absent present)
        | inr member => exact False.elim (headAbsent member)

theorem sortedSetDistinct (rows : List Edge) : distinct (sortedSet rows) = true := by
  induction rows with
  | nil => rfl
  | cons edge rest ih =>
    change distinct (if has (sortedSet rest) edge then sortedSet rest else insertEdge edge (sortedSet rest)) = true
    cases held : has (sortedSet rest) edge with
    | true => exact ih
    | false =>
      apply insertDistinct edge _ ih
      intro member
      have h := (hasIff _ _).mpr member
      rw [held] at h; cases h

theorem pathTransport (first second : List Edge) (included : ∀ edge, edge ∈ first → edge ∈ second)
    (left right : String) (path : Path first left right) : Path second left right := by
  induction path with
  | edge left right held => exact .edge _ _ (included _ held)
  | join left middle right first second ihLeft ihRight => exact .join _ _ _ ihLeft ihRight

theorem sortedSetPath (rows : List Edge) (left right : String) :
    Path (sortedSet rows) left right ↔ Path rows left right :=
  ⟨pathTransport _ _ (fun edge held => (sortedSetMember _ _).mp held) _ _,
   pathTransport _ _ (fun edge held => (sortedSetMember _ _).mpr held) _ _⟩

theorem nativeSourceResult (events : List String) (edges result : List Edge)
    (passed : causalClosure events edges = .ok result) (left right : String) :
    (left,right) ∈ result ↔ Path edges left right := by
  have h := (closureAdmission _ _ _).mp passed
  rw [h.2.2.2]
  constructor
  · intro held
    exact (sortedSetPath _ _ _).mp ((nativeExact _ _ ((escapesMeaning _ _).mp h.2.1) _ _).mp
      ((sortedSetMember _ _).mp held))
  · intro path
    exact (sortedSetMember _ _).mpr ((nativeExact _ _ ((escapesMeaning _ _).mp h.2.1) _ _).mpr
      ((sortedSetPath _ _ _).mpr path))

theorem nativeDistinct (events : List String) (edges result : List Edge)
    (passed : causalClosure events edges = .ok result) : distinct result = true := by
  rw [((closureAdmission _ _ _).mp passed).2.2.2]
  exact sortedSetDistinct _

theorem nativeAcyclic (events : List String) (edges result : List Edge)
    (passed : causalClosure events edges = .ok result) : ∀ state, ¬ Path edges state state := by
  have h := (closureAdmission _ _ _).mp passed
  intro state path
  have member := (nativeExact _ _ ((escapesMeaning _ _).mp h.2.1) _ _).mpr ((sortedSetPath _ _ _).mpr path)
  have cycle := (cycleMeaning _).mpr ⟨state,member⟩
  rw [h.2.2.1] at cycle
  cases cycle

set_option maxRecDepth 10000 in
set_option maxHeartbeats 2000000 in
theorem sourceWitnessClosure : causalClosure ["a","b","c"] [("a","b"),("b","c")] =
    .ok [("a","b"),("a","c"),("b","c")] := rfl

end SFT.Computation.CausalOperations
