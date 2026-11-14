import SFT.Mathematics.PrimePairComplete
namespace SFT.Mathematics.PrimePairCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000

theorem completeTwinsOriginal : completeTwins.map (fun p => (p,p+2))=twinPairs 10000 := by decide

theorem originalTwinCount : (twinPairs 10000).length=205 := by
 rw [← completeTwinsOriginal,OrbitCycleSupport.mappedLength,completeTwinCount]

end SFT.Mathematics.PrimePairCensus
