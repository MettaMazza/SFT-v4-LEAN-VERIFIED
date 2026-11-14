import SFT.Physics.VacuumLedgerProofs
import SFT.Physics.VacuumScaleProofs
namespace SFT.Physics.NuclearResidualForce
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 20000
def primaryBoundarySupport : Except String Rat := do
 let binary ← AlphaCovers.binaryCount
 LeptonRatios.divide (wholeRatio 1) (wholeRatio binary)
def residualBoundarySupport : Except String Rat := do
 let primary ← primaryBoundarySupport
 let residual := multiply primary primary
 let folded ← FoldFirstReturn.checkedFold (.fraction residual)
 let twice ← FoldFirstReturn.checkedFold (.fraction (SFT.Foundation.ExactPartCarrier.asFraction folded))
 if !(SFT.Foundation.ExactPartCarrier.asFraction folded == primary) || !(SFT.Foundation.ExactPartCarrier.asFraction twice == wholeRatio 1) then
  throw "second-order residual did not return through the Fold tower"
 pure residual
structure Exchange where
 closedColourCells : Nat
 leadingExternalLabel : List Nat
 firstRetainedBoundaryExchange : Rat
def neutralCompositeExchange : Except String Exchange := do
 let cells ← FoldFirstReturn.generatorPeriod
 let residual ← residualBoundarySupport
 pure ⟨cells,[],residual⟩
def mediatorRange : FoldFirstReturn.Input → Except String Rat
 | .nonFraction => .error "mediator mass carrier must be exact and positive"
 | .fraction mass => if !zero.blt mass then .error "mediator mass carrier must be exact and positive"
   else LeptonRatios.divide (wholeRatio 1) mass
inductive MassArgument where
 | absent
 | carrier (value : FoldFirstReturn.Input)
def mediatorReachClass : MassArgument → Except String String
 | .absent => .ok "unbounded-no-mass-label"
 | .carrier mass => do
   let _ ← mediatorRange mass
   pure "finite-positive-reciprocal-scale"
def inverseMassOrder : FoldFirstReturn.Input → FoldFirstReturn.Input → Except String Bool
 | .nonFraction,.nonFraction => .error "mass carriers must be exact fractions"
 | .nonFraction,.fraction _ => .error "mass carriers must be exact fractions"
 | .fraction _,.nonFraction => .error "mass carriers must be exact fractions"
 | .fraction light,.fraction heavy => do
   if !zero.blt light || !light.blt heavy then throw "range ordering requires positive ordered masses"
   let longer ← mediatorRange (.fraction light)
   let shorter ← mediatorRange (.fraction heavy)
   pure (shorter.blt longer)
def finiteBoundaryCapacity : Except String Nat := do
 let capacity ← FoldFirstReturn.generatorPeriod
 if capacity<1 then throw "finite boundary support was not generated"
 pure capacity
theorem originalPrimary : primaryBoundarySupport=.ok (normalize 1 2 (by decide)) := rfl
theorem originalResidual : residualBoundarySupport=.ok (normalize 1 4 (by decide)) := rfl
theorem completeExchange : neutralCompositeExchange=.ok ⟨3,[],normalize 1 4 (by decide)⟩ := rfl
theorem completeCapacity : finiteBoundaryCapacity=.ok 3 := rfl
theorem absentMass : mediatorReachClass .absent=.ok "unbounded-no-mass-label" := rfl
end SFT.Physics.NuclearResidualForce
