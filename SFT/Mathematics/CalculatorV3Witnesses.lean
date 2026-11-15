import SFT.Mathematics.CalculatorGUI
import SFT.Mathematics.CalculatorV2Witnesses
namespace SFT.Mathematics.CalculatorV3Witnesses
open SFT.Physics SFT.Mathematics SFT.Host CalculatorValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def witness0 := CalculatorV2Witnesses.witness0
def witness1 := CalculatorV2Witnesses.witness1
def witness2 := CalculatorV2Witnesses.witness2
def witness3 := CalculatorV2Witnesses.witness3
def witness4 := CalculatorV2Witnesses.witness4
def witness5 := CalculatorV2Witnesses.witness5
def witness6 := CalculatorV2Witnesses.witness6
def witness7 := CalculatorV2Witnesses.witness7
def witness8 := CalculatorV2Witnesses.witness8
def witness9 := CalculatorV2Witnesses.witness9
def witness10 := CalculatorV2Witnesses.witness10
def witness11 := CalculatorV2Witnesses.witness11
def contains (interval : CertifiedInterval) (value : Rat) : Bool :=
 let lower := scalarToFractionForProjection interval.lower
 let upper := scalarToFractionForProjection interval.upper
 !(value.blt lower) && !(upper.blt value)
def scalarMagnitude (calculation : Except String CalculatorMachine.Calculation) (magnitude : Rat) : Bool :=
 match calculation with
 | .error _ => false
 | .ok c =>
  match c.value with
  | .scalar (.positive _ m) => decide (Int.ofNat m.numerator * Int.ofNat magnitude.den = magnitude.num * Int.ofNat m.denominator)
  | .scalar .emptyOne | .complex _ | .interval _ => false
def intervalCalculation (calculation : Except String CalculatorMachine.Calculation) : Bool :=
 match calculation with
 | .error _ => false
 | .ok c =>
  match c.value with
  | .interval _ => true
  | .scalar _ | .complex _ => false
def containsCalculation (calculation : Except String CalculatorMachine.Calculation) (value : Rat) : Bool :=
 match calculation with
 | .error _ => false
 | .ok c =>
  match c.value with
  | .interval i => contains i value
  | .scalar _ | .complex _ => false
def witness12 : Bool := scalarMagnitude (CalculatorMachineV3.calculate "1+1=") (CalculatorSeries.natural 2)
def witness13 : Bool := intervalCalculation (CalculatorMachineV3.calculate "2^(1/2)") && intervalCalculation (CalculatorMachineV3.calculate "2^pi" 10)
def witness14 : Bool := containsCalculation (CalculatorMachineV3.calculate "sin(30)" 10 10000 "deg") (LeptonIntervals.normalize 1 2 (by decide)) && containsCalculation (CalculatorMachineV3.calculate "atan(1)" 10 10000 "deg") (CalculatorSeries.natural 45)
def witness15 : Bool := containsCalculation (CalculatorMachineV3.calculate "cosh(0)" 10) (CalculatorSeries.natural 1)
def witness16 : Bool := scalarMagnitude (CalculatorMachineV3.calculate "mean(1,2,3,4)") (LeptonIntervals.normalize 5 2 (by decide)) && scalarMagnitude (CalculatorMachineV3.calculate "variance(1,2,3)") (LeptonIntervals.normalize 2 3 (by decide))
def memoryExample : Except String Bool := do
 let initial : CalculatorSession.Session := {angleMode := "deg"}
 let (first,s) ← CalculatorSession.evaluate initial "1+1="
 let (_,s) := CalculatorSession.memoryStore s
 let (second,s) ← CalculatorSession.evaluate s "ans+mem="
 let firstMagnitude := scalarMagnitude (.ok first) (CalculatorSeries.natural 2)
 let secondMagnitude := scalarMagnitude (.ok second) (CalculatorSeries.natural 4)
 let sameMemory := match s.memory with
  | .scalar a =>
   match first.value with
   | .scalar b => decide (compareScalar a b = 0)
   | .interval _ | .complex _ => false
  | .interval _ | .complex _ => false
 pure (firstMagnitude && secondMagnitude && s.history.length == 2 && sameMemory)
def witness17 : Bool := match memoryExample with | .ok b => b | .error _ => false
def witness18 : Bool :=
 CalculatorDisplay.buttonRows.any (fun row => row.any (Text.equal "=")) &&
 CalculatorDisplay.buttonRows.all (fun row => row.all (fun label => CalculatorDisplay.insertions.any (fun (key,_) => Text.equal key label) || ["MC","MR","M+","M−","MS","C","⌫","=","±"].any (Text.equal label))) &&
 Text.contains CalculatorDisplay.guideText "Exact details" && Text.contains CalculatorDisplay.guideText "Memory"
end SFT.Mathematics.CalculatorV3Witnesses
