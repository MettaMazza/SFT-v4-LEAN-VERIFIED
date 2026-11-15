import SFT.Mathematics.CalculatorOperationsV2
import SFT.Mathematics.CalculatorWitnesses
namespace SFT.Mathematics.CalculatorV2Witnesses
open SFT.Physics SFT.Mathematics SFT.Host
open CalculatorValues CalculatorSeries
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def tanDouble (tangent : Rat) : Except String Rat :=
 LeptonRatios.divide (LeptonIntervals.multiply (natural 2) tangent) (LeptonIntervals.subtract (natural 1) (LeptonIntervals.multiply tangent tangent))
def angleIdentityIsExact : Except String Bool := do
 let t ← tanDouble (← tanDouble (LeptonIntervals.normalize 1 5 (by decide)))
 let p := LeptonIntervals.normalize 1 239 (by decide)
 let difference ← LeptonRatios.divide (LeptonIntervals.subtract t p) (LeptonIntervals.add (natural 1) (LeptonIntervals.multiply t p))
 pure (t.num*119 = 120*t.den && difference.num = difference.den)
def atanEven := CalculatorOperationsV2.atanUnitEnclosureV2 (LeptonIntervals.normalize 1 5 (by decide)) 4
def atanOdd := CalculatorOperationsV2.atanUnitEnclosureV2 (LeptonIntervals.normalize 1 5 (by decide)) 5
def circle := CalculatorOperationsV2.circleConstantEnclosure 32
def witness0 := CalculatorWitnesses.witness0
def witness1 := CalculatorWitnesses.witness1
def witness2 := CalculatorWitnesses.witness2
def witness3 := CalculatorWitnesses.witness3
def witness4 := CalculatorWitnesses.witness4
def witness5 := CalculatorWitnesses.witness6
def witness6 := CalculatorWitnesses.witness7
def witness7 := CalculatorWitnesses.witness8
def witness8 := CalculatorWitnesses.witness9
def parityOrdered (v : Except String Value) : Bool := match v with
 | .error _ => false
 | .ok value => match value with
  | .scalar _ | .complex _ => false
  | .interval x => x.certificate.any (fun t => Text.equal t "parity-checked:v2") && compareScalar x.lower x.upper < 0
def witness9 := parityOrdered atanEven && parityOrdered atanOdd
def witness10 : Bool := match angleIdentityIsExact with | .error _ => false | .ok b => b
def witness11 : Bool := match circle with
 | .error _ => false
 | .ok value => match value with
  | .scalar _ | .complex _ => false
  | .interval x => compareScalar x.lower x.upper < 0 && x.certificate.any (fun t => Text.equal t "parity-checked:v2") && x.certificate.any (fun t => Text.contains t "tangent-certificate")
end SFT.Mathematics.CalculatorV2Witnesses
