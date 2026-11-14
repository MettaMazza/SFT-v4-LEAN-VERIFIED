from pathlib import Path
import sys
w=Path('work');sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import atomic_precision_successor_laws_v1 as src
v=src.terminal_proton_magnetic_projection()
s='''import SFT.Physics.TerminalLamb
import SFT.Physics.TerminalProtonComparison
namespace SFT.Physics.TerminalHyperfine
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def reducedMassRetention : FoldFirstReturn.Input → Except String Rat
 | .nonFraction => .error "reduced-mass transport requires an exact ratio above the One"
 | .fraction ratio => do
   if !(wholeRatio 1).blt ratio then throw "reduced-mass transport requires an exact ratio above the One"
   LeptonRatios.divide ratio (add ratio (wholeRatio 1))
def terminalProtonMagneticProjection : Except String Rat := do
 let alpha ← TerminalLamb.exactAlpha
 let binary ← AlphaCovers.binaryCount
 let colour ← FoldFirstReturn.generatorPeriod
 let blocks ← AlphaBlocks.fineStructureBlocks
 let terminal ← TerminalLamb.terminalBinarySupport
 let heavy ← TerminalLamb.depthThreeHeavyComplement
 let volume ← AlphaCovers.positivePower (.integer (.ofNat colour)) (.integer (.ofNat colour))
 let turn ← TerminalTurn.terminalTurnProjection
 let square := (List.range binary).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let cube := (List.range colour).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let fourth := (List.range (binary*binary)).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let projection ← RunningConvergence.positiveTake turn (← LeptonRatios.divide (wholeRatio 1) (wholeRatio colour))
 let projection ← RunningConvergence.positiveTake projection (multiply (wholeRatio binary) alpha)
 let projection := add projection (multiply (← LeptonRatios.divide (wholeRatio blocks.down) (wholeRatio terminal)) alpha)
 let projection ← RunningConvergence.positiveTake projection (multiply (← LeptonRatios.divide (wholeRatio terminal) (normalize heavy 1 (by decide))) square)
 let projection ← RunningConvergence.positiveTake projection (multiply (← LeptonRatios.divide (wholeRatio blocks.up) (wholeRatio (blocks.down*terminal))) cube)
 let projection := add projection (← LeptonRatios.divide fourth (wholeRatio (blocks.down*volume)))
 let e0 ← RunningConvergence.positiveTake turn (normalize 1 3 (by decide))
 let e1 ← RunningConvergence.positiveTake e0 (multiply (wholeRatio 2) alpha)
 let e2 := add e1 (multiply (normalize 5 16 (by decide)) alpha)
 let e3 ← RunningConvergence.positiveTake e2 (multiply (normalize 16 53 (by decide)) (multiply alpha alpha))
 let e4 ← RunningConvergence.positiveTake e3 (multiply (normalize 7 80 (by decide)) (multiply (multiply alpha alpha) alpha))
 let expected := add e4 (← LeptonRatios.divide (multiply (multiply alpha alpha) (multiply alpha alpha)) (wholeRatio 135))
 if !(projection==expected) then throw "terminal proton magnetic projection routes disagree"
 pure projection
def hyperfineCarrierAt (ratio : FoldFirstReturn.Input) : Except String Rat := do
 let alpha ← TerminalLamb.exactAlpha
 let binary ← AlphaCovers.binaryCount
 let colour ← FoldFirstReturn.generatorPeriod
 let reduced ← reducedMassRetention ratio
 let rho ← match ratio with
  | .fraction q => .ok q
  | .nonFraction => .error "reduced-mass transport requires an exact ratio above the One"
 let spin ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat (binary*binary)))
 let square := (List.range binary).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let cube := (List.range colour).foldl (fun acc _ => multiply acc reduced) (wholeRatio 1)
 let leading ← LeptonRatios.divide (multiply (← LeptonRatios.divide (wholeRatio spin) (wholeRatio colour)) square) rho
 let magnetic ← terminalProtonMagneticProjection
 pure (multiply (multiply leading cube) magnetic)
theorem nonFractionRejected : reducedMassRetention .nonFraction=.error "reduced-mass transport requires an exact ratio above the One" := rfl
theorem oneRejected : reducedMassRetention (.fraction (wholeRatio 1))=.error "reduced-mass transport requires an exact ratio above the One" := rfl
theorem twoRetention : reducedMassRetention (.fraction (wholeRatio 2))=.ok (normalize 2 3 (by decide)) := rfl
'''
s+=f'def magneticExpected : Rat := normalize {v.numerator} {v.denominator} (by decide)\ntheorem magneticComplete : terminalProtonMagneticProjection=.ok magneticExpected := rfl\nend SFT.Physics.TerminalHyperfine\n'
for root in [w/'constants-recovery',Path('/Volumes/One Touch/SFT v4 Full model LEAN')]:
 (root/'SFT/Physics/TerminalHyperfine.lean').write_text(s)
