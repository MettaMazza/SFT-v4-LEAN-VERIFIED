from pathlib import Path
import shutil,sys
w=Path('work');c=Path('/Volumes/One Touch/SFT v4 Full model LEAN');v=Path('/Volumes/One Touch/ernos-labs-sft-platform');r=w/'constants-recovery'
for f in ['hydrogen_rydberg_successor_laws_v1.py','hydrogen_rydberg_successor_validation_v1.py','hydrogen_rydberg_successor_execution_v1.py']:
 shutil.copy2(v/'sft/physics'/f,w/'v3-runtime500/sft/physics'/f)
sys.path.insert(0,str((w/'v3-runtime500').resolve()))
from sft.physics import hydrogen_rydberg_successor_laws_v1 as src
s='''import SFT.Physics.TerminalHyperfine
import SFT.Physics.HydrogenSpectrum
namespace SFT.Physics.HydrogenRydberg
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def exactAlpha := TerminalLamb.exactAlpha
def terminalHydrogenScaleAt (ratio : FoldFirstReturn.Input) : Except String Rat := do
 let alpha ← exactAlpha
 let binary ← AlphaCovers.binaryCount
 let colour ← FoldFirstReturn.generatorPeriod
 let blocks ← AlphaBlocks.fineStructureBlocks
 let scale ← TerminalHyperfine.reducedMassRetention ratio
 let square := (List.range binary).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let cube := (List.range colour).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let completeDirection ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat binary))
 let fourth := (List.range completeDirection).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let fifth := (List.range blocks.down).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let upSquare ← AlphaCovers.positivePower (.integer (.ofNat blocks.up)) (.integer (.ofNat binary))
 let scale := add scale (← LeptonRatios.divide square (wholeRatio blocks.down))
 let scale := add scale (← LeptonRatios.divide cube (wholeRatio binary))
 let scale ← RunningConvergence.positiveTake scale (multiply (wholeRatio (binary*colour)) fourth)
 let scale := add scale (multiply (wholeRatio upSquare) fifth)
 let rho ← match ratio with
  | .fraction q => .ok q
  | .nonFraction => .error "reduced-mass transport requires an exact ratio above the One"
 let expected ← LeptonRatios.divide rho (add rho (wholeRatio 1))
 let a2 := multiply alpha alpha
 let a3 := multiply a2 alpha
 let a4 := multiply a3 alpha
 let a5 := multiply a4 alpha
 let expected := add expected (← LeptonRatios.divide a2 (wholeRatio 5))
 let expected := add expected (← LeptonRatios.divide a3 (wholeRatio 2))
 let expected ← RunningConvergence.positiveTake expected (multiply (wholeRatio 6) a4)
 let expected := add expected (multiply (wholeRatio 49) a5)
 if !(scale==expected) then throw "terminal hydrogen scale routes disagree"
 pure scale
def terminalHydrogenScaleInterval : Except String (Rat × Rat) := do
 let ratios ← TerminalHyperfine.terminalProtonRatioInterval
 let lower ← terminalHydrogenScaleAt (.fraction ratios.1)
 let upper ← terminalHydrogenScaleAt (.fraction ratios.2)
 if !lower.blt upper then throw "terminal hydrogen scale interval orientation failed"
 pure (lower,upper)
def terminalIonizationToElectronRestInterval : Except String (Rat × Rat) := do
 let alpha ← exactAlpha
 let scale ← terminalHydrogenScaleInterval
 let binary ← AlphaCovers.binaryCount
 let carrier ← LeptonRatios.divide ((List.range binary).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)) (wholeRatio binary)
 pure (multiply carrier scale.1,multiply carrier scale.2)
def terminalLineRatioInterval : FoldFirstReturn.Input → Except String (Rat × Rat)
 | .nonFraction => .error "hydrogen line gap must be an exact positive part of the One"
 | .fraction gap => do
  if !(wholeRatio 0).blt gap || !gap.blt (wholeRatio 1) then throw "hydrogen line gap must be an exact positive part of the One"
  let scale ← terminalHydrogenScaleInterval
  pure (multiply gap scale.1,multiply gap scale.2)
theorem nonFractionRejected : terminalHydrogenScaleAt .nonFraction = .error "reduced-mass transport requires an exact ratio above the One" := rfl
theorem lineNonFractionRejected : terminalLineRatioInterval .nonFraction = .error "hydrogen line gap must be an exact positive part of the One" := rfl
theorem lineOneRejected : terminalLineRatioInterval (.fraction (wholeRatio 1)) = .error "hydrogen line gap must be an exact positive part of the One" := rfl
'''
def rat(q):return f'normalize ({q.numerator}) {q.denominator} (by decide)'
for name,op,vals in [('scaleExpected','terminalHydrogenScaleInterval',src.terminal_hydrogen_scale_interval()),('restExpected','terminalIonizationToElectronRestInterval',src.terminal_ionization_to_electron_rest_interval())]:
 s+=f'def {name} : Rat × Rat := ({rat(vals[0])},{rat(vals[1])})\ntheorem {name}Complete : {op}=.ok {name} := rfl\n'
s+='end SFT.Physics.HydrogenRydberg\n'
for root in [r,c]:(root/'SFT/Physics/HydrogenRydberg.lean').write_text(s)
