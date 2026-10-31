import SFT.Physics.MechanicalCompositeCentre
namespace SFT.Physics.MechanicalConservation

-- The source's closed boundary is a complete source/destination ledger.
-- Occurrences, rather than equal-valued labels, identify individual transfers.
structure Transfer (Node Carrier : Type) where
  source : Node
  destination : Node
  carrier : Carrier
  sourceIdentity : String
  actionRecord : SFT.Host.Canonical.Value

abbrev Network (Node Carrier : Type) := List (Transfer Node Carrier)

def departures {Node Carrier : Type} (network : Network Node Carrier) :=
  network.map (fun t => (t.source,t.carrier))

def arrivals {Node Carrier : Type} (network : Network Node Carrier) :=
  network.map (fun t => (t.destination,t.carrier))

def outgoingSupport {Node Carrier : Type} (network : Network Node Carrier) := (departures network).map Prod.snd

def incomingSupport {Node Carrier : Type} (network : Network Node Carrier) := (arrivals network).map Prod.snd

theorem eachDepartureRetainsCarrier {Node Carrier : Type} (network : Network Node Carrier) :
    outgoingSupport network = network.map Transfer.carrier := by
  induction network with
  | nil => rfl
  | cons t ts ih => exact congrArg (List.cons t.carrier) ih

theorem eachArrivalRetainsCarrier {Node Carrier : Type} (network : Network Node Carrier) :
    incomingSupport network = network.map Transfer.carrier := by
  induction network with
  | nil => rfl
  | cons t ts ih => exact congrArg (List.cons t.carrier) ih

theorem completeConservation {Node Carrier : Type} (network : Network Node Carrier) :
    outgoingSupport network = incomingSupport network :=
  (eachDepartureRetainsCarrier network).trans (eachArrivalRetainsCarrier network).symm

-- Every finite occurrence is paired with itself in the received ledger.
def destinationOccurrence {Node Carrier : Type} (network : Network Node Carrier)
    (i : Fin network.length) : Fin network.length := i

def sourceOccurrence {Node Carrier : Type} (network : Network Node Carrier)
    (i : Fin network.length) : Fin network.length := i

theorem occurrenceLeftInverse {Node Carrier : Type} (network : Network Node Carrier) (i : Fin network.length) :
    sourceOccurrence network (destinationOccurrence network i) = i := rfl

theorem occurrenceRightInverse {Node Carrier : Type} (network : Network Node Carrier) (i : Fin network.length) :
    destinationOccurrence network (sourceOccurrence network i) = i := rfl

theorem pairedOccurrenceCarriesSameRecord {Node Carrier : Type} (network : Network Node Carrier)
    (i : Fin network.length) : network.get (destinationOccurrence network i) = network.get i := rfl

theorem carrierCountConserved {Node Carrier : Type} (network : Network Node Carrier) :
    (outgoingSupport network).length = (incomingSupport network).length :=
  congrArg List.length (completeConservation network)

theorem allMechanicalAggregatesConserved {Node Carrier Result : Type} (network : Network Node Carrier)
    (retain : List Carrier → Result) : retain (outgoingSupport network) = retain (incomingSupport network) :=
  congrArg retain (completeConservation network)

theorem appendRetainsPrior {Node Carrier : Type} (left right : Network Node Carrier) :
    (left ++ right).map Transfer.carrier = left.map Transfer.carrier ++ right.map Transfer.carrier :=
  by
    induction left with
    | nil => rfl
    | cons t ts ih => exact congrArg (List.cons t.carrier) ih

theorem changedSourceDistinguished {Node Carrier : Type} (a b : Transfer Node Carrier)
    (h : a.source ≠ b.source) : a ≠ b := fun eq => h (congrArg Transfer.source eq)

theorem changedDestinationDistinguished {Node Carrier : Type} (a b : Transfer Node Carrier)
    (h : a.destination ≠ b.destination) : a ≠ b := fun eq => h (congrArg Transfer.destination eq)

theorem changedProvenanceDistinguished {Node Carrier : Type} (a b : Transfer Node Carrier)
    (h : a.sourceIdentity ≠ b.sourceIdentity ∨ a.actionRecord ≠ b.actionRecord) : a ≠ b := by
  intro eq
  cases h with
  | inl h => exact h (congrArg Transfer.sourceIdentity eq)
  | inr h => exact h (congrArg Transfer.actionRecord eq)

-- The generic ledger retains the entire previously derived mechanical record.
inductive MechanicalCarrier (Part Support State ClockState Clock : Type) where
  | momentum : MechanicalMomentum.Momentum Part Support State ClockState → MechanicalCarrier Part Support State ClockState Clock
  | energy : MechanicalWorkEnergy.EnergyTransfer Part Support State ClockState Clock → MechanicalCarrier Part Support State ClockState Clock

theorem closedMechanicalSupport {Node Part Support State ClockState Clock : Type}
    (network : Network Node (MechanicalCarrier Part Support State ClockState Clock)) :
    outgoingSupport network = incomingSupport network := completeConservation network

end SFT.Physics.MechanicalConservation
