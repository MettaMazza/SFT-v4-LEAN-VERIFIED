from pathlib import Path
import subprocess,sys
w=Path('work');rt=w/'v3-runtime500';rel='sft/physics/molecular_spectroscopy_successor_laws_v1.py';(rt/rel).write_bytes(subprocess.check_output(['git','-C','/Volumes/One Touch/ernos-labs-sft-platform','show','76f1b34e9e9682989adcbb088797b4ae4ce4fcf1:'+rel]));sys.path.insert(0,str(rt.resolve()))
from sft.physics import molecular_spectroscopy_successor_laws_v1 as src
s='''import SFT.Physics.TerminalLamb
namespace SFT.Physics.MolecularSpectroscopy
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 20000
set_option maxHeartbeats 100000000
def exactAlpha : Except String Rat := TerminalLamb.exactAlpha
def downSupport : Except String Nat := do pure (← AlphaBlocks.fineStructureBlocks).down
def upSupport : Except String Nat := do pure (← AlphaBlocks.fineStructureBlocks).up
def terminalSupport : Except String Nat := TerminalLamb.terminalBinarySupport
def heavyComplement : Except String Int := do
 let family ← MassRatioFamily.massRatioFamily (.integer (.ofNat (← FoldFirstReturn.generatorPeriod)))
 if family.heavyOverLight.den != 1 then throw "molecular heavy complement is not a positive count"
 pure family.heavyOverLight.num
'''
common=''' let alpha ← exactAlpha
 let binary ← AlphaCovers.binaryCount
 let colour ← FoldFirstReturn.generatorPeriod
 let down ← downSupport
 let up ← upSupport
 let heavy ← heavyComplement
 let terminal ← terminalSupport
 let binarySquare ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat binary))
 let square := (List.range binary).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let cube := (List.range colour).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
 let fourth := (List.range binarySquare).foldl (fun acc _ => multiply acc alpha) (wholeRatio 1)
'''
for name,original,lead,second,third,fourth,nums,label in [
 ('hydrogenRotationalToVibrational',src.hydrogen_rotational_to_vibrational,'binary','binary*up','heavy+Int.ofNat down','Int.ofNat (down*terminal+binary)',[2,14,58,82],'rotational/vibrational'),
 ('hydrogenAnharmonicToVibrational',src.hydrogen_anharmonic_to_vibrational,'binarySquare','binary*colour*down','heavy+Int.ofNat (binary*colour)','Int.ofNat (binarySquare*terminal)-1',[4,30,59,63],'anharmonic/vibrational')]:
 s+=f'def {name} : Except String Rat := do\n'+common+f''' let leading := multiply (wholeRatio ({lead})) alpha
 let second := multiply (wholeRatio ({second})) square
 let third := multiply (normalize ({third}) 1 (by decide)) cube
 let fourth := multiply (normalize ({fourth}) 1 (by decide)) fourth
 let retained ← RunningConvergence.positiveTake leading second
 let retained ← RunningConvergence.positiveTake retained third
 let retained ← RunningConvergence.positiveTake retained fourth
 let e0 ← RunningConvergence.positiveTake (multiply (wholeRatio {nums[0]}) alpha) (multiply (wholeRatio {nums[1]}) (multiply alpha alpha))
 let e1 ← RunningConvergence.positiveTake e0 (multiply (wholeRatio {nums[2]}) (multiply (multiply alpha alpha) alpha))
 let expected ← RunningConvergence.positiveTake e1 (multiply (wholeRatio {nums[3]}) (multiply (multiply alpha alpha) (multiply alpha alpha)))
 if !(retained==expected) then throw "{label} carrier routes disagree"
 pure retained
'''
 v=original();s+=f'def {name}Expected : Rat := normalize {v.numerator} {v.denominator} (by decide)\ntheorem {name}Complete : {name}=.ok {name}Expected := rfl\n'
s+='def deuteriumRotationalTransport : Except String Rat := do\n'+common+''' let correction ← RunningConvergence.positiveTake (normalize heavy 1 (by decide)) (wholeRatio terminal)
 let correction := add correction (wholeRatio 1)
 let half ← LeptonRatios.divide (wholeRatio 1) (wholeRatio binary)
 let result := add (add half (multiply (wholeRatio down) square)) (multiply correction cube)
 let expected := add (add (normalize 1 2 (by decide)) (multiply (wholeRatio 5) (multiply alpha alpha))) (multiply (wholeRatio 38) (multiply (multiply alpha alpha) alpha))
 if !(result==expected) then throw "rotational isotope carrier routes disagree"
 pure result
'''
s+='def deuteriumVibrationalSquaredTransport : Except String Rat := do\n'+common+''' let upSquared ← AlphaCovers.positivePower (.integer (.ofNat up)) (.integer (.ofNat binary))
 let half ← LeptonRatios.divide (wholeRatio 1) (wholeRatio binary)
 let result := add (add half (multiply (wholeRatio (down*binarySquare)) square)) (multiply (wholeRatio upSquared) cube)
 let expected := add (add (normalize 1 2 (by decide)) (multiply (wholeRatio 20) (multiply alpha alpha))) (multiply (wholeRatio 49) (multiply (multiply alpha alpha) alpha))
 if !(result==expected) then throw "vibrational isotope carrier routes disagree"
 pure result
'''
for name,fn in [('deuteriumRotationalTransport',src.deuterium_rotational_transport),('deuteriumVibrationalSquaredTransport',src.deuterium_vibrational_squared_transport)]:
 v=fn();s+=f'def {name}Expected : Rat := normalize {v.numerator} {v.denominator} (by decide)\ntheorem {name}Complete : {name}=.ok {name}Expected := rfl\n'
s+='end SFT.Physics.MolecularSpectroscopy\n'
for root in [w/'constants-recovery',Path('/Volumes/One Touch/SFT v4 Full model LEAN')]: (root/'SFT/Physics/MolecularSpectroscopy.lean').write_text(s)
