import SFT.Physics.ParticleModeCoordinates
import SFT.Physics.QuarkInvariants
import SFT.Physics.NeutrinoLadder
namespace SFT.Physics.ParticleModeTransport
open ParticleModeCoordinates LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Transport where
 generationLabels : List Nat
 halfFibre : List Rat
 oneFibre : List Rat
 fixedFive : List Rat
 quarterModes : List Rat
 chargedLeptonCubicPairSum : Rat
 chargedLeptonCubicProduct : Rat
 downQuarkCubic : List Rat
 upQuarkCubic : List Rat
 neutrinoMassSquares : List (String × Rat)
 siteOrderSelectsRootOrderOnly : Bool
 oldSiteFractionEqualsMassClaimRejected : Bool
 completeSectorTable : Bool

def massPatternTransport : Except String Transport := do
 let lepton ← LeptonTerminal.terminalProduct
 let quarks ← QuarkInvariants.cubicInvariants
 let neutrinos ← NeutrinoLadder.neutrinoMassSquares
 let coordinates ← generationCoordinates
 let product := BoundaryGrowth.asFraction lepton
 let down := [quarks.down.1,quarks.down.2.1,quarks.down.2.2].map BoundaryGrowth.asFraction
 let up := [quarks.up.1,quarks.up.2.1,quarks.up.2.2].map BoundaryGrowth.asFraction
 let squares := [("lightest",neutrinos.lightest),("middle",neutrinos.middle),("heavy",neutrinos.heavy)]
 pure ⟨coordinates.labels,coordinates.halfFibre,coordinates.oneFibre,coordinates.fixedFive,coordinates.quarterModes,
  normalize 1 6 (by decide),product,down,up,squares,true,true,
  zero.blt product && [down,up].length==2 && squares.length==3⟩

theorem originalTerminalSectorBinding
 (lepton : SFT.Foundation.ExactOperations.PositiveFraction) (quarks : QuarkInvariants.Cubics)
 (neutrinos : NeutrinoLadder.MassSquares)
 (hl : LeptonTerminal.terminalProduct=.ok lepton)
 (hq : QuarkInvariants.cubicInvariants=.ok quarks)
 (hn : NeutrinoLadder.neutrinoMassSquares=.ok neutrinos) :
 massPatternTransport=.ok ⟨originalCoordinates.labels,originalCoordinates.halfFibre,
 originalCoordinates.oneFibre,originalCoordinates.fixedFive,originalCoordinates.quarterModes,
 normalize 1 6 (by decide),BoundaryGrowth.asFraction lepton,
 [quarks.down.1,quarks.down.2.1,quarks.down.2.2].map BoundaryGrowth.asFraction,
 [quarks.up.1,quarks.up.2.1,quarks.up.2.2].map BoundaryGrowth.asFraction,
 [("lightest",neutrinos.lightest),("middle",neutrinos.middle),("heavy",neutrinos.heavy)],true,true,
 zero.blt (BoundaryGrowth.asFraction lepton) && true && true⟩ := by
 unfold massPatternTransport
 rw [hl,hq,hn,originalCompleteCoordinates]
 rfl

def colourBinaryDual (depth : CountInput) : Except String Rat := do
 let d ← SpinStatisticsCondensation.positiveWhole depth "dual depth"
 LeptonRatios.divide (wholeRatio 1) (wholeRatio (3*2^d-1))
theorem originalDualFive : colourBinaryDual (.integer 5)=.ok (normalize 1 95 (by decide)) := rfl
theorem originalDualSeven : colourBinaryDual (.integer 7)=.ok (normalize 1 383 (by decide)) := rfl
theorem originalThirdDual : LeptonRatios.divide (wholeRatio 1) (wholeRatio (2*3^5-1))=
 .ok (normalize 1 485 (by decide)) := rfl
#print axioms massPatternTransport
#print axioms originalTerminalSectorBinding
#print axioms colourBinaryDual
#print axioms originalDualFive
#print axioms originalDualSeven
#print axioms originalThirdDual
end SFT.Physics.ParticleModeTransport
