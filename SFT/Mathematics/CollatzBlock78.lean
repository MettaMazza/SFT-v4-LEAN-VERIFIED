import SFT.Mathematics.CollatzCensus
namespace SFT.Mathematics.CollatzCensus
set_option maxRecDepth 200000
set_option maxHeartbeats 100000000
def censusBlock78 := (List.range 1000).map (fun j => let n := 78000+j+1; (n,stepsWithin n 350))
theorem block78 : censusBlock78.all (fun row => row.2.isSome)=true := by decide
end SFT.Mathematics.CollatzCensus
