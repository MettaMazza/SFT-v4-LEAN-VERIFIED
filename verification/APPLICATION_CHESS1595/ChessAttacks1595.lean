import SFT.Applications.FoldChess.Attacks
open SFT.Applications.FoldChess

def main : IO Unit := do
 for code in List.range 12 do
  for atSq in List.range 64 do
   let state := writeSquare emptyState atSq (code+1)
   for sq in List.range 65 do
    for side in [0,1] do
     IO.println s!"{code+1} {atSq} {sq} {side} {if squareAttacked state sq side then 1 else 0}"
 for sq in List.range 65 do
  for side in [0,1] do
   IO.println s!"start {sq} {side} {if squareAttacked startingState sq side then 1 else 0}"
#print axioms onBoard
#print axioms attackerColour
#print axioms attackRay
#print axioms squareAttacked
#print axioms sideInCheck
