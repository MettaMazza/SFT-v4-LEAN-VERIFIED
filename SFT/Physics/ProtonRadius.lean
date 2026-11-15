import SFT.Physics.AlphaRatio
import SFT.Physics.VacuumLedgerProofs
namespace SFT.Physics.ProtonRadius
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
def one : Rat := wholeRatio 1
def protonInnerSite : Except String Rat := do
 let c ← FoldFirstReturn.generatorPeriod
 LeptonRatios.divide one (wholeRatio c)
def protonEdgeShare : Except String Rat := do
 let edge := subtract one (← protonInnerSite)
 if !(edge.num*3 = 2*edge.den) then throw "proton edge complement changed"
 pure edge
def colourFibreSupport : Except String Nat := do
 let c ← FoldFirstReturn.generatorPeriod
 let b ← AlphaCovers.binaryCount
 let support := c*b
 if support != 6 then throw "complete colour/Fold support changed"
 pure support
def leadingRadiusMultiplier : Except String Rat := do
 let value := multiply (← protonEdgeShare) (wholeRatio (← colourFibreSupport))
 if !(value.num = 4*value.den) then throw "leading proton radius multiplier changed"
 pure value
def completeChargeSupport : Except String Nat := do
 let colour ← FoldFirstReturn.generatorPeriod
 let support := colour*colour+1
 if support != 10 then throw "complete proton charge support changed"
 pure support
def terminalAlpha : Except String Rat := do
 let inverse ← AlphaRatio.inverseFineStructure none
 let value ← LeptonRatios.divide one (BoundaryGrowth.asFraction inverse)
 if !zero.blt value || !value.blt one then throw "terminal alpha left the One"
 pure value
def terminalRadiusRetention : Except String Rat := do
 let value := subtract one (← LeptonRatios.divide (← terminalAlpha) (wholeRatio (← completeChargeSupport)))
 if !zero.blt value || !value.blt one then throw "terminal radius retention left the One"
 pure value
def terminalRadiusCoefficient : Except String Rat := do
 let value := multiply (← leadingRadiusMultiplier) (← terminalRadiusRetention)
 if !(value.num*2519231977345 = 10069574419808*value.den) then throw "terminal proton-radius coefficient changed"
 pure value
structure FormulaRow where
 chargeSupport : Nat
 transportOrder : String
 coefficient : Rat
 structurallySelected : Bool
def structuralFormulaCensus : Except String (List FormulaRow) := do
 let alpha ← terminalAlpha
 let rows ← ([8,9,10] : List Nat).mapM fun support => do
  (["untransported","linear","quadratic"] : List String).mapM fun order => do
   let retention ← if SFT.Host.Text.equal order "untransported" then pure one
    else if SFT.Host.Text.equal order "linear" then pure (subtract one (← LeptonRatios.divide alpha (wholeRatio support)))
    else pure (subtract one (← LeptonRatios.divide (multiply alpha alpha) (wholeRatio support)))
   pure (⟨support,order,multiply (← leadingRadiusMultiplier) retention,support == 10 && SFT.Host.Text.equal order "linear"⟩ : FormulaRow)
 pure rows.flatten
theorem originalInnerSite : protonInnerSite = .ok (normalize 1 3 (by decide)) := rfl
theorem originalEdgeShare : protonEdgeShare = .ok (normalize 2 3 (by decide)) := rfl
theorem originalFibreSupport : colourFibreSupport = .ok 6 := rfl
theorem originalLeadingMultiplier : leadingRadiusMultiplier = .ok (wholeRatio 4) := rfl
theorem originalChargeSupport : completeChargeSupport = .ok 10 := rfl
theorem originalTerminalCoefficient : terminalRadiusCoefficient = .ok (normalize 10069574419808 2519231977345 (by decide)) := rfl
theorem originalFormulaCoordinates : structuralFormulaCensus.map (fun rows => rows.map (fun x => (x.chargeSupport,x.transportOrder))) = .ok [(8,"untransported"),(8,"linear"),(8,"quadratic"),(9,"untransported"),(9,"linear"),(9,"quadratic"),(10,"untransported"),(10,"linear"),(10,"quadratic")] := rfl
theorem originalSelectedFormula : structuralFormulaCensus.map (fun rows => (rows.filter FormulaRow.structurallySelected).map (fun x => (x.chargeSupport,x.transportOrder,x.coefficient))) = .ok [(10,"linear",normalize 10069574419808 2519231977345 (by decide))] := rfl
end SFT.Physics.ProtonRadius
