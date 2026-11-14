import SFT.Mathematics.PrimePairCensus
namespace SFT.Mathematics.PrimePairCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000
def twinBlock9 := ((List.range 996).map (fun n => n+9003)).filter (fun p => isPrime p && isPrime (p+2))
theorem twinCount9 : twinBlock9.length=15 := by decide
end SFT.Mathematics.PrimePairCensus
