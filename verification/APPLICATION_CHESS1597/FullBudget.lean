import SFT.Applications.FoldChess.Driver
open SFT.Applications.FoldChess

def main : IO Unit := do
 let (answer,ctx) := searchBestSeen startingState 12 (stateSignature startingState) {}
 IO.println (String.intercalate "," (answer.toList.map toString) ++ s!" nodes={ctx.nodesLeft} abort={ctx.passAborted} gen={ctx.ttGen}")
