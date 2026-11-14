import SFT.Physics.QuarkDressing
namespace SFT.Physics.TerminalCKM
open LeptonIntervals VacuumLedgerProofs
def slopeContribution : Except String Rat := do
 let inverse ← AlphaRatio.inverseFineStructure none
 let inverseAlpha := BoundaryGrowth.asFraction inverse
 let alpha ← LeptonRatios.divide (wholeRatio 1) inverseAlpha
 let factors ← QuarkDressing.quarkDressingFactors
 let colour ← FoldFirstReturn.generatorPeriod
 let contribution ← LeptonRatios.divide (multiply alpha factors.upperUpRetention) (wholeRatio colour)
 let direct ← LeptonRatios.divide (wholeRatio 1) (multiply (wholeRatio colour) (add inverseAlpha (wholeRatio 7)))
 if !(contribution == direct) then throw "terminal CKM contribution routes disagree"
 pure contribution
structure Result where
 leadingS23 : String
 terminalContribution : Rat
 terminalS23 : String
 s12Squared : String
 s13Squared : String
 phase : Rat
def terminalCKMRelation : Except String Result := do
 let contribution ← slopeContribution
 pure ⟨"positive-difference-of-down-and-up-central-to-heavy-root-slopes",contribution,
 "leading-s23-plus-terminal-contribution","unchanged-down-light-to-central-mass-ratio",
 "s12-squared-times-terminal-s23-squared-over-six-channel-support",normalize 1 2 (by decide)⟩
def originalContribution : Rat := normalize 3676744786 1588750826913 (by decide)
theorem exactContribution : slopeContribution=.ok originalContribution := rfl
def originalRecord : Result := ⟨"positive-difference-of-down-and-up-central-to-heavy-root-slopes",originalContribution,
 "leading-s23-plus-terminal-contribution","unchanged-down-light-to-central-mass-ratio",
 "s12-squared-times-terminal-s23-squared-over-six-channel-support",normalize 1 2 (by decide)⟩
theorem completeSourceRecord : terminalCKMRelation=.ok originalRecord := rfl
theorem contributionPositive : (normalize 1 (10^9) (by decide)).blt originalContribution=true := rfl
end SFT.Physics.TerminalCKM
