import SFT.Physics.CKMFibres
import SFT.Physics.QuarkIsolation
namespace SFT.Physics.MatterIdentityGraphs
open LeptonIntervals VacuumLedgerProofs VacuumScaleProofs
structure CKMIdentity where
 s12Squared : String
 s23 : String
 s13Squared : String
 apexSquared : Rat
 phase : Rat

def ckmPhysicalIdentity : Except String CKMIdentity := do
 let b ← AlphaCovers.binaryCount
 let c ← FoldFirstReturn.generatorPeriod
 let apex ← LeptonRatios.divide (wholeRatio 1) (wholeRatio (b*c))
 let phaseBinary ← AlphaCovers.binaryCount
 let phase ← LeptonRatios.divide (wholeRatio 1) (wholeRatio phaseBinary)
 pure ⟨"down-light-mass/down-central-mass",
  "down-central-root/down-heavy-root positive-take up-central-root/up-heavy-root",
  "s12-squared times s23-squared over six-channel-support",apex,phase⟩

def originalCKM : CKMIdentity :=
 ⟨"down-light-mass/down-central-mass",
  "down-central-root/down-heavy-root positive-take up-central-root/up-heavy-root",
  "s12-squared times s23-squared over six-channel-support",
  ⟨1,6,by decide,by decide⟩,⟨1,2,by decide,by decide⟩⟩

theorem completeCKMIdentity : ckmPhysicalIdentity=.ok originalCKM := rfl

theorem apexSixChannelIdentity : multiply originalCKM.apexSquared (wholeRatio 6)=wholeRatio 1 := rfl

structure ProtonIdentity where
 leptonPolynomial : Rat × Rat × Rat
 protonShare : Rat
 ratioGraph : String

def protonElectronIdentity : Except String ProtonIdentity := do
 let c ← FoldFirstReturn.generatorPeriod
 let share ← LeptonRatios.divide (wholeRatio 1) (wholeRatio c)
 pure ⟨(⟨1,1,by decide,by decide⟩,⟨1,6,by decide,by decide⟩,⟨1,485,by decide,by decide⟩),
  share,"one-third times positive-take(muon-mass,electron-mass) over their product"⟩

def originalProton : ProtonIdentity :=
 ⟨(⟨1,1,by decide,by decide⟩,⟨1,6,by decide,by decide⟩,⟨1,485,by decide,by decide⟩),
  ⟨1,3,by decide,by decide⟩,
  "one-third times positive-take(muon-mass,electron-mass) over their product"⟩

theorem completeProtonIdentity : protonElectronIdentity=.ok originalProton := rfl

theorem threeColourShare : multiply originalProton.protonShare (wholeRatio 3)=wholeRatio 1 := rfl
end SFT.Physics.MatterIdentityGraphs
