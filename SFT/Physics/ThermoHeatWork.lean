import SFT.Physics.ThermoEquilibriumExchange
import SFT.InformationScience.ConservationReverse
namespace SFT.Physics.ThermoHeatWork
open SFT.InformationScience SFT.Mathematics.ProbabilityObservations
open SFT.Mathematics.GeometryTopology

-- HEAT_WORK uses the inherited closed/retained observation distinction.
-- The complete energy-transfer network is retained independently of which
-- of its source labels the receiving observation resolves.
structure ObservedTransfers (Node Carrier : Type) where
  network : MechanicalConservation.Network Node Carrier
  sourceSupport : List String
  receiver : Observation
  valid : ConservationLedger.validateTransformation sourceSupport receiver = .ok receiver
  sourceLabelsPresent : ∀ t, t ∈ network → t.sourceIdentity ∈ sourceSupport

variable {Node Carrier : Type}

def closedLabels (o : ObservedTransfers Node Carrier) := ConservationLedger.closed o.sourceSupport o.receiver
def heldLabels (o : ObservedTransfers Node Carrier) := ConservationLedger.retained o.sourceSupport o.receiver

inductive LabelClass where | closed | held

def classify (o : ObservedTransfers Node Carrier) (pair : String × String) : LabelClass :=
  if image o.receiver pair.1 = image o.receiver pair.2 then .closed else .held

theorem closedMeaning (o : ObservedTransfers Node Carrier) (pair : String × String) :
    pair ∈ closedLabels o ↔ pair ∈ EncodingLoss.sourcePairs o.sourceSupport ∧
      image o.receiver pair.1 = image o.receiver pair.2 := ConservationLedger.closedMeaning _ _ _

theorem heldMeaning (o : ObservedTransfers Node Carrier) (pair : String × String) :
    pair ∈ heldLabels o ↔ pair ∈ EncodingLoss.sourcePairs o.sourceSupport ∧
      image o.receiver pair.1 ≠ image o.receiver pair.2 := ConservationLedger.retainedMeaning _ _ _

theorem completeClassification (o : ObservedTransfers Node Carrier) (pair : String × String)
    (member : pair ∈ EncodingLoss.sourcePairs o.sourceSupport) :
    pair ∈ heldLabels o ∨ pair ∈ closedLabels o := ConservationLedger.pairExhaustion _ _ _ member

theorem classesDisjoint (o : ObservedTransfers Node Carrier) (pair : String × String)
    (held : pair ∈ heldLabels o) (closed : pair ∈ closedLabels o) : False :=
  ConservationLedger.pairDisjoint _ _ _ held closed

theorem heatLabelClosedInReceiver (o : ObservedTransfers Node Carrier) (pair : String × String)
    (closed : pair ∈ closedLabels o) :
    ∃ label, pair.1 ∈ fibre o.sourceSupport o.receiver label ∧ pair.2 ∈ fibre o.sourceSupport o.receiver label :=
  ConservationLedger.closedFibre _ _ _ o.valid closed

theorem workLabelRemainsDistinguishable (o : ObservedTransfers Node Carrier) (pair : String × String)
    (held : pair ∈ heldLabels o) : image o.receiver pair.1 ≠ image o.receiver pair.2 :=
  ((heldMeaning o pair).mp held).2

theorem closedLabelNotReconstructible (o : ObservedTransfers Node Carrier) (pair : String × String)
    (closed : pair ∈ closedLabels o) (different : pair.1 ≠ pair.2)
    (decode : Option String → String)
    (left : decode (image o.receiver pair.1) = pair.1)
    (right : decode (image o.receiver pair.2) = pair.2) : False :=
  different (left.symm.trans ((congrArg decode ((closedMeaning o pair).mp closed).2).trans right))

theorem completeEnergyProvenance (o : ObservedTransfers Node Carrier) :
    MechanicalConservation.outgoingSupport o.network = MechanicalConservation.incomingSupport o.network :=
  MechanicalConservation.completeConservation _

theorem everyOriginalCarrierRetained (o : ObservedTransfers Node Carrier) :
    MechanicalConservation.outgoingSupport o.network = o.network.map MechanicalConservation.Transfer.carrier :=
  MechanicalConservation.eachDepartureRetainsCarrier _
end SFT.Physics.ThermoHeatWork
