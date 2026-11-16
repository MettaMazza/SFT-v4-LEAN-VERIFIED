import SFT.Physics.ParticleModeCoordinates
import SFT.Physics.SectorInventory
import SFT.Physics.AlphaCovers
namespace SFT.Physics.SmithionFlavour
open LeptonIntervals VacuumLedgerProofs GeneratorOperations
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure LFV where
 massParts : List Rat
 weights : List (String × Rat)
 integerRatio : List Int
 tauRatio : Rat
 betaSlopes : List (Nat × Rat)
def lfvCertificate : Except String LFV := do
 let coordinates ← ParticleModeCoordinates.generationCoordinates
 let muon ← LeptonRatios.atIndex coordinates.halfFibre 1
 let tau ← LeptonRatios.atIndex coordinates.halfFibre 2
 let a ← LeptonRatios.atIndex coordinates.quarterModes 0
 let b ← LeptonRatios.atIndex coordinates.quarterModes 1
 let c ← LeptonRatios.atIndex coordinates.quarterModes 2
 let adjacent := subtract b a
 let long := subtract c a
 let weights := [("mu_to_e",multiply (multiply adjacent adjacent) muon),("tau_to_mu",multiply (multiply adjacent adjacent) tau),("tau_to_e",multiply (multiply long long) tau)]
 let ratio ← weights.mapM (fun (_,w) => do
  let q ← LeptonRatios.divide w (normalize 1 96 (by decide))
  .ok (q.num / Int.ofNat q.den))
 let tauRatio ← LeptonRatios.divide (multiply (multiply long long) tau) (multiply (multiply adjacent adjacent) tau)
 let sectors ← PrimeSectorLadder.primeSectorLadder
 let slopes ← sectors.mapM (fun p=>do
  let q ← PrimeSectorLadder.sectorCoupling (.integer (.ofNat p))
  let part ← SectorInventory.fermionMassPart (.integer (.ofNat p))
  .ok (p,← LeptonRatios.divide q part))
 .ok ⟨coordinates.halfFibre,weights,ratio,tauRatio,slopes⟩
structure Abundance where
 volume : Nat
 coverDepth : Nat
 coverSupport : Nat
 baryonShare : Rat
 darkShare : Rat
 darkToBaryon : Rat
 matterToBaryon : Rat
def abundanceCertificate : Except String Abundance := do
 let generator ← FoldFirstReturn.generatorPeriod
 let volume ← AlphaCovers.positivePower (.integer (.ofNat generator)) (.integer (.ofNat generator))
 let depth ← AlphaCovers.minimalBinaryCover (.integer (.ofNat volume))
 let binary ← AlphaCovers.binaryCount
 let support ← AlphaCovers.positivePower (.integer (.ofNat binary)) (.integer (.ofNat depth))
 .ok ⟨volume,depth,support,
  ← LeptonRatios.divide (wholeRatio depth) (wholeRatio support),
  ← LeptonRatios.divide (wholeRatio volume) (wholeRatio support),
  ← LeptonRatios.divide (wholeRatio volume) (wholeRatio depth),
  ← LeptonRatios.divide (wholeRatio support) (wholeRatio depth)⟩
theorem originalLFV : lfvCertificate=.ok ⟨[normalize 1 6 (by decide),normalize 1 2 (by decide),normalize 5 6 (by decide)],
 [("mu_to_e",normalize 1 32 (by decide)),("tau_to_mu",normalize 5 96 (by decide)),("tau_to_e",normalize 5 24 (by decide))],
 [3,5,20],wholeRatio 4,[(2,wholeRatio 1),(3,wholeRatio 2),(5,wholeRatio 4),(7,wholeRatio 6)]⟩ := rfl
theorem originalAbundance : abundanceCertificate=.ok ⟨27,5,32,normalize 5 32 (by decide),normalize 27 32 (by decide),normalize 27 5 (by decide),normalize 32 5 (by decide)⟩ := rfl
#print axioms lfvCertificate
#print axioms abundanceCertificate
#print axioms originalLFV
#print axioms originalAbundance
end SFT.Physics.SmithionFlavour
