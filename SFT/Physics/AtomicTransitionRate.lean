import SFT.Physics.AtomicTransition
import SFT.Physics.LeptonIntervals
namespace SFT.Physics.AtomicTransitionRate
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
inductive CountArgument where
 | count (value : CountInput)
 | nonInteger
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def electricMultipoleExponent : CountArgument → Except String Nat
 | .count (.integer (.ofNat (n+1))) => .ok (2*(n+1)+1)
 | .nonInteger => .error "multipole rank must be a positive whole count"
 | .count (.boolean _) => .error "multipole rank must be a positive whole count"
 | .count (.integer (.negSucc _)) => .error "multipole rank must be a positive whole count"
 | .count (.integer (.ofNat 0)) => .error "multipole rank must be a positive whole count"
def strictGap : FoldFirstReturn.Input → Except String Rat
 | .nonFraction => .error "gap must be an exact positive strict part of the One"
 | .fraction gap => do
  if !(wholeRatio 0).blt gap || !gap.blt (wholeRatio 1) then
   throw "gap must be an exact positive strict part of the One"
  pure gap
def positiveStrength : FoldFirstReturn.Input → Except String Rat
 | .nonFraction => .error "line strength must be an exact positive carrier"
 | .fraction strength => do
  if !(wholeRatio 0).blt strength then throw "line strength must be an exact positive carrier"
  pure strength
def positiveWeight : CountArgument → Except String Nat
 | .count (.integer (.ofNat (n+1))) => .ok (n+1)
 | .nonInteger => .error "statistical weight must be a positive whole count"
 | .count (.boolean _) => .error "statistical weight must be a positive whole count"
 | .count (.integer (.negSucc _)) => .error "statistical weight must be a positive whole count"
 | .count (.integer (.ofNat 0)) => .error "statistical weight must be a positive whole count"
def electricGapPower (gap : Rat) : Nat → Rat
 | 0 => wholeRatio 1
 | exponent+1 => multiply (electricGapPower gap exponent) gap
def normalizedElectricRate (gap strength : FoldFirstReturn.Input) (weight : CountArgument)
 (rank : CountArgument := .count (.integer 1)) : Except String Rat := do
 let gap ← strictGap gap
 let strength ← positiveStrength strength
 let weight ← positiveWeight weight
 let exponent ← electricMultipoleExponent rank
 let power := electricGapPower gap exponent
 LeptonRatios.divide (multiply power strength) (wholeRatio weight)
def decayRate : FoldFirstReturn.Input → Except String Rat
 | .nonFraction => .error "lifetime requires complete positive exact decay rates"
 | .fraction rate => do
  if !(wholeRatio 0).blt rate then throw "lifetime requires complete positive exact decay rates"
  pure rate
def exactLifetime : List FoldFirstReturn.Input → Except String Rat
 | [] => .error "lifetime requires complete positive exact decay rates"
 | first::rest => do
  let rates ← (first::rest).mapM decayRate
  let total := rates.foldl add (wholeRatio 0)
  LeptonRatios.divide (wholeRatio 1) total
def successorMultipoleRatio (input : FoldFirstReturn.Input) : Except String Rat := do
 let gap ← strictGap input
 pure (multiply gap gap)
theorem everyElectricExponent (n : Nat) : electricMultipoleExponent (.count (.integer (.ofNat (n+1))))=.ok (2*(n+1)+1) := rfl
theorem exponentSuccessor (n : Nat) : 2*(n+2)+1=(2*(n+1)+1)+2 := by
 rw [Nat.mul_succ,Nat.add_assoc,Nat.add_comm 2 1,←Nat.add_assoc]
theorem firstFourExponents : [electricMultipoleExponent (.count (.integer 1)),electricMultipoleExponent (.count (.integer 2)),electricMultipoleExponent (.count (.integer 3)),electricMultipoleExponent (.count (.integer 4))]=[.ok 3,.ok 5,.ok 7,.ok 9] := rfl
theorem originalLifetimeWitness : exactLifetime [.fraction (normalize 1 8 (by decide)),.fraction (normalize 1 24 (by decide))]=.ok (wholeRatio 6) := rfl
theorem emptyChannelsRejected : exactLifetime []=.error "lifetime requires complete positive exact decay rates" := rfl
end SFT.Physics.AtomicTransitionRate
