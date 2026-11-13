import SFT.Materials.EnergyConduction
import SFT.Physics.FieldElectricDistinction
namespace SFT.Materials.Thermoelectric
open SFT.Physics

structure ChargeLabel where
 identity : String
 charge : FieldElectricDistinction.Charge
 source : SFT.Host.Canonical.Value

-- Original FUNC-THERMOELECTRIC: both complete transport ledgers share the
-- actual material lattice. Temperature gradient and direction are retained
-- observation conditions, not coefficients selecting the relation.
structure Record where
 energy : EnergyConduction.Record
 charge : DiffusionHistory.Observation ChargeLabel
 sameNetwork : charge.lattice = energy.transport.lattice
 directionConditions : SFT.Host.Canonical.Value
 provenance : SFT.Host.Canonical.Value

def chargeLedger (r : Record) := DiffusionHistory.records (r.charge.first::r.charge.rest)

theorem energyConserved (r : Record) :
 DiffusionHistory.content r.energy.transport.start = DiffusionHistory.content r.energy.transport.finish :=
 EnergyConduction.energyLabelsConserved _

theorem chargeConserved (r : Record) :
 DiffusionHistory.content r.charge.start = DiffusionHistory.content r.charge.finish :=
 DiffusionHistory.observationConserves _

theorem jointConservation (r : Record) :
 (DiffusionHistory.content r.energy.transport.start,DiffusionHistory.content r.charge.start) =
 (DiffusionHistory.content r.energy.transport.finish,DiffusionHistory.content r.charge.finish) := by
 rw [energyConserved r,chargeConserved r]

theorem heldChargesConserved (r : Record) :
 (DiffusionHistory.content r.charge.start).map ChargeLabel.charge =
 (DiffusionHistory.content r.charge.finish).map ChargeLabel.charge :=
 congrArg (List.map ChargeLabel.charge) (chargeConserved r)

theorem chargeSourcesConserved (r : Record) :
 (DiffusionHistory.content r.charge.start).map ChargeLabel.source =
 (DiffusionHistory.content r.charge.finish).map ChargeLabel.source :=
 congrArg (List.map ChargeLabel.source) (chargeConserved r)

theorem energyValuesConserved (r : Record) :
 (DiffusionHistory.content r.energy.transport.start).map EnergyConduction.EnergyLabel.value =
 (DiffusionHistory.content r.energy.transport.finish).map EnergyConduction.EnergyLabel.value :=
 EnergyConduction.energyValuesConserved _

theorem chargeSupportedOnEnergyNetwork (r : Record) :
 DiffusionHistory.supported r.energy.transport.lattice r.charge.finish := by
 rw [← r.sameNetwork]
 exact DiffusionHistory.observationSupported _

theorem energySupportedOnJointNetwork (r : Record) :
 DiffusionHistory.supported r.energy.transport.lattice r.energy.transport.finish :=
 EnergyConduction.retainedMaterialSupport _

theorem chargeTransferOnJointNetwork (r : Record) (move : DiffusionHistory.Move r.charge.lattice ChargeLabel) :
 (move.source,move.destination) ∈ r.energy.transport.lattice.cells.graph.edges := by
 rw [← r.sameNetwork]
 exact move.adjacent

theorem completeChargeLedgerCount (r : Record) :
 (chargeLedger r).length = (r.charge.first::r.charge.rest).length := DiffusionHistory.exactTransitionCount _

theorem everyChargeTransferRetained (r : Record) (move : DiffusionHistory.Move r.charge.lattice ChargeLabel)
 (member : move ∈ r.charge.first::r.charge.rest) :
 DiffusionHistory.transitionRecord move ∈ chargeLedger r := DiffusionHistory.everyTransitionRecorded _ move member

theorem completeEnergyLedgerCount (r : Record) :
 (EnergyConduction.ledger r.energy).length = (r.energy.transport.first::r.energy.transport.rest).length :=
 EnergyConduction.completeLedgerCount _

theorem chargeRecurrenceExact (r : Record) :
 (r.charge.first::r.charge.rest).length * (DiffusionHistory.recurrence r.charge).denominator =
 (DiffusionHistory.recurrence r.charge).numerator * r.charge.clock.length :=
 DiffusionHistory.exactDeclaredRecurrence _

def record (r : Record) := (r,EnergyConduction.record r.energy,chargeLedger r,DiffusionHistory.recurrence r.charge)

theorem completeInputRetained (r : Record) : (record r).1 = r := rfl

theorem gradientRetained (r : Record) : (record r).1.energy.gradient = r.energy.gradient := rfl

def records (rs : List Record) := rs.map record

theorem base (r : Record) : records [r] = [record r] := rfl

theorem successor (rs : List Record) (r : Record) : records (rs++[r]) = records rs++[record r] := by
 induction rs with
 | nil => rfl
 | cons h t ih => exact congrArg (List.cons (record h)) ih
end SFT.Materials.Thermoelectric
