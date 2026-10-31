import SFT.Physics.WaveResonance
import SFT.Physics.FieldActionReaction
namespace SFT.Physics.WaveEnergyMomentum

structure Transport (Part Support State ClockState Clock Cell : Type) where
  carrier : FieldRadiation.Carrier Part Support State ClockState Clock
  start : MechanicalEvents.Event Cell
  adjacent : MechanicalEvents.Event Cell → MechanicalEvents.Event Cell → Prop
  arrival : FieldLocality.Arrival adjacent start
  held : MechanicalLocation.Held
  momentumHeld : MechanicalMomentum.orientation carrier.momentum = held
  actionRecord : SFT.Host.Canonical.Value

variable {Part Support State ClockState Clock Cell : Type}

def transfer (t : Transport Part Support State ClockState Clock Cell) :=
  (⟨t.start,t.arrival.destination,t.carrier,t.carrier.sourceIdentity,t.actionRecord⟩ :
    MechanicalConservation.Transfer (MechanicalEvents.Event Cell) (FieldRadiation.Carrier Part Support State ClockState Clock))

def sourceLoss (t : Transport Part Support State ClockState Clock Cell) := FieldActionReaction.sourceLoss (transfer t)
def remoteGain (t : Transport Part Support State ClockState Clock Cell) := FieldActionReaction.recipientGain (transfer t)

def pathRecords (t : Transport Part Support State ClockState Clock Cell) :=
  (MechanicalEvents.changes (FieldLocality.trace t.arrival.propagation)).map (fun row => (row,t.carrier,t.held))

theorem sameEnergyAtBothEnds (t : Transport Part Support State ClockState Clock Cell) :
    (sourceLoss t).carrier.energy = (remoteGain t).carrier.energy := rfl

theorem sameWorkAtBothEnds (t : Transport Part Support State ClockState Clock Cell) :
    MechanicalWorkEnergy.value (sourceLoss t).carrier.energy = MechanicalWorkEnergy.value (remoteGain t).carrier.energy := rfl

theorem sameMomentumAtBothEnds (t : Transport Part Support State ClockState Clock Cell) :
    (sourceLoss t).carrier.momentum = (remoteGain t).carrier.momentum := rfl

theorem heldMomentumAtResponse (t : Transport Part Support State ClockState Clock Cell) :
    MechanicalMomentum.orientation (remoteGain t).carrier.momentum = t.held := t.momentumHeld

theorem completePathRecovered (t : Transport Part Support State ClockState Clock Cell) :
    (pathRecords t).map Prod.fst = MechanicalEvents.changes (FieldLocality.trace t.arrival.propagation) := by
  have all (rows : List (MechanicalEvents.Row Cell)) :
      (rows.map (fun row => (row,t.carrier,t.held))).map Prod.fst = rows := by
    induction rows with
    | nil => rfl
    | cons row rest ih => exact congrArg (List.cons row) ih
  exact all _

theorem eachPathRecordRetainsCarrier (t : Transport Part Support State ClockState Clock Cell) :
    ∀ row ∈ pathRecords t, row.2.1 = t.carrier ∧ row.2.2 = t.held := by
  intro row member
  obtain ⟨original,_,eq⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage _ _ _ member
  cases eq
  exact ⟨rfl,rfl⟩

theorem eachPathTransitionCausal (t : Transport Part Support State ClockState Clock Cell) :
    ∀ row ∈ MechanicalEvents.changes (FieldLocality.trace t.arrival.propagation), t.adjacent row.before row.after :=
  FieldLocality.everyTransitionAdjacent _

theorem sourceResponseAccountingOpposed (t : Transport Part Support State ClockState Clock Cell) :
    (remoteGain t).held = MechanicalLocation.opposite (sourceLoss t).held := rfl

theorem completeNetworkConservation (ts : List (Transport Part Support State ClockState Clock Cell)) :
    MechanicalConservation.outgoingSupport (ts.map transfer) = MechanicalConservation.incomingSupport (ts.map transfer) :=
  MechanicalConservation.completeConservation _
end SFT.Physics.WaveEnergyMomentum
