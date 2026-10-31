import SFT.Physics.MechanicalForce
namespace SFT.Physics.MechanicalWorkEnergy
open SFT.Mathematics.FoldScalar SFT.Physics.MechanicalEvents

structure Work (Part Support State ClockState Clock : Type) where
  force : MechanicalForce.Force Part Support State ClockState Clock
  displacement : MechanicalLocation.Displacement Support

def displacementScalar {Support : Type} (d : MechanicalLocation.Displacement Support) : Scalar :=
  .positive (MechanicalAcceleration.scalarOrientation d.held) d.separation

def value {Part Support State ClockState Clock : Type}
    (w : Work Part Support State ClockState Clock) : Scalar :=
  multiply (MechanicalForce.value w.force) (displacementScalar w.displacement)

-- Every source-bound transfer row is paired with the full held displacement.
def interactionCells {Part Support State ClockState Clock : Type}
    (w : Work Part Support State ClockState Clock) :=
  MechanicalMomentum.cells (changes w.force.interval) w.displacement

abbrev EnergyTransfer := Work

def energyChange {Part Support State ClockState Clock : Type}
    (w : EnergyTransfer Part Support State ClockState Clock) := value w

theorem exactComposition {Part Support State ClockState Clock : Type}
    (w : Work Part Support State ClockState Clock) :
    value w = multiply (MechanicalForce.value w.force) (displacementScalar w.displacement) := rfl

theorem retainsEveryTransferRow {Part Support State ClockState Clock : Type}
    (w : Work Part Support State ClockState Clock) :
    (interactionCells w).map Prod.fst = changes w.force.interval :=
  MechanicalMomentum.cellsRetainEveryPart _ _

theorem interactionCount {Part Support State ClockState Clock : Type}
    (w : Work Part Support State ClockState Clock) :
    (interactionCells w).length = count w.force.interval := MechanicalMomentum.cellsCount _ _

theorem interactionMembership {Part Support State ClockState Clock : Type}
    (w : Work Part Support State ClockState Clock)
    (row : Row (MechanicalMomentum.Momentum Part Support State ClockState))
    (d : MechanicalLocation.Displacement Support) :
    (row,d) ∈ interactionCells w ↔ row ∈ changes w.force.interval ∧ d = w.displacement :=
  MechanicalMomentum.cellMembership _ _ _ _

theorem positiveCompositionExact {Part Support State ClockState Clock : Type}
    (w : Work Part Support State ClockState Clock) (o : Orientation)
    (f : SFT.Foundation.ExactOperations.PositiveFraction)
    (forceValue : MechanicalForce.value w.force = .positive o f) :
    value w = .positive (productOrientation o (MechanicalAcceleration.scalarOrientation w.displacement.held))
      (SFT.Mathematics.ExactRatioRelations.compose f w.displacement.separation) := by
  unfold value displacementScalar
  rw [forceValue]
  rfl

theorem emptyTransferIsEmpty {Part Support State ClockState Clock : Type}
    (w : Work Part Support State ClockState Clock)
    (forceValue : MechanicalForce.value w.force = .emptyOne) : value w = .emptyOne := by
  unfold value
  rw [forceValue]
  rfl

theorem energyIsRetainedWork {Part Support State ClockState Clock : Type}
    (w : EnergyTransfer Part Support State ClockState Clock) : energyChange w = value w := rfl

theorem energyRetainsInteraction {Part Support State ClockState Clock : Type}
    (w : EnergyTransfer Part Support State ClockState Clock) :
    (Work.mk w.force w.displacement : Work Part Support State ClockState Clock) = w := rfl

theorem changedForceDistinguished {Part Support State ClockState Clock : Type}
    (a b : Work Part Support State ClockState Clock) (changed : a.force ≠ b.force) : a ≠ b :=
  fun equal => changed (congrArg Work.force equal)

theorem changedDisplacementDistinguished {Part Support State ClockState Clock : Type}
    (a b : Work Part Support State ClockState Clock) (changed : a.displacement ≠ b.displacement) : a ≠ b :=
  fun equal => changed (congrArg Work.displacement equal)

def forceDimension (mass length time : DimensionComposition.Path) :=
  DimensionComposition.Path.quotient (.product mass (.quotient length time)) time

def workDimension (mass length time : DimensionComposition.Path) :=
  DimensionComposition.Path.product (forceDimension mass length time) length

def energyDimension (mass length time : DimensionComposition.Path) :=
  DimensionComposition.Path.quotient (.product (.product mass length) length) (.product time time)

theorem pairExpansion (a b c : Nat) : (a+(b+c))+c+b = (a+b)+b+(c+c) := by
  simp only [Nat.add_assoc]
  rw [← Nat.add_assoc c c b,Nat.add_comm (c+c) b]

theorem energyDimensionClosure (mass length time : DimensionComposition.Path) (kind : String) :
    DimensionComposition.counts (workDimension mass length time) kind =
      DimensionComposition.counts (energyDimension mass length time) kind := by
  simp only [workDimension,forceDimension,energyDimension,DimensionComposition.counts]
  exact Prod.ext (pairExpansion _ _ _) (pairExpansion _ _ _)

end SFT.Physics.MechanicalWorkEnergy
