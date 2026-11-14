import SFT.Mathematics.PrimePairCensus
namespace SFT.Mathematics.PrimePairCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000
def twinBlock2 := ((List.range 1000).map (fun n => n+2003)).filter (fun p => isPrime p && isPrime (p+2))
theorem twinCount2 : twinBlock2.length=21 := by decide
end SFT.Mathematics.PrimePairCensus
