import SFT.Physics.CollectiveRadiationCensus
import SFT.Mathematics.OrbitCyclotomic
namespace SFT.Physics.CollectiveRadiationUniqueness
open CollectiveRadiation SFT.Foundation.Count.TraceDerivation SFT.Foundation.CommonRefinement SFT.Mathematics.DiscreteObjects
theorem branchesDistinct (axis : List Nat) (rows : List (List Nat))
    (axisUnique : distinct axis = true) (rowsUnique : distinct rows = true) :
    distinct (axis.flatMap (fun value => rows.map (List.cons value))) = true := by
  induction axis with
  | nil => rfl
  | cons value rest ih =>
    have parts := (distinctCons _ _).mp axisUnique
    apply appendDistinct
    · exact mapDistinct (List.cons value) (fun a b equal => (List.cons.inj equal).2) rows rowsUnique
    · exact ih parts.2
    · intro row first remaining
      obtain ⟨tail,_,equal⟩ := memMapPreimage (List.cons value) row rows first
      obtain ⟨other,member,branch⟩ := memFlatMapOrigin _ rest row remaining
      obtain ⟨otherTail,_,otherEqual⟩ := memMapPreimage (List.cons other) row rows branch
      have same := (List.cons.inj (equal.trans otherEqual.symm)).1
      cases same
      exact (absentIff _ _).mp parts.1 member

theorem productDistinct (axes : List (List Nat))
    (unique : ∀ axis, axis ∈ axes → distinct axis = true) : distinct (occupationProduct axes) = true := by
  induction axes with
  | nil => rfl
  | cons axis rest ih =>
    exact branchesDistinct axis (occupationProduct rest) (unique axis (List.Mem.head _))
      (ih (fun other member => unique other (List.Mem.tail axis member)))


theorem originalRangeUnique (n : Nat) : distinct (List.range n)=true := by
 induction n with
 | zero => rfl
 | succ n ih =>
   rw [VacuumLedgerProofs.rangeSuccessor]
   exact freshAppendDistinct _ n ih ((absentIff _ _).mpr (fun h => Nat.lt_irrefl n ((SFT.Mathematics.OrbitCyclotomic.rangeMember n n).mp h)))

theorem originalOccupationWordsUnique (costs : List Nat) (total : Nat) :
 distinct (completeWords costs total)=true := by
 apply filterDistinct
 apply productDistinct
 intro axis held
 obtain ⟨cost,_,eq⟩ := memMapPreimage (fun c => List.range (total/c+1)) axis costs held
 cases eq
 exact originalRangeUnique _
end SFT.Physics.CollectiveRadiationUniqueness
