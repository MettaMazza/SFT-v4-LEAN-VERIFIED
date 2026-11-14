import SFT.Physics.TerminalLamb
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
def hydrogenRotationalToVibrational : Except String Rat := do
 let alpha ← exactAlpha
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
 let leading := multiply (wholeRatio (binary)) alpha
 let second := multiply (wholeRatio (binary*up)) square
 let third := multiply (normalize (heavy+Int.ofNat down) 1 (by decide)) cube
 let fourth := multiply (normalize (Int.ofNat (down*terminal+binary)) 1 (by decide)) fourth
 let retained ← RunningConvergence.positiveTake leading second
 let retained ← RunningConvergence.positiveTake retained third
 let retained ← RunningConvergence.positiveTake retained fourth
 let e0 ← RunningConvergence.positiveTake (multiply (wholeRatio 2) alpha) (multiply (wholeRatio 14) (multiply alpha alpha))
 let e1 ← RunningConvergence.positiveTake e0 (multiply (wholeRatio 58) (multiply (multiply alpha alpha) alpha))
 let expected ← RunningConvergence.positiveTake e1 (multiply (wholeRatio 82) (multiply (multiply alpha alpha) (multiply alpha alpha)))
 if !(retained==expected) then throw "rotational/vibrational carrier routes disagree"
 pure retained
def hydrogenRotationalToVibrationalExpected : Rat := normalize 891050294212130200059015688492600075210824140 64445503903521854869538077484881292205289061521 (by decide)
theorem hydrogenRotationalToVibrationalComplete : hydrogenRotationalToVibrational=.ok hydrogenRotationalToVibrationalExpected := rfl
def hydrogenAnharmonicToVibrational : Except String Rat := do
 let alpha ← exactAlpha
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
 let leading := multiply (wholeRatio (binarySquare)) alpha
 let second := multiply (wholeRatio (binary*colour*down)) square
 let third := multiply (normalize (heavy+Int.ofNat (binary*colour)) 1 (by decide)) cube
 let fourth := multiply (normalize (Int.ofNat (binarySquare*terminal)-1) 1 (by decide)) fourth
 let retained ← RunningConvergence.positiveTake leading second
 let retained ← RunningConvergence.positiveTake retained third
 let retained ← RunningConvergence.positiveTake retained fourth
 let e0 ← RunningConvergence.positiveTake (multiply (wholeRatio 4) alpha) (multiply (wholeRatio 30) (multiply alpha alpha))
 let e1 ← RunningConvergence.positiveTake e0 (multiply (wholeRatio 59) (multiply (multiply alpha alpha) alpha))
 let expected ← RunningConvergence.positiveTake e1 (multiply (wholeRatio 63) (multiply (multiply alpha alpha) (multiply alpha alpha)))
 if !(retained==expected) then throw "anharmonic/vibrational carrier routes disagree"
 pure retained
def hydrogenAnharmonicToVibrationalExpected : Rat := normalize 1776682883707972233972700395355383633647719432 64445503903521854869538077484881292205289061521 (by decide)
theorem hydrogenAnharmonicToVibrationalComplete : hydrogenAnharmonicToVibrational=.ok hydrogenAnharmonicToVibrationalExpected := rfl
def deuteriumRotationalTransport : Except String Rat := do
 let alpha ← exactAlpha
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
 let correction ← RunningConvergence.positiveTake (normalize heavy 1 (by decide)) (wholeRatio terminal)
 let correction := add correction (wholeRatio 1)
 let half ← LeptonRatios.divide (wholeRatio 1) (wholeRatio binary)
 let result := add (add half (multiply (wholeRatio down) square)) (multiply correction cube)
 let expected := add (add (normalize 1 2 (by decide)) (multiply (wholeRatio 5) (multiply alpha alpha))) (multiply (wholeRatio 38) (multiply (multiply alpha alpha) alpha))
 if !(result==expected) then throw "rotational isotope carrier routes disagree"
 pure result
def deuteriumVibrationalSquaredTransport : Except String Rat := do
 let alpha ← exactAlpha
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
 let upSquared ← AlphaCovers.positivePower (.integer (.ofNat up)) (.integer (.ofNat binary))
 let half ← LeptonRatios.divide (wholeRatio 1) (wholeRatio binary)
 let result := add (add half (multiply (wholeRatio (down*binarySquare)) square)) (multiply (wholeRatio upSquared) cube)
 let expected := add (add (normalize 1 2 (by decide)) (multiply (wholeRatio 20) (multiply alpha alpha))) (multiply (wholeRatio 49) (multiply (multiply alpha alpha) alpha))
 if !(result==expected) then throw "vibrational isotope carrier routes disagree"
 pure result
def deuteriumRotationalTransportExpected : Rat := normalize 127978935375939764924042592947263805 255814091290792903110270905899893418 (by decide)
theorem deuteriumRotationalTransportComplete : deuteriumRotationalTransport=.ok deuteriumRotationalTransportExpected := rfl
def deuteriumVibrationalSquaredTransportExpected : Rat := normalize 128184365564433438104117938993725957 255814091290792903110270905899893418 (by decide)
theorem deuteriumVibrationalSquaredTransportComplete : deuteriumVibrationalSquaredTransport=.ok deuteriumVibrationalSquaredTransportExpected := rfl
end SFT.Physics.MolecularSpectroscopy
