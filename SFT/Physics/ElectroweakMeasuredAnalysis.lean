import SFT.Physics.PrecisionValidationOperations
namespace SFT.Physics.ElectroweakMeasuredAnalysis
open LeptonIntervals
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000

-- Original electroweak_measured_value_successor_validation_v1.py: interval.
-- Inputs here are the source Fraction values after conversion.
def interval (center uncertainty : Rat) : Except String (Rat × Rat) :=
 if !uncertainty.blt center || !zero.blt uncertainty then
  .error "electroweak measured interval must remain positive"
 else .ok (subtract center uncertainty, add center uncertainty)

structure Target where
 directCenter : Rat
 directUncertainty : Rat
 zCenter : Rat
 zUncertainty : Rat
 compatibleWCenter : Rat
 compatibleWUncertainty : Rat
 allWCenter : Rat
 allWUncertainty : Rat
 incompatibleInputDisclosure : Bool
 poorConsistencyDisclosure : Bool
 aggregateNotTarget : Bool
 allRowsRetained : Bool

structure Analysis where
 directOnShellInterval : Rat × Rat
 compatibleWZSquaredInterval : Rat × Rat
 allInputWZSquaredMethodRecord : Rat × Rat
 forcedSineInsideDirectInterval : Bool
 forcedCosineInsideCompatibleWZInterval : Bool
 exactPartition : Bool
 incompatibleInputDisclosureRetained : Bool
 poorConsistencyDisclosureRetained : Bool
 inconsistentAggregateNotUsedAsTarget : Bool
 allSourceRowsRetained : Bool

-- Divisions are the original positive-interval endpoint divisions, without
-- inserting the separate older validator's lower-endpoint guard.
def squaredEndpoints (w z : Rat × Rat) : Except String (Rat × Rat) := do
 let lower ← LeptonRatios.divide w.1 z.2
 let upper ← LeptonRatios.divide w.2 z.1
 .ok (multiply lower lower, multiply upper upper)

def exactAnalysis (t : Target) : Except String Analysis := do
 let direct ← interval t.directCenter t.directUncertainty
 let z ← interval t.zCenter t.zUncertainty
 let compatibleW ← interval t.compatibleWCenter t.compatibleWUncertainty
 let allW ← interval t.allWCenter t.allWUncertainty
 let compatibleWZ ← squaredEndpoints compatibleW z
 let allInputWZ ← squaredEndpoints allW z
 let sine ← ElectroweakTerminalRatio.sinSquared
 let cosine ← ElectroweakTerminalRatio.cosSquared
 let s := BoundaryGrowth.asFraction sine
 let c := BoundaryGrowth.asFraction cosine
 .ok ⟨direct,compatibleWZ,allInputWZ,
  PrecisionValidationOperations.contains direct s,
  PrecisionValidationOperations.contains compatibleWZ c,
  add s c == BoundaryGrowth.asFraction AlphaRatio.one,
  t.incompatibleInputDisclosure,t.poorConsistencyDisclosure,
  t.aggregateNotTarget,t.allRowsRetained⟩

def empirical (a : Analysis) : Bool :=
 a.forcedSineInsideDirectInterval && a.forcedCosineInsideCompatibleWZInterval &&
 a.exactPartition && a.incompatibleInputDisclosureRetained &&
 a.poorConsistencyDisclosureRetained && a.inconsistentAggregateNotUsedAsTarget &&
 a.allSourceRowsRetained

-- Exact decimal readings from the immutable original registered_target.
def registeredTarget : Target :=
 ⟨normalize 22342 100000 (by decide),normalize 9 100000 (by decide),
 normalize 911880 10000 (by decide),normalize 20 10000 (by decide),
 normalize 803692 10000 (by decide),normalize 133 10000 (by decide),
 normalize 80395 1000 (by decide),normalize 12 1000 (by decide),
 true,true,true,true⟩

def measuredPass : Except String Bool := do
 let a ← exactAnalysis registeredTarget
 .ok (empirical a)

def directTamperRejected : Except String Bool := do
 let a ← exactAnalysis {registeredTarget with directCenter := normalize 22000 100000 (by decide)}
 .ok (!a.forcedSineInsideDirectInterval)

def compatibleWTamperRejected : Except String Bool := do
 let a ← exactAnalysis {registeredTarget with compatibleWCenter := normalize 81 1 (by decide)}
 .ok (!a.forcedCosineInsideCompatibleWZInterval)

theorem originalMeasuredPass : measuredPass = .ok true := rfl
theorem originalDirectControl : directTamperRejected = .ok true := rfl
theorem originalCompatibleWControl : compatibleWTamperRejected = .ok true := rfl

def exactTerminalWitness : Except String Bool := do
 let sine ← ElectroweakTerminalRatio.sinSquared
 let s := BoundaryGrowth.asFraction sine
 .ok ((normalize 1 5 (by decide)).blt s && s.blt (normalize 1 4 (by decide)))

theorem originalTerminalWitness : exactTerminalWitness = .ok true := rfl

#print axioms interval
#print axioms squaredEndpoints
#print axioms exactAnalysis
#print axioms empirical
#print axioms registeredTarget
#print axioms originalMeasuredPass
#print axioms originalDirectControl
#print axioms originalCompatibleWControl
#print axioms exactTerminalWitness
#print axioms originalTerminalWitness
end SFT.Physics.ElectroweakMeasuredAnalysis
