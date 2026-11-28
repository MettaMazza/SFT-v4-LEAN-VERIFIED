import SFT.Applications.FoldChess.Driver
open SFT.Applications.FoldChess
#print axioms decimalDigits
#print axioms integerText
#print axioms stateSignature
#print axioms rootPass
#print axioms deepen
#print axioms searchBestSeen
#print axioms searchBest
def line (tag : String) (answer : Board) (ctx : SearchContext) : IO Unit :=
 IO.println (tag ++ " " ++ String.intercalate "," (answer.toList.map toString) ++ s!" nodes={ctx.nodesLeft} abort={ctx.passAborted} gen={ctx.ttGen}")
def main : IO Unit := do
 let start := startingState
 let fool := makeMove (makeMove (makeMove start 853) 3364) 926
 let mate := makeMove fool 3807
 for pair in [("start",start),("fool",fool),("mate",mate)] do
  let (tag,state) := pair
  IO.println (tag ++ " signature " ++ stateSignature state)
  for previous in ([-1,82] : List Int) do
   for seen in ["",stateSignature (makeMove state 82)] do
    let (answer,ctx) := rootPass state 2 seen previous {nodesLeft := 256}
    line (tag ++ s!" root {previous} " ++ seen) answer ctx
  let (answer,ctx) := searchBestSeen state 2 (stateSignature state) {}
  line (tag ++ " iterative") answer ctx
 let (answer,ctx) := searchBest fool 2 {}
 line "fool fixed" answer ctx
 IO.println s!"mateCheck {sideInCheck mate} {(legalMoves mate).size}"
