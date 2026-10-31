import SFT.Physics.FieldMagnetic
namespace SFT.Physics.FieldInduction
open MechanicalEvents SFT.Mathematics.FoldScalar

-- The linked support change and the observed cyclic work are retained together;
-- no differential field equation or fitted proportionality is introduced.
structure LinkedChange (Support State ClockState : Type) where
  before : FieldMagnetic.Response Support State ClockState
  after : FieldMagnetic.Response Support State ClockState
  sourceIdentity : String
  changeRecord : SFT.Host.Canonical.Value

structure BoundaryWork (Part Support State ClockState Clock : Type) where
  linked : LinkedChange Support State ClockState
  boundary : MechanicalAngularMotion.Cycle State
  workAt : (row : Row State) → MechanicalWorkEnergy.EnergyTransfer Part Support State ClockState Clock

variable {Part Support State ClockState Clock : Type}

def cyclicTransfers (b : BoundaryWork Part Support State ClockState Clock) :=
  (changes b.boundary.recurrence.path).map (fun step => (b.linked,step,b.boundary.held,b.workAt step))

def boundaryTrace (b : BoundaryWork Part Support State ClockState Clock) :=
  (cyclicTransfers b).map (fun entry => entry.2.1)

theorem completeBoundary (b : BoundaryWork Part Support State ClockState Clock) :
    boundaryTrace b = changes b.boundary.recurrence.path := by
  have all (rows : List (Row State)) :
      (rows.map (fun step => (b.linked,step,b.boundary.held,b.workAt step))).map (fun e => e.2.1) = rows := by
    induction rows with
    | nil => rfl
    | cons x xs ih => exact congrArg (List.cons x) ih
  exact all _

theorem boundaryReturns (b : BoundaryWork Part Support State ClockState Clock) :
    b.boundary.recurrence.first.carrier = b.boundary.recurrence.last.carrier :=
  b.boundary.recurrence.returnsToCarrier.symm

theorem everyChangeRetained (b : BoundaryWork Part Support State ClockState Clock) (step : Row State)
    (h : step ∈ changes b.boundary.recurrence.path) : step ∈ boundaryTrace b := by
  rw [completeBoundary]; exact h

theorem noAdditionalPath (b : BoundaryWork Part Support State ClockState Clock) (step : Row State)
    (h : step ∈ boundaryTrace b) : step ∈ changes b.boundary.recurrence.path := by
  rw [completeBoundary] at h; exact h

theorem sourceChangeRetained (b : BoundaryWork Part Support State ClockState Clock) :
    (cyclicTransfers b).map (fun entry => entry.1) =
      (changes b.boundary.recurrence.path).map (fun _ => b.linked) := by
  have all (rows : List (Row State)) :
      (rows.map (fun step => (b.linked,step,b.boundary.held,b.workAt step))).map (fun e => e.1) =
      rows.map (fun _ => b.linked) := by
    induction rows with
    | nil => rfl
    | cons x xs ih => exact congrArg (List.cons b.linked) ih
  exact all _

theorem completeSourceProvenance (b : BoundaryWork Part Support State ClockState Clock) :
    (boundaryTrace b).map (fun step => (step.sourceIdentity,step.actionRecord)) =
      sourceRecords b.boundary.recurrence.path := by
  rw [completeBoundary]; exact allSourceRecordsRetained _

theorem changedLinkedSupportDistinguished (a b : BoundaryWork Part Support State ClockState Clock)
    (h : a.linked ≠ b.linked) : a ≠ b := fun eq => h (congrArg BoundaryWork.linked eq)

theorem changedBoundaryDistinguished (a b : BoundaryWork Part Support State ClockState Clock)
    (h : a.boundary ≠ b.boundary) : a ≠ b := fun eq => h (congrArg BoundaryWork.boundary eq)

def electricResponse (b : BoundaryWork Part Support State ClockState Clock) (step : Row State) :
    FieldElectricPotential.ElectricInteraction Part Support State ClockState Clock :=
  ⟨b.linked.after.transport.charge,b.workAt step⟩

theorem noAdditionalElectricSource (b : BoundaryWork Part Support State ClockState Clock) (step : Row State) :
    (electricResponse b step).charge = b.linked.after.transport.charge := rfl

theorem inducedPotentialUsesCompleteWork (b : BoundaryWork Part Support State ClockState Clock) (step : Row State) :
    FieldElectricPotential.potentialDifference (electricResponse b step) =
      FieldElectricPotential.normalizeCharge (MechanicalWorkEnergy.energyChange (b.workAt step))
        b.linked.after.transport.charge := rfl

theorem inducedWorkRetained (b : BoundaryWork Part Support State ClockState Clock) (step : Row State) :
    (electricResponse b step).work = b.workAt step := rfl

end SFT.Physics.FieldInduction
