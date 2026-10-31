import SFT.Physics.MatterSpectrum
namespace SFT.Physics.MatterHadrons
open SFT.Foundation.ExactOperations

structure Joint where
  whole : MatterAntiparticle.Constituent
  returnTrace : List String
  fullPeriod : returnTrace.length = whole.word.state.phaseCycle.length
  first : MatterAntiparticle.Constituent
  second : MatterAntiparticle.Constituent
  rest : List MatterAntiparticle.Constituent
  internalTransfers : MechanicalConservation.Network (Fin (rest.length + 2)) (String × MechanicalLocation.Held)
  totalCarriers : List SFT.Host.Canonical.Value
  name : String

def constituents (j : Joint) := j.first :: j.second :: j.rest

def external (j : Joint) := (j.totalCarriers,j.whole.inertial)

def description (j : Joint) : MatterSpectrum.Description (List SFT.Host.Canonical.Value × PositiveFraction) :=
  ⟨j.whole,j.returnTrace,j.fullPeriod,j.name,external j,[constituents j]⟩

theorem multipleConstituents (j : Joint) : 2 ≤ (constituents j).length :=
  Nat.le_add_left 2 j.rest.length

theorem boundaryClosedSource (j : Joint) (t : MechanicalConservation.Transfer (Fin (j.rest.length + 2)) (String × MechanicalLocation.Held))
    (_held : t ∈ j.internalTransfers) : t.source.val < j.rest.length + 2 ∧ t.destination.val < j.rest.length + 2 :=
  ⟨t.source.isLt,t.destination.isLt⟩

theorem allInternalLabelsPaired (j : Joint) :
    MechanicalConservation.outgoingSupport j.internalTransfers = MechanicalConservation.incomingSupport j.internalTransfers :=
  MechanicalConservation.completeConservation j.internalTransfers

theorem everyInternalAggregatePaired (j : Joint) {Result : Type}
    (aggregate : List (String × MechanicalLocation.Held) → Result) :
    aggregate (MechanicalConservation.outgoingSupport j.internalTransfers) =
      aggregate (MechanicalConservation.incomingSupport j.internalTransfers) :=
  congrArg aggregate (allInternalLabelsPaired j)

theorem externalRetainsTotalAndInertia (j : Joint) :
    (external j).1 = j.totalCarriers ∧ (external j).2 = j.whole.inertial ∧ 0 < (external j).2.numerator :=
  ⟨rfl,rfl,j.whole.inertial.positive⟩

theorem internalRearrangementNotSeparatelyObservable (j : Joint)
    (network : MechanicalConservation.Network (Fin (j.rest.length + 2)) (String × MechanicalLocation.Held)) :
    external {j with internalTransfers := network} = external j := rfl

theorem noExternalReadingSeparatesSameTotals (a b : Joint) (same : external a = external b)
    {Reading : Type} (read : (List SFT.Host.Canonical.Value × PositiveFraction) → Reading) :
    read (external a) = read (external b) := congrArg read same

theorem closedCompositeExcludedFromElementary (j : Joint)
    (rows : List (MatterSpectrum.Description (List SFT.Host.Canonical.Value × PositiveFraction))) :
    description j ∉ MatterSpectrum.elementary rows :=
  MatterSpectrum.properCompositeExcluded rows (description j) (constituents j) (.head _)

theorem jointRecurrenceRetained (j : Joint) :
    SFT.QuantumComputation.ReversibleModel.phaseAction j.whole.word.state j.returnTrace = .ok j.whole.word.state :=
  QuantumPhysicalSpin.fullOrientationRecurrenceReturns _ _ j.fullPeriod
end SFT.Physics.MatterHadrons
