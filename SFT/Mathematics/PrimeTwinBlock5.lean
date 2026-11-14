import SFT.Mathematics.PrimePairCensus
namespace SFT.Mathematics.PrimePairCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000
def twinBlock5 := ((List.range 1000).map (fun n => n+5003)).filter (fun p => isPrime p && isPrime (p+2))
theorem twinCount5 : twinBlock5.length=17 := by decide
end SFT.Mathematics.PrimePairCensus
