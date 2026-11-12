import SFT.Materials.JunctionObservation
namespace SFT.Materials.JunctionPreservation
open SFT.Physics
variable {Part Support State ClockState Clock : Type}
abbrev Coupling := CollectivePlasma.Coupling Part Support State ClockState Clock

-- The source induction appends a transition while keeping every earlier row.
def records (before after : String → SFT.Mathematics.DiscreteObjects.Collection) (history : List (Coupling (Part := Part)
 (Support := Support) (State := State) (ClockState := ClockState) (Clock := Clock))) :=
 (history.filter (fun c => JunctionTransfer.opposedDopedEndpoints before after c.transfer)).map JunctionCoupling.retainedResponse

theorem base (before after : String → SFT.Mathematics.DiscreteObjects.Collection) (c : Coupling (Part := Part) (Support := Support)
 (State := State) (ClockState := ClockState) (Clock := Clock)) :
 records before after [c] = match JunctionTransfer.opposedDopedEndpoints before after c.transfer with
 | true => [JunctionCoupling.retainedResponse c]
 | false => [] := by
 unfold records
 change (match JunctionTransfer.opposedDopedEndpoints before after c.transfer with
  | true => [c]
  | false => []).map JunctionCoupling.retainedResponse = _
 cases JunctionTransfer.opposedDopedEndpoints before after c.transfer <;> rfl

theorem appendExactly (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (earlier later : List (Coupling (Part := Part) (Support := Support) (State := State)
 (ClockState := ClockState) (Clock := Clock))) :
 records before after (earlier ++ later) = records before after earlier ++ records before after later := by
 induction earlier with
 | nil => rfl
 | cons c rest ih =>
   cases h : JunctionTransfer.opposedDopedEndpoints before after c.transfer <;>
    simp only [records,List.cons_append,List.filter,h,List.map] at *
   · exact ih
   · exact congrArg (List.cons _) ih

theorem successorExactly (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (history : List (Coupling (Part := Part) (Support := Support) (State := State)
 (ClockState := ClockState) (Clock := Clock))) (c : Coupling (Part := Part)
 (Support := Support) (State := State) (ClockState := ClockState) (Clock := Clock)) :
 records before after (history ++ [c]) = records before after history ++
 (match JunctionTransfer.opposedDopedEndpoints before after c.transfer with
 | true => [JunctionCoupling.retainedResponse c]
 | false => []) := by
 rw [appendExactly,base]

theorem earlierRowsRetained (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (earlier later : List (Coupling (Part := Part) (Support := Support) (State := State)
 (ClockState := ClockState) (Clock := Clock))) (row)
 (held : row ∈ records before after earlier) : row ∈ records before after (earlier ++ later) := by
 rw [appendExactly]
 exact SFT.Foundation.Count.TraceDerivation.memAppendLeft _ _ _ held

theorem everyRowHasActualTransferAndField (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (history : List (Coupling (Part := Part) (Support := Support) (State := State)
 (ClockState := ClockState) (Clock := Clock))) (row)
 (held : row ∈ records before after history) :
 ∃ c, c ∈ history ∧ JunctionTransfer.opposedDopedEndpoints before after c.transfer = true ∧ row = JunctionCoupling.retainedResponse c ∧
 (JunctionTransfer.spaceCharge c.transfer).2.1.2 = c.field.electric.charge := by
 obtain ⟨c,member,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage
  JunctionCoupling.retainedResponse row _ held
 have full := (SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mp member
 exact ⟨c,full.1,full.2,same.symm,JunctionCoupling.depletionAndFieldShareCharge c⟩

theorem everyCrossingRecorded (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (history : List (Coupling (Part := Part) (Support := Support) (State := State)
 (ClockState := ClockState) (Clock := Clock))) (c : Coupling (Part := Part)
 (Support := Support) (State := State) (ClockState := ClockState) (Clock := Clock))
 (held : c ∈ history) (opposed : JunctionTransfer.opposedDopedEndpoints before after c.transfer = true) :
 JunctionCoupling.retainedResponse c ∈ records before after history :=
 SFT.Foundation.Count.TraceDerivation.memMap _ _ _
  ((SFT.Mathematics.DiscreteObjects.filterMemberIff _ _ _).mpr
   ⟨held,opposed⟩)
end SFT.Materials.JunctionPreservation
