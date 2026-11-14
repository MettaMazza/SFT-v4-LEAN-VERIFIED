import SFT.Mathematics.PrimePairCensus
namespace SFT.Mathematics.PrimePairCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000
def twinBlock8 := ((List.range 1000).map (fun n => n+8003)).filter (fun p => isPrime p && isPrime (p+2))
theorem twinCount8 : twinBlock8.length=15 := by decide
end SFT.Mathematics.PrimePairCensus
