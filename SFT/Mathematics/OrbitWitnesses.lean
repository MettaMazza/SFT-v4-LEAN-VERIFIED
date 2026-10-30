import SFT.Mathematics.OrbitNumberWitnesses
import SFT.Mathematics.OrbitLoopCompletion
namespace SFT.Mathematics.OrbitWitnesses
set_option maxHeartbeats 4000000
set_option maxRecDepth 100000
attribute [local irreducible] OrbitNumberWitnesses.orderExamples OrbitNumberWitnesses.allReducedRanks OrbitNumberWitnesses.primeDivision OrbitNumberWitnesses.orbitTiling
structure Witness where
 name : String
 statement : String
 passed : Bool
def orders : Witness := ⟨"orders","The independently counted orders for denominators three, five, seven, nine and eleven are two, four, three, six and ten.",OrbitNumberWitnesses.orderExamples⟩
theorem ordersPassed : orders.passed = true := OrbitNumberWitnesses.originalOrders
def allReduced : Witness := ⟨"all-reduced-ranks","Every reduced rank through odd denominator ninety-nine has orbit length equal to its denominator order.",OrbitNumberWitnesses.allReducedRanks⟩
theorem allReducedPassed : allReduced.passed = true := by
 change OrbitNumberWitnesses.allReducedRanks = true
 exact OrbitNumberWitnesses.originalAllReducedRanks
def primeDivision : Witness := ⟨"prime-division","Each tested prime period divides one less than the prime.",OrbitNumberWitnesses.primeDivision⟩
theorem primeDivisionPassed : primeDivision.passed = true := OrbitNumberWitnesses.originalPrimeDivision
def tiling : Witness := ⟨"orbit-tiling","Reduced residues for denominator seventy-three tile into eight disjoint orbits of length nine.",OrbitNumberWitnesses.orbitTiling⟩
theorem tilingPassed : tiling.passed = true := OrbitNumberWitnesses.originalOrbitTiling
def witnesses : List Witness := [orders,allReduced,primeDivision,tiling]
theorem allWitnessesPass : witnesses.all Witness.passed = true := by
 change (orders.passed && (allReduced.passed && (primeDivision.passed && (tiling.passed && (true))))) = true
 rw [ordersPassed,allReducedPassed,primeDivisionPassed,tilingPassed]
 rfl
end SFT.Mathematics.OrbitWitnesses
