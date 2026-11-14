import SFT.Mathematics.PrimePairCensus
namespace SFT.Mathematics.PrimePairCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000
def twinBlock0 := ((List.range 1000).map (fun n => n+3)).filter (fun p => isPrime p && isPrime (p+2))
theorem twinCount0 : twinBlock0.length=35 := by decide
end SFT.Mathematics.PrimePairCensus
