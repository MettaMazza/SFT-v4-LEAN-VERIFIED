import SFT.Physics.SmithionRoots
import SFT.Physics.ConfinementLift
namespace SFT.Physics.SmithionSpectrum
open LeptonIntervals VacuumLedgerProofs GeneratorOperations SmithionInvariants SmithionRoots SmithionFlavour
set_option maxRecDepth 1000000
set_option maxHeartbeats 100000000
structure Row where
 sector : Nat
 kind : String
 depth : Nat
 invariants : Rat × Rat × Rat
 roots : List Bracket
 massRatios : List (Rat × Rat)
def spectrumRow (p : Nat) (kind : String) : Except String Row := do
 let sector := CountInput.integer (.ofNat p)
 .ok ⟨p,kind,← spectrumDepth sector kind,← spectrumInvariants sector kind,
  ← spectrumRootBrackets sector kind (.integer 60),← massRatioEnclosures sector kind⟩
def smithionSpectrumCensus : Except String (List Row) := do
 let rows ← ([5,7] : List Nat).mapM (fun p=>["down","up"].mapM (spectrumRow p))
 .ok rows.flatten
def lightestUnique (roots : List Bracket) : Except String Bool := do
 let a ← LeptonRatios.atIndex roots 0
 let b ← LeptonRatios.atIndex roots 1
 let c ← LeptonRatios.atIndex roots 2
 let lowB ← match b.1 with | none=>.error "TypeError" | some x=>.ok x
 let lowC ← match c.1 with | none=>.error "TypeError" | some x=>.ok x
 .ok (a.2.blt lowB && lowB.blt lowC)
structure Relic where
 newSectors : List Nat
 singletConstituents : List Nat
 neutralCompleteFibres : List Bool
 generationCount : List Nat
 lightestUnique : List Bool
 electromagneticChannel : List Rat
 sectorChannels : List Rat
 mediators : List Nat
 massParts : List Rat
 stabilityScope : String
def relicCertificate : Except String Relic := do
 let rows ← smithionSpectrumCensus
 let sectors := [5,7]
 let counts ← sectors.mapM (fun p=>SectorInventory.singletConstituentCount (.integer (.ofNat p)))
 let unique ← rows.mapM (fun r=>lightestUnique r.roots)
 let channels ← sectors.mapM (fun p=>PrimeSectorLadder.sectorCoupling (.integer (.ofNat p)))
 let mediators ← sectors.mapM (fun p=>PrimeSectorLadder.mediatorCount (.integer (.ofNat p)))
 let parts ← sectors.mapM (fun p=>SectorInventory.fermionMassPart (.integer (.ofNat p)))
 .ok ⟨sectors,counts,counts.zipWith (fun n p=>n==p) sectors,rows.map (fun r=>r.roots.length),unique,[],channels,mediators,parts,
 "lightest-complete-neutral-singlet-under-the-closed-prime-sector-and-generation-grammar"⟩
structure Certificate where
 quarkCrossLock : Bool
 fourSpectra : Bool
 twelveRoots : Bool
 allRootsDisjointPositive : Bool
 relic : Relic
 lfv : LFV
 abundance : Abundance
def theoremCertificate : Except String Certificate := do
 let rows ← smithionSpectrumCensus
 let relic ← relicCertificate
 let lfv ← lfvCertificate
 let abundance ← abundanceCertificate
 let down ← colouredProduct (.integer 3) (.integer 5)
 let up ← colouredProduct (.integer 3) (.integer 7)
 let products ← ConfinementLift.sharpenedQuarkProducts
 let positive ← rows.mapM (fun row=>do
  let unique ← lightestUnique row.roots
  .ok (row.roots.all (fun (lower,upper)=>match lower with | none=>false | some l=>zero.blt l && !upper.blt l) && unique))
 .ok ⟨down==products.down && up==products.up,rows.length==4,(rows.map (fun r=>r.roots.length)).sum==12,positive.all id,relic,lfv,abundance⟩
#print axioms spectrumRow
#print axioms smithionSpectrumCensus
#print axioms lightestUnique
#print axioms relicCertificate
#print axioms theoremCertificate
end SFT.Physics.SmithionSpectrum
