import SFT.Computation.SearchTrace
import SFT.Mathematics.ArrangementCompleteness
import SFT.Mathematics.CombinatorialLedger
namespace SFT.Computation.OrderingTrace
open SFT.Mathematics DiscreteObjects CombinatorialArrangements AlgebraOperations GeometryTopology

-- Exact registered comparisons, retaining every ordered candidate and tie.
def ordered (relation : OrderOperations.Relation) : List String → Bool
 | [] => true
 | head :: rest => rest.all (fun item => has relation (head,item)) && ordered relation rest

inductive Invariant (relation : OrderOperations.Relation) : List String → Prop where
 | empty : Invariant relation []
 | next (head : String) (rest : List String)
     (comparisons : ∀ item, item ∈ rest → (head,item) ∈ relation)
     (tail : Invariant relation rest) : Invariant relation (head :: rest)

theorem orderingMeaning (relation : OrderOperations.Relation) (items : List String) :
    ordered relation items = true ↔ Invariant relation items := by
  induction items with
  | nil => exact ⟨fun _ => .empty,fun _ => rfl⟩
  | cons head rest ih =>
    constructor
    · intro h
      have parts := (andTrue _ _).mp h
      exact .next head rest (fun item held => (hasIff _ _).mp (allTrueAtMember _ _ parts.1 item held)) (ih.mp parts.2)
    · intro h
      cases h with
      | next _ _ comparisons tail =>
        exact (andTrue _ _).mpr ⟨(allTrueIffMembers _ _).mpr
          (fun item held => (hasIff _ _).mpr (comparisons item held)),ih.mpr tail⟩

def orders (carrier : List String) (relation : OrderOperations.Relation) : List (List String) :=
  (arrangementsCore carrier).filter (ordered relation)

theorem completeOrders (carrier result : List String) (relation : OrderOperations.Relation)
    (nonempty : carrier ≠ []) (unique : distinct carrier = true) :
    result ∈ orders carrier relation ↔ List.Perm result carrier ∧ Invariant relation result := by
  constructor
  · intro held
    have parts := (filterMemberIff _ _ _).mp held
    exact ⟨(arrangementMembershipIff _ _ nonempty unique).mp parts.1,(orderingMeaning _ _).mp parts.2⟩
  · intro parts
    exact (filterMemberIff _ _ _).mpr
      ⟨(arrangementMembershipIff _ _ nonempty unique).mpr parts.1,(orderingMeaning _ _).mpr parts.2⟩

theorem retainedDuplicateClass (carrier result : List String) (relation : OrderOperations.Relation)
    (nonempty : carrier ≠ []) (unique : distinct carrier = true)
    (held : result ∈ orders carrier relation) (classify : String → String) (label item : String) :
    item ∈ CombinatorialLedger.lookup (CombinatorialLedger.disjointClassLedger result classify) label ↔
      item ∈ carrier ∧ classify item = label := by
  have perm := ((completeOrders _ _ _ nonempty unique).mp held).1
  constructor
  · intro h
    have parts := (CombinatorialLedger.classMemberIff _ _ _ _).mp h
    exact ⟨permutationMember perm item parts.1,parts.2⟩
  · intro h
    exact (CombinatorialLedger.classMemberIff _ _ _ _).mpr ⟨permutationMember perm.symm item h.1,h.2⟩

theorem terminalCertificate (carrier result : List String) (relation : OrderOperations.Relation)
    (nonempty : carrier ≠ []) (unique : distinct carrier = true)
    (held : result ∈ orders carrier relation) :
    List.Perm result carrier ∧ result.length = carrier.length ∧ Invariant relation result := by
  have parts := (completeOrders _ _ _ nonempty unique).mp held
  exact ⟨parts.1,permutationLength parts.1,parts.2⟩

theorem orderedSuccessor (relation : OrderOperations.Relation) (items : List String) (fresh : String)
    (prior : Invariant relation items) (newRows : ∀ item, item ∈ items → (item,fresh) ∈ relation) :
    Invariant relation (items ++ [fresh]) := by
  induction prior with
  | empty => exact .next fresh [] (fun item impossible => by cases impossible) .empty
  | next head rest comparisons tail ih =>
    apply Invariant.next
    · intro item held
      cases SFT.Foundation.Count.TraceDerivation.memAppendCases _ _ _ held with
      | inl old => exact comparisons item old
      | inr added =>
        cases added with
        | head => exact newRows head (.head _)
        | tail _ impossible => cases impossible
    · exact ih (fun item held => newRows item (.tail head held))

def recursionValues (step : List String → String → List String) (base : List String) : List String → List (List String)
 | [] => [base]
 | position :: rest => base :: recursionValues step (step base position) rest

def structuralRecursion (base successorTrace : List String) (step : List String → String → List String) :
    Except String (List (List String)) :=
  if !distinct successorTrace then .error "ValueError: successor trace must contain unique generated identities"
  else .ok (recursionValues step base successorTrace)

theorem recursionCount (step : List String → String → List String) (positions base : List String) :
    (recursionValues step base positions).length = positions.length + 1 := by
  induction positions generalizing base with
  | nil => rfl
  | cons head rest ih => exact congrArg Nat.succ (ih (step base head))

inductive RecursionTrace (step : List String → String → List String) : List String → List String → List (List String) → Prop where
 | base (value) : RecursionTrace step value [] [value]
 | next (value position rest values) (tail : RecursionTrace step (step value position) rest values) :
     RecursionTrace step value (position :: rest) (value :: values)

theorem exactRecursionTrace (step : List String → String → List String) (positions base : List String) :
    RecursionTrace step base positions (recursionValues step base positions) := by
  induction positions generalizing base with
  | nil => exact .base base
  | cons position rest ih => exact .next _ _ _ _ (ih (step base position))

theorem admittedRecursion (base positions : List String) (step : List String → String → List String)
    (unique : distinct positions = true) :
    structuralRecursion base positions step = .ok (recursionValues step base positions) ∧
      RecursionTrace step base positions (recursionValues step base positions) ∧
      (recursionValues step base positions).length = positions.length+1 := by
  refine ⟨?_,exactRecursionTrace _ _ _,recursionCount _ _ _⟩
  unfold structuralRecursion; rw [unique]; rfl

end SFT.Computation.OrderingTrace
