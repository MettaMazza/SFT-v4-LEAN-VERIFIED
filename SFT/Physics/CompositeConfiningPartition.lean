import SFT.Physics.CompositeConfiningLoop
import SFT.Mathematics.OrbitLoopCompletion
import SFT.Mathematics.ExactTraceArithmetic
namespace SFT.Physics.CompositeConfiningDerivation
open SFT.Physics.CompositeConfining SFT.Physics.GeneratorOperations
open SFT.Mathematics.OrbitCyclotomic SFT.Mathematics.OrbitCycleSupport
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
/-- The partition operation's original tag-to-integer map retains every generated position. -/
theorem originalTraceNumbers (d k n : Nat) (initial : CountInput)
 (value : labelInteger initial=Int.ofNat k) :
 (originalTaggedTrace d k initial n).map (fun x => (labelInteger x).toNat)=
 (List.range n).map (originalTicks d k) := by
 induction n with
 | zero => rfl
 | succ n ih =>
  unfold originalTaggedTrace
  rw [SFT.Mathematics.ExactTraceArithmetic.mapAppend,ih,
   SFT.Mathematics.OrbitLoopCompletion.rangeSuccessor,
   SFT.Mathematics.ExactTraceArithmetic.mapAppend]
  change _ ++ [(labelInteger (originalTaggedTick d k initial n)).toNat] = _ ++ [originalTicks d k n]
  rw [originalTaggedValue d k n initial value]
  rfl
/-- Source orbit membership is exactly reachability in the held support. -/
theorem originalTraceReachability (d k period x : Nat) (positive : 0<d) (odd : d%2=1)
 (kp : 0<k) (kb : k<d) (pp : 0<period) (returned : originalTicks d k period=k) :
 x∈(List.range period).map (originalTicks d k) ↔ Reaches d k x := by
 constructor
 · intro member
   obtain ⟨n,_,same⟩ := mapPreimage _ _ x member
   exact ⟨n,(originalTicksRank d k n positive odd kp kb).symm.trans same⟩
 · intro reachable
   obtain ⟨n,same⟩ := reachable
   obtain ⟨j,before,eq⟩ := originalOrbitCoverage d k period positive odd kp kb pp returned n
   have target : originalTicks d k j=x := eq.trans ((originalTicksRank d k n positive odd kp kb).trans same)
   rw [← target]
   exact mapMember _ _ j ((rangeMember period j).mpr before)
/-- Every generated row used by partitioning has exactly its source cycle membership. -/
theorem originalPartitionRow (sector : CountInput) (d k : Nat)
 (held : heldDenominator sector=.ok d) (positive : 0<d) (odd : d%2=1)
 (kp : 0<k) (kb : k<d) :
 ∃ raw : List CountInput, orbitFromLabel (.integer (.ofNat k)) sector=.ok raw ∧
 (∀ x, x∈raw.map (fun y => (labelInteger y).toNat) ↔ Reaches d k x) ∧
 (∀ x, x∈raw.map (fun y => (labelInteger y).toNat) → 0<x ∧ x<d) := by
 obtain ⟨period,pp,_,returned,_,finished⟩ := originalOrbitFromLabelCompletes sector (.integer (.ofNat k)) d k held rfl positive odd kp kb
 refine ⟨originalTaggedTrace d k (.integer (.ofNat k)) period,finished,?_,?_⟩
 · intro x
   rw [originalTraceNumbers d k period (.integer (.ofNat k)) rfl]
   exact originalTraceReachability d k period x positive odd kp kb pp returned
 · intro x member
   rw [originalTraceNumbers d k period (.integer (.ofNat k)) rfl] at member
   obtain ⟨n,_,same⟩ := mapPreimage _ _ x member
   rw [← same]
   exact originalTicksConfined d k n positive odd kp kb

theorem originalRemainingMember (xs : List Nat) (x : Nat) :
 xs.any (fun y => y=x)=true ↔ x∈xs := by
 constructor
 · intro h
   obtain ⟨y,member,same⟩ := (SFT.Mathematics.GeometryTopology.anyTrueIff _ _).mp h
   have eq := of_decide_eq_true same
   exact eq ▸ member
 · intro h
   exact (SFT.Mathematics.GeometryTopology.anyTrueIff _ _).mpr ⟨x,h,decide_eq_true rfl⟩
/-- Removing the generated complete cycle retains precisely the other closed cycles. -/
theorem originalRemovalClosed (d k : Nat) (remaining orbit : List Nat)
 (positive : 0<d) (odd : d%2=1) (kp : 0<k) (kb : k<d)
 (contained : ∀ x, x∈remaining → 0<x ∧ x<d)
 (closed : ∀ x, x∈remaining → ∀ y, Reaches d x y → y∈remaining)
 (row : ∀ x, x∈orbit ↔ Reaches d k x) :
 ∀ x, x∈remaining.filter (fun x => !(orbit.any (fun y => y=x))) →
 ∀ y, Reaches d x y → y∈remaining.filter (fun x => !(orbit.any (fun y => y=x))) := by
 intro x member y reach
 have hx := (SFT.Mathematics.OrbitTilingCount.filterMember _ _ _).mp member
 apply (SFT.Mathematics.OrbitTilingCount.filterMember _ _ _).mpr
 refine ⟨closed x hx.1 y reach,?_⟩
 have absentX : ¬x∈orbit := by
  intro present
  have hit := (originalRemainingMember orbit x).mpr present
  rw [hit] at hx
  cases hx.2
 have absentY : ¬y∈orbit := by
  intro present
  have bounds := contained x hx.1
  have same := (originalOrbitPartition d k x positive odd kp kb bounds.1 bounds.2).2.2
   y ((row y).mp present) reach x
  have back := same.mpr (reachesSelf d x)
  exact absentX ((row x).mpr back)
 cases hit : orbit.any (fun z => z=y) with
 | false => rfl
 | true => exact False.elim (absentY ((originalRemainingMember orbit y).mp hit))
/-- The original partition loop completes within the number of remaining labels.
Its containment check succeeds at every original least-remaining-label step. -/
theorem originalPartitionLoopCompletes (sector : CountInput) (d fuel : Nat)
 (held : heldDenominator sector=.ok d) (positive : 0<d) (odd : d%2=1)
 (remaining : List Nat) (orbits : List (List Nat))
 (contained : ∀ x, x∈remaining → 0<x ∧ x<d)
 (closed : ∀ x, x∈remaining → ∀ y, Reaches d x y → y∈remaining)
 (enough : remaining.length≤fuel) :
 ∃ result, partitionLoop sector fuel remaining orbits=.ok result := by
 induction fuel generalizing remaining orbits with
 | zero =>
  cases remaining with
  | nil => exact ⟨orbits,rfl⟩
  | cons x xs => exact False.elim (Nat.not_succ_le_zero xs.length enough)
 | succ fuel ih =>
  cases remaining with
  | nil => exact ⟨orbits,rfl⟩
  | cons first rest =>
   have bounds := contained first (List.Mem.head _)
   obtain ⟨raw,generated,row,_⟩ := originalPartitionRow sector d first held positive odd bounds.1 bounds.2
   let orbit := raw.map (fun y => (labelInteger y).toNat)
   have included : ∀ x, x∈orbit → x∈first::rest := by
    intro x member
    exact closed first (List.Mem.head _) x ((row x).mp member)
   have guard : orbit.any (fun x => !((first::rest).any (fun y => y=x)))=false := by
    cases hit : orbit.any (fun x => !((first::rest).any (fun y => y=x))) with
    | false => rfl
    | true =>
     obtain ⟨x,member,bad⟩ := (SFT.Mathematics.GeometryTopology.anyTrueIff _ _).mp hit
     have present := (originalRemainingMember (first::rest) x).mpr (included x member)
     rw [present] at bad
     cases bad
   have firstRemoved : (!(orbit.any (fun y => y=first)))=false := by
    rw [(originalRemainingMember orbit first).mpr ((row first).mpr (reachesSelf d first))]
    rfl
   let next := (first::rest).filter (fun x => !(orbit.any (fun y => y=x)))
   have shorter := SFT.Mathematics.OrbitTilingCount.filterRemovalShorter
    (fun x => !(orbit.any (fun y => y=x))) (first::rest) first (List.Mem.head _) firstRemoved
   have nextBound : next.length≤fuel := Nat.le_of_lt_succ (Nat.lt_of_lt_of_le shorter enough)
   have nextContained : ∀ x, x∈next → 0<x ∧ x<d := by
    intro x member
    exact contained x ((SFT.Mathematics.OrbitTilingCount.filterMember _ _ _).mp member).1
   have nextClosed := originalRemovalClosed d first (first::rest) orbit positive odd
    bounds.1 bounds.2 contained closed row
   obtain ⟨result,finished⟩ := ih next (orbits++[orbit]) nextContained nextClosed nextBound
   refine ⟨result,?_⟩
   unfold partitionLoop
   rw [generated]
   change (if orbit.any (fun x => !((first::rest).any (fun y => y=x)))=true then
    Except.error "generated Fold orbits overlap" else partitionLoop sector fuel next (orbits++[orbit])) = .ok result
   rw [guard]
   exact finished
/-- The exported original partition operation is total on its admitted held support. -/
theorem originalOrbitPartitionCompletes (sector : CountInput) (d : Nat)
 (held : heldDenominator sector=.ok d) (positive : 0<d) (odd : d%2=1) :
 ∃ result, orbitPartition sector=.ok result := by
 let labels := SFT.Mathematics.OrbitTilingCount.positiveRanks d
 have contained : ∀ x, x∈labels → 0<x ∧ x<d := fun x h =>
  (SFT.Mathematics.OrbitTilingCount.positiveRankMember d x positive).mp h
 have closed : ∀ x, x∈labels → ∀ y, Reaches d x y → y∈labels := by
  intro x member y reach
  obtain ⟨n,same⟩ := reach
  have bounds := contained x member
  have actual := originalTicksConfined d x n positive odd bounds.1 bounds.2
  have eq := (originalTicksRank d x n positive odd bounds.1 bounds.2).trans same
  exact (SFT.Mathematics.OrbitTilingCount.positiveRankMember d y positive).mpr (eq ▸ actual)
 obtain ⟨result,finished⟩ := originalPartitionLoopCompletes sector d labels.length held positive odd labels [] contained closed (Nat.le_refl _)
 refine ⟨result,?_⟩
 unfold orbitPartition
 rw [originalStandingLabels sector d held]
 exact finished
end SFT.Physics.CompositeConfiningDerivation
