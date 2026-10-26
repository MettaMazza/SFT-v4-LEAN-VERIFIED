import SFT
open SFT.Foundation.CommonRefinement SFT.Host.Canonical
def main : IO Unit := do
  let traces := [[],["a"],["a","b"],["","λ","x,y"],["a","a"]]
  for xs in traces do
    for ys in traces do
      IO.println (render (.array [.array ((pairCells xs ys).map Value.text), .boolean (hasGeneratedBijection xs ys), .array ((liftedA xs ys).map Value.text), .array ((liftedB xs ys).map Value.text)]))
