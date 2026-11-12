import SFT.Materials.MaterialInterface
import SFT.Physics.FieldSourceContinuity
import SFT.Physics.FieldElectricDistinction
import SFT.Mathematics.FoldScalar
namespace SFT.Materials.JunctionTransfer
open SFT.Physics SFT.Physics.MechanicalConservation
open SFT.Foundation.ExactOperations SFT.Mathematics.FoldScalar

-- Original SEMI-JUNCTION transfer: the source is depleted by the same
-- carrier occurrence that arrives across the retained material interface.
def spaceCharge (transfer : Transfer String FieldElectricDistinction.Charge) :=
 ((transfer.source,FieldElectricDistinction.reverse transfer.carrier),
  (transfer.destination,transfer.carrier),transfer.sourceIdentity,transfer.actionRecord)

theorem chargeMagnitudePaired (transfer : Transfer String FieldElectricDistinction.Charge) :
 (spaceCharge transfer).1.2.amount = (spaceCharge transfer).2.1.2.amount :=
 FieldElectricDistinction.reversalRetainsAmount transfer.carrier

theorem chargeOrientationsOpposed (transfer : Transfer String FieldElectricDistinction.Charge) :
 (spaceCharge transfer).1.2.held =
 MechanicalLocation.opposite (spaceCharge transfer).2.1.2.held := rfl

theorem transferAndChargeProvenanceRetained (transfer : Transfer String FieldElectricDistinction.Charge) :
 (spaceCharge transfer).1.1 = transfer.source ∧
 (spaceCharge transfer).2.1.1 = transfer.destination ∧
 (spaceCharge transfer).2.2.1 = transfer.sourceIdentity ∧
 (spaceCharge transfer).2.2.2 = transfer.actionRecord := ⟨rfl,rfl,rfl,rfl⟩

def depletion (inside : String → Bool) (network : Network String FieldElectricDistinction.Charge) :=
 (FieldSourceContinuity.outward inside network).map spaceCharge

theorem depletionExactly (inside : String → Bool) (network : Network String FieldElectricDistinction.Charge)
 (record) : record ∈ depletion inside network ↔
 ∃ transfer, transfer ∈ network ∧ inside transfer.source = true ∧
 inside transfer.destination = false ∧ spaceCharge transfer = record := by
 constructor
 · intro h
   obtain ⟨transfer,held,same⟩ := SFT.Foundation.Count.TraceDerivation.memMapPreimage spaceCharge record _ h
   have p := (FieldSourceContinuity.outwardMember inside network transfer).mp held
   exact ⟨transfer,p.1,p.2.1,p.2.2,same⟩
 · intro ⟨transfer,held,source,destination,same⟩
   cases same
   exact SFT.Foundation.Count.TraceDerivation.memMap spaceCharge transfer _
    ((FieldSourceContinuity.outwardMember inside network transfer).mpr ⟨held,source,destination⟩)

theorem everyInterfaceTransferHasRetainedEndpoints (carrier : MaterialInterface.Carrier)
 (edge : SFT.Mathematics.GraphOperations.Edge) (held : edge ∈ MaterialInterface.boundary carrier)
 (transfer : Transfer String FieldElectricDistinction.Charge)
 (bound : MaterialInterface.onBoundary edge transfer) :
 (spaceCharge transfer).1.1 ∈ carrier.lattice.cells.graph.nodes ∧
 (spaceCharge transfer).2.1.1 ∈ carrier.lattice.cells.graph.nodes :=
 MaterialInterface.transferEndpointsHeld carrier edge held transfer bound

theorem exactDepletionTransportBalance (inside : String → Bool)
 (network : Network String FieldElectricDistinction.Charge) :
 FieldSourceContinuity.departuresInside inside network + (FieldSourceContinuity.inward inside network).length =
 FieldSourceContinuity.arrivalsInside inside network + (FieldSourceContinuity.outward inside network).length :=
 FieldSourceContinuity.exactInteriorBoundaryBalance inside network

-- Compare transport and opposed field response in their retained common
-- reference. This states the balance criterion without assuming termination.
def residual (transport response : PositiveFraction) : Scalar :=
 opposed .forward .counter transport response

theorem balancedExactly (transport response : PositiveFraction) :
 residual transport response = .emptyOne ↔
 transport.numerator * response.denominator = response.numerator * transport.denominator :=
 opposedEmptyIff .forward .counter transport response

theorem transportSurplus (transport response : PositiveFraction)
 (excess : rightCross transport response < leftCross transport response) :
 residual transport response = .positive .forward (leftRemainder transport response excess) :=
 opposedLeft .forward .counter transport response excess

theorem fieldSurplus (transport response : PositiveFraction)
 (excess : leftCross transport response < rightCross transport response) :
 residual transport response = .positive .counter (rightRemainder transport response excess) :=
 opposedRight .forward .counter transport response excess

theorem transportRemainderRetainsBothResponses (transport response : PositiveFraction)
 (excess : rightCross transport response < leftCross transport response) :
 rightCross transport response * (leftRemainder transport response excess).denominator +
 (leftRemainder transport response excess).numerator * denominator transport response =
 leftCross transport response * (leftRemainder transport response excess).denominator :=
 leftRemainderReconstructs transport response excess
end SFT.Materials.JunctionTransfer
