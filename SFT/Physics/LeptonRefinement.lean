import SFT.Physics.LeptonRatios
namespace SFT.Physics.LeptonRefinement
open LeptonIntervals LeptonIsolation LeptonRatios
set_option maxRecDepth 20000
set_option maxHeartbeats 50000000

def terminalPrediction (denominator : Int) (source : Rat × Rat) (fuel : Nat) : Except String (Option (Rat × Rat)) := do
 let product ← LeptonTerminal.terminalProduct
 let initial ← terminalSearch
 match initial with
 | none => .error "Unreachable: certified terminal isolation did not complete"
 | some brackets => refineWithin 1 denominator source pairSum (BoundaryGrowth.asFraction product) fuel brackets

def muonElectronSource : Rat × Rat := (endpoint 2067682781 10000000 (by decide),endpoint 2067682873 10000000 (by decide))

def muonElectronPrediction : Rat × Rat := (endpoint 2760006749688854416 13348308265544641 (by decide),endpoint 2760006753011508025 13348308034474884 (by decide))

theorem muonElectronExact : terminalPrediction 0 muonElectronSource 27 = .ok (some muonElectronPrediction) := rfl

theorem muonElectronContained : contained muonElectronPrediction muonElectronSource = true := rfl

theorem muonElectronOverlap : overlap muonElectronPrediction muonElectronSource = true := rfl

def muonTauSource : Rat × Rat := (endpoint 118919 2000000 (by decide),endpoint 23787 400000 (by decide))

def muonTauPrediction : Rat × Rat := (endpoint 164508926409 2766726569104 (by decide),endpoint 164509737604 2766723242409 (by decide))

theorem muonTauExact : terminalPrediction 2 muonTauSource 15 = .ok (some muonTauPrediction) := rfl

theorem muonTauContained : contained muonTauPrediction muonTauSource = true := rfl

theorem muonTauOverlap : overlap muonTauPrediction muonTauSource = true := rfl

theorem nativeRefinementRun (product : SFT.Foundation.ExactOperations.PositiveFraction)
 (native : LeptonTerminal.terminalProduct = .ok product)
 (denominator : Int) (source : Rat × Rat) (fuel : Nat) (result : Rat × Rat)
 (found : terminalPrediction denominator source fuel = .ok (some result)) :
 RefinementRun 1 denominator source pairSum (BoundaryGrowth.asFraction product) terminalBrackets result := by
 unfold terminalPrediction at found
 rw [native,terminalSearchComplete] at found
 exact refinementSound 1 denominator source pairSum (BoundaryGrowth.asFraction product) fuel terminalBrackets result found

theorem muonElectronRun (product : SFT.Foundation.ExactOperations.PositiveFraction)
 (native : LeptonTerminal.terminalProduct = .ok product) :
 RefinementRun 1 0 muonElectronSource pairSum (BoundaryGrowth.asFraction product) terminalBrackets muonElectronPrediction :=
 nativeRefinementRun product native 0 muonElectronSource 27 muonElectronPrediction muonElectronExact

theorem muonTauRun (product : SFT.Foundation.ExactOperations.PositiveFraction)
 (native : LeptonTerminal.terminalProduct = .ok product) :
 RefinementRun 1 2 muonTauSource pairSum (BoundaryGrowth.asFraction product) terminalBrackets muonTauPrediction :=
 nativeRefinementRun product native 2 muonTauSource 15 muonTauPrediction muonTauExact

theorem bothRowsOverlap :
 overlap muonElectronPrediction muonElectronSource && overlap muonTauPrediction muonTauSource = true := rfl

end SFT.Physics.LeptonRefinement
