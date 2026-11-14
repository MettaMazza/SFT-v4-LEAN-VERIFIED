import SFT.Mathematics.CollatzCensus
namespace SFT.Mathematics.CollatzCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000
def censusBlock11 := (List.range 1000).map (fun j => let n := 11000+j+1; (n,stepsWithin n 350))
theorem block11 : censusBlock11.all (fun row => row.2.isSome)=true := by decide
end SFT.Mathematics.CollatzCensus
