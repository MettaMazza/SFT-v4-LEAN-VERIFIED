import SFT.Physics.LeptonDecimal
import SFT.Physics.LeptonRatios
import SFT.Physics.ElectroweakTerminalRatio
import SFT.Physics.PlanckHierarchy
namespace SFT.Physics.PrecisionValidationOperations
open LeptonIntervals

-- Original precision_value_validation_v1.py: interval and its exact input guard.
def interval (central uncertainty : String) : Except String (Rat × Rat) := do
 let middle ← LeptonDecimal.exactDecimal central
 let width ← LeptonDecimal.exactDecimal uncertainty
 if !width.blt middle || !zero.blt width then
  .error "source interval must remain strictly positive"
 else .ok (subtract middle width,add middle width)

def intervalsOverlap (first second : Rat × Rat) : Bool := LeptonRatios.overlap first second

-- Preserve the original lower-endpoint-only guard; do not impose interval ordering.
def squaredRatioInterval (numerator denominator : Rat × Rat) : Except String (Rat × Rat) :=
 if !zero.blt numerator.1 || !zero.blt denominator.1 then
  .error "squared ratio requires positive source intervals"
 else do
  let lower ← LeptonRatios.divide numerator.1 denominator.2
  let upper ← LeptonRatios.divide numerator.2 denominator.1
  .ok (multiply lower lower,multiply upper upper)

def contains (bounds : Rat × Rat) (value : Rat) : Bool :=
 !value.blt bounds.1 && !bounds.2.blt value

def electroweakComparison (onShell zMass allWMass compatibleWMass : Rat × Rat) :
 Except String (Rat × Rat × (Rat × Rat) × (Rat × Rat) × Bool × Bool × Bool) := do
 let weak ← ElectroweakTerminalRatio.sinSquared
 let allWZ ← squaredRatioInterval allWMass zMass
 let compatibleWZ ← squaredRatioInterval compatibleWMass zMass
 let cosine ← ElectroweakTerminalRatio.cosSquared
 let weakQ := BoundaryGrowth.asFraction weak
 let cosineQ := BoundaryGrowth.asFraction cosine
 .ok (weakQ,cosineQ,compatibleWZ,allWZ,
  contains onShell weakQ,contains compatibleWZ cosineQ,contains allWZ cosineQ)

def hierarchyComparison (planck proton : Rat × Rat) : Except String Bool := do
 let bounds ← squaredRatioInterval planck proton
 let prediction ← PlanckHierarchy.terminalSquaredHierarchy
 .ok (contains bounds (BoundaryGrowth.asFraction prediction))
end SFT.Physics.PrecisionValidationOperations
