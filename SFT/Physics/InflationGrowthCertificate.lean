import SFT.Physics.InflationGrowth
import SFT.Physics.VelocityComposition
namespace SFT.Physics.InflationGrowthCertificate
open InflationGrowth LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Certificate where
 volume : Nat
 depth : Nat
 support : Nat
 scalar : Rat
 tensor : Rat
 completePrimordialPartition : Bool
 exactDuration : Nat
 growthTrace : List Rat
 strictGrowth : Bool
 transfer : Bool

def certificate : Except String Certificate := do
 let (depth,support) ← generatorCover
 let scalar ← scalarSupportShare
 let tensor ← tensorSupportShare
 let duration ← exactDoublingDepth (.integer (.ofNat support))
 let trace := perturbationGrowthTrace
 let first ← LeptonRatios.atIndex trace 0
 let second ← LeptonRatios.atIndex trace 1
 let third ← LeptonRatios.atIndex trace 2
 let checks ← [normalize 1 2 (by decide),wholeRatio 1,normalize 3 2 (by decide),wholeRatio 2,wholeRatio 3].mapM fun g => do
  let t ← forwardComponentTransfer g
  pure (VelocityComposition.ratEqual t.matterOverRadiation g)
 pure ⟨3^3,depth,support,scalar,tensor,
  VelocityComposition.ratEqual (add scalar tensor) (wholeRatio 1),duration,trace,
  first.blt second && second.blt third,checks.all id⟩

theorem originalCertificateCounts : certificate.toOption.map (fun c => (c.volume,c.depth,c.support,c.exactDuration))=some (27,5,32,5) := by decide +kernel

theorem originalCertificateFlags : certificate.toOption.map (fun c => c.completePrimordialPartition && c.strictGrowth && c.transfer)=some true := by decide +kernel
end SFT.Physics.InflationGrowthCertificate
