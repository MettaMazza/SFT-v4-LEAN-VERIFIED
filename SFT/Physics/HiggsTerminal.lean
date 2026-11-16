import SFT.Physics.HiggsGround
import SFT.Physics.PlanckHierarchy
namespace SFT.Physics.HiggsTerminal
open LeptonIntervals VacuumLedgerProofs HiggsGround
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def generationCoverDepth : Except String Nat := do
 let generator ← FoldFirstReturn.generatorPeriod
 let volume ← AlphaCovers.positivePower (.integer (.ofNat generator)) (.integer (.ofNat generator))
 AlphaCovers.minimalBinaryCover (.integer (.ofNat volume))
def scalarDirectionSupport : Except String Nat := do
 .ok ((← AlphaCovers.binaryCount)*(← FoldFirstReturn.generatorPeriod))
def activeScalarDirections : Except String Nat := do
 GeneratorOperations.positivePredecessor (.integer (.ofNat (← scalarDirectionSupport)))
def terminalHiggsReturn : Except String Rat := do
 let active ← activeScalarDirections
 if active != (← generationCoverDepth) then throw "held direction support and generation cover did not cross-lock"
 let share ← LeptonRatios.divide (wholeRatio (← scalarDirectionSupport)) (wholeRatio active)
 .ok (multiply share (BoundaryGrowth.asFraction (← PlanckHierarchy.terminalAlpha)))
def terminalHiggsMassRatio : Except String Rat := do
 let ground := HiggsGround.asRat (← displacedGround)
 let ratio := add ground (← terminalHiggsReturn)
 if !ground.blt ratio || !ratio.blt (wholeRatio 1) then throw "terminal Higgs ratio left its exact positive displaced interval"
 .ok ratio
def terminalHiggsSelfCoupling : Except String Rat := do
 let ratio ← terminalHiggsMassRatio
 let coupling ← LeptonRatios.divide (multiply ratio ratio) (wholeRatio (← AlphaCovers.binaryCount))
 let rungs ← leadingHiggsRungs
 if !rungs.2.2.blt coupling || !coupling.blt (HiggsGround.asRat (← displacedGround)) then throw "terminal Higgs self-coupling left its generated interval"
 .ok coupling
structure Routes where
 massRouteSquared : Rat
 twoFibreCouplingRoute : Rat
 routesEqual : Bool
def routeCrossLock : Except String Routes := do
 let ratio ← terminalHiggsMassRatio
 let coupling ← terminalHiggsSelfCoupling
 let massRoute := multiply ratio ratio
 let couplingRoute := multiply (wholeRatio (← AlphaCovers.binaryCount)) coupling
 .ok ⟨massRoute,couplingRoute,massRoute==couplingRoute⟩
theorem originalSupport : (do pure ((← scalarDirectionSupport),(← activeScalarDirections),(← generationCoverDepth)))=.ok (6,5,5) := rfl
theorem originalMassRatio : terminalHiggsMassRatio=.ok (normalize 2563352914777 5038463954690 (by decide)) := rfl
theorem originalCoupling : terminalHiggsSelfCoupling=.ok (normalize 6570778165695741824959729 50772238045420788745992200 (by decide)) := rfl
theorem originalRouteEquality : (routeCrossLock.map Routes.routesEqual)=.ok true := rfl
#print axioms generationCoverDepth
#print axioms terminalHiggsReturn
#print axioms terminalHiggsMassRatio
#print axioms terminalHiggsSelfCoupling
#print axioms routeCrossLock
#print axioms originalSupport
#print axioms originalMassRatio
#print axioms originalCoupling
#print axioms originalRouteEquality
end SFT.Physics.HiggsTerminal
