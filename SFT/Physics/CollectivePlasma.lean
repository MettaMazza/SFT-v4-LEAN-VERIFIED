import SFT.Physics.CollectiveTurbulence
import SFT.Physics.FieldElectromagnetic
namespace SFT.Physics.CollectivePlasma
open MechanicalConservation FieldElectricDistinction

structure Coupling (Part Support State ClockState Clock : Type) where
 transfer : Transfer String Charge
 field : FieldElectromagnetic.Carrier Part Support State ClockState Clock
 commonCharge : transfer.carrier = field.electric.charge

structure Plasma (Part Support State ClockState Clock : Type) where
 flow : CollectiveFlow.Flow Charge
 couplings : List (Coupling Part Support State ClockState Clock)
 complete : couplings.map Coupling.transfer = flow.transfers

variable {Part Support State ClockState Clock : Type}

def recurrence (c : Coupling Part Support State ClockState Clock) := FieldElectromagnetic.propagation c.field

def collectiveRecurrence (p : Plasma Part Support State ClockState Clock) :=
 p.couplings.map (fun c => FieldElectromagnetic.cycleRows (recurrence c))

theorem everyMobileCarrierCoupled (p : Plasma Part Support State ClockState Clock)
 (t : Transfer String Charge) (held : t ∈ p.flow.transfers) :
 ∃ c, c ∈ p.couplings ∧ c.transfer = t := by
 rw [← p.complete] at held
 exact SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ held

theorem noUnrecordedCoupling (p : Plasma Part Support State ClockState Clock)
 (c : Coupling Part Support State ClockState Clock) (held : c ∈ p.couplings) :
 c.transfer ∈ p.flow.transfers := by
 rw [← p.complete]
 exact SFT.Foundation.Count.TraceDerivation.memMap _ _ _ held

theorem couplingIsAdjacent (p : Plasma Part Support State ClockState Clock)
 (c : Coupling Part Support State ClockState Clock) (held : c ∈ p.couplings) :
 (c.transfer.source,c.transfer.destination) ∈ p.flow.cells.graph.edges :=
 p.flow.adjacent _ (noUnrecordedCoupling p c held)

theorem twoOrientationsExhaust (c : Coupling Part Support State ClockState Clock) :
 c.transfer.carrier.held = .first ∨ c.transfer.carrier.held = .second := twoFibresExhaust _

theorem magneticChargeIsTransportedCharge (c : Coupling Part Support State ClockState Clock) :
 c.field.magnetic.transport.charge = c.transfer.carrier :=
 c.field.commonSource.trans c.commonCharge.symm

theorem collectiveChargeConserved (p : Plasma Part Support State ClockState Clock) :
 outgoingSupport p.flow.transfers = incomingSupport p.flow.transfers := closedChargeConservation _

theorem heldOrientationsConserved (p : Plasma Part Support State ClockState Clock) :
 (outgoingSupport p.flow.transfers).map Charge.held =
 (incomingSupport p.flow.transfers).map Charge.held := closedHeldLabelConservation _

theorem bothRecurrenceLegsComplete (c : Coupling Part Support State ClockState Clock) :
 FieldElectromagnetic.electricLegs (FieldElectromagnetic.cycleRows (recurrence c)) = recurrence c ∧
 FieldElectromagnetic.magneticLegs (FieldElectromagnetic.cycleRows (recurrence c)) = recurrence c :=
 ⟨FieldElectromagnetic.everyElectricLeg _,FieldElectromagnetic.everyMagneticLeg _⟩

theorem coupledMotionRetainsCarrier (c : Coupling Part Support State ClockState Clock)
 (step : MechanicalEvents.Row State) :
 (FieldInduction.electricResponse c.field.induction step).charge = c.transfer.carrier :=
 (FieldElectromagnetic.changingMagneticReturnsSameElectricSource c.field step).trans c.commonCharge.symm

theorem completeCollectiveCensus (p : Plasma Part Support State ClockState Clock) :
 (collectiveRecurrence p).length = p.flow.transfers.length := by
 have h : (collectiveRecurrence p).length = p.couplings.length := by
  unfold collectiveRecurrence
  induction p.couplings with
  | nil => rfl
  | cons c rest ih => exact congrArg Nat.succ ih
 have t : (p.couplings.map Coupling.transfer).length = p.couplings.length := by
  induction p.couplings with
  | nil => rfl
  | cons c rest ih => exact congrArg Nat.succ ih
 rw [p.complete] at t
 exact h.trans t.symm

theorem fieldResponseUnique (c : Coupling Part Support State ClockState Clock)
 (q r : Charge) (hq : q = c.field.magnetic.transport.charge)
 (hr : r = c.field.magnetic.transport.charge) : q = r := hq.trans hr.symm
end SFT.Physics.CollectivePlasma
