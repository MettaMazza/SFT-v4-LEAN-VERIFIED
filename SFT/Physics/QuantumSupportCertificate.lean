import SFT.Physics.QuantumSupportJoint
import SFT.Physics.QuantumSupportBell
namespace SFT.Physics.QuantumSupportCertificate
open QuantumSupportPreparation QuantumSupportWalsh QuantumSupportJoint QuantumSupportBell LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Certificate where
 walsh : Bool
 depth : Bool
 spacing : Bool
 depthTwoFloor : Bool
 joints : Bool
 coprime : Bool
 bell : Bool
def theoremCertificate : Except String Certificate := do
 let walsh ← completeWalshCensus (.integer 4)
 let twoThree ← jointSubsetCensus (.integer 2) (.integer 3)
 let threeFive ← jointSubsetCensus (.integer 3) (.integer 5)
 let bell := bellLocalRecordCensus
 let inclusive := settingInclusiveNoSignalSupport
 let depthThree ← preparationDepth (.integer 8)
 let depthTwoWords ← binaryWords (.integer 2)
 let depthTwo ← walshSupportCertificate (.integer 2) (depthTwoWords.take 2)
 let depthThreeWords ← binaryWords (.integer 3)
 let spacings ← [normalize 1 8 (by decide),normalize 2 9 (by decide),normalize 3 7 (by decide),normalize 5 11 (by decide)].mapM fun spacing => do
  let c ← spacingCancellationCertificate (.integer 3) (depthThreeWords.take 1) spacing
  pure c.spacingCancelled
 let firstTrace ← coprimeTraceCensus (.integer 2) (.integer 3)
 let secondTrace ← coprimeTraceCensus (.integer 3) (.integer 5)
 pure ⟨walsh.allPass && walsh.candidateSupports==65808,
  depthThree.depth==3 && VelocityComposition.ratEqual depthThree.branchUnit (normalize 1 8 (by decide)),
  spacings.all id,
  VelocityComposition.ratEqual depthTwo.squaredProduct (normalize 1 16 (by decide)) && VelocityComposition.ratEqual (normalize 1 16 (by decide)) depthTwo.squaredFloor,
  [twoThree,threeFive].all (fun c => c.censusComplete && c.fullProductFactorable && c.projectionsComplete && c.remoteRelabelInvariant),
  firstTrace.oneVisit && secondTrace.oneVisit,
  bell.allBounded && bell.maximumWins==3 && inclusive.allRelations && inclusive.noSignalling⟩
end SFT.Physics.QuantumSupportCertificate
