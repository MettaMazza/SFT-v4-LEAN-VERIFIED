import SFT.Mathematics.CalculatorMachine
namespace SFT.Mathematics.CalculatorWitnesses
open SFT.Mathematics CalculatorValues
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def scalarMagnitude (value : FoldScalar.Scalar) (n d : Nat) : Bool := match value with
 | .emptyOne => false
 | .positive _ q => q.numerator*d == n*q.denominator
def decimalSum := CalculatorMachine.calculate "0.1+0.2"
def cancelled := CalculatorMachine.calculate "1-1"
def held := CalculatorMachine.calculate "1-3"
def one : Except String Value := do pure (.scalar (← forward (CalculatorSeries.natural 1)))
def rootTwo : Except String Value := do CalculatorRoots.nthRoot (.scalar (← forward (CalculatorSeries.natural 2))) 2
def expOne : Except String Value := do CalculatorSeries.expEnclosure (← one) 12
def lnExpLower : Except String Value := do
 match ← expOne with
 | .interval x => CalculatorSeries.lnEnclosure (.scalar x.lower) 8
 | .scalar _ | .complex _ => throw "source conditional returned None"
def sinOne : Except String Value := do CalculatorTrigonometry.sinEnclosure (← one) 12
def circle := CalculatorTrigonometry.circleConstantEnclosure 24
def orthogonalSquare : Except String Value := do
 let unit ← forward (CalculatorSeries.natural 1)
 CalculatorOperations.multiply (.complex ⟨.emptyOne,unit⟩) (.complex ⟨.emptyOne,unit⟩)
def witness0 : Bool := match decimalSum with
 | .error _ => false
 | .ok x => match x.value with
  | .scalar v => scalarMagnitude v 3 10
  | .interval _ | .complex _ => false
def witness1 : Bool := match cancelled with
 | .error _ => false
 | .ok x => match x.value with
  | .scalar v => match v with | .emptyOne => true | .positive _ _ => false
  | .interval _ | .complex _ => false
def witness2 : Bool := match held with
 | .error _ => false
 | .ok x => match x.value with
  | .scalar v => match v with
   | .emptyOne => false
   | .positive o q => match o with
    | .forward => false
    | .counter => q.numerator == 2*q.denominator
  | .interval _ | .complex _ => false
def witness3 : Bool := match rootTwo with
 | .error _ => false
 | .ok x => match x with
  | .scalar _ | .complex _ => false
  | .interval x => match x.lower with
   | .emptyOne => false
   | .positive _ l => match x.upper with
    | .emptyOne => false
    | .positive _ u => l.numerator^2 < 2*l.denominator^2 && 2*u.denominator^2 <= u.numerator^2
def combinatorial : Except String Bool := do
 let five ← forward (CalculatorSeries.natural 5)
 let ten ← forward (CalculatorSeries.natural 10)
 let three ← forward (CalculatorSeries.natural 3)
 let fac ← CalculatorOperations.factorial (.scalar five)
 let selection ← CalculatorOperations.combination (.scalar ten) (.scalar three)
 pure (scalarMagnitude fac 120 1 && scalarMagnitude selection 120 1)
def witness4 : Bool := match combinatorial with | .error _ => false | .ok b => b
def intervalResult : Except String Value → Bool
 | .error _ => false
 | .ok v => CalculatorOperations.isInterval v
def witness5 : Bool := intervalResult expOne && intervalResult lnExpLower && intervalResult sinOne && intervalResult circle
def witness6 : Bool := match orthogonalSquare with
 | .error _ => false
 | .ok v => match v with
  | .scalar _ | .interval _ => false
  | .complex v => match v.real with
   | .emptyOne => false
   | .positive o q => match o with
    | .forward => false
    | .counter => match v.orthogonal with
     | .emptyOne => q.numerator == q.denominator
     | .positive _ _ => false
def divisionByEmpty : Except String Value := do CalculatorOperations.divide (← one) (.scalar .emptyOne)
def witness7 : Bool := match divisionByEmpty with | .error _ => true | .ok _ => false
def witness8 : Bool := match decimalSum with
 | .error _ => false
 | .ok x => x.operationsExecuted == 1 && x.trace.length >= 4
def witness9 : Bool := match CalculatorNumerals.parseExactNumber "1.25e-2" with
 | .error _ => false
 | .ok x => scalarMagnitude x 1 80
end SFT.Mathematics.CalculatorWitnesses
