import SFT.Mathematics.CalculatorTrigonometry
namespace SFT.Mathematics.CalculatorOperationsV2
open SFT.Physics SFT.Mathematics SFT.Host
open CalculatorValues CalculatorRoots CalculatorSeries CalculatorTrigonometry
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def atanUnitEnclosureV2 (x : Rat) (terms : Int) : Except String Value := do
 if !((natural 0).blt x) || (natural 1).blt x then throw "alternating arctangent certificate requires a positive part at most One"
 if terms < 1 then throw "arctangent certificate requires a positive term count"
 let totals ← (List.range terms.toNat).foldlM (fun (positive,counter) index => do
  let term ← LeptonRatios.divide (ratPower x (2*index+1)) (natural (2*index+1))
  pure (if index % 2 == 1 then (positive,LeptonIntervals.add counter term) else (LeptonIntervals.add positive term,counter))) (natural 0,natural 0)
 let partialSum := LeptonIntervals.subtract totals.1 totals.2
 let nextTerm ← LeptonRatios.divide (← integerPower x (2*terms+1)) (LeptonIntervals.normalize (2*terms+1) 1 (by decide))
 let (lower,upper) := if terms % 2 = 1 then (LeptonIntervals.subtract partialSum nextTerm,partialSum) else (partialSum,LeptonIntervals.add partialSum nextTerm)
 pure (.interval (← certifiedInterval (← forward lower) (← forward upper) [Text.append "atan-alternating-terms:" (Canonical.render (.integer terms)),Text.append "next-term-bound:" (fractionText nextTerm),"parity-checked:v2"]))
def circleConstantEnclosure (terms : Int := 32) : Except String Value := do
 let fifth ← atanUnitEnclosureV2 (LeptonIntervals.normalize 1 5 (by decide)) terms
 let other ← atanUnitEnclosureV2 (LeptonIntervals.normalize 1 239 (by decide)) terms
 let result ← CalculatorOperations.subtract (← CalculatorOperations.multiply (.scalar (← forward (natural 16))) fifth) (← CalculatorOperations.multiply (.scalar (← forward (natural 4))) other)
 match result with
 | .interval x => pure (.interval (← certifiedInterval x.lower x.upper (x.certificate ++ ["exact-angle-composition:16*atan(1/5)-4*atan(1/239)","tangent-certificate:tan(4*atan(1/5)-atan(1/239))=One"])))
 | .scalar _ | .complex _ => throw "circle enclosure construction failed"
end SFT.Mathematics.CalculatorOperationsV2
