import SFT
open SFT.Engine SFT.Host.Canonical

def main : IO Unit := do
  let good := "sha256:aaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaaa"
  let sequences : List (List String) := [[],["a"],["a","b"],["a","a"],["a","b","a"],[""],[" \t"],["α","β"],["α","α"]]
  for rule in ["generate"," \t"] do
    for boundary in ["operational",""] do
      for count in ([-1,0,1,2,3] : List Int) do
        for ids in sequences do
          for form in ["exact","\n"] do
            for trace in [good,"invalid"] do
              for cert in [good,"invalid"] do
                let c : CandidateCensus := ⟨rule,boundary,count,cert, ids.map fun id => ⟨id,form,trace⟩⟩
                IO.println (render (.array ((censusViolations c).map Value.text)))
  for c in [SFT.Foundation.Root.Evidence.generateCandidatesData,
      SFT.Foundation.Root.Gate.incorrectCardinalityCensus,
      SFT.Foundation.Root.Gate.duplicateCandidateCensus] do
    IO.println (render (.array ((censusViolations c).map Value.text)))
