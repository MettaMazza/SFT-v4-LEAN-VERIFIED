import SFT.Materials.JunctionTransfer
import SFT.Physics.CollectivePlasmaOscillation
namespace SFT.Materials.JunctionCoupling
open SFT.Physics SFT.Physics.MechanicalConservation
open SFT.Mathematics.DiscreteObjects

variable {Part Support State ClockState Clock : Type}

def crosses (inside : String → Bool)
 (c : CollectivePlasma.Coupling Part Support State ClockState Clock) : Bool :=
 inside c.transfer.source && !inside c.transfer.destination

def interfaceCouplings (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock) :=
 p.couplings.filter (crosses inside)

theorem crossingExactly (inside : String → Bool)
 (c : CollectivePlasma.Coupling Part Support State ClockState Clock) :
 crosses inside c = true ↔ inside c.transfer.source = true ∧ inside c.transfer.destination = false := by
 constructor
 · intro h
   have parts := (SFT.Mathematics.GeometryTopology.andTrue _ _).mp h
   exact ⟨parts.1,(SFT.Mathematics.GeometryTopology.notTrue _).mp parts.2⟩
 · intro h
   unfold crosses
   rw [h.1,h.2]
   rfl

theorem everyDepletionTransferHasSourceField (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 (t : Transfer String FieldElectricDistinction.Charge)
 (held : t ∈ FieldSourceContinuity.outward inside p.flow.transfers) :
 ∃ c, c ∈ interfaceCouplings inside p ∧ c.transfer = t ∧ c.field.electric.charge = t.carrier := by
 have h := (FieldSourceContinuity.outwardMember _ _ _).mp held
 obtain ⟨c,member,same⟩ := CollectivePlasma.everyMobileCarrierCoupled p t h.1
 refine ⟨c,(filterMemberIff _ _ _).mpr ⟨member,?_⟩,same,?_⟩
 · apply (crossingExactly inside c).mpr
   rw [same]
   exact h.2
 · exact c.commonCharge.symm.trans (congrArg Transfer.carrier same)

theorem noForeignInterfaceField (inside : String → Bool)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 (c : CollectivePlasma.Coupling Part Support State ClockState Clock)
 (held : c ∈ interfaceCouplings inside p) :
 c.transfer ∈ FieldSourceContinuity.outward inside p.flow.transfers := by
 have h := (filterMemberIff _ _ _).mp held
 have direction := (crossingExactly _ _).mp h.2
 exact (FieldSourceContinuity.outwardMember _ _ _).mpr
  ⟨CollectivePlasma.noUnrecordedCoupling p c h.1,direction.1,direction.2⟩

def retainedResponse (c : CollectivePlasma.Coupling Part Support State ClockState Clock) :=
 (JunctionTransfer.spaceCharge c.transfer,FieldElectromagnetic.electricProjection c.field,
  FieldElectromagnetic.magneticProjection c.field,CollectivePlasma.recurrence c,
  c.field.induction)

theorem depletionAndFieldShareCharge (c : CollectivePlasma.Coupling Part Support State ClockState Clock) :
 (JunctionTransfer.spaceCharge c.transfer).2.1.2 = c.field.electric.charge := c.commonCharge

theorem depletedOrientationComesFromSameField (c : CollectivePlasma.Coupling Part Support State ClockState Clock) :
 (JunctionTransfer.spaceCharge c.transfer).1.2.held =
 MechanicalLocation.opposite c.field.electric.charge.held := by
 change MechanicalLocation.opposite c.transfer.carrier.held = _
 rw [c.commonCharge]

theorem responseUsesActualSourceWork (c : CollectivePlasma.Coupling Part Support State ClockState Clock) :
 FieldElectricPotential.field c.field.electric =
 FieldElectricPotential.normalizeCharge (MechanicalForce.value c.field.electric.work.force) c.transfer.carrier := by
 unfold FieldElectricPotential.field
 rw [c.commonCharge]

theorem depletionReversesActualSourceResponse (c : CollectivePlasma.Coupling Part Support State ClockState Clock) :
 FieldElectricPotential.normalizeCharge (MechanicalForce.value c.field.electric.work.force)
   (JunctionTransfer.spaceCharge c.transfer).1.2 =
 SFT.Mathematics.FoldScalar.reverse (FieldElectricPotential.field c.field.electric) := by
 change FieldElectricPotential.normalizeCharge _ (FieldElectricDistinction.reverse c.transfer.carrier) = _
 rw [FieldElectricPotential.reversedChargeReversesResponse,c.commonCharge]
 rfl

theorem sourcePropagationRetained (c : CollectivePlasma.Coupling Part Support State ClockState Clock) :
 (retainedResponse c).2.2.2.1 = FieldElectromagnetic.propagation c.field ∧
 (retainedResponse c).2.2.2.2 = c.field.induction := ⟨rfl,rfl⟩

theorem exactResponseNormalization (c : CollectivePlasma.Coupling Part Support State ClockState Clock)
 (magnitude : SFT.Foundation.ExactOperations.PositiveFraction) :
 (magnitude.numerator*c.transfer.carrier.amount.denominator)*
 (SFT.Mathematics.FoldScalar.quotientMagnitude magnitude c.transfer.carrier.amount).denominator =
 (SFT.Mathematics.FoldScalar.quotientMagnitude magnitude c.transfer.carrier.amount).numerator*
 (magnitude.denominator*c.transfer.carrier.amount.numerator) := by
 rw [c.commonCharge]
 exact FieldElectricPotential.normalizationExact c.field.electric magnitude
def dopedInterfaceCouplings
 (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock) :=
 p.couplings.filter (fun c => JunctionTransfer.opposedDopedEndpoints before after c.transfer)

-- Bind the entry-specific opposed-support selection to the same existing
-- charge/field couplings, without supplying an independent field reading.
theorem everyDopedInterfaceTransferHasSourceField
 (before after : String → SFT.Mathematics.DiscreteObjects.Collection)
 (p : CollectivePlasma.Plasma Part Support State ClockState Clock)
 (t : Transfer String FieldElectricDistinction.Charge)
 (held : t ∈ JunctionTransfer.dopedInterfaceTransfers before after p.flow.transfers) :
 ∃ c, c ∈ dopedInterfaceCouplings before after p ∧ c.transfer = t ∧
 (JunctionTransfer.spaceCharge t).2.1.2 = c.field.electric.charge := by
 have h := (filterMemberIff _ _ _).mp held
 obtain ⟨c,member,same⟩ := CollectivePlasma.everyMobileCarrierCoupled p t h.1
 refine ⟨c,(filterMemberIff _ _ _).mpr ⟨member,?_⟩,same,?_⟩
 · rw [same]
   exact h.2
 · have charge := depletionAndFieldShareCharge c
   rw [same] at charge
   exact charge

-- Reconstruct force from the field and the very same transported charge.
-- V3 field_laws.ELECTRIC_POTENTIAL and calculator/values.py scalar division.
def reconstructedTransferForce
 (c : CollectivePlasma.Coupling Part Support State ClockState Clock) :=
 SFT.Mathematics.FoldScalar.multiply (FieldElectricPotential.field c.field.electric)
  (.positive (MechanicalAcceleration.scalarOrientation c.transfer.carrier.held)
   c.transfer.carrier.amount)

theorem fieldReconstructsActualForce
 (c : CollectivePlasma.Coupling Part Support State ClockState Clock) :
 match MechanicalForce.value c.field.electric.work.force with
 | .emptyOne => reconstructedTransferForce c = .emptyOne
 | .positive orientation magnitude =>
   ∃ recovered, reconstructedTransferForce c = .positive orientation recovered ∧
    magnitude.numerator * recovered.denominator = recovered.numerator * magnitude.denominator := by
 unfold reconstructedTransferForce FieldElectricPotential.field
 rw [← c.commonCharge]
 cases force : MechanicalForce.value c.field.electric.work.force with
 | emptyOne => rfl
 | positive orientation magnitude =>
   let q := c.transfer.carrier.amount
   let recovered := SFT.Mathematics.ExactRatioRelations.compose
    (SFT.Mathematics.FoldScalar.quotientMagnitude magnitude q) q
   refine ⟨recovered,?_,?_⟩
   · change SFT.Mathematics.FoldScalar.Scalar.positive
      (SFT.Mathematics.FoldScalar.productOrientation
       (SFT.Mathematics.FoldScalar.productOrientation orientation
        (MechanicalAcceleration.scalarOrientation c.transfer.carrier.held))
       (MechanicalAcceleration.scalarOrientation c.transfer.carrier.held)) recovered = _
     cases orientation <;> cases c.transfer.carrier.held <;> rfl
   · have h := SFT.Mathematics.ExactRatioRelations.composeRepresents
      (SFT.Mathematics.FoldScalar.quotientMagnitude magnitude q) q
      (magnitude.numerator*q.denominator) (magnitude.denominator*q.numerator)
      q.numerator q.denominator (SFT.Mathematics.FoldScalar.quotientExact magnitude q) rfl
     apply SFT.Mathematics.ExactRatioRelations.cancelPositive (q.denominator*q.numerator)
      _ _ (Nat.mul_pos (Nat.pos_of_ne_zero q.denominatorNonzero) q.positive)
     calc
      (q.denominator*q.numerator)*(magnitude.numerator*recovered.denominator) =
       ((magnitude.numerator*q.denominator)*q.numerator)*recovered.denominator := by
        rw [← SFT.Foundation.FractionReduction.mulAssoc, Nat.mul_comm (q.denominator*q.numerator) magnitude.numerator,
          ← SFT.Foundation.FractionReduction.mulAssoc magnitude.numerator q.denominator q.numerator]
      _ = recovered.numerator*((magnitude.denominator*q.numerator)*q.denominator) := h
      _ = (q.denominator*q.numerator)*(recovered.numerator*magnitude.denominator) := by
        rw [SFT.Foundation.FractionReduction.mulAssoc magnitude.denominator q.numerator q.denominator,
          Nat.mul_comm q.numerator q.denominator,
          ← SFT.Foundation.FractionReduction.mulAssoc recovered.numerator magnitude.denominator (q.denominator*q.numerator),
          Nat.mul_comm (recovered.numerator*magnitude.denominator) (q.denominator*q.numerator)]

end SFT.Materials.JunctionCoupling
