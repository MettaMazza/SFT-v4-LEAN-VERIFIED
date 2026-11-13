import SFT.Materials.DiffusionHistory
import SFT.Mathematics.FoldScalar
namespace SFT.Materials.EnergyConduction
open SFT.Physics SFT.Mathematics.FoldScalar

structure EnergyLabel where
 identity : String
 value : Scalar
 source : SFT.Host.Canonical.Value

-- The existing adjacent-label transport is uniform in its retained carrier.
-- Here the retained labels are the original energy labels.
structure Record where
 transport : DiffusionHistory.Observation EnergyLabel
 scattering : List (ThermoKineticTransport.Collision String EnergyLabel)
 gradient : SFT.Host.Canonical.Value
 conditions : SFT.Host.Canonical.Value

variable (r : Record)

def ledger := DiffusionHistory.records (r.transport.first::r.transport.rest)

theorem energyLabelsConserved :
 DiffusionHistory.content r.transport.start = DiffusionHistory.content r.transport.finish :=
 DiffusionHistory.observationConserves r.transport

theorem energyValuesConserved :
 (DiffusionHistory.content r.transport.start).map EnergyLabel.value =
 (DiffusionHistory.content r.transport.finish).map EnergyLabel.value :=
 congrArg (List.map EnergyLabel.value) (energyLabelsConserved r)

theorem energySourcesConserved :
 (DiffusionHistory.content r.transport.start).map EnergyLabel.source =
 (DiffusionHistory.content r.transport.finish).map EnergyLabel.source :=
 congrArg (List.map EnergyLabel.source) (energyLabelsConserved r)

theorem connectedTransfer (m : DiffusionHistory.Move r.transport.lattice EnergyLabel) :
 (m.source,m.destination) ∈ r.transport.lattice.cells.graph.edges := m.adjacent

theorem retainedMaterialSupport :
 DiffusionHistory.supported r.transport.lattice r.transport.finish :=
 DiffusionHistory.observationSupported r.transport

theorem completeLedgerCount :
 (ledger r).length = (r.transport.first::r.transport.rest).length :=
 DiffusionHistory.exactTransitionCount _

theorem everyTransferHeld (m : DiffusionHistory.Move r.transport.lattice EnergyLabel)
 (held : m ∈ r.transport.first::r.transport.rest) :
 DiffusionHistory.transitionRecord m ∈ ledger r :=
 DiffusionHistory.everyTransitionRecorded _ m held

theorem exactTransferRecurrence :
 (r.transport.first::r.transport.rest).length * (DiffusionHistory.recurrence r.transport).denominator =
 (DiffusionHistory.recurrence r.transport).numerator * r.transport.clock.length :=
 DiffusionHistory.exactDeclaredRecurrence r.transport

theorem scatteringRetainsRecords (c : ThermoKineticTransport.Collision String EnergyLabel)
 (row : MechanicalConservation.Transfer String EnergyLabel) :
 row ∈ c.after ↔ row ∈ c.before := ThermoKineticTransport.collisionRetainsEveryRecord c row

theorem scatteringCount (c : ThermoKineticTransport.Collision String EnergyLabel) :
 c.after.length = c.before.length := ThermoKineticTransport.collisionCountConserved c

theorem scatteringLocal (c : ThermoKineticTransport.Collision String EnergyLabel)
 (row : MechanicalConservation.Transfer String EnergyLabel) (held : row ∈ c.after) :
 row.source = c.cell ∧ row.destination = c.cell := ThermoKineticTransport.collisionRemainsLocal c row held

def record := (r,ledger r,DiffusionHistory.recurrence r.transport)

theorem completeInputRetained : (record r).1 = r := rfl

def records (rs : List Record) := rs.map record

theorem base : records [r] = [record r] := rfl

theorem successor (rs : List Record) : records (rs ++ [r]) = records rs ++ [record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.EnergyConduction
