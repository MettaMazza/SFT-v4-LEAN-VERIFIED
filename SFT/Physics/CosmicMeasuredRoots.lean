import SFT.Physics.NeutrinolessBounds
import SFT.Physics.CosmicComponentTransport
namespace SFT.Physics.CosmicMeasuredRoots
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
abbrev Bracket := Rat × Rat

def square (x : Rat) : Rat := multiply x x

-- Integer squares are <= n/d exactly when their denominator multiple is < n+1.
-- Reuse the existing proved whole-number search with that exact integer bound.
def initialRootBracket (value : Rat) : Except String Bracket :=
 if value.blt (wholeRatio 1) then
  .error "registered late-time expansion roots begin at the One"
 else
  let upper := NeutrinolessBounds.wholeUpper (value.num.natAbs+1) value.den (value.num.natAbs+2) 1
  .ok (wholeRatio (upper-1),wholeRatio upper)

theorem originalInitialSearch (value : Rat) :
 NeutrinolessBounds.WholeUpperRun (value.num.natAbs+1) value.den 1
  (NeutrinolessBounds.wholeUpper (value.num.natAbs+1) value.den (value.num.natAbs+2) 1) :=
 NeutrinolessBounds.wholeUpperFromOne (value.num.natAbs+1) value.den (Nat.pos_of_ne_zero value.den_nz)

def refineRootBracket (value : Rat) (bracket : Bracket) : Bracket :=
 let middle := midpoint bracket.1 bracket.2
 if !value.blt (square middle) then (middle,bracket.2) else (bracket.1,middle)

def residualBounds (observed observedUncertainty h0 h0Uncertainty e2 : Rat)
 (root : Bracket) : Except String Bracket := do
 let lower := multiply h0 root.1
 let upper := multiply h0 root.2
 let residual := if observed.blt lower then (subtract lower observed,subtract upper observed)
  else if upper.blt observed then (subtract observed upper,subtract observed lower)
  else
   let left := subtract observed lower
   let right := subtract upper observed
   (zero,if left.blt right then right else left)
 let variance := add (square observedUncertainty) (multiply e2 (square h0Uncertainty))
 .ok (← LeptonRatios.divide (square residual.1) variance,
      ← LeptonRatios.divide (square residual.2) variance)

theorem originalOneBracket : initialRootBracket (wholeRatio 1) = .ok (wholeRatio 1,wholeRatio 2) := rfl
theorem originalSquareBoundary : initialRootBracket (wholeRatio 4) = .ok (wholeRatio 2,wholeRatio 3) := rfl
theorem originalRefinementEquality : refineRootBracket (normalize 9 4 (by decide)) (wholeRatio 1,wholeRatio 2) =
 (normalize 3 2 (by decide),wholeRatio 2) := rfl

#print axioms initialRootBracket
#print axioms originalInitialSearch
#print axioms refineRootBracket
#print axioms residualBounds
#print axioms originalOneBracket
#print axioms originalSquareBoundary
#print axioms originalRefinementEquality
end SFT.Physics.CosmicMeasuredRoots
