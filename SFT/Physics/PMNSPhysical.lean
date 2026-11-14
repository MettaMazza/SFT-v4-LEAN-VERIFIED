import SFT.Physics.NeutrinoLadder
namespace SFT.Physics.PMNSPhysical
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
structure Result where
 atmospheric : Rat
 solar : Rat
 reactor : Rat
 cpPhase : Rat
 electronWeights : Rat × Rat × Rat

def pmnsCPStructure : Except String Result := do
 let b ← AlphaCovers.binaryCount
 let c ← FoldFirstReturn.generatorPeriod
 let atmospheric ← LeptonRatios.divide (wholeRatio 1) (wholeRatio b)
 let solar ← LeptonRatios.divide (wholeRatio 1) (wholeRatio c)
 let support ← AlphaCovers.positivePower (.integer (.ofNat b)) (.integer (.ofNat c))
 let reactor ← LeptonRatios.divide (multiply atmospheric solar) (wholeRatio support)
 let remainingSolar := subtract (wholeRatio 1) solar
 let remainingReactor := subtract (wholeRatio 1) reactor
 let weights := (multiply remainingSolar remainingReactor,multiply solar remainingReactor,reactor)
 let sum := add (add weights.1 weights.2.1) weights.2.2
 if !(decide (sum=wholeRatio 1)) then throw "PMNS electron weights did not close"
 let phaseBinary ← AlphaCovers.binaryCount
 let phase ← LeptonRatios.divide (wholeRatio 1) (wholeRatio phaseBinary)
 pure ⟨atmospheric,solar,reactor,phase,weights⟩

def originalRecord : Result :=
 ⟨⟨1,2,by decide,by decide⟩,⟨1,3,by decide,by decide⟩,⟨1,48,by decide,by decide⟩,
  ⟨1,2,by decide,by decide⟩,
  (⟨47,72,by decide,by decide⟩,⟨47,144,by decide,by decide⟩,⟨1,48,by decide,by decide⟩)⟩

theorem completeSourceRecord : pmnsCPStructure=.ok originalRecord := rfl

theorem exactWeightClosure : add (add originalRecord.electronWeights.1 originalRecord.electronWeights.2.1)
 originalRecord.electronWeights.2.2=wholeRatio 1 := rfl

theorem halfOnePhase : add originalRecord.cpPhase originalRecord.cpPhase=wholeRatio 1 := rfl
end SFT.Physics.PMNSPhysical
