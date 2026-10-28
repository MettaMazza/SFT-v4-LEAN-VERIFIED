import SFT.InformationScience.QuantityPositions
import SFT.Mathematics.ProbabilityObservations
namespace SFT.InformationScience.EntropyPartition
open SFT.Mathematics.DiscreteObjects SFT.Mathematics.AlgebraOperations SFT.Mathematics.GeometryTopology
open SFT.Mathematics.ProbabilityObservations SFT.Mathematics.ProbabilityIndependence
open SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement
abbrev Partition := List (String × List String)
abbrev Pair := String × String

def partitionValid (support : List String) (observation : Observation) : Bool :=
  !support.isEmpty && distinct support && distinct (observation.map Prod.fst) && keysMatch support observation

def exactPartition (support : List String) (observation : Observation) : Except String Partition :=
  if partitionValid support observation then .ok (classRows support observation)
  else .error "ValueError: uncertainty requires complete support and total observation"

inductive Uncertainty where
  | emptyOne
  | pairs (values : List Pair)

def emptyOne : List String := ["empty-One"]

def unresolvedPairs (members : List String) : Uncertainty :=
  match EncodingLoss.sourcePairs members with
  | [] => .emptyOne
  | pair :: rest => .pairs (pair :: rest)

def uncertaintyPairs : Uncertainty → List Pair
  | .emptyOne => []
  | .pairs values => values

def closedPairs (support : List String) (observation : Observation) : Except String (List Pair) :=
  match exactPartition support observation with
  | .error e => .error e
  | .ok partition => .ok (partition.flatMap (fun row => uncertaintyPairs (unresolvedPairs row.2)))

theorem validityMeaning (support : List String) (observation : Observation) :
    partitionValid support observation = true ↔ support.isEmpty = false ∧ distinct support = true ∧
      distinct (observation.map Prod.fst) = true ∧ keysMatch support observation = true := by
  constructor
  · intro h
    have p := (andTrue _ _).mp h
    have q := (andTrue _ _).mp p.1
    have v := (andTrue _ _).mp q.1
    exact ⟨(notTrue _).mp v.1,v.2,q.2,p.2⟩
  · intro h
    exact (andTrue _ _).mpr ⟨(andTrue _ _).mpr ⟨(andTrue _ _).mpr
      ⟨(notTrue _).mpr h.1,h.2.1⟩,h.2.2.1⟩,h.2.2.2⟩

theorem partitionResult (support : List String) (observation : Observation) (partition : Partition)
    (h : exactPartition support observation = .ok partition) :
    partitionValid support observation = true ∧ partition = classRows support observation := by
  unfold exactPartition at h
  cases hv : partitionValid support observation with
  | false => rw [hv] at h; cases h
  | true => rw [hv] at h; cases h; exact ⟨rfl,rfl⟩

theorem partitionExists (support : List String) (observation : Observation)
    (h : partitionValid support observation = true) : exactPartition support observation = .ok (classRows support observation) := by
  unfold exactPartition; rw [h]; rfl

theorem partitionMembership (support : List String) (observation : Observation) (partition : Partition)
    (h : exactPartition support observation = .ok partition) (label : String) (members : List String) :
    (label,members) ∈ partition ↔
      (∃ state, state ∈ support ∧ image observation state = some label) ∧ members = fibre support observation label := by
  rw [(partitionResult _ _ _ h).2]
  exact rowMembership _ _ _ _

theorem partitionNonemptyClass (support : List String) (observation : Observation) (partition : Partition)
    (h : exactPartition support observation = .ok partition) (label : String) (members : List String)
    (hm : (label,members) ∈ partition) : ∃ state, state ∈ members := by
  rw [(partitionResult _ _ _ h).2] at hm
  exact classNonempty _ _ _ _ hm

theorem partitionCovers (support : List String) (observation : Observation) (partition : Partition)
    (h : exactPartition support observation = .ok partition) (state : String) (hm : state ∈ support) :
    ∃ label members, (label,members) ∈ partition ∧ state ∈ members := by
  have p := partitionResult _ _ _ h
  have valid := (validityMeaning _ _).mp p.1
  obtain ⟨label,hr,hs⟩ := classesCover _ _ valid.2.2.2 state hm
  rw [p.2]
  exact ⟨label,fibre support observation label,hr,hs⟩

theorem partitionDisjoint (support : List String) (observation : Observation) (partition : Partition)
    (h : exactPartition support observation = .ok partition) (a b : String) (xs ys : List String)
    (hx : (a,xs) ∈ partition) (hy : (b,ys) ∈ partition) (state : String)
    (sx : state ∈ xs) (sy : state ∈ ys) : a = b := by
  have px := (partitionMembership _ _ _ h _ _).mp hx
  have py := (partitionMembership _ _ _ h _ _).mp hy
  rw [px.2] at sx
  rw [py.2] at sy
  exact fibreDisjoint _ _ _ _ _ sx sy

theorem partitionClassDistinct (support : List String) (observation : Observation) (partition : Partition)
    (h : exactPartition support observation = .ok partition) (label : String) (members : List String)
    (hm : (label,members) ∈ partition) : distinct members = true := by
  rw [((partitionMembership _ _ _ h _ _).mp hm).2]
  exact filterDistinct _ _ ((validityMeaning _ _).mp (partitionResult _ _ _ h).1).2.1

theorem unresolvedContents (members : List String) :
    uncertaintyPairs (unresolvedPairs members) = EncodingLoss.sourcePairs members := by
  unfold unresolvedPairs
  cases EncodingLoss.sourcePairs members <;> rfl

theorem singletonUncertainty (state : String) : unresolvedPairs [state] = .emptyOne := rfl

theorem emptyUncertainty : unresolvedPairs [] = .emptyOne := rfl

theorem pairUncertainty (a b : String) : unresolvedPairs [a,b] = .pairs [(a,b)] := rfl

theorem certaintyIff (members : List String) : unresolvedPairs members = .emptyOne ↔ members.length ≤ 1 := by
  cases members with
  | nil => constructor; intro _; exact Nat.zero_le _; intro _; rfl
  | cons first rest =>
    cases rest with
    | nil => constructor; intro _; exact Nat.le_refl _; intro _; rfl
    | cons second tail =>
      constructor
      · intro h; cases h
      · intro h
        have impossible : tail.length+2 ≤ 1 := h
        exact False.elim (Nat.not_succ_le_zero _ (Nat.le_of_succ_le_succ impossible))

theorem closedResult (support : List String) (observation : Observation) (partition : Partition)
    (h : exactPartition support observation = .ok partition) :
    closedPairs support observation = .ok (partition.flatMap (fun row => uncertaintyPairs (unresolvedPairs row.2))) := by
  unfold closedPairs; rw [h]

theorem closedMembership (support : List String) (observation : Observation) (partition : Partition)
    (h : exactPartition support observation = .ok partition) (pair : Pair) :
    pair ∈ partition.flatMap (fun row => uncertaintyPairs (unresolvedPairs row.2)) ↔
      ∃ label members, (label,members) ∈ partition ∧ pair ∈ EncodingLoss.sourcePairs members := by
  constructor
  · intro hm
    obtain ⟨row,hr,hp⟩ := memFlatMapOrigin _ _ _ hm
    rw [unresolvedContents] at hp
    exact ⟨row.1,row.2,hr,hp⟩
  · intro ⟨label,members,hm,hp⟩
    apply memFlatMap _ _ (label,members) pair hm
    rw [unresolvedContents]; exact hp

end SFT.InformationScience.EntropyPartition
