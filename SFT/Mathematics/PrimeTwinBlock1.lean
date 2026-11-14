import SFT.Mathematics.PrimePairCensus
namespace SFT.Mathematics.PrimePairCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000
def twinBlock1 := ((List.range 1000).map (fun n => n+1003)).filter (fun p => isPrime p && isPrime (p+2))
theorem twinCount1 : twinBlock1.length=26 := by decide
end SFT.Mathematics.PrimePairCensus
