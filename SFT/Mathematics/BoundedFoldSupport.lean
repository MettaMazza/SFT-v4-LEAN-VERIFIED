import SFT.Mathematics.BoundedFoldTuple
import SFT.Foundation.CommonRefinement
import SFT.Mathematics.OrbitCyclotomic
namespace SFT.Mathematics.BoundedFoldSupport
open OrbitOrderIdentity OrbitCycleSupport OrbitTilingCount
open SFT.Foundation

def support : List Nat → List (List Nat)
 | [] => [[]]
 | q::qs => (positiveRanks (q+1)).flatMap (fun p => (support qs).map (List.cons p))

def capacity : List Nat → Nat
 | [] => 1
 | q::qs => q*capacity qs

theorem rowsSize (rs : List Nat) (ss : List (List Nat)) :
 (rs.flatMap (fun r => ss.map (List.cons r))).length = rs.length*ss.length := by
 induction rs with
 | nil => exact (Nat.zero_mul _).symm
 | cons r rs ih =>
   change ((ss.map (List.cons r)) ++ rs.flatMap (fun r => ss.map (List.cons r))).length = (rs.length+1)*ss.length
   rw [CommonRefinement.appendLength,mappedLength,ih,Nat.succ_mul,Nat.add_comm]

theorem supportSize (qs : List Nat) : (support qs).length = capacity qs := by
 induction qs with
 | nil => rfl
 | cons q qs ih =>
   change ((positiveRanks (q+1)).flatMap (fun p => (support qs).map (List.cons p))).length = q*capacity qs
   rw [rowsSize,ih]
   have size : (positiveRanks (q+1)).length=q :=
     (mappedLength _ _).trans (rangeLoopLength q [])
   rw [size]

structure Input where
 rank : Nat
 denominator : Nat
 positive : 0 < rank
 bound : rank ≤ denominator
 reduced : Nat.gcd rank denominator = 1

def configuration (xs : List Input) (n : Nat) := xs.map (fun x => rankIterate x.rank x.denominator n)

theorem everyConfigurationInSupport (xs : List Input) (n : Nat) :
 configuration xs n ∈ support (xs.map Input.denominator) := by
 induction xs with
 | nil => exact List.Mem.head _
 | cons x xs ih =>
   have bounds := iterateBounds x.rank x.denominator n x.positive x.bound
   have member := (positiveRankMember (x.denominator+1) (rankIterate x.rank x.denominator n)
     (Nat.zero_lt_succ _)).mpr ⟨bounds.1,Nat.lt_succ_of_le bounds.2⟩
   apply CommonRefinement.memFlatMap _ _ _ _ member
   exact Count.TraceDerivation.memMap _ _ _ ih

-- The recurrent carrier is the original Cartesian product of the complete
-- component orbit supports, with all component phases retained.
def recurrentSupport : List BoundedFoldTuple.Component → List (List Nat)
 | [] => [[]]
 | c::cs => (cycleSupport c.rank c.denominator c.period).flatMap
     (fun p => (recurrentSupport cs).map (List.cons p))

def recurrentCapacity : List BoundedFoldTuple.Component → Nat
 | [] => 1
 | c::cs => c.period*recurrentCapacity cs

theorem recurrentSupportSize (cs : List BoundedFoldTuple.Component) :
 (recurrentSupport cs).length=recurrentCapacity cs := by
 induction cs with
 | nil => rfl
 | cons c cs ih =>
   change ((cycleSupport c.rank c.denominator c.period).flatMap
     (fun p => (recurrentSupport cs).map (List.cons p))).length = c.period*recurrentCapacity cs
   rw [rowsSize,completeCycleCardinality,ih]

theorem componentAtModulo (c : BoundedFoldTuple.Component) (n : Nat) :
 BoundedFoldTuple.componentAt c n=BoundedFoldTuple.componentAt c (n%c.period) := by
 have split := FractionReduction.remainderQuotient n c.period c.first.1
 calc
   BoundedFoldTuple.componentAt c n = BoundedFoldTuple.componentAt c ((n%c.period)+c.period*(n/c.period)) :=
     congrArg (BoundedFoldTuple.componentAt c) split.symm
   _ = BoundedFoldTuple.componentAt c (c.period*(n/c.period)+(n%c.period)) :=
     congrArg (BoundedFoldTuple.componentAt c) (Nat.add_comm _ _)
   _ = BoundedFoldTuple.componentAt c (n%c.period) := by
     unfold BoundedFoldTuple.componentAt
     rw [iterateAddition,show rankIterate c.rank c.denominator (c.period*(n/c.period))=c.rank from BoundedFoldTuple.multipleReturns c (n/c.period)]

theorem recurrentConfigurationInSupport (cs : List BoundedFoldTuple.Component) (n : Nat) :
 BoundedFoldTuple.configuration cs n ∈ recurrentSupport cs := by
 induction cs with
 | nil => exact List.Mem.head _
 | cons c cs ih =>
   have member : BoundedFoldTuple.componentAt c n ∈ cycleSupport c.rank c.denominator c.period := by
     rw [componentAtModulo c n]
     exact Count.TraceDerivation.memMap _ _ _ ((OrbitCyclotomic.rangeMember c.period (n%c.period)).mpr (Nat.mod_lt n c.first.1))
   apply CommonRefinement.memFlatMap _ _ _ _ member
   exact Count.TraceDerivation.memMap _ _ _ ih

end SFT.Mathematics.BoundedFoldSupport
