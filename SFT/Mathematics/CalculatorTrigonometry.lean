import SFT.Mathematics.CalculatorSeries
namespace SFT.Mathematics.CalculatorTrigonometry
open SFT.Physics SFT.Mathematics SFT.Host
open CalculatorValues CalculatorRoots CalculatorSeries
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def trigLoop : Nat → Nat → Bool → Bool → Rat → FoldScalar.Scalar → Rat → Rat → Except String Value
 | 0,_,_,_,_,_,_,_ => .error "trigonometric certificate did not close inside the declared term bound"
 | fuel+1,index,cosine,isForward,xSquared,total,term,tol => do
  let denominator := if cosine then (2*index-1)*(2*index) else (2*index)*(2*index+1)
  let term ← LeptonRatios.divide (LeptonIntervals.multiply term xSquared) (natural denominator)
  let signedTerm ← if index % 2 == 0 then forward term else counter term
  let total := FoldScalar.add total signedTerm
  let nextDenominator := if cosine then (2*index+1)*(2*index+2) else (2*index+2)*(2*index+3)
  let nextTerm ← LeptonRatios.divide (LeptonIntervals.multiply term xSquared) (natural nextDenominator)
  if !term.blt nextTerm && !tol.blt nextTerm then
   let bound ← forward nextTerm
   let lower := FoldScalar.subtract total bound
   let upper := FoldScalar.add total bound
   let lo := if !cosine && !isForward then FoldScalar.reverse upper else lower
   let hi := if !cosine && !isForward then FoldScalar.reverse lower else upper
   pure (.interval (← certifiedInterval lo hi [Text.join [if cosine then "cos" else "sin","-alternating-terms:",digits (index+1)],Text.append "next-term-bound:" (fractionText nextTerm)]))
  else trigLoop fuel (index+1) cosine isForward xSquared total term tol
def alternatingTrig (value : FoldScalar.Scalar) (cosine : Bool) (places maxTerms : Int) : Except String Value := do
 match value with
 | .emptyOne =>
  let base ← if cosine then forward (natural 1) else pure .emptyOne
  pure (.interval (CalculatorOperations.asInterval base "trigonometric-empty-One-base"))
 | .positive orientation magnitude =>
  let x := BoundaryGrowth.asFraction magnitude
  let term := if cosine then natural 1 else x
  let total ← forward term
  let isForward := match orientation with | .forward => true | .counter => false
  trigLoop maxTerms.toNat 1 cosine isForward (LeptonIntervals.multiply x x) total term (← tolerance places)
def sinEnclosure (value : Value) (places : Int := 18) : Except String Value := do
 alternatingTrig (← CalculatorOperations.requireScalar value) false places 4096
def cosEnclosure (value : Value) (places : Int := 18) : Except String Value := do
 alternatingTrig (← CalculatorOperations.requireScalar value) true places 4096
def tanEnclosure (value : Value) (places : Int := 18) : Except String Value := do
 CalculatorOperations.divide (← sinEnclosure value (places+4)) (← cosEnclosure value (places+4))
def integerPower (x : Rat) (power : Int) : Except String Rat :=
 if power < 0 then LeptonRatios.divide (natural 1) (ratPower x power.natAbs)
 else pure (ratPower x power.toNat)
def atanUnitEnclosure (x : Rat) (terms : Int) : Except String Value := do
 let totals ← (List.range terms.toNat).foldlM (fun (positive,counter) index => do
  let term ← LeptonRatios.divide (ratPower x (2*index+1)) (natural (2*index+1))
  pure (if index % 2 == 1 then (positive,LeptonIntervals.add counter term) else (LeptonIntervals.add positive term,counter))) (natural 0,natural 0)
 let partialSum := LeptonIntervals.subtract totals.1 totals.2
 let nextTerm ← LeptonRatios.divide (← integerPower x (2*terms+1)) (LeptonIntervals.normalize (2*terms+1) 1 (by decide))
 -- Retain claim003's original parity. Its own V3 supersession record belongs to entry004.
 let (lower,upper) := if terms % 2 = 1 then (partialSum,LeptonIntervals.add partialSum nextTerm) else (LeptonIntervals.subtract partialSum nextTerm,partialSum)
 pure (.interval (← certifiedInterval (← forward lower) (← forward upper) [Text.append "atan-alternating-terms:" (Canonical.render (.integer terms)),Text.append "next-term-bound:" (fractionText nextTerm)]))
def circleConstantEnclosure (terms : Int := 32) : Except String Value := do
 let fifth ← atanUnitEnclosure (LeptonIntervals.normalize 1 5 (by decide)) terms
 let other ← atanUnitEnclosure (LeptonIntervals.normalize 1 239 (by decide)) terms
 let result ← CalculatorOperations.subtract (← CalculatorOperations.multiply (.scalar (← forward (natural 16))) fifth) (← CalculatorOperations.multiply (.scalar (← forward (natural 4))) other)
 match result with
 | .interval x => pure (.interval (← certifiedInterval x.lower x.upper (x.certificate ++ ["exact-tangent-composition:16*atan(1/5)-4*atan(1/239)"])))
 | .scalar _ | .complex _ => throw "circle enclosure construction failed"
end SFT.Mathematics.CalculatorTrigonometry
