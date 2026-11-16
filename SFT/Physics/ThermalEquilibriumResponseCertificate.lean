import SFT.Physics.ThermalEquilibriumResponse
namespace SFT.Physics.ThermalEquilibriumResponseCertificate
open ThermalEquilibriumResponse LeptonIntervals VacuumLedgerProofs
set_option maxRecDepth 100000
set_option maxHeartbeats 100000000
structure Certificate where
 temperature : Bool
 equilibrium : Bool
 canonical : Bool
 weights : Bool
 fluctuation : Bool
 noise : Bool
def descending : List Rat → Bool
 | [] => true
 | [_] => true
 | a::b::rest => b.blt a && descending (b::rest)
def certificate : Except String Certificate := do
 let temperature ← [[natRatio 1 4 (by decide),natRatio 3 4 (by decide)],
   [natRatio 1 3 (by decide),natRatio 1 2 (by decide),natRatio 2 3 (by decide)]].mapM totalThrowIdentity
 let equilibrium ← (List.range 11).mapM fun i => do
   let c ← pairedEquilibriumCensus (.integer (.ofNat (i+1)))
   pure (c.survivors==[i+1] && VelocityComposition.ratEqual c.share (natRatio 1 2 (by decide)))
 let canonical ← [2,3,4,5].mapM fun n => do
   let c ← canonicalMaximumCertificate (.integer (.ofNat n))
   pure c.unique
 let weights ← (List.range 8).mapM fun i => do
   let ws ← dyadicCanonicalWeights (.integer (.ofNat (i+2)))
   pure (VelocityComposition.ratEqual (ws.foldl add zero) (wholeRatio 1) && descending ws)
 let fluctuation := fluctuationResponseLedger
 let noise ← (List.range 9).mapM fun i => do
   let c ← deterministicNoiseCycle (.integer (.ofNat (i+1)))
   pure (VelocityComposition.ratEqual c.mean (natRatio 1 2 (by decide)))
 pure ⟨temperature.all id,equilibrium.all id,canonical.all id,weights.all id,
 fluctuation.complete && fluctuation.equalDeparture,noise.all id⟩
end SFT.Physics.ThermalEquilibriumResponseCertificate
