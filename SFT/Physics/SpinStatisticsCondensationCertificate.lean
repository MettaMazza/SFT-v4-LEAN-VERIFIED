import SFT.Physics.SpinStatisticsCondensation
namespace SFT.Physics.SpinStatisticsCondensationCertificate
open SpinStatisticsCondensation LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Certificate where
 occupation : Bool
 weights : Bool
 cold : Bool
 spin : Bool
def occupationCheck : Except String Bool := do
 let rows ← (List.range 6).mapM fun l => do
   let rows ← (List.range 6).mapM fun n => do
     let c ← occupationCensus (.integer (.ofNat (n+1))) (.integer (.ofNat (l+1)))
     pure c.complete
   pure (rows.all id)
 pure (rows.all id)
def weightsCheck : Except String Bool := do
 let rows ← ["preserving","alternating"].mapM fun exchange => do
   let rows ← (List.range 4).mapM fun l => do
     let levels := l+2
     let rows ← (List.range levels).mapM fun n => do
       let rows ← (List.range 4).mapM fun d => do
         let weights ← canonicalOccupationWeights (.integer (.ofNat (n+1))) (.integer (.ofNat levels)) exchange (.integer (.ofNat (d+1)))
         pure (VelocityComposition.ratEqual ((weights.map Prod.snd).foldl add zero) (wholeRatio 1))
       pure (rows.all id)
     pure (rows.all id)
   pure (rows.all id)
 pure (rows.all id)
def coldCheck : Except String Bool := do
 let rows ← (List.range 4).mapM fun m => do
   let rows ← (List.range 4).mapM fun l => do
     let rows ← (List.range 5).mapM fun n => do
       let c ← criticalCondensationCertificate (.integer (.ofNat (n+2))) (.integer (.ofNat (l+2))) (.integer (.ofNat (m+2)))
       let g ← minimalThrowGroundCertificate (.integer (.ofNat (n+2))) (.integer (.ofNat (l+2)))
       pure (c.priorBelow && g.unique)
     pure (rows.all id)
   pure (rows.all id)
 pure (rows.all id)
def certificate : Except String Certificate := do
 let occupation ← occupationCheck
 let weights ← weightsCheck
 let cold ← coldCheck
 pure ⟨occupation,weights,cold,exchangeSpinCensus.completeCount==4 && spinReturnCertificate.alternatingFirstReturn==2⟩
end SFT.Physics.SpinStatisticsCondensationCertificate
