import SFT.Physics.CoupledEnsembleSynchronization
namespace SFT.Physics.CoupledMapCriticality
open LeptonIntervals GeneratorOperations
set_option maxHeartbeats 100000000
set_option maxRecDepth 100000
def positiveLabelCount : CountInput → Except String Nat
 | .integer (.ofNat (n+2)) => .ok (n+2)
 | .integer (.ofNat 0) | .integer (.ofNat 1) | .integer (.negSucc _) | .boolean _ => .error "complete generated label count must be at least two"
def holdingThreshold (labelCount : CountInput) : Except String Rat := do
 let m ← positiveLabelCount labelCount
 if hm : 0<m then pure (normalize (.ofNat (m-1)) m hm)
 else throw "complete generated label count must be at least two"
def retainedTransverseMultiplier (labelCount : CountInput) (coupling : Rat) : Except String Rat := do
 let m ← positiveLabelCount labelCount
 if !zero.blt coupling || !coupling.blt (normalize 1 1 (by decide)) then
  throw "coupling must be an exact proper positive part"
 pure (multiply (normalize (.ofNat m) 1 (by decide)) (subtract (normalize 1 1 (by decide)) coupling))
def stabilityClass (labelCount : CountInput) (coupling : Rat) : Except String String := do
 let multiplier ← retainedTransverseMultiplier labelCount coupling
 if multiplier==normalize 1 1 (by decide) then pure "neutral-boundary"
 else pure (if multiplier.blt (normalize 1 1 (by decide)) then "strict-contraction" else "strict-expansion")
theorem binaryThresholdIsForcedHalf : holdingThreshold (.integer 2)=.ok CoupledEnsembleSynchronization.halfOneValue := rfl
end SFT.Physics.CoupledMapCriticality
