import SFT.Mathematics.PrimePairCensus
namespace SFT.Mathematics.PrimePairCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000
def twinBlock4 := ((List.range 1000).map (fun n => n+4003)).filter (fun p => isPrime p && isPrime (p+2))
theorem twinCount4 : twinBlock4.length=22 := by decide
end SFT.Mathematics.PrimePairCensus
