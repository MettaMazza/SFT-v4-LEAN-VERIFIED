import SFT.Mathematics.PrimePairCensus
namespace SFT.Mathematics.PrimePairCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000
def twinBlock6 := ((List.range 1000).map (fun n => n+6003)).filter (fun p => isPrime p && isPrime (p+2))
theorem twinCount6 : twinBlock6.length=19 := by decide
end SFT.Mathematics.PrimePairCensus
