import SFT.Materials.JunctionObservation
namespace SFT.Materials.JunctionPreservation
open SFT.Physics
variable {Part Support State ClockState Clock : Type}
abbrev Coupling := CollectivePlasma.Coupling Part Support State ClockState Clock

-- The source induction appends a transition while keeping every earlier row.
def records (inside : String → Bool) (history : List (Coupling (Part := Part)
 (Support := Support) (State := State) (ClockState := ClockState) (Clock := Clock))) :=
 (history.filter (JunctionCoupling.crosses inside)).map JunctionCoupling.retainedResponse

theorem base (inside : String → Bool) (c : Coupling (Part := Part) (Support := Support)
 (State := State) (ClockState := ClockState) (Clock := Clock)) :
 records inside [c] = match JunctionCoupling.crosses inside c with
 | true => [JunctionCoupling.retainedResponse c]
 | false => [] := by
 unfold records
 change (match JunctionCoupling.crosses inside c with
  | true => [c]
  | false => []).map JunctionCoupling.retainedResponse = _
 cases JunctionCoupling.crosses inside c <;> rfl

theorem appendExactly (inside : String → Bool)
 (earlier later : List (Coupling (Part := Part) (Support := Support) (State := State)
 (ClockState := ClockState) (Clock := Clock))) :
 records inside (earlier ++ later) = records inside earlier ++ records inside later := by
 induction earlier with
 | nil => rfl
 | cons c rest ih =>
   cases h : JunctionCoupling.crosses inside c <;>
    simp only [records,List.cons_append,List.filter,h,List.map] at *
   · exact ih
   · exact congrArg (List.cons _) ih

theorem successorExactly (inside : String → Bool)
 (history : List (Coupling (Part := Part) (Support := Support) (State := State)
 (ClockState := ClockState) (Clock := Clock))) (c : Coupling (Part := Part)
 (Support := Support) (State := State) (ClockState := ClockState) (Clock := Clock)) :
 records inside (history ++ [c]) = records inside history ++
 (match JunctionCoupling.crosses inside c with
 | true => [JunctionCoupling.retainedResponse c]
 | false => []) := by
 rw [appendExactly,base]

theorem earlierRowsRetained (inside : String → Bool)
 (earlier later : List (Coupling (Part := Part) (Support := Support) (State := State)
 (ClockState := ClockState) (Clock := Clock))) (row)
 (held : row ∈ records inside earlier) : row ∈ records inside (earlier ++ later) := by
 rw [appendExactly]
 exact SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem everyRowHasActualTransferAndField (inside : String → Bool)
 (history : List (Coupling (Part := Part) (Support := Support) (State := State)
 (ClockState := ClockState) (Clock := Clock))) (row)
 (held : row ∈ records inside history) :
 ∃ c, c ∈ history ∧ inside c.transfer.source = true ∧
 inside c.transfer.destination = false ∧ row = JunctionCoupling.retainedResponse c ∧
 (JunctionTransfer.spaceCharge c.transfer).2.1.2 = c.field.electric.charge := by
 obtain ⟨c,member,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage
  JunctionCoupling.retainedResponse row _ held
 have full := (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mp member
 have cross := (JunctionCoupling.crossingExactly inside c).mp full.2
 exact ⟨c,full.1,cross.1,cross.2,same.symm,JunctionCoupling.depletionAndFieldShareCharge c⟩

theorem everyCrossingRecorded (inside : String → Bool)
 (history : List (Coupling (Part := Part) (Support := Support) (State := State)
 (ClockState := ClockState) (Clock := Clock))) (c : Coupling (Part := Part)
 (Support := Support) (State := State) (ClockState := ClockState) (Clock := Clock))
 (held : c ∈ history) (source : inside c.transfer.source = true)
 (destination : inside c.transfer.destination = false) :
 JunctionCoupling.retainedResponse c ∈ records inside history :=
 SFT.Foundation.Count.TraceDerivation.memMap _ _ _
  ((SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr
   ⟨held,(JunctionCoupling.crossingExactly inside c).mpr ⟨source,destination⟩⟩)
end SFT.Materials.JunctionPreservation
