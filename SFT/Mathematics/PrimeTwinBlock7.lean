import SFT.Mathematics.PrimePairCensus
namespace SFT.Mathematics.PrimePairCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000
def twinBlock7 := ((List.range 1000).map (fun n => n+7003)).filter (fun p => isPrime p && isPrime (p+2))
theorem twinCount7 : twinBlock7.length=13 := by decide
end SFT.Mathematics.PrimePairCensus
