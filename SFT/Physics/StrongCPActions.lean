import SFT.Physics.LeptonRatios
import SFT.Physics.VacuumLedgerProofs
import SFT.Physics.PrimeSectorLadder
import SFT.Physics.FoldFirstReturn
namespace SFT.Physics.StrongCPActions
open LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
-- Original sector_action_signatures: every generated mediator cell, in source order.
def sectorActionSignatures : Except String (List (Nat × Nat × Nat)) := do
 let sectors ← PrimeSectorLadder.primeSectorLadder
 let rows ← sectors.mapM fun sector => do
  let count ← PrimeSectorLadder.mediatorCount (.integer (.ofNat sector))
  .ok ((List.range count).map (fun i=>(sector,sector,i+1)))
 .ok rows.flatten
def crossFibreLabelPairs : Except String (List (Nat × Nat × Nat × Nat)) := do
 let sectors ← PrimeSectorLadder.primeSectorLadder
 .ok (sectors.flatMap (fun source=>sectors.flatMap (fun target=>
  if source==target then [] else
   (List.range source).flatMap (fun s=>(List.range target).map (fun t=>(source,s+1,target,t+1))))))
structure Certificate where
 sectors : List Nat
 mediatorCounts : List Nat
 mediatorTotal : Nat
 allActionsFibrePreserving : Bool
 crossFibrePairCount : Nat
 generatedCrossFibreActions : List (Nat × Nat × Nat × Nat)
 quarkToLeptonPairCount : Nat
def sectorActionCertificate : Except String Certificate := do
 let signatures ← sectorActionSignatures
 let pairs ← crossFibreLabelPairs
 let sectors ← PrimeSectorLadder.primeSectorLadder
 let counts ← sectors.mapM (fun p=>PrimeSectorLadder.mediatorCount (.integer (.ofNat p)))
 .ok ⟨sectors,counts,signatures.length,signatures.all (fun (s,t,_)=>s==t),pairs.length,
  pairs.filter (fun (s,_,t,_)=>signatures.any (fun (a,b,_)=>s==a && t==b)),
  (pairs.filter (fun (s,_,t,_)=>s==3 && t==2)).length⟩
def completeColourWords : Except String (List (List Int)) := do
 let colour ← FoldFirstReturn.generatorPeriod
 let alphabet := (List.range colour).map (fun i=>Int.ofNat (i+1))
 .ok ((List.range colour).foldl (fun words _=>words.flatMap (fun word=>alphabet.map (fun label=>word++[label]))) [[]])
def baryonTally (word : List Int) : Except String Rat := do
 let colour ← FoldFirstReturn.generatorPeriod
 if word.length != colour || !word.all (fun label=>1≤label && label≤Int.ofNat colour) then
  throw "baryon tally requires one complete colour-three word"
 let part ← LeptonRatios.divide (wholeRatio 1) (wholeRatio colour)
 .ok (subtract (word.foldl (fun tally _=>add tally part) part) part)
theorem originalActionCertificate : sectorActionCertificate=.ok ⟨[2,3,5,7],[3,8,24,48],83,true,202,[],6⟩ := rfl
theorem originalColourCount : (completeColourWords.map List.length)=.ok 27 := rfl
theorem everyOriginalTally : (do (← completeColourWords).mapM baryonTally)=.ok (List.replicate 27 (wholeRatio 1)) := rfl
#print axioms sectorActionSignatures
#print axioms crossFibreLabelPairs
#print axioms sectorActionCertificate
#print axioms completeColourWords
#print axioms baryonTally
#print axioms originalActionCertificate
#print axioms originalColourCount
#print axioms everyOriginalTally
end SFT.Physics.StrongCPActions
