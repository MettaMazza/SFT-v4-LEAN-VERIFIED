import SFT.Physics.MatterIdentityGraphs
namespace SFT.Physics.MagneticAnomaly
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
structure Result where
 bareG : Nat
 terminalAlpha : Rat
 phaseNormalizedLeadingAnomaly : Rat
 massSensitivityGraph : String
 physicalTurnTranslation : String

def magneticAnomalyStructure : Except String Result := do
 let inverse ← AlphaRatio.inverseFineStructure none
 let inverseRat := natRatio inverse.numerator inverse.denominator (Nat.pos_of_ne_zero inverse.denominatorNonzero)
 let alpha ← LeptonRatios.divide (wholeRatio 1) inverseRat
 let b ← AlphaCovers.binaryCount
 let normalized ← LeptonRatios.divide alpha (wholeRatio b)
 let lepton ← MatterIdentityGraphs.protonElectronIdentity
 let _polynomial := lepton.leptonPolynomial
 let bare ← AlphaCovers.binaryCount
 pure ⟨bare,alpha,normalized,"muon-to-electron mass ratio squared","post-seal-only"⟩

def originalRecord : Result :=
 ⟨2,⟨3676744786,503846395469,by decide,by decide⟩,
  ⟨1838372393,503846395469,by decide,by decide⟩,
  "muon-to-electron mass ratio squared","post-seal-only"⟩

theorem completeSourceRecord : magneticAnomalyStructure=.ok originalRecord := rfl

theorem binaryLeadingReassemblesAlpha : multiply (wholeRatio originalRecord.bareG)
 originalRecord.phaseNormalizedLeadingAnomaly=originalRecord.terminalAlpha := rfl
theorem strictlyPositiveLeading : zero.blt originalRecord.phaseNormalizedLeadingAnomaly=true := rfl
end SFT.Physics.MagneticAnomaly
