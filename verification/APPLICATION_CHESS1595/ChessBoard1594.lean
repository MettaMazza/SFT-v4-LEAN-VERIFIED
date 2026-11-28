import SFT.Applications.FoldChess.Board
open SFT.Applications.FoldChess

def main : IO Unit := do
 for code in List.range 21 do
  let c := (code : Int) - 4
  IO.println s!"piece {c} {if pieceIsWhite c then 1 else 0} {if pieceIsBlack c then 1 else 0} {pieceKind c}"
 for kind in List.range 9 do
  for sq in List.range 64 do
   for side in List.range 2 do
    IO.println s!"reach {kind} {sq} {side} {countedReach kind sq side}"
 for sq in List.range 64 do IO.println s!"flip {sq} {flipRank sq}"
 for i in List.range 71 do
  IO.println s!"board {i} {startingState.getD i 0} {emptyState.getD i 0} {(copyState startingState).getD i 0}"
 IO.println s!"budget {thinkingBudget}"
#print axioms pieceIsWhite
#print axioms pieceIsBlack
#print axioms pieceKind
#print axioms startingState
#print axioms emptyState
#print axioms copyState
#print axioms countedReach
#print axioms flipRank
#print axioms thinkingBudget
