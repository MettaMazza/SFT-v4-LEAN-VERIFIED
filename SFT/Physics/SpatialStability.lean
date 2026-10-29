import SFT.Physics.GeneratorThreeEvidence
import SFT.Mathematics.DiscreteComplement
namespace SFT.Physics.SpatialStability
open SFT.Foundation SFT.Mathematics.DiscreteObjects
open SFT.Foundation.Count.TraceDerivation
open GeneratorOperations FoldFirstReturn

def positiveCounts : Nat → List Nat
 | 0 => []
 | n+1 => positiveCounts n ++ [n+1]

theorem positiveCountMembership (bound count : Nat) :
    count ∈ positiveCounts bound ↔ 0 < count ∧ count ≤ bound := by
  induction bound with
  | zero => constructor; intro h; cases h; intro h; exact False.elim (Nat.not_lt_zero _ (Nat.lt_of_lt_of_le h.1 h.2))
  | succ n ih =>
    constructor
    · intro held
      cases memAppendCases count (positiveCounts n) [n+1] held with
      | inl held => have h := ih.mp held; exact ⟨h.1,Nat.le_trans h.2 (Nat.le_succ _)⟩
      | inr held => cases held with
        | head => exact ⟨Nat.zero_lt_succ _,Nat.le_refl _⟩
        | tail _ h => cases h
    · intro h
      cases Nat.eq_or_lt_of_le h.2 with
      | inl same => cases same; exact memAppendRight _ _ _ (List.Mem.head _)
      | inr smaller => exact memAppendLeft _ _ _ (ih.mpr ⟨h.1,Nat.le_of_lt_succ smaller⟩)

theorem positiveCountLength (bound : Nat) : (positiveCounts bound).length = bound := by
  induction bound with
  | zero => rfl
  | succ bound ih =>
    change (positiveCounts bound ++ [bound+1]).length = _
    rw [CommonRefinement.appendLength,ih]
    rfl

theorem positiveCountUnique (bound : Nat) : (positiveCounts bound).Nodup := by
  induction bound with
  | zero => exact List.Pairwise.nil
  | succ bound ih =>
    apply FoldAssembly.disjointAppendNodup _ _ ih
    · exact List.Pairwise.cons (fun _ h => by cases h) List.Pairwise.nil
    · intro x hx hy
      cases hy with
      | head => exact Nat.not_succ_le_self _ ((positiveCountMembership _ _).mp hx).2
      | tail _ h => cases h

def pairCells (left right : List String) : List (String × String) :=
  left.flatMap (fun a => right.map (fun b => (a,b)))

theorem pairCellCount (left right : List String) : (pairCells left right).length = left.length * right.length := by
  induction left with
  | nil => exact (Nat.zero_mul _).symm
  | cons a tail ih =>
    change ((right.map (fun b => (a,b))) ++ pairCells tail right).length = _
    rw [CommonRefinement.appendLength,CommonRefinement.mapLength,ih]
    change right.length + tail.length * right.length = (tail.length+1)*right.length
    rw [Nat.succ_mul,Nat.add_comm]

def stableCounts (binary : Nat) : List Nat :=
  (positiveCounts (binary*binary)).filter (fun count => decide (binary < count ∧ count < binary*binary))

theorem completeWindow (binary count : Nat) : count ∈ stableCounts binary ↔
    binary < count ∧ count < binary*binary := by
  constructor
  · intro h; exact of_decide_eq_true ((filterMemberIff _ _ _).mp h).2
  · intro h
    exact (filterMemberIff _ _ _).mpr
      ⟨(positiveCountMembership _ _).mpr ⟨Nat.lt_of_le_of_lt (Nat.zero_le _) h.1,Nat.le_of_lt h.2⟩,
       decide_eq_true h⟩

theorem lowerBoundaryExcluded (binary : Nat) : ¬ binary ∈ stableCounts binary :=
  fun held => Nat.lt_irrefl _ ((completeWindow _ _).mp held).1

theorem upperBoundaryExcluded (binary : Nat) : ¬ binary*binary ∈ stableCounts binary :=
  fun held => Nat.lt_irrefl _ ((completeWindow _ _).mp held).2

def stableSpatialCounts : CountInput → Except String (List Nat)
 | .boolean _ => .error "ValueError: the Fold fibre count must be a positive extension of the One"
 | .integer (.negSucc _) => .error "ValueError: the Fold fibre count must be a positive extension of the One"
 | .integer (.ofNat 0) => .error "ValueError: the Fold fibre count must be a positive extension of the One"
 | .integer (.ofNat 1) => .error "ValueError: the Fold fibre count must be a positive extension of the One"
 | .integer (.ofNat (n+2)) => .ok (stableCounts (n+2))

theorem admittedCounts (n : Nat) : stableSpatialCounts (.integer (.ofNat (n+2))) = .ok (stableCounts (n+2)) := rfl

theorem fibreCount : FoldAssembly.labels.length = 2 := rfl

theorem fibrePairCellCount : (pairCells FoldAssembly.labels FoldAssembly.labels).length = 4 := rfl

theorem singletonWindow : stableCounts 2 = [3] := rfl

theorem forcedCount (count : Nat) (lower : 2 < count) (upper : count < 4) : count = 3 :=
  Nat.le_antisymm (Nat.le_of_lt_succ upper) lower

theorem onlySpatialCount (count : Nat) : count ∈ stableCounts 2 ↔ count = 3 := by
  constructor
  · intro held; have h := (completeWindow _ _).mp held; exact forcedCount count h.1 h.2
  · intro same; cases same; rw [singletonWindow]; exact List.Mem.head _

def spatialDimension : Except String Nat := do
  let candidates ← stableSpatialCounts (.integer (.ofNat 2))
  let generator ← generatorPeriod
  if candidates != [generator] then
    .error "ValueError: stability enumeration and Fold recurrence do not cross-lock"
  else .ok generator

theorem spatialDimensionThree : spatialDimension = .ok 3 := by
  change (do
    let generator ← generatorPeriod
    if [3] != [generator] then
      .error "ValueError: stability enumeration and Fold recurrence do not cross-lock"
    else .ok generator) = .ok 3
  rw [generatorPeriodThree]
  rfl

theorem independentCrosslock : spatialDimension = generatorPeriod :=
  spatialDimensionThree.trans generatorPeriodThree.symm

theorem completeSpatialDerivation :
    (pairCells FoldAssembly.labels FoldAssembly.labels).length = 4 ∧
    (∀ count, count ∈ stableCounts FoldAssembly.labels.length ↔ count = 3) ∧
    spatialDimension = .ok 3 ∧ spatialDimension = generatorPeriod :=
  ⟨fibrePairCellCount,onlySpatialCount,spatialDimensionThree,independentCrosslock⟩

end SFT.Physics.SpatialStability
