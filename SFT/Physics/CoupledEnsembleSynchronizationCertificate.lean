import SFT.Physics.CoupledEnsembleSynchronization
namespace SFT.Physics.CoupledEnsembleSynchronizationCertificate
open CoupledEnsembleSynchronization LeptonIntervals
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Certificate where
 couplings : List Rat
 pairs : List (Rat × Rat)
 residualRecords : List (List (List Rat))
 uniqueSynchronizingCoupling : Rat
 halfOneResidualsEmpty : Bool
 offHalfResidualsPositive : Bool
 residualScaleLower : Scale
 residualScaleHalf : Scale
 residualScaleUpper : Scale
 synchronizedTerminalPreserved : Bool
def formalCertificate : Except String Certificate := do
 let pairs := [(normalize 1 8 (by decide),normalize 7 8 (by decide)),
  (normalize 1 4 (by decide),normalize 3 4 (by decide)),
  (normalize 1 3 (by decide),normalize 2 3 (by decide)),
  (normalize 2 5 (by decide),normalize 4 5 (by decide))]
 let couplings := [normalize 1 3 (by decide),normalize 1 2 (by decide),normalize 2 3 (by decide)]
 let records ← pairs.mapM (fun (a,b) => couplings.mapM (residualRecord a b))
 let selected ← uniquePairSynchronizingCoupling
 let halfRecords ← pairs.mapM (fun (a,b) => residualRecord a b (normalize 1 2 (by decide)))
 let offRecords ← pairs.mapM (fun (a,b) => [normalize 1 3 (by decide),normalize 2 3 (by decide)].mapM (fun c => do
  match ← residualRecord a b c with
  | first::_ => pure (zero.blt first)
  | [] => throw "IndexError"))
 let ensembles ← [normalize 1 3 (by decide),normalize 1 2 (by decide),normalize 3 4 (by decide)].mapM (fun p =>
  [2,3,5,8].mapM (fun n => do pure ((← synchronizedEnsembleSuccessor p (.integer (.ofNat n))).eraseDups.length==1)))
 pure ⟨couplings,pairs,records,selected,halfRecords.all List.isEmpty,(offRecords.flatten).all id,
  ← residualScale (normalize 1 3 (by decide)),← residualScale (normalize 1 2 (by decide)),← residualScale (normalize 2 3 (by decide)),
  ensembles.flatten.all id⟩
def certificateFacts : Except String Bool := do
 let c ← formalCertificate
 pure (c.uniqueSynchronizingCoupling==normalize 1 2 (by decide) && c.halfOneResidualsEmpty && c.offHalfResidualsPositive && c.synchronizedTerminalPreserved)
theorem originalComputedFacts : certificateFacts=.ok true := rfl
end SFT.Physics.CoupledEnsembleSynchronizationCertificate
